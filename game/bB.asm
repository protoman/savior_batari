game
.
 ;;line 1;; 

.
 ;;line 2;; 

.
 ;;line 3;; 

.L00 ;;line 4;;  set romsize 16k

.L01 ;;line 5;;  const pfscore = 1

.
 ;;line 6;; 

.
 ;;line 7;; 

.
 ;;line 8;; 

.
 ;;line 9;; 

.
 ;;line 10;; 

.
 ;;line 11;; 

.
 ;;line 12;; 

.
 ;;line 13;; 

.L02 ;;line 14;;  a = 72  :  b = 40  :  c = 100

	LDA #72
	STA a
	LDA #40
	STA b
	LDA #100
	STA c
.L03 ;;line 15;;  d = 0  :  e = 1  :  f = 0

	LDA #0
	STA d
	LDA #1
	STA e
	LDA #0
	STA f
.L04 ;;line 16;;  g = 6  :  h = 0  :  i = 0

	LDA #6
	STA g
	LDA #0
	STA h
	STA i
.L05 ;;line 17;;  j = 120  :  k =  - 1  :  m = 4

	LDA #120
	STA j
	LDA #255
	STA k
	LDA #4
	STA m
.L06 ;;line 18;;  n = 0  :  o = 0

	LDA #0
	STA n
	STA o
.
 ;;line 19;; 

.
 ;;line 20;; 

.L07 ;;line 21;;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
.
 ;;line 34;; 

.L08 ;;line 35;;  player0:

	LDX #<playerL08_0
	STX player0pointerlo
	LDA #>playerL08_0
	STA player0pointerhi
	LDA #10
	STA player0height
.
 ;;line 48;; 

.L09 ;;line 49;;  player1:

	LDX #<playerL09_1
	STX player1pointerlo
	LDA #>playerL09_1
	STA player1pointerhi
	LDA #10
	STA player1height
.
 ;;line 62;; 

.
 ;;line 63;; 

.L010 ;;line 64;;  gosub LoadRoom

 jsr .LoadRoom

.
 ;;line 65;; 

.L011 ;;line 66;;  player0x = 80

	LDA #80
	STA player0x
.L012 ;;line 67;;  player0y = 30

	LDA #30
	STA player0y
.
 ;;line 68;; 

.main
 ;;line 69;; main

.
 ;;line 70;; 

.L013 ;;line 71;;  if f = 1 then if collision(missile0,player1) then j = 0  :  f = 0

	LDA f
	CMP #1
     BNE .skipL013
.condpart0
	bit 	CXM0P
	BPL .skip0then
.condpart1
	LDA #0
	STA j
	STA f
.skip0then
.skipL013
.
 ;;line 72;; 

.
 ;;line 73;; 

.L014 ;;line 74;;  if collision(player0,player1) then gosub PlayerHit

	bit 	CXPPMM
	BPL .skipL014
.condpart2
 jsr .PlayerHit

.skipL014
.
 ;;line 75;; 

.
 ;;line 76;; 

.L015 ;;line 77;;  a = player0x

	LDA player0x
	STA a
.L016 ;;line 78;;  b = player0y

	LDA player0y
	STA b
.L017 ;;line 79;;  d = 0

	LDA #0
	STA d
.
 ;;line 80;; 

.
 ;;line 81;; 

.L018 ;;line 82;;  if joy0left then player0x = player0x  -  1  :  d = 1  :  e = 0

 bit SWCHA
	BVS .skipL018
.condpart3
	DEC player0x
	LDA #1
	STA d
	LDA #0
	STA e
.skipL018
.L019 ;;line 83;;  if joy0right then player0x = player0x  +  1  :  d = 1  :  e = 1

 bit SWCHA
	BMI .skipL019
.condpart4
	INC player0x
	LDA #1
	STA d
	STA e
.skipL019
.
 ;;line 84;; 

.
 ;;line 85;; 

