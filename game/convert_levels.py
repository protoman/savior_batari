#!/usr/bin/env python3
"""Convert level JSON to bB room subroutines using pfhline (DPC+ asymmetric playfield).

Editor stores 32 independent columns. Each column maps directly to a bB
playfield column — no mirroring needed.
"""
import json, os, sys, re

def is_wall(tile):
    return tile in (1, 2, 3)

def generate_level_code(json_path):
    with open(json_path) as f:
        data = json.load(f)

    level = data.get("level", data)
    rooms = level.get("rooms", [])

    lines = []
    for r, room in enumerate(rooms):
        tiles = room.get("tiles", [])
        room_w = room.get("width", 32)
        room_h = min(room.get("height", 12), 12)

        lines.append("LoadRoom{}".format(r))
        for y in range(room_h):
            # Build a 32-column bitmap for this row (direct mapping, no mirror)
            row_bits = [0] * 32
            for gx in range(min(room_w, 32)):
                idx = y * room_w + gx
                if idx < len(tiles) and is_wall(tiles[idx]):
                    row_bits[gx] = 1

            # Convert runs of 1s into pfhline calls
            x = 0
            while x < 32:
                if row_bits[x]:
                    start = x
                    while x < 32 and row_bits[x]:
                        x += 1
                    lines.append("  pfhline {} {} {} on".format(start, y, x - 1))
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
        print("Inject FAILED (markers not found)")

if __name__ == '__main__':
    main()
