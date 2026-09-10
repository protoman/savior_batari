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
	  ldx #(12>pfres)*(pfres*pfwidth-1)+(12<=pfres)*47
  else
	  ldx #((12*pfwidth-1)*((12*pfwidth-1)<47))+(47*((12*pfwidth-1)>=47))
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
 ;;line 35;; 

.L08 ;;line 36;;  player0:

	LDX #<playerL08_0
	STX player0pointerlo
	LDA #>playerL08_0
	STA player0pointerhi
	LDA #10
	STA player0height
.
 ;;line 49;; 

.L09 ;;line 50;;  player1:

	LDX #<playerL09_1
	STX player1pointerlo
	LDA #>playerL09_1
	STA player1pointerhi
	LDA #10
	STA player1height
.
 ;;line 63;; 

.
 ;;line 64;; 

.L010 ;;line 65;;  gosub LoadRoom

 jsr .LoadRoom

.
 ;;line 66;; 

.L011 ;;line 67;;  player0x = 80

	LDA #80
	STA player0x
.L012 ;;line 68;;  player0y = 30

	LDA #30
	STA player0y
.
 ;;line 69;; 

.main
 ;;line 70;; main

.
 ;;line 71;; 

.L013 ;;line 72;;  if f = 1 then if collision(missile0,player1) then j = 0  :  f = 0

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
 ;;line 73;; 

.
 ;;line 74;; 

.L014 ;;line 75;;  if collision(player0,player1) then gosub PlayerHit

	bit 	CXPPMM
	BPL .skipL014
.condpart2
 jsr .PlayerHit

.skipL014
.
 ;;line 76;; 

.
 ;;line 77;; 

.L015 ;;line 78;;  a = player0x

	LDA player0x
	STA a
.L016 ;;line 79;;  b = player0y

	LDA player0y
	STA b
.L017 ;;line 80;;  d = 0

	LDA #0
	STA d
.
 ;;line 81;; 

.
 ;;line 82;; 

.L018 ;;line 83;;  if joy0left then player0x = player0x  -  1  :  d = 1  :  e = 0

 bit SWCHA
	BVS .skipL018
.condpart3
	DEC player0x
	LDA #1
	STA d
	LDA #0
	STA e
.skipL018
.L019 ;;line 84;;  if joy0right then player0x = player0x  +  1  :  d = 1  :  e = 1

 bit SWCHA
	BMI .skipL019
.condpart4
	INC player0x
	LDA #1
	STA d
	STA e
.skipL019
.
 ;;line 85;; 

.
 ;;line 86;; 

.L020 ;;line 87;;  if collision(player0,playfield) then player0x = a

	bit 	CXP0FB
	BPL .skipL020
.condpart5
	LDA a
	STA player0x
.skipL020
.
 ;;line 88;; 

.
 ;;line 89;; 

.L021 ;;line 90;;  if joy0up then player0y = player0y  -  1  :  d = 1  :  n = 0

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
 ;;line 91;; 

.
 ;;line 92;; 

.L022 ;;line 93;;  if !joy0up then n = n  +  1

 lda #$10
 bit SWCHA
	BEQ .skipL022
.condpart7
	INC n
.skipL022
.L023 ;;line 94;;  if !joy0up then if n  >=  4 then player0y = player0y  +  1  :  n = 0

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
 ;;line 95;; 

.
 ;;line 96;; 

.L024 ;;line 97;;  if collision(player0,playfield) then player0y = b

	bit 	CXP0FB
	BPL .skipL024
.condpart10
	LDA b
	STA player0y
.skipL024
.
 ;;line 98;; 

.
 ;;line 99;; 

.
 ;;line 100;; 

.L025 ;;line 101;;  if player0x  >  150 then if o  <  2 then o = o  +  1  :  gosub LoadRoom  :  player0x = 18

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
 ;;line 102;; 