.L020 ;;line 86;;  if collision(player0,playfield) then player0x = a

	bit 	CXP0FB
	BPL .skipL020
.condpart5
	LDA a
	STA player0x
.skipL020
.
 ;;line 87;; 

.
 ;;line 88;; 

.L021 ;;line 89;;  if joy0up then player0y = player0y  -  1  :  d = 1  :  n = 0

 lda #$10
 bit SWCHA
	BNE .skipL021
.condpart6
	DEC player0y
	LDA #1
	STA d
	LDA #0
	STA n
.skipL021
.
 ;;line 90;; 

.
 ;;line 91;; 

.L022 ;;line 92;;  if !joy0up then n = n  +  1

 lda #$10
 bit SWCHA
	BEQ .skipL022
.condpart7
	INC n
.skipL022
.L023 ;;line 93;;  if !joy0up then if n  >=  4 then player0y = player0y  +  1  :  n = 0

 lda #$10
 bit SWCHA
	BEQ .skipL023
.condpart8
	LDA n
	CMP #4
     BCC .skip8then
.condpart9
	INC player0y
	LDA #0
	STA n
.skip8then
.skipL023
.
 ;;line 94;; 

.
 ;;line 95;; 

.L024 ;;line 96;;  if collision(player0,playfield) then player0y = b

	bit 	CXP0FB
	BPL .skipL024
.condpart10
	LDA b
	STA player0y
.skipL024
.
 ;;line 97;; 

.
 ;;line 98;; 

.
 ;;line 99;; 

.L025 ;;line 100;;  if player0x  >  150 then if o  <  2 then o = o  +  1  :  gosub LoadRoom  :  player0x = 18

	LDA #150
	CMP player0x
     BCS .skipL025
.condpart11
	LDA o
	CMP #2
     BCS .skip11then
.condpart12
	INC o
 jsr .LoadRoom
	LDA #18
	STA player0x
.skip11then
.skipL025
.
 ;;line 101;; 

.L026 ;;line 102;;  if player0x  <  18 then if o  >  0 then o = o  -  1  :  gosub LoadRoom  :  player0x = 148

	LDA player0x
	CMP #18
     BCS .skipL026
.condpart13
	LDA #0
	CMP o
     BCS .skip13then
.condpart14
	DEC o
 jsr .LoadRoom
	LDA #148
	STA player0x
.skip13then
.skipL026
.
 ;;line 103;; 

.
 ;;line 104;; 

.L027 ;;line 105;;  if player0x  <  18 then player0x = 18

	LDA player0x
	CMP #18
     BCS .skipL027
.condpart15
	LDA #18
	STA player0x
.skipL027
.L028 ;;line 106;;  if player0x  >  148 then player0x = 148

	LDA #148
	CMP player0x
     BCS .skipL028
.condpart16
	LDA #148
	STA player0x
.skipL028
.L029 ;;line 107;;  if player0y  <  10 then player0y = 10

	LDA player0y
	CMP #10
     BCS .skipL029
.condpart17
	LDA #10
	STA player0y
.skipL029
.L030 ;;line 108;;  if player0y  >  80 then player0y = 80

	LDA #80
	CMP player0y
     BCS .skipL030
.condpart18
	LDA #80
	STA player0y
.skipL030
.
 ;;line 109;; 

.
 ;;line 110;; 

.L031 ;;line 111;;  if joy0fire then if f = 0 then f = 1  :  missile0x = player0x  +  3  :  missile0y = player0y  +  2

 bit INPT4
	BMI .skipL031
.condpart19
	LDA f
	CMP #0
     BNE .skip19then
.condpart20
	LDA #1
	STA f
	LDA player0x
	CLC
	ADC #3
	STA missile0x
	LDA player0y
	CLC
	ADC #2
	STA missile0y
.skip19then
.skipL031
.L032 ;;line 112;;  if f = 1 then if e = 1 then missile0x = missile0x  +  3

	LDA f
	CMP #1
     BNE .skipL032
