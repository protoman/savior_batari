#!/usr/bin/env python3
"""Convert level JSON to bB room subroutines using pfhline (DPC+ asymmetric playfield).

Editor stores 32 independent columns. Each column maps directly to a bB
playfield column — no mirroring needed.

Also generates pfcolors entries using the level's 2 wall colors in a
3-band pattern.
"""
import json, os, sys, re

# Atari 2600 NTSC palette: [hue][luma] = (R, G, B)
PALETTE = [
    [(0x00,0x00,0x00), (0x40,0x40,0x40), (0x6c,0x6c,0x6c), (0x90,0x90,0x90), (0xb0,0xb0,0xb0), (0xc8,0xc8,0xc8), (0xdc,0xdc,0xdc), (0xec,0xec,0xec)],
    [(0x44,0x44,0x00), (0x64,0x64,0x10), (0x84,0x84,0x24), (0xa0,0xa0,0x34), (0xb8,0xb8,0x40), (0xd0,0xd0,0x50), (0xe8,0xe8,0x5c), (0xfc,0xfc,0x68)],
    [(0x70,0x28,0x00), (0x84,0x44,0x14), (0x98,0x5c,0x28), (0xac,0x78,0x3c), (0xbc,0x8c,0x4c), (0xcc,0xa0,0x5c), (0xdc,0xb4,0x68), (0xe8,0xcc,0x7c)],
    [(0x84,0x18,0x00), (0x98,0x34,0x18), (0xac,0x50,0x30), (0xc0,0x68,0x48), (0xd0,0x80,0x5c), (0xe0,0x94,0x70), (0xec,0xa8,0x80), (0xfc,0xbc,0x94)],
    [(0x88,0x00,0x00), (0x9c,0x20,0x20), (0xb0,0x3c,0x3c), (0xc0,0x58,0x58), (0xd0,0x70,0x70), (0xe0,0x88,0x88), (0xec,0xa0,0xa0), (0xfc,0xb4,0xb4)],
    [(0x78,0x00,0x5c), (0x8c,0x20,0x74), (0xa0,0x3c,0x88), (0xb0,0x58,0x9c), (0xc0,0x70,0xb0), (0xd0,0x84,0xc0), (0xdc,0x9c,0xd0), (0xec,0xb0,0xe0)],
    [(0x48,0x00,0x78), (0x60,0x20,0x90), (0x78,0x3c,0xa4), (0x8c,0x58,0xb8), (0xa0,0x70,0xcc), (0xb4,0x84,0xdc), (0xc4,0x9c,0xec), (0xd4,0xb0,0xfc)],
    [(0x14,0x00,0x84), (0x30,0x20,0x98), (0x4c,0x3c,0xac), (0x68,0x58,0xc0), (0x7c,0x70,0xd0), (0x94,0x88,0xe0), (0xa8,0xa0,0xec), (0xbc,0xb4,0xfc)],
    [(0x00,0x00,0x88), (0x1c,0x20,0x9c), (0x38,0x40,0xb0), (0x50,0x5c,0xc0), (0x68,0x74,0xd0), (0x7c,0x8c,0xe0), (0x90,0xa4,0xec), (0xa4,0xb8,0xfc)],
    [(0x00,0x18,0x7c), (0x1c,0x38,0x90), (0x38,0x54,0xa8), (0x50,0x70,0xbc), (0x68,0x88,0xcc), (0x7c,0x9c,0xdc), (0x90,0xb4,0xec), (0xa4,0xc8,0xfc)],
    [(0x00,0x2c,0x5c), (0x1c,0x4c,0x78), (0x38,0x68,0x90), (0x50,0x84,0xac), (0x68,0x9c,0xc0), (0x7c,0xb4,0xd4), (0x90,0xcc,0xe8), (0xa4,0xe0,0xfc)],
    [(0x00,0x40,0x2c), (0x1c,0x5c,0x48), (0x38,0x7c,0x64), (0x50,0x9c,0x80), (0x68,0xb4,0x94), (0x7c,0xd0,0xac), (0x90,0xe4,0xc0), (0xa4,0xfc,0xd4)],
    [(0x00,0x3c,0x00), (0x20,0x5c,0x20), (0x40,0x7c,0x40), (0x5c,0x9c,0x5c), (0x74,0xb4,0x74), (0x8c,0xd0,0x8c), (0xa4,0xe4,0xa4), (0xb8,0xfc,0xb8)],
    [(0x14,0x38,0x00), (0x34,0x5c,0x1c), (0x50,0x7c,0x38), (0x6c,0x98,0x50), (0x84,0xb4,0x68), (0x9c,0xcc,0x7c), (0xb4,0xe4,0x90), (0xc8,0xfc,0xa4)],
    [(0x2c,0x30,0x00), (0x4c,0x50,0x1c), (0x68,0x70,0x34), (0x84,0x8c,0x4c), (0x9c,0xa8,0x64), (0xb4,0xc0,0x78), (0xcc,0xd4,0x88), (0xe0,0xec,0x9c)],
    [(0x44,0x28,0x00), (0x64,0x48,0x18), (0x84,0x68,0x30), (0xa0,0x84,0x44), (0xb8,0x9c,0x5c), (0xd0,0xb4,0x6c), (0xfc,0xe0,0x8c), (0xff,0xee,0x94)],
]

