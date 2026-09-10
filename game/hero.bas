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

 pfcolors:
 $28
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
 j = 0 : k = -1 : m = 4
 n = 0 : o = 0
 score = 123456

 ; Load first room
 gosub LoadRoom
 ; Start player inside room (center)
 player0x = 80
 player0y = 30

main
 ; Set DPC+ playfield fractional increments
 DF0FRACINC = 20
 DF1FRACINC = 20
 DF2FRACINC = 20
 DF3FRACINC = 20

 ; Check laser-spider collision (disabled)
 rem if f = 1 then if collision(missile0, player1) then j = 0 : f = 0

 ; Check player-spider collision (disabled)
 rem if collision(player0, player1) then gosub PlayerHit

 ; Store position
 a = player0x
 b = player0y
 d = 0

 ; Horizontal movement
 if joy0left then player0x = player0x - 1 : d = 1 : e = 0
 if joy0right then player0x = player0x + 1 : d = 1 : e = 1

 ; Check horizontal collision
 if collision(playfield, player0) then player0x = a

 ; Vertical movement
 if joy0up then player0y = player0y - 1 : d = 1 : n = 0

 ; Gravity
 if !joy0up then n = n + 1
 if !joy0up then if n >= 2 then player0y = player0y + 1 : n = 0

 ; Check vertical collision
 if collision(playfield, player0) then player0y = b

 ; Room transitions
 ; Right edge -> next room
 if player0x > 150 then if o < 2 then o = o + 1 : gosub LoadRoom : player0x = 18
 ; Left edge -> previous room
 if player0x < 18 then if o > 0 then o = o - 1 : gosub LoadRoom : player0x = 148

 ; Boundaries
 if player0x < 18 then player0x = 18
 if player0x > 148 then player0x = 148
 if player0y < 10 then player0y = 10

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

 ; Spider (disabled)
 rem if j > 0 then j = j + k
 rem if j < 60 then k = 1
 rem if j > 100 then k = -1
 rem if j > 0 then player1x = j
 rem if j > 0 then player1y = 50

 ; Power depletion
 if d = 1 then c = c - 1
 if c <= 0 then gosub GameOver

 ; Colors - set every frame
 COLUPF = $28
 COLUP0 = $0E
 COLUP1 = $1C
 scorecolor = $0E
 DF6FRACINC = 255
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
 $04
end

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
  pfhline 0 1 0 on
  pfhline 31 1 31 on
  pfhline 0 2 0 on
  pfhline 31 2 31 on
  pfhline 0 3 0 on
  pfhline 31 3 31 on
  pfhline 0 4 0 on
  pfhline 31 4 31 on
  pfhline 0 5 0 on
  pfhline 31 5 31 on
  pfhline 0 6 0 on
  pfhline 31 6 31 on
  pfhline 0 7 3 on
  pfhline 28 7 31 on
  pfhline 0 8 0 on
  pfhline 10 8 21 on
  pfhline 31 8 31 on
  pfhline 0 9 0 on
  pfhline 31 9 31 on
  pfhline 0 10 0 on
  pfhline 31 10 31 on
  pfhline 0 11 5 on
  pfhline 10 11 21 on
  pfhline 26 11 31 on
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
