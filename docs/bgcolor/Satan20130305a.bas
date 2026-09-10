 rem batari Basic Program
 rem created 10/18/2011 5:21:01 PM by Visual bB Version 1.0.0.565

 bank 1
 
 temp1 = temp1

 rem  set tv ntsc
 set kernel DPC+
 set smartbranching on
 set optimization inlinerand
 set kernel_options collision(playfield,player1) 

 dim myx = k.l


 goto MAIN bank2

 rem *****************************************************
 bank 2
 rem ***************************************************** 
 temp1 = temp1
 dim titlescreencolor=c.d

 dim wait=w
 titlescreencolor=$00


MAIN

 goto StartInBank3 bank3
 m=0

MAIN2

 DF0FRACINC = 128
 DF1FRACINC = 128
 DF2FRACINC = 128
 DF3FRACINC = 128
 DF4FRACINC = 255
 DF6FRACINC = 255
 bkcolors:
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $54
 $56
 $56
 $58
 $5A
 $5C
 $02
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $04
 $00
 $00
 $00
 $00
 $22
 $22
 $22
 $22
 $22
 $00
end
 pfcolors:
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $64
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $62
 $64
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
 $B2
 $B2
 $B2
 $B2
 $B2
 $B2
 $B2
 $B2
 $B2
 $B2
 $B2
 $B2
 $B0
 $B0
 $0C
 $0C
 $00
 $00
 $00
 $00
end
 playfield:
 ..XXXXXXXXXXXXXXXXXXXXXXXXXXXXX.
 .XXXXXXXXXXXXXXXXXXX............
 XXXXXX..........................
 XXXXXXX.........................
 .XXXXXXXXXX.....................
 ..XXXXXXXXXXXXXXXXXXXXXXXX......
 .XXXXXXXXXXXXXXXXXXXXXXX........
 XXXXXXXXXXXXXXXXXXXXXXXXXX...XXX
 XXXXXXXXXXXXXXXXXXXXXXXX......XX
 XXXXXXXXXXXXXXXXXXXXXXX.........
 XXXXXXXXXXXXXXXXXXXXXXXX........
 ..XXXXXXXXXXXXXXXXXXXX..........
 X..XXXXXXXXXXXXXXXXXX...........
 XXXXXXXXXXXXXXXXX...............
 XXXXXXXXXXXXXXXXXXXX............
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 .XXXXXXXXXXXXXXXXXXXXXXXXXXXXX..
 ...XXX.....XXXXXXXXXXXXXXXXXX...
 .........XXXXXXXXXXXXXXXXXX.....
 .....XXXXXXXXXXXXXXXXXXXXX......
 ..XXXXXXXXXXXXXXXXXXXXXXXX......
 .XXXXXXXXXXXXXXXXXXXXXXXX.......
 XXXXXXXXXXXXXXXXXXXXXXXX.......X
 XXXXXXXXXXXXXXXXXXXXXXX.......XX
 XXXXXXXXXXXXXXXXXXXXX..........X
 XXXXXXXXXXXXXXXXXXXX..........XX
 XXXXXXXXXXXXXXXXXX...........XXX
 .XXXXXXXXXX.................XXX.
 ...............................X
 XXXX............................
 ................................
 ................................
 ...XXXXXXXXXXXXXXXX.............
 ....XXXXXXXXXXXXXXXX............
 .....XXXXXXXXXXXXXXXX...........
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX.
 .XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 ......XXXXXXXXXXXXXXXXXXX.......
 .......XXXXXXXXXXXXXXXXXXX......
 ..............................X.
 ..............................X.
 ..............................X.
 ..............................X.
 ..............................X.
 ..............................XX
 ..............................XX
 ..............................XX
 ..............................XX
 .............................XXX
 .............................XXX
 .............................XXX
 .............................XXX
 .............................XXX
 .............................XXX
 .............................XXX
 .............................XXX
 .............................XXX
 .............................XXX
 .............................XXX
 .............................XXX
 .............................XXX
 .............................XXX
 ............................XXXX
 ............................XXXX
 ............................XXXX
 ...X........................XXXX
 ..XXX.....X.................XXXX
 .XXXXX...XXX................XXXX
 XXXXXXX.XXXXX.X.............XXXX
 ..........XXXXXXXXX.............
 ........XXXXX.XXX.XXXX..........
 .....XXXXXXXXXXXXXXX.XXX........
 ....XXXXXX.XXXXXXXXXXXXXX.......
 ..XXXXXXXXXXXXXXXXX.XXXX.XX.....
 ..XXXXXXXXXXXXXXXXXXXX.XXXXXX...
 .XXXXX.XXXXXXXXXXXXXXXXXXX.XXX..
 .X.XXXXXXXXXXXXXXXXXXXXXXXXXXXX.
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 ....XXXXXXXXXXXXXXXXXXXXXXXXX...
 .....XXX.XXXXXXXXXXXXXXXXXXX....
 ......X...XXX...................
 ........................XXX.....
 ........................XXX.....
 ........................XXXXXXXX
 ........................XXXXXXXX
 ........................XXXXXXXX
 ........................XXXXXXXX
end



 rem  PF0 = 149
 rem 
 rem   missile0x = 134
 player0color:
 $C8
 $CC
 $C8
 $C8
 $C8
 $C6
 $C8
 $CA
 $C8
 $C8
 $C8
 $C8
 $C8
 $DA
 $BA
 $38
end

bird1
 player0:
 %00001000
 %00011000
 %00111000
 %01111000
 %11111100
 %11111100
 %00011111
 %00011111
 %00011110
 %00111110
 %00110110
 %01100100
 %01000100
 %11000100
 %11000000
 %01000000