def nearest_ntsc_byte(r, g, b):
    """Find the nearest Atari NTSC color byte for an RGB color."""
    best_byte = 0
    best_dist = float('inf')
    for hue in range(16):
        for luma in range(8):
            pr, pg, pb = PALETTE[hue][luma]
            dr = r - pr
            dg = g - pg
            db = b - pb
            dist = dr*dr + dg*dg + db*db
            if dist < best_dist:
                best_dist = dist
                best_byte = (hue << 4) | (luma << 1)
    return best_byte

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
            row_bits = [0] * 32
            for gx in range(min(room_w, 32)):
                idx = y * room_w + gx
                if idx < len(tiles) and is_wall(tiles[idx]):
                    row_bits[gx] = 1

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

def generate_pfcolors(json_path):
    """Generate per-scanline pfcolors block from level wall colors."""
    with open(json_path) as f:
        data = json.load(f)

    level = data.get("level", data)
    r1 = level.get("wall_r", 56)
    g1 = level.get("wall_g", 104)
    b1 = level.get("wall_b", 144)
    r2 = level.get("wall2_r", 40)
    g2 = level.get("wall2_g", 130)
    b2 = level.get("wall2_b", 90)

    c1 = nearest_ntsc_byte(r1, g1, b1)
    c2 = nearest_ntsc_byte(r2, g2, b2)

    band1 = 25
    band2 = 26
    band3 = 125
    entries = [c1] * band1 + [c2] * band2 + [c1] * band3
    return "\n".join(" ${:02X}".format(e) for e in entries)

def generate_level_metadata(json_path):
    """Generate level metadata: player start, miner, room count, num rooms per transition."""
    with open(json_path) as f:
        data = json.load(f)

    level = data.get("level", data)
    rooms = level.get("rooms", [])
    num_rooms = len(rooms)

    start_room = level.get("start_room", 0)
    start_x = int(level.get("start_x", 8.0) * 4) + 18  # Convert grid col to screen x
    start_y = int(level.get("start_y", 2.0) * 16)        # Convert grid row to screen y

    miner_room = level.get("miner_room", num_rooms - 1)
    miner_x = int(level.get("miner_x", 13.0) * 4) + 18
    miner_y = int(level.get("miner_y", 10.0) * 16)

    lines = []
    lines.append("; Level metadata (auto-generated from JSON)")
    lines.append("; Player start")
    lines.append("  startRoom = {}".format(start_room))
    lines.append("  startX = {}".format(start_x))
    lines.append("  startY = {}".format(start_y))
    lines.append("; Miner goal")
    lines.append("  minerRoom = {}".format(miner_room))
    lines.append("  minerX = {}".format(miner_x))
    lines.append("  minerY = {}".format(miner_y))
    lines.append("; Room count for transitions")
    lines.append("  maxRoom = {}".format(num_rooms - 1))

    return "\n".join(lines)

def inject_level(hero_path, level_code, pfcolors_code, metadata_code):
    with open(hero_path, 'r') as f:
        content = f.read()

    # Inject room code
    pattern = r'; ROOM_CODE_START.*?; ROOM_CODE_END'
    replacement = "; ROOM_CODE_START\n" + level_code + "; ROOM_CODE_END"
    new_content = re.sub(pattern, replacement, content, flags=re.DOTALL)

    # Inject pfcolors (inside main loop, before drawscreen)
    pf_pattern = r'pfcolors:\s*\n(?:\s*\$[0-9A-Fa-f]+\s*\n)+end'
    pf_replacement = "pfcolors:\n" + pfcolors_code + "\nend"
    new_content = re.sub(pf_pattern, pf_replacement, new_content)

    # Inject level metadata (before main loop)
    meta_pattern = r'; LEVEL_METADATA_START.*?; LEVEL_METADATA_END'
    meta_replacement = "; LEVEL_METADATA_START\n" + metadata_code + "\n; LEVEL_METADATA_END"
    new_content = re.sub(meta_pattern, meta_replacement, new_content, flags=re.DOTALL)

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
    pfcolors_code = generate_pfcolors(json_path)
    metadata_code = generate_level_metadata(json_path)
    print("Level {} ({} rooms)".format(os.path.basename(json_path), num_rooms))

    if inject_level(hero_path, level_code, pfcolors_code, metadata_code):
        print("Injected OK")
    else:
        print("Inject FAILED (no changes)")

if __name__ == '__main__':
    main()
