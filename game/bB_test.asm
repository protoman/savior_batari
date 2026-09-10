batari Basic v1.8 (c)2025
game
.
 ;;line 1;; 

.
 ;;line 2;; 

.
 ;;line 3;; 

.
 ;;line 4;; 

.L00 ;;line 5;;  dim lastPlayerX = e

.L01 ;;line 6;;  dim lastPlayerY = f

.L02 ;;line 7;;  dim powerGauge = g

.L03 ;;line 8;;  dim isMoving = i

.L04 ;;line 9;;  dim laserActive = j

.L05 ;;line 10;;  dim laserDirection = k

.L06 ;;line 11;;  dim dynamiteCount = l

.L07 ;;line 12;;  dim dynamiteActive = m

.L08 ;;line 13;;  dim dynamiteFuse = n

.L09 ;;line 14;;  dim spiderX = o

.L010 ;;line 15;;  dim spiderY = p

.L011 ;;line 16;;  dim spiderActive = q

.L012 ;;line 17;;  dim spiderDir = r

.L013 ;;line 18;;  dim batX = s

.L014 ;;line 19;;  dim batY = t

.L015 ;;line 20;;  dim batActive = u

.L016 ;;line 21;;  dim batDir = v

.L017 ;;line 22;;  dim batFlyUp = w

.L018 ;;line 23;;  dim currentRoom = x

.L019 ;;line 24;;  dim screenTransition = y

.
 ;;line 25;; 

.
 ;;line 26;; 

.L020 ;;line 27;;  e = 76

	LDA #76
	STA e
.L021 ;;line 28;;  f = 40

	LDA #40
	STA f
.L022 ;;line 29;;  g = 100

	LDA #100
	STA g
.L023 ;;line 30;;  i = 0

	LDA #0
	STA i
.L024 ;;line 31;;  j = 0

	LDA #0
	STA j
.L025 ;;line 32;;  k = 1

	LDA #1
	STA k
.L026 ;;line 33;;  l = 6

	LDA #6
	STA l
.L027 ;;line 34;;  m = 0

	LDA #0
	STA m
.L028 ;;line 35;;  n = 0

	LDA #0
	STA n
.L029 ;;line 36;;  o = 100

	LDA #100
	STA o
.L030 ;;line 37;;  p = 70

	LDA #70
	STA p
.L031 ;;line 38;;  q = 1

	LDA #1
	STA q
.L032 ;;line 39;;  r = 1

	LDA #1
	STA r
.L033 ;;line 40;;  s = 30

	LDA #30
	STA s
.L034 ;;line 41;;  t = 20

	LDA #20
	STA t
.L035 ;;line 42;;  u = 1

	LDA #1
	STA u
.L036 ;;line 43;;  v = 1

	LDA #1
	STA v
.L037 ;;line 44;;  w = 0

	LDA #0
	STA w
.L038 ;;line 45;;  x = 0

	LDA #0
	STA x
.L039 ;;line 46;;  y = 0

	LDA #0
	STA y
.
 ;;line 47;; 

.
 ;;line 48;; 

.L040 ;;line 49;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L041 ;;line 50;;  COLUPF = $0A

	LDA #$0A
	STA COLUPF
.L042 ;;line 51;;  COLUP0 = $1A

	LDA #$1A
	STA COLUP0
.L043 ;;line 52;;  COLUP1 = $34

	LDA #$34
	STA COLUP1
.
 ;;line 53;; 

.
 ;;line 54;; 

.L044 ;;line 55;;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %10011111, %01111111
	if (pfwidth>2)
	.byte %01111111, %01011111
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %10011111, %01111111
	if (pfwidth>2)
	.byte %01111111, %01011111
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %10011111, %01111111
	if (pfwidth>2)
	.byte %01111111, %01011111
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %10011111, %01111111
	if (pfwidth>2)
	.byte %01111111, %01011111
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
.
 ;;line 68;; 

.
 ;;line 69;; 

.L045 ;;line 70;;  player0:

	LDX #<playerL045_0
	STX player0pointerlo
	LDA #>playerL045_0
	STA player0pointerhi
	LDA #10
	STA player0height
.
 ;;line 83;; 

.
 ;;line 84;; 

.L046 ;;line 85;;  player1:

	LDX #<playerL046_1
	STX player1pointerlo
	LDA #>playerL046_1
	STA player1pointerhi
	LDA #10
	STA player1height
