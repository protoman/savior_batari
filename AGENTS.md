# Savior - H.E.R.O. Atari 2600 Clone

## IMPORTANT RULES

- **Never change data formats (room dimensions, row counts, column counts, file formats) without explicit user approval first.** Always ask before suggesting format changes.

## Project Overview

Clone of Activision's **H.E.R.O. (Helicopter Emergency Rescue Operation)** for Atari 2600, built with Batari Basic (bB). Must run on original hardware.

**Original Game (1984):**
- Designer: John Van Ryzin
- Genre: Vertical platformer / action-adventure
- Player controls Roderick Hero, rescue worker with helicopter backpack
- Navigate mineshaft mazes, avoid hazards, rescue trapped miners

## Game Mechanics (HERO)

### Core Systems
- **Movement:** Hoverpack allows flying up, left, right; hovering; gravity pulls down
- **Weapons:** Microlaser beam (helmet-mounted), 6 sticks of dynamite per level
- **Power Gauge:** Depletes when moving; game over when empty + no lives
- **Lives:** Start with 4 (1 active + 3 reserve); extra life every 20,000 points

### Hazards & Enemies
| Type | Behavior | Destruction |
|------|----------|-------------|
| Spiders | Patrol surfaces | Laser |
| Bats | Fly patterns | Laser |
| Snakes | Ground patrol | Laser |
| Tentacles | Emerge from water/lava | Laser |
| Giant Moth | Flying enemy | Laser |
| Magma walls | Toggle open/closed | Dynamite only |
| Fragile walls | Block passage | Laser or Dynamite |
| Reinforced walls | Block passage | Dynamite only |
| Lanterns | Illuminate room | Touch = darkness |

### Level Structure
- Flip-screen style (screen transitions at edges)
- Multiple connected screens per level
- Vertical mine shafts with platforms
- Flooded sections requiring hover
- Dark rooms requiring dynamite fuse light

## HUD Elements (from screenshot)

```
┌────────────────────────────────────────────┐
│ [Game Area - mine shafts, player, enemies] │
│                                            │
├────────────────────────────────────────────┤
│ POWER  [████████████░░░░░░░░]  ← Energy   │
│ ♦♦♦♦♦♦  ← Dynamite sticks (6 max)        │
│ [Lives icons]  ← Reserve lives             │
│ SCORE: 000000  ← 6-digit score            │
│ ████████  ← Status bar (colored)          │
└────────────────────────────────────────────┘
```

**HUD Components:**
1. **Power Gauge** - Horizontal bar, depletes during movement
2. **Dynamite Counter** - Icons showing remaining sticks (6 per level)
3. **Lives Display** - Icons for reserve lives
4. **Score** - 6-digit numeric display
5. **Status Bar** - Colored bar at bottom (Activision branding in original)

## Kernel Selection Analysis

### Option 1: Standard Kernel
| Feature | Capability |
|---------|------------|
| Sprites | 1 player0, 1 player1 (8px wide, variable height) |
| Missiles | 2 (1 per player) |
| Ball | 1 |
| Playfield | 32×11, asymmetric, RAM-stored |
| ROM Size | 4K (expandable via bankswitching) |
| Hardware | No extra hardware needed |

**Pros:** Simple, no extra hardware, well-documented
**Cons:** Limited sprites (need flickering for multiple enemies), single-color sprites

### Option 2: DPC+ Kernel
| Feature | Capability |
|---------|------------|
| Sprites | 1 player0, up to 9 player1 copies (multicolor, 2× vertical res) |
| Missiles | 2 (standard) |
| Ball | 1 |
| Playfield | High resolution, per-line colors, async |
| ROM Size | 32K (20K usable) |
| Hardware | Requires Melody board (ARM coprocessor) |

**Pros:** More sprites, multicolor, better graphics
**Cons:** Requires special cartridge hardware, closed-source components

### Recommendation: **Standard Kernel**