.condpart21
	LDA e
	CMP #1
     BNE .skip21then
.condpart22
	LDA missile0x
	CLC
	ADC #3
	STA missile0x
.skip21then
.skipL032
.L033 ;;line 113;;  if f = 1 then if e = 0 then missile0x = missile0x  -  3

	LDA f
	CMP #1
     BNE .skipL033
.condpart23
	LDA e
	CMP #0
     BNE .skip23then
.condpart24
	LDA missile0x
	SEC
	SBC #3
	STA missile0x
.skip23then
.skipL033
.L034 ;;line 114;;  if f = 1 then if missile0x  <  1 then f = 0

	LDA f
	CMP #1
     BNE .skipL034
.condpart25
	LDA missile0x
	CMP #1
     BCS .skip25then
.condpart26
	LDA #0
	STA f
.skip25then
.skipL034
.L035 ;;line 115;;  if f = 1 then if missile0x  >  150 then f = 0

	LDA f
	CMP #1
     BNE .skipL035
.condpart27
	LDA #150
	CMP missile0x
     BCS .skip27then
.condpart28
	LDA #0
	STA f
.skip27then
.skipL035
.L036 ;;line 116;;  if f = 1 then if collision(missile0,playfield) then f = 0

	LDA f
	CMP #1
     BNE .skipL036
.condpart29
	bit 	CXM0FB
	BPL .skip29then
.condpart30
	LDA #0
	STA f
.skip29then
.skipL036
.L037 ;;line 117;;  if !joy0fire then f = 0

 bit INPT4
	BPL .skipL037
.condpart31
	LDA #0
	STA f
.skipL037
.
 ;;line 118;; 

.
 ;;line 119;; 

.L038 ;;line 120;;  if joy0down then if i = 0 then if g  >  0 then i = 1  :  h = 30  :  g = g  -  1

 lda #$20
 bit SWCHA
	BNE .skipL038
.condpart32
	LDA i
	CMP #0
     BNE .skip32then
.condpart33
	LDA #0
	CMP g
     BCS .skip33then
.condpart34
	LDA #1
	STA i
	LDA #30
	STA h
	DEC g
.skip33then
.skip32then
.skipL038
.L039 ;;line 121;;  if i = 1 then h = h  -  1

	LDA i
	CMP #1
     BNE .skipL039
.condpart35
	DEC h
.skipL039
.L040 ;;line 122;;  if h  <=  0 then i = 0

	LDA #0
	CMP h
     BCC .skipL040
.condpart36
	LDA #0
	STA i
.skipL040
.
 ;;line 123;; 

.
 ;;line 124;; 

.L041 ;;line 125;;  if j  >  0 then j = j  +  k

	LDA #0
	CMP j
     BCS .skipL041
.condpart37
	LDA j
	CLC
	ADC k
	STA j
.skipL041
.L042 ;;line 126;;  if j  <  40 then k = 1

	LDA j
	CMP #40
     BCS .skipL042
.condpart38
	LDA #1
	STA k
.skipL042
.L043 ;;line 127;;  if j  >  120 then k =  - 1

	LDA #120
	CMP j
     BCS .skipL043
.condpart39
	LDA #255
	STA k
.skipL043
.L044 ;;line 128;;  if j  >  0 then player1x = j

	LDA #0
	CMP j
     BCS .skipL044
.condpart40
	LDA j
	STA player1x
.skipL044
.L045 ;;line 129;;  if j  >  0 then player1y = 50

	LDA #0
	CMP j
     BCS .skipL045
.condpart41
	LDA #50
	STA player1y
.skipL045
.
 ;;line 130;; 

.
 ;;line 131;; 

.L046 ;;line 132;;  if d = 1 then c = c  -  1

	LDA d
	CMP #1
     BNE .skipL046
.condpart42
	DEC c
.skipL046
.L047 ;;line 133;;  if c  <=  0 then gosub GameOver

	LDA #0
	CMP c
     BCC .skipL047
