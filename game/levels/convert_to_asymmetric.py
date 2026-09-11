#!/usr/bin/env python3
"""Convert existing 16-column symmetric level JSON to 32-column asymmetric format.

Mirror left half to right half: column i on right maps to column (31-i) on left.
"""
import json, sys

def mirror_tiles(tiles_16, width=16, height=12):
    """Expand 16-column tiles to 32-column using mirror."""
    tiles_32 = []
    for y in range(height):
        left_row = tiles_16[y * width : y * width + width]
        # Right half mirrors left: column 31-i = left column i
        right_row = list(reversed(left_row))
        tiles_32.extend(left_row)
        tiles_32.extend(right_row)
    return tiles_32

def convert_file(path):
    with open(path) as f:
        data = json.load(f)

    level = data.get("level", data)
    rooms = level.get("rooms", [])

    for room in rooms:
        old_w = room.get("width", 16)
        if old_w == 32:
            print(f"  Room {room.get('room_id', '?')}: already 32 columns, skipping")
            continue

        old_h = room.get("height", 12)
        old_tiles = room.get("tiles", [])
        expected = old_w * old_h
        if len(old_tiles) != expected:
            print(f"  Room {room.get('room_id', '?')}: tile count {len(old_tiles)} != expected {expected}, skipping")
            continue

        new_tiles = mirror_tiles(old_tiles, old_w, old_h)
        room["width"] = 32
        room["tiles"] = new_tiles
        print(f"  Room {room.get('room_id', '?')}: {old_w}x{old_h} -> 32x{old_h} ({len(new_tiles)} tiles)")

    # Update start/miner positions if needed (they should be fine as-is since
    # they're in the left half which doesn't change)

    with open(path, 'w') as f:
        json.dump(data, f, indent=4)
    print(f"Converted: {path}")

def main():
    if len(sys.argv) < 2:
        print("Usage: convert_to_asymmetric.py <level_XX.json> [...]")
        return
    for path in sys.argv[1:]:
        convert_file(path)

if __name__ == '__main__':
    main()
