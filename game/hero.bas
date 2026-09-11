; Savior - H.E.R.O. Atari 2600 Clone
; DPC+ kernel with dynamic room loading

 set kernel DPC+
 set kernel_options collision(playfield,player0)

 goto start bank2

 bank 2
start

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

 scorecolors:
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 end

 player0:
 %00011000
 %00111100
 %00111100
 %00111100
 %00100100
 %00100100
 %00111100
 %00111100
 %00111100
 %00011000
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
 dim startRoom = k
 dim startX = l
 dim startY = m
 dim minerRoom = q
 dim minerX = r
 dim minerY = s
 dim maxRoom = t
 a = 72 : b = 40 : c = 100
 d = 0 : e = 1 : f = 0
 g = 6 : h = 0 : i = 0
 j = 0 : n = 0 : o = 0
 score = 123456

; LEVEL_METADATA_START
; Level metadata (auto-generated from JSON)
; Player start
  startRoom = 0
  startX = 50
  startY = 32
; Miner goal
  minerRoom = 1
  minerX = 132
  minerY = 160
; Room count for transitions
  maxRoom = 1
; LEVEL_METADATA_END

 ; Load first room
 o = startRoom
 gosub LoadRoom
 ; Start player at editor-defined position
 player0x = startX
 player0y = startY

main
 ; Set DPC+ playfield fractional increments
 DF0FRACINC = 20
 DF1FRACINC = 20
 DF2FRACINC = 20
 DF3FRACINC = 20
 DF4FRACINC = 255

 ; Store movement delta (like examples: track how much we moved)
 p = 0
 d = 0

 ; Horizontal movement
 if joy0left then player0x = player0x - 1 : p = 255 : e = 0
 if joy0right then player0x = player0x + 1 : p = 1 : e = 1

 ; Vertical movement — skip UP if head was touching playfield last frame
 if joy0up then if j = 0 then player0y = player0y - 1 : d = 255 : n = 0

 ; Gravity
 if !joy0up then n = n + 1
 if !joy0up then if n >= 2 then player0y = player0y + 1 : d = 1 : n = 0

 ; Room transitions (before drawscreen, like the example)
 ; Right edge -> next room
 if player0x > 150 then if o < maxRoom then o = o + 1 : gosub LoadRoom : player0x = 18
 ; Left edge -> previous room
 if player0x < 18 then if o > 0 then o = o - 1 : gosub LoadRoom : player0x = 148

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

 ; Colors - set every frame
 COLUP0 = $0E
 COLUP1 = $1C
 scorecolor = $0E
 DF6FRACINC = 255
 player0:
 %00011000
 %00111100
 %00111100
 %00111100
 %00100100
 %00100100
 %00111100
 %00111100
 %00111100
 %00011000
 %00011000
end
 bkcolors:
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $74
 $74
 $74
 $74
 $74
 $74
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
end

 pfcolors:
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $B4
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
 $32
end

 drawscreen

 ; Simple collision check after drawscreen (matches the example)
 if collision(player0, playfield) then player0x = player0x - p
 if collision(player0, playfield) then player0y = player0y - d

 ; Save collision state for next frame (used to block UP when head touches ceiling)
 j = 0
 if collision(player0, playfield) then j = 1

 ; Boundaries
 if player0x > 148 then player0x = 148

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
 pfclear; ROOM_CODE_START
LoadRoom0
  pfhline 0 0 12 on
  pfhline 19 0 31 on
  pfhline 0 1 3 on
  pfhline 28 1 31 on
  pfhline 0 2 3 on
  pfhline 28 2 31 on
  pfhline 0 3 3 on
  pfhline 28 3 31 on
  pfhline 0 4 1 on
  pfhline 30 4 31 on
  pfhline 0 5 1 on
  pfhline 30 5 31 on
  pfhline 0 6 1 on
  pfhline 30 6 31 on
  pfhline 0 7 1 on
  pfhline 30 7 31 on
  pfhline 0 8 13 on
  pfhline 19 8 31 on
  pfhline 0 9 13 on
  pfhline 19 9 31 on
  pfhline 0 10 13 on
  pfhline 19 10 31 on
  pfhline 0 11 13 on
  pfhline 19 11 31 on
  return

LoadRoom1
  pfhline 0 0 5 on
  pfhline 10 0 21 on
  pfhline 26 0 31 on
  pfhline 0 1 0 on
  pfhline 15 1 16 on
  pfhline 31 1 31 on
  pfhline 0 2 0 on
  pfhline 15 2 16 on
  pfhline 31 2 31 on
  pfhline 0 3 0 on
  pfhline 15 3 16 on
  pfhline 31 3 31 on
  pfhline 0 4 0 on
  pfhline 15 4 16 on
  pfhline 31 4 31 on
  pfhline 0 5 0 on
  pfhline 15 5 16 on
  pfhline 31 5 31 on
  pfhline 0 6 0 on
  pfhline 15 6 16 on
  pfhline 31 6 31 on
  pfhline 0 7 0 on
  pfhline 15 7 16 on
  pfhline 31 7 31 on
  pfhline 0 8 0 on
  pfhline 15 8 16 on
  pfhline 31 8 31 on
  pfhline 0 9 0 on
  pfhline 15 9 16 on
  pfhline 31 9 31 on
  pfhline 0 10 0 on
  pfhline 15 10 16 on
  pfhline 31 10 31 on
  pfhline 0 11 31 on
  return
; ROOM_CODE_END
return