.condpart43
 jsr .GameOver

.skipL047
.
 ;;line 134;; 

.
 ;;line 135;; 

.L048 ;;line 136;;  pfscore1 = 0

	LDA #0
	STA pfscore1
.L049 ;;line 137;;  if m = 4 then pfscore1 = 31

	LDA m
	CMP #4
     BNE .skipL049
.condpart44
	LDA #31
	STA pfscore1
.skipL049
.L050 ;;line 138;;  if m = 3 then pfscore1 = 15

	LDA m
	CMP #3
     BNE .skipL050
.condpart45
	LDA #15
	STA pfscore1
.skipL050
.L051 ;;line 139;;  if m = 2 then pfscore1 = 7

	LDA m
	CMP #2
     BNE .skipL051
.condpart46
	LDA #7
	STA pfscore1
.skipL051
.L052 ;;line 140;;  if m = 1 then pfscore1 = 3

	LDA m
	CMP #1
     BNE .skipL052
.condpart47
	LDA #3
	STA pfscore1
.skipL052
.L053 ;;line 141;;  if m = 0 then pfscore1 = 0

	LDA m
	CMP #0
     BNE .skipL053
.condpart48
	LDA #0
	STA pfscore1
.skipL053
.
 ;;line 142;; 

.L054 ;;line 143;;  pfscore2 = 0

	LDA #0
	STA pfscore2
.L055 ;;line 144;;  if c  >  87 then pfscore2 = 255

	LDA #87
	CMP c
     BCS .skipL055
.condpart49
	LDA #255
	STA pfscore2
.skipL055
.L056 ;;line 145;;  if c  >  75 then pfscore2 = 224

	LDA #75
	CMP c
     BCS .skipL056
.condpart50
	LDA #224
	STA pfscore2
.skipL056
.L057 ;;line 146;;  if c  >  62 then pfscore2 = 192

	LDA #62
	CMP c
     BCS .skipL057
.condpart51
	LDA #192
	STA pfscore2
.skipL057
.L058 ;;line 147;;  if c  >  50 then pfscore2 = 160

	LDA #50
	CMP c
     BCS .skipL058
.condpart52
	LDA #160
	STA pfscore2
.skipL058
.L059 ;;line 148;;  if c  >  37 then pfscore2 = 128

	LDA #37
	CMP c
     BCS .skipL059
.condpart53
	LDA #128
	STA pfscore2
.skipL059
.L060 ;;line 149;;  if c  >  25 then pfscore2 = 96

	LDA #25
	CMP c
     BCS .skipL060
.condpart54
	LDA #96
	STA pfscore2
.skipL060
.L061 ;;line 150;;  if c  >  12 then pfscore2 = 64

	LDA #12
	CMP c
     BCS .skipL061
.condpart55
	LDA #64
	STA pfscore2
.skipL061
.L062 ;;line 151;;  if c  >  6 then pfscore2 = 32

	LDA #6
	CMP c
     BCS .skipL062
.condpart56
	LDA #32
	STA pfscore2
.skipL062
.L063 ;;line 152;;  if c  >  3 then pfscore2 = 16

	LDA #3
	CMP c
     BCS .skipL063
.condpart57
	LDA #16
	STA pfscore2
.skipL063
.L064 ;;line 153;;  if c  >  0 then pfscore2 = 8

	LDA #0
	CMP c
     BCS .skipL064
.condpart58
	LDA #8
	STA pfscore2
.skipL064
.L065 ;;line 154;;  if c = 0 then pfscore2 = 0

	LDA c
	CMP #0
     BNE .skipL065
.condpart59
	LDA #0
	STA pfscore2
.skipL065
.
 ;;line 155;; 

.
 ;;line 156;; 

.L066 ;;line 157;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L067 ;;line 158;;  COLUPF = $28

	LDA #$28
	STA COLUPF