.L026 ;;line 103;;  if player0x  <  18 then if o  >  0 then o = o  -  1  :  gosub LoadRoom  :  player0x = 148

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
 ;;line 104;; 

.
 ;;line 105;; 

.L027 ;;line 106;;  if player0x  <  18 then player0x = 18

	LDA player0x
	CMP #18
     BCS .skipL027
.condpart15
	LDA #18
	STA player0x
.skipL027
.L028 ;;line 107;;  if player0x  >  148 then player0x = 148

	LDA #148
	CMP player0x
     BCS .skipL028
.condpart16
	LDA #148
	STA player0x
.skipL028
.L029 ;;line 108;;  if player0y  <  10 then player0y = 10

	LDA player0y
	CMP #10
     BCS .skipL029
.condpart17
	LDA #10
	STA player0y
.skipL029
.L030 ;;line 109;;  if player0y  >  80 then player0y = 80

	LDA #80
	CMP player0y
     BCS .skipL030
.condpart18
	LDA #80
	STA player0y
.skipL030
.
 ;;line 110;; 

.
 ;;line 111;; 

.L031 ;;line 112;;  if joy0fire then if f = 0 then f = 1  :  missile0x = player0x  +  3  :  missile0y = player0y  +  2

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
.L032 ;;line 113;;  if f = 1 then if e = 1 then missile0x = missile0x  +  3

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
.L033 ;;line 114;;  if f = 1 then if e = 0 then missile0x = missile0x  -  3

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
.L034 ;;line 115;;  if f = 1 then if missile0x  <  1 then f = 0

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
.L035 ;;line 116;;  if f = 1 then if missile0x  >  150 then f = 0

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
.L036 ;;line 117;;  if f = 1 then if collision(missile0,playfield) then f = 0

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
.L037 ;;line 118;;  if !joy0fire then f = 0

 bit INPT4
	BPL .skipL037
.condpart31
	LDA #0
	STA f
.skipL037
.
 ;;line 119;; 

.
 ;;line 120;; 

.L038 ;;line 121;;  if joy0down then if i = 0 then if g  >  0 then i = 1  :  h = 30  :  g = g  -  1

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
.L039 ;;line 122;;  if i = 1 then h = h  -  1

	LDA i
	CMP #1
     BNE .skipL039
.condpart35
	DEC h
.skipL039
.L040 ;;line 123;;  if h  <=  0 then i = 0

	LDA #0
	CMP h
     BCC .skipL040
.condpart36
	LDA #0
	STA i
.skipL040
.
 ;;line 124;; 

.
 ;;line 125;; 

.L041 ;;line 126;;  if j  >  0 then j = j  +  k

	LDA #0
	CMP j
     BCS .skipL041
.condpart37
	LDA j
	CLC
	ADC k
	STA j
.skipL041
.L042 ;;line 127;;  if j  <  40 then k = 1

	LDA j
	CMP #40
     BCS .skipL042
.condpart38
	LDA #1
	STA k
.skipL042
.L043 ;;line 128;;  if j  >  120 then k =  - 1

	LDA #120
	CMP j
     BCS .skipL043
.condpart39
	LDA #255
	STA k
.skipL043
.L044 ;;line 129;;  if j  >  0 then player1x = j

	LDA #0
	CMP j
     BCS .skipL044
.condpart40
	LDA j
	STA player1x
.skipL044
.L045 ;;line 130;;  if j  >  0 then player1y = 50

	LDA #0
	CMP j
     BCS .skipL045
.condpart41
	LDA #50
	STA player1y
.skipL045
.
 ;;line 131;; 

.
 ;;line 132;; 

.L046 ;;line 133;;  if d = 1 then c = c  -  1

	LDA d
	CMP #1
     BNE .skipL046
.condpart42
	DEC c
.skipL046
.L047 ;;line 134;;  if c  <=  0 then gosub GameOver

	LDA #0
	CMP c
     BCC .skipL047
.condpart43
 jsr .GameOver

.skipL047
.
 ;;line 135;; 