.
 ;;line 98;; 

.
 ;;line 99;; 

.L047 ;;line 100;;  player0x = 76

	LDA #76
	STA player0x
.L048 ;;line 101;;  player0y = 40

	LDA #40
	STA player0y
.
 ;;line 102;; 

.main
 ;;line 103;; main

.
 ;;line 104;; 

.L049 ;;line 105;;  e = player0x

	LDA player0x
	STA e
.L050 ;;line 106;;  f = player0y

	LDA player0y
	STA f
.L051 ;;line 107;;  i = 0

	LDA #0
	STA i
.
 ;;line 108;; 

.
 ;;line 109;; 

.L052 ;;line 110;;  if joy0left then player0x = player0x  -  1  :  i = 1  :  k = 0

 bit SWCHA
	BVS .skipL052
.condpart0
	DEC player0x
	LDA #1
	STA i
	LDA #0
	STA k
.skipL052
.L053 ;;line 111;;  if joy0right then player0x = player0x  +  1  :  i = 1  :  k = 1

 bit SWCHA
	BMI .skipL053
.condpart1
	INC player0x
	LDA #1
	STA i
	STA k
.skipL053
.
 ;;line 112;; 

.
 ;;line 113;; 

.L054 ;;line 114;;  if joy0up then player0y = player0y  -  2  :  i = 1

 lda #$10
 bit SWCHA
	BNE .skipL054
.condpart2
	LDA player0y
	SEC
	SBC #2
	STA player0y
	LDA #1
	STA i
.skipL054
.
 ;;line 115;; 

.
 ;;line 116;; 

.L055 ;;line 117;;  if !joy0up then player0y = player0y  +  1

 lda #$10
 bit SWCHA
	BEQ .skipL055
.condpart3
	INC player0y
.skipL055
.
 ;;line 118;; 

.
 ;;line 119;; 

.L056 ;;line 120;;  if joy0fire then if j = 0 then j = 1  :  missile0x = player0x  +  3  :  missile0y = player0y  +  2

 bit INPT4
	BMI .skipL056
.condpart4
	LDA j
	CMP #0
     BNE .skip4then
.condpart5
	LDA #1
	STA j
	LDA player0x
	CLC
	ADC #3
	STA missile0x
	LDA player0y
	CLC
	ADC #2
	STA missile0y
.skip4then
.skipL056
.
 ;;line 121;; 

.
 ;;line 122;; 

.L057 ;;line 123;;  if j = 1 then if k = 1 then missile0x = missile0x  +  4

	LDA j
	CMP #1
     BNE .skipL057
.condpart6
	LDA k
	CMP #1
     BNE .skip6then
.condpart7
	LDA missile0x
	CLC
	ADC #4
	STA missile0x
.skip6then
.skipL057
.L058 ;;line 124;;  if j = 1 then if k = 0 then missile0x = missile0x  -  4

	LDA j
	CMP #1
     BNE .skipL058
.condpart8
	LDA k
	CMP #0
     BNE .skip8then
.condpart9
	LDA missile0x
	SEC
	SBC #4
	STA missile0x
.skip8then
.skipL058
.L059 ;;line 125;;  if j = 1 then if missile0x  <  1 then j = 0

	LDA j
	CMP #1
     BNE .skipL059
.condpart10
	LDA missile0x
	CMP #1
     BCS .skip10then
.condpart11
	LDA #0
	STA j
.skip10then
.skipL059
.L060 ;;line 126;;  if j = 1 then if missile0x  >  150 then j = 0

	LDA j
	CMP #1
     BNE .skipL060
.condpart12
	LDA #150
	CMP missile0x
     BCS .skip12then
.condpart13
	LDA #0
	STA j
.skip12then
.skipL060
.L061 ;;line 127;;  if j = 1 then if collision(missile0,playfield) then j = 0

	LDA j
	CMP #1
     BNE .skipL061
.condpart14
	bit 	CXM0FB
	BPL .skip14then
.condpart15
	LDA #0
	STA j
.skip14then
.skipL061
.L062 ;;line 128;;  if !joy0fire then j = 0

 bit INPT4
	BPL .skipL062
.condpart16
	LDA #0
	STA j
.skipL062
.
 ;;line 129;; 

.
 ;;line 130;; 

.L063 ;;line 131;;  if joy0down then if m = 0 then if l  >  0 then gosub PlaceDynamite

 lda #$20
 bit SWCHA
	BNE .skipL063