.L068 ;;line 159;;  COLUP0 = $C6

	LDA #$C6
	STA COLUP0
.L069 ;;line 160;;  COLUP1 = $1C

	LDA #$1C
	STA COLUP1
.L070 ;;line 161;;  scorecolor = $36

	LDA #$36
	STA scorecolor
.
 ;;line 162;; 

.L071 ;;line 163;;  drawscreen

 sta temp7
 lda #>(ret_point1-1)
 pha
 lda #<(ret_point1-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point1
.L072 ;;line 164;;  goto main

 jmp .main

.
 ;;line 165;; 

.
 ;;line 166;; 

.
 ;;line 167;; 

.
 ;;line 168;; 

.
 ;;line 169;; 

.LoadRoom
 ;;line 170;; LoadRoom

.L073 ;;line 171;;  pfclear

	LDA #0
 sta temp7
 lda #>(ret_point2-1)
 pha
 lda #<(ret_point2-1)
 pha
 lda #>(pfclear-1)
 pha
 lda #<(pfclear-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point2
.L074 ;;line 172;;  if o = 0 then gosub LoadRoom0

	LDA o
	CMP #0
     BNE .skipL074
.condpart60
 jsr .LoadRoom0

.skipL074
.L075 ;;line 173;;  if o = 1 then gosub LoadRoom1

	LDA o
	CMP #1
     BNE .skipL075
.condpart61
 jsr .LoadRoom1

.skipL075
.L076 ;;line 174;;  if o = 2 then gosub LoadRoom2

	LDA o
	CMP #2
     BNE .skipL076
.condpart62
 jsr .LoadRoom2

.skipL076
.
 ;;line 175;; 

.L077 ;;line 176;;  if o = 0 then j = 100  :  k =  - 1

	LDA o
	CMP #0
     BNE .skipL077
.condpart63
	LDA #100
	STA j
	LDA #255
	STA k
.skipL077
.L078 ;;line 177;;  if o = 1 then j = 80  :  k =  - 1

	LDA o
	CMP #1
     BNE .skipL078
.condpart64
	LDA #80
	STA j
	LDA #255
	STA k
.skipL078
.L079 ;;line 178;;  if o = 2 then j = 120  :  k = 1

	LDA o
	CMP #2
     BNE .skipL079
.condpart65
	LDA #120
	STA j
	LDA #1
	STA k
.skipL079
.L080 ;;line 179;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 180;; 

.
 ;;line 181;; 

.LoadRoom0
 ;;line 182;; LoadRoom0

.
 ;;line 183;; 

.L081 ;;line 184;;  pfhline 0 0 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #0
	LDA #0
 sta temp7
 lda #>(ret_point3-1)
 pha
 lda #<(ret_point3-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point3
.
 ;;line 185;; 

.L082 ;;line 186;;  pfhline 0 10 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #10
	LDA #0
 sta temp7
 lda #>(ret_point4-1)
 pha
 lda #<(ret_point4-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point4
.
 ;;line 187;; 

.
 ;;line 188;; 

.
 ;;line 189;; 

.L083 ;;line 190;;  q = 1

	LDA #1
	STA q
.L084 ;;line 191;;  gosub DrawWalls

 jsr .DrawWalls

.L085 ;;line 192;;  q = 2

	LDA #2
	STA q
.L086 ;;line 193;;  gosub DrawWalls

 jsr .DrawWalls

.L087 ;;line 194;;  q = 3

	LDA #3
	STA q
.L088 ;;line 195;;  gosub DrawWalls

 jsr .DrawWalls

.L089 ;;line 196;;  q = 4

	LDA #4
	STA q
.L090 ;;line 197;;  gosub DrawWalls

 jsr .DrawWalls

.L091 ;;line 198;;  q = 5

	LDA #5
	STA q
.L092 ;;line 199;;  gosub DrawWalls

 jsr .DrawWalls

.L093 ;;line 200;;  q = 6

	LDA #6
	STA q