.
 ;;line 136;; 

.L048 ;;line 137;;  pfscore1 = 0

	LDA #0
	STA pfscore1
.L049 ;;line 138;;  if m = 4 then pfscore1 = 31

	LDA m
	CMP #4
     BNE .skipL049
.condpart44
	LDA #31
	STA pfscore1
.skipL049
.L050 ;;line 139;;  if m = 3 then pfscore1 = 15

	LDA m
	CMP #3
     BNE .skipL050
.condpart45
	LDA #15
	STA pfscore1
.skipL050
.L051 ;;line 140;;  if m = 2 then pfscore1 = 7

	LDA m
	CMP #2
     BNE .skipL051
.condpart46
	LDA #7
	STA pfscore1
.skipL051
.L052 ;;line 141;;  if m = 1 then pfscore1 = 3

	LDA m
	CMP #1
     BNE .skipL052
.condpart47
	LDA #3
	STA pfscore1
.skipL052
.L053 ;;line 142;;  if m = 0 then pfscore1 = 0

	LDA m
	CMP #0
     BNE .skipL053
.condpart48
	LDA #0
	STA pfscore1
.skipL053
.
 ;;line 143;; 

.L054 ;;line 144;;  pfscore2 = 0

	LDA #0
	STA pfscore2
.L055 ;;line 145;;  if c  >  87 then pfscore2 = 255

	LDA #87
	CMP c
     BCS .skipL055
.condpart49
	LDA #255
	STA pfscore2
.skipL055
.L056 ;;line 146;;  if c  >  75 then pfscore2 = 224

	LDA #75
	CMP c
     BCS .skipL056
.condpart50
	LDA #224
	STA pfscore2
.skipL056
.L057 ;;line 147;;  if c  >  62 then pfscore2 = 192

	LDA #62
	CMP c
     BCS .skipL057
.condpart51
	LDA #192
	STA pfscore2
.skipL057
.L058 ;;line 148;;  if c  >  50 then pfscore2 = 160

	LDA #50
	CMP c
     BCS .skipL058
.condpart52
	LDA #160
	STA pfscore2
.skipL058
.L059 ;;line 149;;  if c  >  37 then pfscore2 = 128

	LDA #37
	CMP c
     BCS .skipL059
.condpart53
	LDA #128
	STA pfscore2
.skipL059
.L060 ;;line 150;;  if c  >  25 then pfscore2 = 96

	LDA #25
	CMP c
     BCS .skipL060
.condpart54
	LDA #96
	STA pfscore2
.skipL060
.L061 ;;line 151;;  if c  >  12 then pfscore2 = 64

	LDA #12
	CMP c
     BCS .skipL061
.condpart55
	LDA #64
	STA pfscore2
.skipL061
.L062 ;;line 152;;  if c  >  6 then pfscore2 = 32

	LDA #6
	CMP c
     BCS .skipL062
.condpart56
	LDA #32
	STA pfscore2
.skipL062
.L063 ;;line 153;;  if c  >  3 then pfscore2 = 16

	LDA #3
	CMP c
     BCS .skipL063
.condpart57
	LDA #16
	STA pfscore2
.skipL063
.L064 ;;line 154;;  if c  >  0 then pfscore2 = 8

	LDA #0
	CMP c
     BCS .skipL064
.condpart58
	LDA #8
	STA pfscore2
.skipL064
.L065 ;;line 155;;  if c = 0 then pfscore2 = 0

	LDA c
	CMP #0
     BNE .skipL065
.condpart59
	LDA #0
	STA pfscore2
.skipL065
.
 ;;line 156;; 

.
 ;;line 157;; 

.L066 ;;line 158;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L067 ;;line 159;;  COLUPF = $28

	LDA #$28
	STA COLUPF
.L068 ;;line 160;;  COLUP0 = $C6

	LDA #$C6
	STA COLUP0
