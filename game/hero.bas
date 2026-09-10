; Savior - H.E.R.O. Atari 2600 Clone
; 16K with bankswitching

 set romsize 16k
 const pfscore = 1

 ; Variables:
 ; a = lastPlayerX, b = lastPlayerY, c = powerGauge
 ; d = isMoving, e = laserDir, f = laserActive
 ; g = dynamiteCount, h = dynamiteFuse, i = dynamiteActive
 ; j = spiderX, k = spiderDir, m = lives
 ; n = gravityTimer, o = currentRoom

 a = 72 : b = 40 : c = 100
 d = 0 : e = 1 : f = 0
 g = 6 : h = 0 : i = 0
 j = 120 : k = -1 : m = 4
 n = 0 : o = 0

 ; Default playfield
 playfield:
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
end

 player0:
 %00111100
 %01111110
 %01111110
 %00111100
 %00100100
 %00100100
 %01111110
 %00111100
 %00111100
 %00111100
 %00011000
end

 player1:
 %00000000
 %01000010
 %10100101
 %01000010
 %00000000
 %01000010
 %10100101
 %01000010
 %00000000
 %00000000
 %00000000
end

 ; Load first room
 gosub LoadRoom
 ; Start player inside room (column 8 = center)
 player0x = 42
 player0y = 30

main
 ; Check laser-spider collision
 if f = 1 then if collision(missile0, player1) then j = 0 : f = 0

 ; Check player-spider collision
 if collision(player0, player1) then gosub PlayerHit

 ; Store position
 a = player0x
 b = player0y
 d = 0

 ; Horizontal movement
 if joy0left then player0x = player0x - 1 : d = 1 : e = 0
 if joy0right then player0x = player0x + 1 : d = 1 : e = 1

 ; Check horizontal collision
 if collision(player0, playfield) then player0x = a

 ; Vertical movement
 if joy0up then player0y = player0y - 1 : d = 1 : n = 0

 ; Gravity
 if !joy0up then n = n + 1
 if !joy0up then if n >= 4 then player0y = player0y + 1 : n = 0

 ; Check vertical collision
 if collision(player0, playfield) then player0y = b

 ; Room transitions
 ; Right edge -> next room
 if player0x > 80 then if o < 2 then o = o + 1 : gosub LoadRoom : player0x = 14
 ; Left edge -> previous room
 if player0x < 12 then if o > 0 then o = o - 1 : gosub LoadRoom : player0x = 78

 ; Boundaries (keep player in visible area)
 if player0x < 12 then player0x = 12
 if player0x > 80 then player0x = 80
 if player0y < 10 then player0y = 10
 if player0y > 80 then player0y = 80

 ; Laser
 if joy0fire then if f = 0 then f = 1 : missile0x = player0x + 3 : missile0y = player0y + 2
 if f = 1 then if e = 1 then missile0x = missile0x + 3
 if f = 1 then if e = 0 then missile0x = missile0x - 3
 if f = 1 then if missile0x < 1 then f = 0
 if f = 1 then if missile0x > 150 then f = 0
 if f = 1 then if collision(missile0, playfield) then f = 0
 if !joy0fire then f = 0

 ; Dynamite
 if joy0down then if i = 0 then if g > 0 then i = 1 : h = 30 : g = g - 1
 if i = 1 then h = h - 1
 if h <= 0 then i = 0

 ; Spider
 if j > 0 then j = j + k
 if j < 30 then k = 1
 if j > 70 then k = -1
 if j > 0 then player1x = j
 if j > 0 then player1y = 50

 ; Power depletion
 if d = 1 then c = c - 1
 if c <= 0 then gosub GameOver

 ; HUD
 pfscore1 = 0
 if m = 4 then pfscore1 = 31
 if m = 3 then pfscore1 = 15
 if m = 2 then pfscore1 = 7
 if m = 1 then pfscore1 = 3
 if m = 0 then pfscore1 = 0

 pfscore2 = 0
 if c > 87 then pfscore2 = 255
 if c > 75 then pfscore2 = 224
 if c > 62 then pfscore2 = 192
 if c > 50 then pfscore2 = 160
 if c > 37 then pfscore2 = 128
 if c > 25 then pfscore2 = 96
 if c > 12 then pfscore2 = 64
 if c > 6 then pfscore2 = 32
 if c > 3 then pfscore2 = 16
 if c > 0 then pfscore2 = 8
 if c = 0 then pfscore2 = 0

 ; Colors
 COLUBK = $02
 COLUPF = $28
 COLUP0 = $C6
 COLUP1 = $1C
 scorecolor = $36
 CTRLPF = $01

 drawscreen
 goto main

; ============================================
; LoadRoom - Draw room using playfield commands
; Room is 16 columns (0-15) × 11 rows (0-10)
; ============================================
LoadRoom
 pfclear
 if o = 0 then gosub LoadRoom0
 if o = 1 then gosub LoadRoom1
 if o = 2 then gosub LoadRoom2
 ; Reset spider position for room
 if o = 0 then j = 60 : k = -1
 if o = 1 then j = 40 : k = -1
 if o = 2 then j = 50 : k = 1
 return

; Room 0: Simple mine shaft with platforms
LoadRoom0
 ; Top border (row 0)
 pfhline 0 0 15 on
 ; Left wall (column 0, rows 1-10)
 pfvline 0 1 10 on
 ; Right wall (column 15, rows 1-10)
 pfvline 15 1 10 on
 ; Bottom border (row 10)
 pfhline 0 10 15 on
 ; Platform at row 4, columns 4-6
 pfhline 4 4 6 on
 ; Platform at row 7, columns 9-11
 pfhline 9 7 11 on
 return

; Room 1: Shaft with opening top/bottom
LoadRoom1
 ; Top border with shaft opening (columns 6-9 open)
 pfhline 0 0 5 on
 pfhline 10 0 15 on
 ; Left wall
 pfvline 0 1 10 on
 ; Right wall
 pfvline 15 1 10 on
 ; Bottom border with shaft opening (columns 6-9 open)
 pfhline 0 10 5 on
 pfhline 10 10 15 on
 ; Platform at row 3, columns 2-4
 pfhline 2 3 4 on
 ; Platform at row 6, columns 7-9
 pfhline 7 6 9 on
 ; Platform at row 8, columns 11-13
 pfhline 11 8 13 on
 return

; Room 2: Miner room
LoadRoom2
 ; Top border with shaft opening (columns 6-9 open)
 pfhline 0 0 5 on
 pfhline 10 0 15 on
 ; Left wall
 pfvline 0 1 10 on
 ; Right wall
 pfvline 15 1 10 on
 ; Bottom border
 pfhline 0 10 15 on
 ; Platform at row 4, columns 5-7
 pfhline 5 4 7 on
 ; Platform at row 7, columns 3-5
 pfhline 3 7 5 on
 ; Fragile wall at row 5-6, columns 10-10 (single column)
 pfvline 10 5 6 on
 return

PlayerHit
 COLUBK = $34
 m = m - 1
 player0x = 42
 player0y = 30
 j = 0
 COLUBK = $02
 if m <= 0 then gosub GameOver
 return

GameOver
 c = 100
 g = 6
 m = 4
 o = 0
 player0x = 42
 player0y = 30
 gosub LoadRoom
 return