.L094 ;;line 201;;  gosub DrawWalls

 jsr .DrawWalls

.L095 ;;line 202;;  q = 7

	LDA #7
	STA q
.L096 ;;line 203;;  gosub DrawWalls

 jsr .DrawWalls

.L097 ;;line 204;;  q = 8

	LDA #8
	STA q
.L098 ;;line 205;;  gosub DrawWalls

 jsr .DrawWalls

.L099 ;;line 206;;  q = 9

	LDA #9
	STA q
.L0100 ;;line 207;;  gosub DrawWalls

 jsr .DrawWalls

.
 ;;line 208;; 

.L0101 ;;line 209;;  pfhline 10 4 14 on

	LDX #0
	LDA #14
	STA temp3
	LDY #4
	LDA #10
 sta temp7
 lda #>(ret_point5-1)
 pha
 lda #<(ret_point5-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point5
.
 ;;line 210;; 

.L0102 ;;line 211;;  pfhline 18 7 22 on

	LDX #0
	LDA #22
	STA temp3
	LDY #7
	LDA #18
 sta temp7
 lda #>(ret_point6-1)
 pha
 lda #<(ret_point6-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point6
.L0103 ;;line 212;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 213;; 

.DrawWalls
 ;;line 214;; DrawWalls

.
 ;;line 215;; 

.L0104 ;;line 216;;  pfpixel 1 q on

	LDX #0
	LDY q
	LDA #1
 sta temp7
 lda #>(ret_point7-1)
 pha
 lda #<(ret_point7-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point7
.
 ;;line 217;; 

.L0105 ;;line 218;;  pfpixel 30 q on

	LDX #0
	LDY q
	LDA #30
 sta temp7
 lda #>(ret_point8-1)
 pha
 lda #<(ret_point8-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point8
.L0106 ;;line 219;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 220;; 

.
 ;;line 221;; 

.LoadRoom1
 ;;line 222;; LoadRoom1

.
 ;;line 223;; 

.L0107 ;;line 224;;  pfhline 0 0 13 on

	LDX #0
	LDA #13
	STA temp3
	LDY #0
	LDA #0
 sta temp7
 lda #>(ret_point9-1)
 pha
 lda #<(ret_point9-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point9
.L0108 ;;line 225;;  pfhline 18 0 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #0
	LDA #18
 sta temp7
 lda #>(ret_point10-1)
 pha
 lda #<(ret_point10-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point10
.
 ;;line 226;; 

.L0109 ;;line 227;;  pfhline 0 10 13 on

	LDX #0
	LDA #13
	STA temp3
	LDY #10
	LDA #0
 sta temp7
 lda #>(ret_point11-1)
 pha
 lda #<(ret_point11-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point11
.L0110 ;;line 228;;  pfhline 18 10 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #10
	LDA #18
 sta temp7
 lda #>(ret_point12-1)
 pha
 lda #<(ret_point12-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point12
.
 ;;line 229;; 

.L0111 ;;line 230;;  q = 1

	LDA #1
	STA q
.L0112 ;;line 231;;  gosub DrawWalls

 jsr .DrawWalls

.L0113 ;;line 232;;  q = 2

	LDA #2
	STA q
.L0114 ;;line 233;;  gosub DrawWalls

 jsr .DrawWalls

.L0115 ;;line 234;;  q = 3

	LDA #3
	STA q
.L0116 ;;line 235;;  gosub DrawWalls

 jsr .DrawWalls

.L0117 ;;line 236;;  q = 4

	LDA #4
	STA q
.L0118 ;;line 237;;  gosub DrawWalls

 jsr .DrawWalls

.L0119 ;;line 238;;  q = 5

	LDA #5
	STA q
.L0120 ;;line 239;;  gosub DrawWalls

 jsr .DrawWalls

.L0121 ;;line 240;;  q = 6

	LDA #6
	STA q