.L069 ;;line 161;;  COLUP1 = $1C

	LDA #$1C
	STA COLUP1
.L070 ;;line 162;;  scorecolor = $36

	LDA #$36
	STA scorecolor
.
 ;;line 163;; 

.L071 ;;line 164;;  drawscreen

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
.L072 ;;line 165;;  goto main

 jmp .main

.
 ;;line 166;; 

.PlayerHit
 ;;line 167;; PlayerHit

.L073 ;;line 168;;  COLUBK = $34

	LDA #$34
	STA COLUBK
.L074 ;;line 169;;  m = m  -  1

	DEC m
.L075 ;;line 170;;  player0x = 80

	LDA #80
	STA player0x
.L076 ;;line 171;;  player0y = 30

	LDA #30
	STA player0y
.L077 ;;line 172;;  j = 0

	LDA #0
	STA j
.L078 ;;line 173;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L079 ;;line 174;;  if m  <=  0 then gosub GameOver

	LDA #0
	CMP m
     BCC .skipL079
.condpart60
 jsr .GameOver

.skipL079
.L080 ;;line 175;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 176;; 

.GameOver
 ;;line 177;; GameOver

.L081 ;;line 178;;  c = 100

	LDA #100
	STA c
.L082 ;;line 179;;  g = 6

	LDA #6
	STA g
.L083 ;;line 180;;  m = 4

	LDA #4
	STA m
.L084 ;;line 181;;  o = 0

	LDA #0
	STA o
.L085 ;;line 182;;  player0x = 80

	LDA #80
	STA player0x
.L086 ;;line 183;;  player0y = 30

	LDA #30
	STA player0y
.L087 ;;line 184;;  gosub LoadRoom

 jsr .LoadRoom

.L088 ;;line 185;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 186;; 

.LoadRoom
 ;;line 187;; LoadRoom

.L089 ;;line 188;;  pfclear

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
.L090 ;;line 189;;  if o = 0 then gosub LoadRoom0

	LDA o
	CMP #0
     BNE .skipL090
.condpart61
 jsr .LoadRoom0

.skipL090
.L091 ;;line 190;;  if o = 1 then gosub LoadRoom1

	LDA o
	CMP #1
     BNE .skipL091
.condpart62
 jsr .LoadRoom1

.skipL091
.L092 ;;line 191;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 192;; 

.
 ;;line 193;; 

.LoadRoom0
 ;;line 194;; LoadRoom0