.condpart17
	LDA m
	CMP #0
     BNE .skip17then
.condpart18
	LDA #0
	CMP l
     BCS .skip18then
.condpart19
 jsr .PlaceDynamite

.skip18then
.skip17then
.skipL063
.
 ;;line 132;; 

.
 ;;line 133;; 

.L064 ;;line 134;;  if m = 1 then gosub UpdateDynamite

	LDA m
	CMP #1
     BNE .skipL064
.condpart20
 jsr .UpdateDynamite

.skipL064
.
 ;;line 135;; 

.
 ;;line 136;; 

.L065 ;;line 137;;  if q = 1 then gosub UpdateSpider

	LDA q
	CMP #1
     BNE .skipL065
.condpart21
 jsr .UpdateSpider

.skipL065
.
 ;;line 138;; 

.
 ;;line 139;; 

.L066 ;;line 140;;  if u = 1 then gosub UpdateBat

	LDA u
	CMP #1
     BNE .skipL066
.condpart22
 jsr .UpdateBat

.skipL066
.
 ;;line 141;; 

.
 ;;line 142;; 

.L067 ;;line 143;;  if collision(player0,player1) then goto PlayerHit

	bit 	CXPPMM
	BPL .skipL067
.condpart23
 jmp .PlayerHit

.skipL067
.
 ;;line 144;; 

.
 ;;line 145;; 

.L068 ;;line 146;;  if j = 1 then if collision(missile0,player1) then gosub KillSpider

	LDA j
	CMP #1
     BNE .skipL068
.condpart24
	bit 	CXM0P
	BPL .skip24then
.condpart25
 jsr .KillSpider

.skip24then
.skipL068
.
 ;;line 147;; 

.
 ;;line 148;; 

.L069 ;;line 149;;  if player0x  <  1 then gosub TransitionLeft

	LDA player0x
	CMP #1
     BCS .skipL069
.condpart26
 jsr .TransitionLeft

.skipL069
.L070 ;;line 150;;  if player0x  >  148 then gosub TransitionRight

	LDA #148
	CMP player0x
     BCS .skipL070
.condpart27
 jsr .TransitionRight

.skipL070
.L071 ;;line 151;;  if player0y  <  10 then gosub TransitionUp

	LDA player0y
	CMP #10
     BCS .skipL071
.condpart28
 jsr .TransitionUp

.skipL071
.L072 ;;line 152;;  if player0y  >  90 then gosub TransitionDown

	LDA #90
	CMP player0y
     BCS .skipL072
.condpart29
 jsr .TransitionDown

.skipL072
.
 ;;line 153;; 

.
 ;;line 154;; 

.L073 ;;line 155;;  if y = 0 then if player0x  <  1 then player0x = 1

	LDA y
	CMP #0
     BNE .skipL073
.condpart30
	LDA player0x
	CMP #1
     BCS .skip30then
.condpart31
	LDA #1
	STA player0x
.skip30then
.skipL073
.L074 ;;line 156;;  if y = 0 then if player0x  >  148 then player0x = 148

	LDA y
	CMP #0
     BNE .skipL074
.condpart32
	LDA #148
	CMP player0x
     BCS .skip32then
.condpart33
	LDA #148
	STA player0x
.skip32then
.skipL074
.L075 ;;line 157;;  if y = 0 then if player0y  <  10 then player0y = 10

	LDA y
	CMP #0
     BNE .skipL075
.condpart34
	LDA player0y
	CMP #10
     BCS .skip34then
.condpart35
	LDA #10
	STA player0y
.skip34then
.skipL075
.L076 ;;line 158;;  if y = 0 then if player0y  >  90 then player0y = 90

	LDA y
	CMP #0
     BNE .skipL076
.condpart36
	LDA #90
	CMP player0y
     BCS .skip36then
.condpart37
	LDA #90
	STA player0y
.skip36then
.skipL076
.
 ;;line 159;; 

.
 ;;line 160;; 

.L077 ;;line 161;;  if collision(player0,playfield) then goto RestorePosition

	bit 	CXP0FB
	BPL .skipL077
.condpart38
 jmp .RestorePosition

.skipL077
.
 ;;line 162;; 

.
 ;;line 163;; 

.L078 ;;line 164;;  if i = 1 then g = g  -  1

	LDA i
	CMP #1
     BNE .skipL078