.L0122 ;;line 241;;  gosub DrawWalls

 jsr .DrawWalls

.L0123 ;;line 242;;  q = 7

	LDA #7
	STA q
.L0124 ;;line 243;;  gosub DrawWalls

 jsr .DrawWalls

.L0125 ;;line 244;;  q = 8

	LDA #8
	STA q
.L0126 ;;line 245;;  gosub DrawWalls

 jsr .DrawWalls

.L0127 ;;line 246;;  q = 9

	LDA #9
	STA q
.L0128 ;;line 247;;  gosub DrawWalls

 jsr .DrawWalls

.
 ;;line 248;; 

.L0129 ;;line 249;;  pfhline 5 3 9 on

	LDX #0
	LDA #9
	STA temp3
	LDY #3
	LDA #5
 sta temp7
 lda #>(ret_point13-1)
 pha
 lda #<(ret_point13-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point13
.
 ;;line 250;; 

.L0130 ;;line 251;;  pfhline 14 6 18 on

	LDX #0
	LDA #18
	STA temp3
	LDY #6
	LDA #14
 sta temp7
 lda #>(ret_point14-1)
 pha
 lda #<(ret_point14-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point14
.
 ;;line 252;; 

.L0131 ;;line 253;;  pfhline 22 8 26 on

	LDX #0
	LDA #26
	STA temp3
	LDY #8
	LDA #22
 sta temp7
 lda #>(ret_point15-1)
 pha
 lda #<(ret_point15-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point15
.L0132 ;;line 254;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 255;; 

.
 ;;line 256;; 

.LoadRoom2
 ;;line 257;; LoadRoom2

.
 ;;line 258;; 

.L0133 ;;line 259;;  pfhline 0 0 13 on

	LDX #0
	LDA #13
	STA temp3
	LDY #0
	LDA #0
 sta temp7
 lda #>(ret_point16-1)
 pha
 lda #<(ret_point16-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point16
.L0134 ;;line 260;;  pfhline 18 0 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #0
	LDA #18
 sta temp7
 lda #>(ret_point17-1)
 pha
 lda #<(ret_point17-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point17
.
 ;;line 261;; 

.L0135 ;;line 262;;  pfhline 0 10 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #10
	LDA #0
 sta temp7
 lda #>(ret_point18-1)
 pha
 lda #<(ret_point18-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point18
.
 ;;line 263;; 

.L0136 ;;line 264;;  q = 1

	LDA #1
	STA q
.L0137 ;;line 265;;  gosub DrawWalls

 jsr .DrawWalls

.L0138 ;;line 266;;  q = 2

	LDA #2
	STA q
.L0139 ;;line 267;;  gosub DrawWalls

 jsr .DrawWalls

.L0140 ;;line 268;;  q = 3

	LDA #3
	STA q
.L0141 ;;line 269;;  gosub DrawWalls

 jsr .DrawWalls

.L0142 ;;line 270;;  q = 4

	LDA #4
	STA q
.L0143 ;;line 271;;  gosub DrawWalls

 jsr .DrawWalls

.L0144 ;;line 272;;  q = 5

	LDA #5
	STA q
.L0145 ;;line 273;;  gosub DrawWalls

 jsr .DrawWalls

.L0146 ;;line 274;;  q = 6

	LDA #6
	STA q
.L0147 ;;line 275;;  gosub DrawWalls

 jsr .DrawWalls

.L0148 ;;line 276;;  q = 7

	LDA #7
	STA q
.L0149 ;;line 277;;  gosub DrawWalls

 jsr .DrawWalls

.L0150 ;;line 278;;  q = 8

	LDA #8
	STA q
.L0151 ;;line 279;;  gosub DrawWalls

 jsr .DrawWalls

.L0152 ;;line 280;;  q = 9

	LDA #9
	STA q
.L0153 ;;line 281;;  gosub DrawWalls

 jsr .DrawWalls

.
 ;;line 282;; 