end


 player2color:
 $C8
 $CC
 $C8
 $C8
 $C8
 $C6
 $C8
 $CA
 $C8
 $C8
 $C8
 $C8
 $C8
 $DA
 $BA
 $38
end

 player3color:
 $C8
 $CC
 $C8
 $C8
 $C8
 $C6
 $C8
 $CA
 $C8
 $C8
 $C8
 $C8
 $C8
 $DA
 $BA
 $38
end

 player4color:
 $C8
 $CC
 $C8
 $C8
 $C8
 $C6
 $C8
 $CA
 $C8
 $C8
 $C8
 $C8
 $C8
 $DA
 $BA
 $38
end

 player2-4:
 %00001000
 %00011000
 %00111000
 %01111000
 %11111100
 %11111100
 %00011111
 %00011111
 %00011110
 %00111110
 %00110110
 %01100100
 %01000100
 %11000100
 %11000000
 %01000000
end
 player1color:
 $1A
 $1A
 $1A
 $1A
 $1A
 $1A
 $1A
 $1A
 $1A
 $1A
 $1A
 $1A
 $1A
 $1A
end

god1
 player1:
 %00011000
 %00010000
 %00011000
 %00011000
 %00010000
 %01111110
 %00011000
 %01011010
 %01011010
 %01000010
 %11011011
 %00111100
 %10100101
 %01000010
end
 
 player8color:
 $42
 $42
 $42
 $42
 $42
 $42
 $42
 $42
end

pit
 player8:
 %00100010
 %01010101
 %10001000
 %00100010
 %01010101
 %10001000
 %01010101
 %10101010
end

 REFP0 = 8
 NUSIZ0 = $14
 player0x = 18+myx/2 : player0y =24-myx 
 NUSIZ2 = $14:  NUSIZ2{3} = 1
 player2x = 30+myx/2 : player2y = 1+myx 
 NUSIZ3 = $14
 rem  NUSIZ2{3} =1
 player3x = 42-myx/2 : player3y =25+myx 
 rem  NUSIZ3 = $14
 rem  player3x = 30-myx/2 : player3y =47-myx 
 NUSIZ4 = $14
 player4x = 56: player4y = 78
 NUSIZ8 = $17 ; 5 Double 7 Quad size player pit
 player8x = 111: player8y = 170

 player1x = 16 + m: player1y = 150


 m=m+1: if m=100  then m=1
 myx = myx + 0.5: if myx = 24 then myx = 0 
 if myx > 140 then myx = 0
 rem  player5x = 96 + myx-8: player5y = 29
 rem 
 rem 
 rem    AUDV0 = 8
 rem    AUDC0 = 2
 rem    AUDF0 = 14
 rem 
 rem    AUDV1 = 8
 rem    AUDC1 = 2
 rem    if joy0fire then AUDF1 = 8 else AUDC1 = 0
 rem 
   rem  *****************************************************
   rem  *
   rem  *  Main game loop starts here.
   rem  *
   rem  *****************************************************
 
   ballx = m + 18: bally = 166
   ballheight = 4 : rem * Ball 4 pixels high for bridge piece.
   CTRLPF = $21 : rem * Ball $3x = 8 pixels wide. $21 =4 wide

  COLUM0 = $18 ; missile 0 colour Line
  missile0x = 59
  missile0y = 180
  missile0height = 9

 rem   _NUSIZ1 = $27
 rem   COLUM1 = $44 ; missile 0 colour
 rem   missile1x = rand
 rem   missile1y = rand
 rem   missile1height = 1
 rem 

 rem   missile9height = 1
 rem 
 rem   NUSIZ9 = $13
 rem 
 rem    COLUPF = $1E : rem * Ball/playfield color.
 rem 


 drawscreen

 if player0x < 144 then goto MAIN2

 goto MAIN2


 rem *****************************************************
 bank 3
 rem ***************************************************** 
 rem  const scorepointers=player1x
 temp1 = temp1
StartInBank3

 const fontstyle = 7
 const scorepointers=99

 score = 2013
 
 scorecolors:
 $40
 $40
 $40
 $40
 $40
 $40
 $40
 $40
end



 rem *** The selected game number. The game selection minikernel displays 
 rem *** this variable
 dim gamenumber=q

 rem *** this debounce variable is used to slow down the game number selection
 dim swdebounce=r

 const scorefade=1

 scorecolor=$1a

 swdebounce=0
 gamenumber=1

titlepage
 gosub titledraw bank6
 if joy0fire || switchreset then goto gamestart
 if !switchselect then swdebounce=0
 if swdebounce>0  then swdebounce=swdebounce-1: goto titlepage
 if switchselect then swdebounce=30: gamenumber=gamenumber+1
 if gamenumber=21 then gamenumber=1

 rem *** make scorecolor color-cycle
 scorecolor = scorecolor - 3


 rem *** Game start. If you move the joystick it goes to the game.

gamestart

 drawscreen
 if joy0left || joy0right then goto MAIN2 bank2
 if joy0up || joy0down then goto MAIN2 bank2
 goto titlepage

 rem *****************************************************
 bank 4
 rem ***************************************************** 
 temp1 = temp1

 rem *****************************************************
 bank 5
 rem ***************************************************** 
 temp1 = temp1

 rem *****************************************************
 bank 6
 rem ***************************************************** 
 temp1 = temp1

titledraw
 asm
 include "titlescreen/asm/titlescreen.asm"
end

