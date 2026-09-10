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

 ; Store movement delta (like examples: track how much we moved)
 p = 0
 d = 0

 ; Horizontal movement
 if joy0left then player0x = player0x - 1 : p = 255 : e = 0
 if joy0right then player0x = player0x + 1 : p = 1 : e = 1

 ; Vertical movement
 if joy0up then player0y = player0y - 1 : d = 255 : n = 0

 ; Gravity
 if !joy0up then n = n + 1
 if !joy0up then if n >= 2 then player0y = player0y + 1 : d = 1 : n = 0

 ; Room transitions (before drawscreen, like the example)
 ; Right edge -> next room
 if player0x > 150 then if o < 2 then o = o + 1 : gosub LoadRoom : player0x = 18
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
 COLUPF = $28
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
 $04
end

 drawscreen

 ; Check collision AFTER drawscreen (like the example)
 ; When moving straight up and hitting ceiling, only undo vertical (allows sliding sideways)
 ; When moving diagonally, undo both to prevent passing through side walls
 if collision(player0, playfield) then if d = 255 && p = 0 then player0y = player0y - d
 if collision(player0, playfield) then if d <> 255 || p <> 0 then player0x = player0x - p
 if collision(player0, playfield) then if d <> 255 || p <> 0 then player0y = player0y - d

 ; Boundaries
 if player0x < 18 then player0x = 18
 if player0x > 148 then player0x = 148
 if player0y < 10 then player0y = 10

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