.L093 ;;line 195;;  pfhline 0 0 31 on

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
.L094 ;;line 196;;  pfhline 0 1 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #1
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
.L095 ;;line 197;;  pfhline 6 1 7 on

	LDX #0
	LDA #7
	STA temp3
	LDY #1
	LDA #6
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
.L096 ;;line 198;;  pfhline 22 1 23 on

	LDX #0
	LDA #23
	STA temp3
	LDY #1
	LDA #22
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
.L097 ;;line 199;;  pfhline 30 1 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #1
	LDA #30
 sta temp7
 lda #>(ret_point7-1)
 pha
 lda #<(ret_point7-1)
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
ret_point7
.L098 ;;line 200;;  pfhline 0 2 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #2
	LDA #0
 sta temp7
 lda #>(ret_point8-1)
 pha
 lda #<(ret_point8-1)
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
ret_point8
.L099 ;;line 201;;  pfhline 6 2 7 on

	LDX #0
	LDA #7
	STA temp3
	LDY #2
	LDA #6
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
.L0100 ;;line 202;;  pfhline 22 2 23 on

	LDX #0
	LDA #23
	STA temp3
	LDY #2
	LDA #22
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
.L0101 ;;line 203;;  pfhline 30 2 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #2
	LDA #30
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
.L0102 ;;line 204;;  pfhline 0 3 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #3
	LDA #0
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
.L0103 ;;line 205;;  pfhline 30 3 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #3
	LDA #30
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
.L0104 ;;line 206;;  pfhline 0 4 7 on

	LDX #0
	LDA #7
	STA temp3
	LDY #4
	LDA #0
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
.L0105 ;;line 207;;  pfhline 30 4 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #4
	LDA #30
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
.L0106 ;;line 208;;  pfhline 0 5 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #5
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
.L0107 ;;line 209;;  pfhline 30 5 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #5
	LDA #30
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
.L0108 ;;line 210;;  pfhline 0 6 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #6
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
.L0109 ;;line 211;;  pfhline 30 6 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #6
	LDA #30
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
.L0110 ;;line 212;;  pfhline 0 7 7 on

	LDX #0
	LDA #7
	STA temp3
	LDY #7
	LDA #0
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
.L0111 ;;line 213;;  pfhline 30 7 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #7
	LDA #30
 sta temp7
 lda #>(ret_point21-1)
 pha
 lda #<(ret_point21-1)
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
ret_point21
.L0112 ;;line 214;;  pfhline 0 8 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #8
	LDA #0
 sta temp7
 lda #>(ret_point22-1)
 pha
 lda #<(ret_point22-1)
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
ret_point22
.L0113 ;;line 215;;  pfhline 20 8 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #8
	LDA #20
 sta temp7
 lda #>(ret_point23-1)
 pha
 lda #<(ret_point23-1)
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
ret_point23
.L0114 ;;line 216;;  pfhline 0 9 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #9
	LDA #0
 sta temp7
 lda #>(ret_point24-1)
 pha
 lda #<(ret_point24-1)
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
ret_point24
.L0115 ;;line 217;;  pfhline 30 9 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #9
	LDA #30
 sta temp7
 lda #>(ret_point25-1)
 pha
 lda #<(ret_point25-1)
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
ret_point25
.L0116 ;;line 218;;  pfhline 0 10 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #10
	LDA #0
 sta temp7
 lda #>(ret_point26-1)
 pha
 lda #<(ret_point26-1)
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
ret_point26
.L0117 ;;line 219;;  pfhline 30 10 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #10
	LDA #30
 sta temp7
 lda #>(ret_point27-1)
 pha
 lda #<(ret_point27-1)
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
ret_point27
.L0118 ;;line 220;;  pfhline 0 11 11 on

	LDX #0
	LDA #11
	STA temp3
	LDY #11
	LDA #0
 sta temp7
 lda #>(ret_point28-1)
 pha
 lda #<(ret_point28-1)
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
ret_point28
.L0119 ;;line 221;;  pfhline 20 11 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #11
	LDA #20
 sta temp7
 lda #>(ret_point29-1)
 pha
 lda #<(ret_point29-1)
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
ret_point29
.L0120 ;;line 222;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 223;; 

.LoadRoom1
 ;;line 224;; LoadRoom1