**Rationale:**
1. Original HERO ran on standard 2600 hardware - no special chips
2. Authenticity: true to 1984 hardware capabilities
3. Simpler development, easier to test on real hardware
4. Standard kernel handles HERO's needs:
   - Player sprite + helicopter backpack
   - 1-2 enemies visible at once (with flickering if needed)
   - Playfield for mine shaft walls
5. Bankswitching (F8/F6) provides enough ROM for multiple levels

**Workaround for sprite limit:** Use kernel flickering or prioritize visible enemies.

## Editor Structure

The level editor (`editor/`) is a C++ Qt6 application:

```
editor/
├── CMakeLists.txt      # Build system
└── src/
    ├── main.cpp
    ├── MainWindow.{hpp,cpp}
    ├── MapCanvas.{hpp,cpp}
    ├── LevelData.hpp    # Data structures
    ├── DataSerializer.{hpp,cpp}
    ├── AtariPalette.{hpp,cpp}
    ├── UndoHistory.hpp
    └── NtscColorDialog.hpp
```

### Data Format (LevelData.hpp)
- **TileType:** AIR, SOLID_WALL, FRAGILE_WALL, REINFORCED_WALL, LAVA, WATER, RAFT, MAGMA_FALL
- **EnemyType:** SPIDER, BAT, SNAKE, TENTACLE, GIANT_MOTH
- **RoomData:** 16×12 tiles (authentic map dimensions), enemies, lamps
- **LevelData:** Rooms, wall colors (RGB), start/miner positions

### bB Level Data Format

**CRITICAL: When changing the level data format in the editor, ALWAYS regenerate/convert existing data files to match.**

The editor exports to bB-compatible `.asm` files stored in `game/levels/`. The format uses bB `data` statements:

#### Playfield Data (per room, 24 bytes)
```bB
data _L{level}_R{room}_PF
  $XX,$YY, ...  ; 12 rows × 2 bytes (16 bits per row)
end
```
- Each bit represents a tile: 1=wall (SOLID/FRAGILE/REINFORCED), 0=air
- Bit 7 = column 0 (left), Bit 0 = column 15 (right)
- Row 0 = top, Row 11 = bottom

#### Enemy Data (per room)
```bB
data _L{level}_R{room}_EN
  count, {type,x,y,range_min,range_max}, ...
end
```
- type: 0=SPIDER, 1=BAT, 2=SNAKE, 3=TENTACLE, 4=GIANT_MOTH
- x,y: pixel coordinates (×2 from editor grid)
- range_min,range_max: patrol bounds in pixels

#### Lamp Data (per room)
```bB
data _L{level}_R{room}_LM
  count, {x,y}, ...
end
```

#### Level Metadata
```bB
data _L{level}_META
  start_room, start_x, start_y,
  miner_room, miner_x, miner_y,
  num_rooms, pf_color, bg_color
end
```

### Data File Maintenance Rule
**When modifying tile types, enemy types, or room dimensions in the editor:**
1. Update `DataSerializer::ExportBbLevel()` to match new format
2. Regenerate all affected `.asm` files in `game/levels/`
3. Update hero.bas loading code if format changes
4. Test compilation and verify rooms render correctly
5. Commit both editor changes AND regenerated data files together

### Export Target
Editor exports to bB-compatible format (`.asm` include files in `game/levels/`).

## Implementation Plan (Incremental)

Each feature validated before proceeding.

### Phase 1: Foundation
- [x] **1.1** Set up bB project structure, hello world
- [x] **1.2** Implement basic playfield rendering (mine shaft walls)
- [x] **1.3** Player sprite with hoverpack movement (up/down/left/right/hover)

### Phase 2: Core Gameplay
- [x] **2.1** Collision detection (player vs walls, hazards)
- [x] **2.2** Power gauge system (HUD element + depletion)
- [x] **2.3** Laser beam weapon (fire button)
- [x] **2.4** Dynamite placement (6 per level, explosion effect)

### Phase 3: Enemies & Hazards
- [x] **3.1** Spider enemy (patrol behavior)
- [x] **3.2** Bat enemy (flying pattern)
- [ ] **3.3** Fragile/reinforced wall destruction
- [ ] **3.4** Lantern darkness mechanic