.L0154 ;;line 283;;  pfhline 10 4 14 on

	LDX #0
	LDA #14
	STA temp3
	LDY #4
	LDA #10
 sta temp7
 lda #>(ret_point19-1)
 pha
 lda #<(ret_point19-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point19
.
 ;;line 284;; 

.L0155 ;;line 285;;  pfhline 6 7 10 on

	LDX #0
	LDA #10
	STA temp3
	LDY #7
	LDA #6
 sta temp7
 lda #>(ret_point20-1)
 pha
 lda #<(ret_point20-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point20
.
 ;;line 286;; 

.L0156 ;;line 287;;  pfpixel 20 5 on

	LDX #0
	LDY #5
	LDA #20
 sta temp7
 lda #>(ret_point21-1)
 pha
 lda #<(ret_point21-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point21
.L0157 ;;line 288;;  pfpixel 20 6 on

	LDX #0
	LDY #6
	LDA #20
 sta temp7
 lda #>(ret_point22-1)
 pha
 lda #<(ret_point22-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point22
.L0158 ;;line 289;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 290;; 

.PlayerHit
 ;;line 291;; PlayerHit

.L0159 ;;line 292;;  COLUBK = $34

	LDA #$34
	STA COLUBK
.L0160 ;;line 293;;  m = m  -  1

	DEC m
.L0161 ;;line 294;;  player0x = 80

	LDA #80
	STA player0x
.L0162 ;;line 295;;  player0y = 30

	LDA #30
	STA player0y
.L0163 ;;line 296;;  j = 0

	LDA #0
	STA j
.L0164 ;;line 297;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L0165 ;;line 298;;  if m  <=  0 then gosub GameOver

	LDA #0
	CMP m
     BCC .skipL0165
.condpart66
 jsr .GameOver

.skipL0165
.L0166 ;;line 299;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 300;; 

.GameOver
 ;;line 301;; GameOver

.L0167 ;;line 302;;  c = 100

	LDA #100
	STA c
.L0168 ;;line 303;;  g = 6

	LDA #6
	STA g
.L0169 ;;line 304;;  m = 4

	LDA #4
	STA m
.L0170 ;;line 305;;  o = 0

	LDA #0
	STA o
.L0171 ;;line 306;;  player0x = 80

	LDA #80
	STA player0x
.L0172 ;;line 307;;  player0y = 30

	LDA #30
	STA player0y
.L0173 ;;line 308;;  gosub LoadRoom

 jsr .LoadRoom

.L0174 ;;line 309;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
 if ECHO1
 echo "    ",[(start_bank1 - *)]d , "bytes of ROM space left in bank 1")
 endif
ECHO1 = 1
 ORG $1FF4-bscode_length
 RORG $9FF4-bscode_length
start_bank1 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $1FFC
 RORG $9FFC
 .word (start_bank1 & $ffff)
 .word (start_bank1 & $ffff)
 ORG $2000
 RORG $B000
 if ECHO2
 echo "    ",[(start_bank2 - *)]d , "bytes of ROM space left in bank 2")
 endif
ECHO2 = 1
 ORG $2FF4-bscode_length
 RORG $BFF4-bscode_length
start_bank2 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $2FFC
 RORG $BFFC
 .word (start_bank2 & $ffff)
 .word (start_bank2 & $ffff)
 ORG $3000
 RORG $D000
 if ECHO3
 echo "    ",[(start_bank3 - *)]d , "bytes of ROM space left in bank 3")
 endif
ECHO3 = 1
 ORG $3FF4-bscode_length
 RORG $DFF4-bscode_length
start_bank3 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $3FFC
 RORG $DFFC
 .word (start_bank3 & $ffff)
 .word (start_bank3 & $ffff)
 ORG $4000
 RORG $F000
; bB.asm file is split here
 if (<*) > (<(*+10))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL08_0
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
playerL09_1
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
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left in bank 4")
 endif 
ECHOFIRST = 1
 
 
 