.L0121 ;;line 225;;  pfhline 0 0 11 on

	LDX #0
	LDA #11
	STA temp3
	LDY #0
	LDA #0
 sta temp7
 lda #>(ret_point30-1)
 pha
 lda #<(ret_point30-1)
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
ret_point30
.L0122 ;;line 226;;  pfhline 20 0 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #0
	LDA #20
 sta temp7
 lda #>(ret_point31-1)
 pha
 lda #<(ret_point31-1)
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
ret_point31
.L0123 ;;line 227;;  pfhline 0 1 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #1
	LDA #0
 sta temp7
 lda #>(ret_point32-1)
 pha
 lda #<(ret_point32-1)
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
ret_point32
.L0124 ;;line 228;;  pfhline 30 1 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #1
	LDA #30
 sta temp7
 lda #>(ret_point33-1)
 pha
 lda #<(ret_point33-1)
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
ret_point33
.L0125 ;;line 229;;  pfhline 0 2 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #2
	LDA #0
 sta temp7
 lda #>(ret_point34-1)
 pha
 lda #<(ret_point34-1)
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
ret_point34
.L0126 ;;line 230;;  pfhline 30 2 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #2
	LDA #30
 sta temp7
 lda #>(ret_point35-1)
 pha
 lda #<(ret_point35-1)
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
ret_point35
.L0127 ;;line 231;;  pfhline 0 3 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #3
	LDA #0
 sta temp7
 lda #>(ret_point36-1)
 pha
 lda #<(ret_point36-1)
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
ret_point36
.L0128 ;;line 232;;  pfhline 30 3 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #3
	LDA #30
 sta temp7
 lda #>(ret_point37-1)
 pha
 lda #<(ret_point37-1)
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
ret_point37
.L0129 ;;line 233;;  pfhline 0 4 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #4
	LDA #0
 sta temp7
 lda #>(ret_point38-1)
 pha
 lda #<(ret_point38-1)
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
ret_point38
.L0130 ;;line 234;;  pfhline 30 4 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #4
	LDA #30
 sta temp7
 lda #>(ret_point39-1)
 pha
 lda #<(ret_point39-1)
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
ret_point39
.L0131 ;;line 235;;  pfhline 0 5 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #5
	LDA #0
 sta temp7
 lda #>(ret_point40-1)
 pha
 lda #<(ret_point40-1)
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
ret_point40
.L0132 ;;line 236;;  pfhline 30 5 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #5
	LDA #30
 sta temp7
 lda #>(ret_point41-1)
 pha
 lda #<(ret_point41-1)
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
ret_point41
.L0133 ;;line 237;;  pfhline 0 6 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #6
	LDA #0
 sta temp7
 lda #>(ret_point42-1)
 pha
 lda #<(ret_point42-1)
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
ret_point42
.L0134 ;;line 238;;  pfhline 30 6 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #6
	LDA #30
 sta temp7
 lda #>(ret_point43-1)
 pha
 lda #<(ret_point43-1)
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
ret_point43
.L0135 ;;line 239;;  pfhline 0 7 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #7
	LDA #0
 sta temp7
 lda #>(ret_point44-1)
 pha
 lda #<(ret_point44-1)
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
ret_point44
.L0136 ;;line 240;;  pfhline 30 7 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #7
	LDA #30
 sta temp7
 lda #>(ret_point45-1)
 pha
 lda #<(ret_point45-1)
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
ret_point45
.L0137 ;;line 241;;  pfhline 0 8 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #8
	LDA #0
 sta temp7
 lda #>(ret_point46-1)
 pha
 lda #<(ret_point46-1)
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
ret_point46
.L0138 ;;line 242;;  pfhline 30 8 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #8
	LDA #30
 sta temp7
 lda #>(ret_point47-1)
 pha
 lda #<(ret_point47-1)
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
ret_point47
.L0139 ;;line 243;;  pfhline 0 9 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #9
	LDA #0
 sta temp7
 lda #>(ret_point48-1)
 pha
 lda #<(ret_point48-1)
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
ret_point48
.L0140 ;;line 244;;  pfhline 30 9 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #9
	LDA #30
 sta temp7
 lda #>(ret_point49-1)
 pha
 lda #<(ret_point49-1)
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
ret_point49
.L0141 ;;line 245;;  pfhline 0 10 1 on

	LDX #0
	LDA #1
	STA temp3
	LDY #10
	LDA #0
 sta temp7
 lda #>(ret_point50-1)
 pha
 lda #<(ret_point50-1)
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
ret_point50
.L0142 ;;line 246;;  pfhline 30 10 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #10
	LDA #30
 sta temp7
 lda #>(ret_point51-1)
 pha
 lda #<(ret_point51-1)
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
ret_point51
.L0143 ;;line 247;;  pfhline 0 11 31 on

	LDX #0
	LDA #31
	STA temp3
	LDY #11
	LDA #0
 sta temp7
 lda #>(ret_point52-1)
 pha
 lda #<(ret_point52-1)
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
ret_point52
.L0144 ;;line 248;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 249;; 

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
 
 
 
