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