### Phase 4: Level System
- [x] **4.1** Flip-screen room transitions
- [~] **4.2** Level data loading from editor format
  - Editor export function added to DataSerializer
  - bB data format defined (playfield, enemies, lamps)
  - Current implementation: hardcoded rooms with pfhline/pfpixel
  - TODO: Integrate actual data statements from level_XX.asm files
- [~] **4.3** Multiple rooms per level
  - 3 rooms implemented with left/right transitions
  - TODO: Vertical transitions, more rooms
- [ ] **4.4** Miner rescue goal + level complete

### Phase 5: HUD & Polish
- [x] **5.1** Complete HUD (dynamite, lives, score)
- [ ] **5.2** Score system (enemies, level complete, bonus)
- [ ] **5.3** Lives system + game over
- [ ] **5.4** Title screen / game select

### Phase 6: Levels & Content
- [ ] **6.1** Create 5+ levels using editor
- [ ] **6.2** Difficulty progression
- [ ] **6.3** Sound effects (laser, explosion, pickup)
- [ ] **6.4** Final testing on real hardware / accurate emulator

## Implementation Notes

### bB Compilation Issues
- **Variable Aliases:** `dim` aliases sometimes fail to resolve in dasm assembly. Workaround: use direct variable names (a-z) instead of aliases for complex code.
- **Assembly Errors:** Some "Fatal assembly errors" are non-critical - binary still created. Check with `ls -la *.bin` to verify.
- **Include Paths:** Ensure `-I` flag points to correct bB includes directory.
- **Shell Script:** Use `2600basic.sh` with proper `bB` environment variable set.

### Working Code Structure
Current hero.bas uses:
- 14 variables (a-n) for game state
- Direct variable assignments (no dim aliases)
- HUD using pfscore bars (lives + power) and score display
- Core gameplay: movement, laser, dynamite, enemies, transitions
- 3 rooms with hardcoded layouts (pfhline/pfpixel)
- Room transitions via left/right edge detection

### Next Steps
1. Integrate level data loading from data statements (Phase 4.2)
2. Implement fragile wall destruction (Phase 3.3)
3. Complete score system (Phase 5.2)
4. Add more rooms and vertical transitions (Phase 4.3)
5. Test on Stella emulator for accuracy

## Validation Protocol

**After each feature:**
1. Test on Stella emulator (cycle-accurate)
2. Verify no flicker beyond acceptable limits
3. Check RAM usage (128 bytes total, 26 general variables)
4. Test on real hardware if possible
5. User validation before commit

## Technical Notes

### bB Variables
- `a-z`: 26 general-purpose variables (1 byte each)
- `temp1-temp5`: Local variables for subroutines
- `var0-var8`: Additional variables (DPC+)
- Total RAM: 128 bytes (shared with system)

### Sprite Definitions
```bB
player0:
%01000010
%01111110
%00111100
end
```
Note: Bytes are upside down in code (flipped in display)

### Playfield
- 32 pixels wide, 11 rows visible (12th hidden for scrolling)
- Asymmetric mode for unique left/right sides
- Use `pfpixel` for individual pixels (80 cycles each)

### Timing
- ~2ms between `drawscreen` calls
- 192 visible scanlines per frame
- VBLANK + overscan for game logic

## File Structure

```
batari_savior/
├── AGENTS.md           # This file
├── docs/
│   └── HERO/
│       └── hero_screenshot.gif
├── editor/             # Level editor (C++/Qt)
│   ├── CMakeLists.txt
│   └── src/
└── game/               # bB source
    ├── hero.bas        # Main game file (current: ~3KB)
    ├── hero.bas.bin    # Compiled binary (4K ROM)
    ├── hero.bas.asm    # Generated assembly
    ├── hero.bas.lst    # Assembly listing
    ├── hero.bas.sym    # Symbol table
    ├── includes/       # Custom kernels, data
    └── levels/         # Level data files
        └── level_01.asm  # Level 1 data (24 bytes/room)
```
