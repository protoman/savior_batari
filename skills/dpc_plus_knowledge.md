# DPC+ Kernel Development Guide

## Key Learnings for H.E.R.O. Clone

### 1. DPC+ Kernel Setup

```bB
 set kernel DPC+

 goto start bank2

 bank 2
start
 ; Your game code here (banks 2-6 have 20K free)
```

**Rules:**
- `set kernel DPC+` — NOT `DPCplus`, and NO `set romsize` (DPC+ is always 32K automatically)
- Must use `goto start bank2` to force game code into bank 2 (bank 1 is mostly used by DPC+ kernel)
- Banks 2-6 have ~20K free for user code
- Playfield MUST use `pfhline`/`pfpixel`/`pfclear` (not asm/data to playfield RAM)

### 2. Playfield Tile Height

`DF0FRACINC`-`DF3FRACINC` control playfield row height (higher = shorter tiles):

| DF Value | Playfield Rows | Tile Height |
|----------|---------------|-------------|
| 255      | 176 scanlines | Very tall    |
| 128      | 88 scanlines  | Tall         |
| 64       | 44 scanlines  | Medium       |
| 32       | 22 scanlines  | Short        |
| 20       | ~9 rows       | Good for HERO |
| 16       | ~11 rows      | Very short   |

**For H.E.R.O.:** `DF0FRACINC = 20` gives correct tile proportions.

All 4 registers must match: `DF0FRACINC = DF1FRACINC = DF2FRACINC = DF3FRACINC`

### 3. Per-Scanline Background Colors (bkcolors)

```bB
 DF6FRACINC = 255
 bkcolors:
 $02
 $02
 ... (one entry per scanline)
end
```

**Critical rules:**
- `DF6FRACINC = 255` enables per-scanline background colors
- `DF6FRACINC = 0` disables (uses single COLUBK color)
- `bkcolors:` block MUST be inside the main loop, right before `drawscreen`
- Each entry = one scanline color
- First entries = TOP of screen, last entries = BOTTOM
- Do NOT set `COLUBK` in main loop (it overrides bkcolors)
- bB has line length limit — put each color on its own line
- Total entries must match visible scanlines (~176 for DPC+)

**Positioning formula:**
- Playfield area: entries 0 to (playfield_rows × scanlines_per_row)
- HUD area: entries from playfield_end to screen_bottom

### 4. Score Display

```bB
 scorecolors:
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
end
```

- `scorecolors:` block overrides `scorecolor` — must set all 8 digits
- `scorecolor` alone doesn't work in DPC+ when scorecolors is present
- Score is rendered at the bottom of the screen

### 5. Common Pitfalls

| Problem | Cause | Fix |
|---------|-------|-----|
| No playfield visible | Missing DF0FRACINC-3 settings | Set all to same value (e.g., 20) |
| Score not visible | scorecolors overriding scorecolor | Set all 8 digits in scorecolors |
| Background wrong color | COLUBK set in main loop | Remove COLUBK, use bkcolors |
| Bands not covering screen | Wrong number of bkcolors entries | Match entries to visible scanlines |
| Playfield too tall/short | Wrong DF0FRACINC value | Adjust (lower=taller, higher=shorter) |
| Code overflow bank 1 | DPC+ kernel is large | Use `goto bank2` for game code |
| HUD alignment wrong | Spacer entries changed count | **See Alignment section below** |

### 6. bkcolors Alignment — Critical Lesson

**Problem:** When adjusting bkcolors bands, changing the number of entries in one band shifts all subsequent bands up/down.

**Root Cause:** bkcolors entries are sequential scanlines. Each entry = 1 scanline. The position of each band is determined by the cumulative count of all previous entries.

**Example:**
```
Band 1: 10 entries ($00) → scanlines 0-9
Band 2: 10 entries ($00) → scanlines 10-19
...
Band 8: 24 entries ($04) → scanlines XX-YY
```
If you remove entries from Band 7, Band 8 shifts UP. If you add entries, Band 8 shifts DOWN.

**How to fix alignment:**
1. Count total entries needed (screen height in scanlines)
2. Calculate playfield area entries (playfield_rows × scanlines_per_row)
3. Remaining entries = HUD area
4. Do NOT change entry counts in earlier bands when adjusting later bands
5. If you need to shift a band, change ONLY the band immediately before it

**Current working config (DF0FRACINC=20):**
- Total entries: 135
- Black ($00): 75 entries → playfield area
- Blue ($74): 10 entries → pool/water/lava area (dynamic based on room flag)
- Gray ($04): 50 entries → rest of HUD with score
- Blue starts at entry 75, gray starts at entry 85

**Alignment key:** Blue/gray position is determined by cumulative entry count. To shift blue/gray DOWN, increase black entries. To shift UP, decrease black entries.

**Fine-tuning:** Each entry = 1 scanline = 1 pixel. To shift by N pixels, add/remove N entries from the band before the target band.

**Position calculation method:**
1. Count pixels from top of screen to playfield bottom (P pixels)
2. Count pixels from playfield bottom to desired blue-gray transition (T pixels)
3. Black entries = P
4. Blue entries = T
5. Gray entries = Total entries - Black - Blue

Example: If playfield bottom is at 70% of screen (70 entries), and blue should be 6 pixels tall, then:
- Black = 70 entries
- Blue = 6 entries
- Gray = remaining entries

**Warning:** Removing "spacer" bands (like $14 or $02) that were positioned correctly will break alignment. When removing spacer entries, compensate by adding same number of entries to adjacent band.

### 7. HUD Pool Band (Water/Lava)

The HUD has 3 visual zones:
1. **Black** ($00): playfield background
2. **Blue/Red/Black**: pool area (dynamic based on room type)
3. **Gray** ($04): status bar with score

**Room flag values:**
- $74 = Blue (water)
- $26 = Red (lava)
- $00 = Black (no pool)

To change pool color, modify the $74 entries in bkcolors block.

### 6. Memory Map

- Bank 0: ARM firmware (4K)
- Bank 1: DPC+ kernel + init (4K, mostly used)
- Banks 2-6: User code (5 × 4K = 20K)
- Bank 7: Graphics data (4K, for sprites/playfield)

### 7. Testing Checklist

1. Playfield renders correctly with pfhline
2. Player sprites visible and movable
3. Score visible with correct colors
4. Background colors match intended layout
5. HUD area has correct background color
6. No black gaps between playfield and HUD

## File: DPC+ Background Color Positioning

The HUD area (below playfield) requires:
1. bkcolors entries for playfield area (black)
2. bkcolors entries for HUD area (gray)
3. Total entries must fill entire screen (~176 scanlines)
4. Gray entries start after last playfield row

**Alignment formula:**
```
Total entries = Playfield entries + HUD entries
Playfield entries = playfield_rows × scanlines_per_row
HUD entries = Total entries - Playfield entries
```

**For DF0FRACINC=20:**
- Playfield rows: ~9
- Scanlines per row: ~13
- Playfield entries: ~117
- HUD entries: remaining to fill screen

**To shift HUD band position:**
- Add N entries to last playfield band → HUD shifts DOWN by N
- Remove N entries from last playfield band → HUD shifts UP by N
- Do NOT change earlier bands when adjusting position
