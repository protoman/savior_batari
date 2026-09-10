#!/usr/bin/env python3
"""Convert level JSON to bB room subroutines."""
import json, os, sys, re

def is_wall(tile):
    return tile in (1, 2, 3)

def generate_level_code(json_path):
    with open(json_path) as f:
        data = json.load(f)

    level = data.get("level", data)
    rooms = level.get("rooms", [])
    pf_w = 32

    lines = []
    for r, room in enumerate(rooms):
        tiles = room.get("tiles", [])
        room_w = room.get("width", 16)
        room_h = room.get("height", 12)

        lines.append("LoadRoom{}".format(r))
        for y in range(min(room_h, 12)):
            x = 0
            while x < room_w:
                idx = y * room_w + x
                if idx < len(tiles) and is_wall(tiles[idx]):
                    start = x
                    while x < room_w:
                        idx = y * room_w + x
                        if idx >= len(tiles) or not is_wall(tiles[idx]):
                            break
                        x += 1
                    end = x
                    pf_x1 = (start * pf_w) // room_w
                    pf_x2 = ((end) * pf_w) // room_w - 1
                    if pf_x2 >= pf_x1:
                        lines.append("  pfhline {} {} {} on".format(pf_x1, y, pf_x2))
                else:
                    x += 1
        lines.append("  return")
        lines.append("")

    return "\n".join(lines), len(rooms)

def inject_level(hero_path, level_code):
    with open(hero_path, 'r') as f:
        content = f.read()

    pattern = r'; ROOM_CODE_START.*?; ROOM_CODE_END'
    replacement = "; ROOM_CODE_START\n" + level_code + "; ROOM_CODE_END"
    new_content = re.sub(pattern, replacement, content, flags=re.DOTALL)

    if new_content == content:
        return False

    with open(hero_path, 'w') as f:
        f.write(new_content)
    return True

def main():
    game_dir = os.path.dirname(os.path.abspath(__file__))
    level_dir = os.path.join(game_dir, 'levels')
    hero_path = os.path.join(game_dir, 'hero.bas')

    json_path = os.path.join(level_dir, 'level_01.json')
    if len(sys.argv) > 1:
        json_path = os.path.join(level_dir, 'level_{:02d}.json'.format(int(sys.argv[1])))

    if not os.path.exists(json_path):
        print("Not found: {}".format(json_path))
        return

    level_code, num_rooms = generate_level_code(json_path)
    print("Level {} ({} rooms)".format(os.path.basename(json_path), num_rooms))

    if inject_level(hero_path, level_code):
        print("Injected OK")
    else:
        print("Inject FAILED")

if __name__ == '__main__':
    main()