.condpart39
	DEC g
.skipL078
.
 ;;line 165;; 

.
 ;;line 166;; 

.L079 ;;line 167;;  if g  <=  0 then goto GameOver

	LDA #0
	CMP g
     BCC .skipL079
.condpart40
 jmp .GameOver

.skipL079
.
 ;;line 168;; 

.
 ;;line 169;; 

.L080 ;;line 170;;  score = g  *  100

	LDA #$055
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.
 ;;line 171;; 

.
 ;;line 172;; 

.L081 ;;line 173;;  e = player0x

	LDA player0x
	STA e
.L082 ;;line 174;;  f = player0y

	LDA player0y
	STA f
.
 ;;line 175;; 

.
 ;;line 176;; 

.L083 ;;line 177;;  player1x = o

	LDA o
	STA player1x
.L084 ;;line 178;;  player1y = p

	LDA p
	STA player1y
.
 ;;line 179;; 

.L085 ;;line 180;;  drawscreen

 jsr drawscreen
.L086 ;;line 181;;  goto main

 jmp .main

.
 ;;line 182;; 

.RestorePosition
 ;;line 183;; RestorePosition

.
 ;;line 184;; 

.L087 ;;line 185;;  player0x = e

	LDA e
	STA player0x
.L088 ;;line 186;;  player0y = f

	LDA f
	STA player0y
.L089 ;;line 187;;  drawscreen

 jsr drawscreen
.L090 ;;line 188;;  goto main

 jmp .main

.
 ;;line 189;; 

.GameOver
 ;;line 190;; GameOver

.
 ;;line 191;; 

.L091 ;;line 192;;  g = 100

	LDA #100
	STA g
.L092 ;;line 193;;  player0x = 76

	LDA #76
	STA player0x
.L093 ;;line 194;;  player0y = 40

	LDA #40
	STA player0y
.L094 ;;line 195;;  drawscreen

 jsr drawscreen
.L095 ;;line 196;;  goto main

 jmp .main

.
 ;;line 197;; 

.PlaceDynamite
 ;;line 198;; PlaceDynamite

.
 ;;line 199;; 

.L096 ;;line 200;;  m = 1

	LDA #1
	STA m
.L097 ;;line 201;;  n = 30

	LDA #30
	STA n
.L098 ;;line 202;;  l = l  -  1

	DEC l
.L099 ;;line 203;;  return

	RTS
.
 ;;line 204;; 

.UpdateDynamite
 ;;line 205;; UpdateDynamite

.
 ;;line 206;; 

.L0100 ;;line 207;;  n = n  -  1

	DEC n
.L0101 ;;line 208;;  if n  <=  0 then m = 0

	LDA #0
	CMP n
     BCC .skipL0101
.condpart41
	LDA #0
	STA m
.skipL0101
.L0102 ;;line 209;;  return

	RTS
.
 ;;line 210;; 

.UpdateSpider
 ;;line 211;; UpdateSpider

.
 ;;line 212;; 

.L0103 ;;line 213;;  o = o  +  r

	LDA o
	CLC
	ADC r
	STA o
.
 ;;line 214;; 

.
 ;;line 215;; 

.L0104 ;;line 216;;  if o  <  20 then r = 1

	LDA o
	CMP #20
     BCS .skipL0104
.condpart42
	LDA #1
	STA r
.skipL0104
.L0105 ;;line 217;;  if o  >  130 then r =  - 1

	LDA #130
	CMP o
     BCS .skipL0105
.condpart43
	LDA #255
	STA r
.skipL0105
.
 ;;line 218;; 

.L0106 ;;line 219;;  return

	RTS
.
 ;;line 220;; 

.UpdateBat
 ;;line 221;; UpdateBat

.
 ;;line 222;; 

.L0107 ;;line 223;;  s = s  +  v

	LDA s
	CLC
	ADC v
	STA s
.
 ;;line 224;; 

.
 ;;line 225;; 

.L0108 ;;line 226;;  if w = 0 then t = t  +  1

	LDA w
	CMP #0
     BNE .skipL0108
.condpart44
	INC t
.skipL0108
.L0109 ;;line 227;;  if w = 1 then t = t  -  1

	LDA w
	CMP #1
     BNE .skipL0109
.condpart45
	DEC t
.skipL0109
.
 ;;line 228;; 

.
 ;;line 229;; 

