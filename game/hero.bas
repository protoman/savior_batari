; Savior - H.E.R.O. Atari 2600 Clone
; DPC+ kernel for asymmetric playfield

 set kernel DPC+skip constants
 const pfscore = 1

 ; Variables:
 ; a = lastPlayerX, b = lastPlayerY, c = powerGauge
 ; d = isMoving, e = laserDir, f = laserActive
 ; g = dynamiteCount, h = dynamiteFuse, i = dynamiteActive
 ; j = spiderX, k = spiderDir, m = lives
 ; n = gravityTimer, o = currentRoom

 goto start bank2

 bank 2
start

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

 ; Variables init
 a = 72 : b = 40 : c = 100
 d = 0 : e = 1 : f = 0
 g = 6 : h = 0 : i = 0
 j = 120 : k = -1 : m = 4
 n = 0 : o = 0

 ; Load first room
 gosub LoadRoom
 ; Start player inside room (center)
 player0x = 80
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
 if player0x > 150 then if o < 2 then o = o + 1 : gosub LoadRoom : player0x = 18
 ; Left edge -> previous room
 if player0x < 18 then if o > 0 then o = o - 1 : gosub LoadRoom : player0x = 148

 ; Boundaries
 if player0x < 18 then player0x = 18
 if player0x > 148 then player0x = 148
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
 if j < 40 then k = 1
 if j > 120 then k = -1
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

 ; Colors - set every frame
 COLUBK = $02
 COLUPF = $28
 COLUP0 = $C6
 COLUP1 = $1C
 scorecolor = $36

 drawscreen
 goto main

PlayerHit
 COLUBK = $34
 m = m - 1
 player0x = 80
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
 player0x = 80
 player0y = 30
 gosub LoadRoom
 return

LoadRoom
 pfclear
 ; ROOM_CODE_START
LoadRoom0
  pfhline 0 0 31 on
  pfhline 0 1 1 on
  pfhline 6 1 7 on
  pfhline 22 1 23 on
  pfhline 30 1 31 on
  pfhline 0 2 1 on
  pfhline 6 2 7 on
  pfhline 22 2 23 on
  pfhline 30 2 31 on
  pfhline 0 3 1 on
  pfhline 30 3 31 on
  pfhline 0 4 7 on
  pfhline 30 4 31 on
  pfhline 0 5 1 on
  pfhline 30 5 31 on
  pfhline 0 6 1 on
  pfhline 30 6 31 on
  pfhline 0 7 7 on
  pfhline 30 7 31 on
  pfhline 0 8 1 on
  pfhline 20 8 31 on
  pfhline 0 9 1 on
  pfhline 30 9 31 on
  pfhline 0 10 1 on
  pfhline 30 10 31 on
  pfhline 0 11 11 on
  pfhline 20 11 31 on
  return

LoadRoom1
  pfhline 0 0 11 on
  pfhline 20 0 31 on
  pfhline 0 1 1 on
  pfhline 30 1 31 on
  pfhline 0 2 1 on
  pfhline 30 2 31 on
  pfhline 0 3 1 on
  pfhline 30 3 31 on
  pfhline 0 4 1 on
  pfhline 30 4 31 on
  pfhline 0 5 1 on
  pfhline 30 5 31 on
  pfhline 0 6 1 on
  pfhline 30 6 31 on
  pfhline 0 7 1 on
  pfhline 30 7 31 on
  pfhline 0 8 1 on
  pfhline 30 8 31 on
  pfhline 0 9 1 on
  pfhline 30 9 31 on
  pfhline 0 10 1 on
  pfhline 30 10 31 on
  pfhline 0 11 31 on
  return
; ROOM_CODE_END
 return
