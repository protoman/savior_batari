#!/usr/bin/env python3
"""Convert level JSON files to bB room code and inject into hero.bas."""
import json, glob, os, sys, re

def is_wall(tile):
    return tile in (1, 2, 3)  # SOLID, FRAGILE, REINFORCED

def generate_room_code(room, room_idx):
    """Generate bB code for a single room (no return - dispatcher handles it)."""
    tiles = room.get("tiles", [])
    room_w = room.get("width", 16)
    room_h = room.get("height", 12)
    pf_w = 32
    lines = []

    lines.append("LoadRoom{}".format(room_idx))

    # Scan rows for horizontal wall runs
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
                # Map to bB playfield columns (0-31)
                pf_x1 = (start * pf_w) // room_w
                pf_x2 = ((end) * pf_w) // room_w - 1
                if pf_x2 >= pf_x1:
                    lines.append("  pfhline {} {} {} on".format(pf_x1, y, pf_x2))
            else:
                x += 1

    return "\n".join(lines)

def generate_level_code(json_path):
    """Generate full bB level code from JSON."""
    with open(json_path) as f:
        data = json.load(f)

    level = data.get("level", data)
    rooms = level.get("rooms", [])

    lines = []
    # Generate room subroutines
    for r, room in enumerate(rooms):
        lines.append(generate_room_code(room, r))
        lines.append("")

    # Generate dispatcher
    lines.append("; Room dispatcher - set 'o' to room index")
    lines.append("LoadRoom")
    lines.append("  pfclear")
    for r in range(len(rooms)):
        lines.append("  if o = {} then gosub LoadRoom{}".format(r, r))
    lines.append("  return")

    return "\n".join(lines)

def inject_level(hero_path, level_code):
    """Replace room code placeholder in hero.bas."""
    with open(hero_path, 'r') as f:
        content = f.read()

    # Find and replace between markers
    pattern = r'; ROOM_CODE_START.*?; ROOM_CODE_END'
    replacement = "; ROOM_CODE_START\n" + level_code + "\n; ROOM_CODE_END"
    new_content = re.sub(pattern, replacement, content, flags=re.DOTALL)

    if new_content == content:
        print("Warning: Could not find room code markers in hero.bas")
        return False

    with open(hero_path, 'w') as f:
        f.write(new_content)
    return True

def main():
    game_dir = os.path.dirname(os.path.abspath(__file__))
    level_dir = os.path.join(game_dir, 'levels')
    hero_path = os.path.join(game_dir, 'hero.bas')

    # Default to level 1
    json_path = os.path.join(level_dir, 'level_01.json')

    # Allow command line override
    if len(sys.argv) > 1:
        level_num = int(sys.argv[1])
        json_path = os.path.join(level_dir, 'level_{:02d}.json'.format(level_num))

    if not os.path.exists(json_path):
        print("Level file not found: {}".format(json_path))
        return

    print("Loading: {}".format(os.path.basename(json_path)))
    level_code = generate_level_code(json_path)
    num_rooms = level_code.count("gosub LoadRoom")
    print("  {} rooms generated".format(num_rooms))

    if inject_level(hero_path, level_code):
        print("  Injected into hero.bas")
    else:
        print("  Failed to inject - check markers")

if __name__ == '__main__':
    main()