.L0110 ;;line 230;;  if t  >  30 then w = 1

	LDA #30
	CMP t
     BCS .skipL0110
.condpart46
	LDA #1
	STA w
.skipL0110
.L0111 ;;line 231;;  if t  <  15 then w = 0

	LDA t
	CMP #15
     BCS .skipL0111
.condpart47
	LDA #0
	STA w
.s2600 Basic compilation complete.
kipL0111
.
 ;;line 232;; 

.
 ;;line 233;; 

.L0112 ;;line 234;;  if s  <  20 then v = 1

	LDA s
	CMP #20
     BCS .skipL0112
.condpart48
	LDA #1
	STA v
.skipL0112
.L0113 ;;line 235;;  if s  >  130 then v =  - 1

	LDA #130
	CMP s
     BCS .skipL0113
.condpart49
	LDA #255
	STA v
.skipL0113
.
 ;;line 236;; 

.L0114 ;;line 237;;  return

	RTS
.
 ;;line 238;; 

.KillSpider
 ;;line 239;; KillSpider

.
 ;;line 240;; 

.L0115 ;;line 241;;  q = 0

	LDA #0
	STA q
.L0116 ;;line 242;;  j = 0

	LDA #0
	STA j
.
 ;;line 243;; 

.L0117 ;;line 244;;  score = score  +  100

	SED
	CLC
	LDA score+1
	ADC #$01
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.L0118 ;;line 245;;  return

	RTS
.
 ;;line 246;; 

.TransitionLeft
 ;;line 247;; TransitionLeft

.
 ;;line 248;; 

.L0119 ;;line 249;;  x = x  -  1

	DEC x
.L0120 ;;line 250;;  if x  <  0 then x = 2

	LDA x
	CMP #0
     BCS .skipL0120
.condpart50
	LDA #2
	STA x
.skipL0120
.L0121 ;;line 251;;  player0x = 140

	LDA #140
	STA player0x
.L0122 ;;line 252;;  y = 1

	LDA #1
	STA y
.L0123 ;;line 253;;  gosub LoadRoom

 jsr .LoadRoom

.L0124 ;;line 254;;  return

	RTS
.
 ;;line 255;; 

.TransitionRight
 ;;line 256;; TransitionRight

.
 ;;line 257;; 

.L0125 ;;line 258;;  x = x  +  1

	INC x
.L0126 ;;line 259;;  if x  >  2 then x = 0

	LDA #2
	CMP x
     BCS .skipL0126
.condpart51
	LDA #0
	STA x
.skipL0126
.L0127 ;;line 260;;  player0x = 10

	LDA #10
	STA player0x
.L0128 ;;line 261;;  y = 1

	LDA #1
	STA y
.L0129 ;;line 262;;  gosub LoadRoom

 jsr .LoadRoom

.L0130 ;;line 263;;  return

	RTS
.
 ;;line 264;; 

.TransitionUp
 ;;line 265;; TransitionUp

.
 ;;line 266;; 

.L0131 ;;line 267;;  player0y = 80

	LDA #80
	STA player0y
.L0132 ;;line 268;;  y = 1

	LDA #1
	STA y
.L0133 ;;line 269;;  return

	RTS
.
 ;;line 270;; 

.TransitionDown
 ;;line 271;; TransitionDown

.
 ;;line 272;; 

.L0134 ;;line 273;;  player0y = 15

	LDA #15
	STA player0y
.L0135 ;;line 274;;  y = 1

	LDA #1
	STA y
.L0136 ;;line 275;;  return

	RTS
.
 ;;line 276;; 

.LoadRoom
 ;;line 277;; LoadRoom

.
 ;;line 278;; 

.
 ;;line 279;; 

.L0137 ;;line 280;;  y = 0

	LDA #0
	STA y
.L0138 ;;line 281;;  return

	RTS
 if (<*) > (<(*+10))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL045_0
	.byte  %00111100
	.byte  %01111110
	.byte  %01111110
	.byte  %00111100
	.byte  %00100100
	.byte  %00100100
	.byte  %01111110
	.byte  %00111100
	.byte  %00111100
	.byte  %00111100
	.byte  %00011000
 if (<*) > (<(*+10))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL046_1
	.byte  %00000000
	.byte  %01000010
	.byte  %10100101
	.byte  %01000010
	.byte  %00000000
	.byte  %01000010
	.byte  %10100101
	.byte  %01000010
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
