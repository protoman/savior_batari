; Savior - H.E.R.O. Atari 2600 Clone
; DPC+ kernel test - hardcoded playfield

 set kernel DPC+

 goto start bank2

 bank 2
start

 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
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

 a = 80 : b = 50
 player0x = a : player0y = b
 player1x = 60 : player1y = 50

main
 DF0FRACINC = 16
 DF1FRACINC = 16
 DF2FRACINC = 16
 DF3FRACINC = 32

 if joy0left then a = a - 1
 if joy0right then a = a + 1
 if joy0up then b = b - 1
 if joy0down then b = b + 1

 player0x = a
 player0y = b

 ; Spider patrol
 player1x = player1x + 1
 if player1x > 120 then player1x = 40

 COLUBK = $00
 COLUPF = $28
 COLUP0 = $C6
 COLUP1 = $1C

 drawscreen
 goto main
