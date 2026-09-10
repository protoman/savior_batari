game
.
 ;;line 1;; 

.
 ;;line 2;; 

.
 ;;line 3;; 

.L00 ;;line 4;;  set kernel DPC + skip constants

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

.L02 ;;line 14;;  goto start bank2

 sta temp7
 lda #>(.start-1)
 pha
 lda #<(.start-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #2
 jmp BS_jsr
.
 ;;line 15;; 

.L03 ;;line 16;;  bank 2

 if ECHO1
 echo "    ",[(start_bank1 - *)]d , "bytes of ROM space left in bank 1")
 endif
ECHO1 = 1
 ORG $1FF4-bscode_length
 RORG $1FF4-bscode_length
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
 RORG $1FFC
 .word (start_bank1 & $ffff)
 .word (start_bank1 & $ffff)
 ORG $2000
 RORG $3000
HMdiv
  .byte 0, 0, 0, 0, 0, 0, 0
  .byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2
  .byte 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3
  .byte 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4
  .byte 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5
  .byte 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6
  .byte 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7
  .byte 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8
  .byte 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9
  .byte 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10
  .byte 10,10,10,10,10,10,0,0,0
.start
 ;;line 17;; start

.
 ;;line 18;; 

.
 ;;line 19;; 

.L04 ;;line 20;;  playfield:

 ldy #12
	LDA #<PF_data1
	LDX #((>PF_data1) & $0f) | (((>PF_data1) / 2) & $70)
 sta temp7
 lda #>(ret_point1-1)
 pha
 lda #<(ret_point1-1)
 pha
 lda #>(pfsetup-1)
 pha
 lda #<(pfsetup-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point1
.
 ;;line 34;; 

.L05 ;;line 35;;  player0:

	LDX #<playerL05_0
	STX player0pointerlo
	LDA #((>playerL05_0) & $0f) | (((>playerL05_0) / 2) & $70)
	STA player0pointerhi
	LDA #11
	STA player0height
.
 ;;line 48;; 

.L06 ;;line 49;;  player1:

	lda #<(playerpointers+0)
	sta DF0LOW
	lda #(>(playerpointers+0)) & $0F
	sta DF0HI
	LDX #<playerL06_1
	STX DF0WRITE
	LDA #((>playerL06_1) & $0f) | (((>playerL06_1) / 2) & $70)
	STA DF0WRITE
	LDA #11
	STA player1height
.
 ;;line 62;; 

.
 ;;line 63;; 

.L07 ;;line 64;;  a = 72  :  b = 40  :  c = 100

	LDA #72
	STA a
	LDA #40
	STA b
	LDA #100
	STA c
.L08 ;;line 65;;  d = 0  :  e = 1  :  f = 0

	LDA #0
	STA d
	LDA #1
	STA e
	LDA #0
	STA f
.L09 ;;line 66;;  g = 6  :  h = 0  :  i = 0

	LDA #6
	STA g
	LDA #0
	STA h
	STA i
.L010 ;;line 67;;  j = 120  :  k =  - 1  :  m = 4

	LDA #120
	STA j
	LDA #255
	STA k
	LDA #4
	STA m
.L011 ;;line 68;;  n = 0  :  o = 0

	LDA #0
	STA n
	STA o
.
 ;;line 69;; 

.
 ;;line 70;; 

.L012 ;;line 71;;  gosub LoadRoom

 jsr .LoadRoom

.
 ;;line 72;; 

.L013 ;;line 73;;  player0x = 80

	LDA #80
	STA player0x
.L014 ;;line 74;;  player0y = 30

	LDA #30
	STA player0y
.
 ;;line 75;; 

.main
 ;;line 76;; main

.
 ;;line 77;; 

.L015 ;;line 78;;  if f = 1 then if collision(missile0,player1) then j = 0  :  f = 0

	LDA f
	CMP #1
     BNE .skipL015
.condpart0
	bit 	CXM0P
	BPL .skip0then
.condpart1
	LDA #0
	STA j
	STA f
.skip0then
.skipL015
.
 ;;line 79;; 

.
 ;;line 80;; 

.L016 ;;line 81;;  if collision(player0,player1) then gosub PlayerHit

	bit 	CXPPMM
	BPL .skipL016
.condpart2
 jsr .PlayerHit

.skipL016
.
 ;;line 82;; 

.
 ;;line 83;; 

.L017 ;;line 84;;  a = player0x

	LDA player0x
	STA a
.L018 ;;line 85;;  b = player0y

	LDA player0y
	STA b
.L019 ;;line 86;;  d = 0

	LDA #0
	STA d
.
 ;;line 87;; 

.
 ;;line 88;; 

.L020 ;;line 89;;  if joy0left then player0x = player0x  -  1  :  d = 1  :  e = 0

 bit SWCHA
	BVS .skipL020
.condpart3
	DEC player0x
	LDA #1
	STA d
	LDA #0
	STA e
.skipL020
.L021 ;;line 90;;  if joy0right then player0x = player0x  +  1  :  d = 1  :  e = 1

 bit SWCHA
	BMI .skipL021
.condpart4
	INC player0x
	LDA #1
	STA d
	STA e
.skipL021
.
 ;;line 91;; 

.
 ;;line 92;; 

.L022 ;;line 93;;  if collision(player0,playfield) then player0x = a

	bit 	CXP0FB
	BPL .skipL022
.condpart5
	LDA a
	STA player0x
.skipL022
.
 ;;line 94;; 

.
 ;;line 95;; 

.L023 ;;line 96;;  if joy0up then player0y = player0y  -  1  :  d = 1  :  n = 0

 lda #$10
 bit SWCHA
	BNE .skipL023
.condpart6
	DEC player0y
	LDA #1
	STA d
	LDA #0
	STA n
.skipL023
.
 ;;line 97;; 

.
 ;;line 98;; 

.L024 ;;line 99;;  if !joy0up then n = n  +  1

 lda #$10
 bit SWCHA
	BEQ .skipL024
.condpart7
	INC n
.skipL024
.L025 ;;line 100;;  if !joy0up then if n  >=  4 then player0y = player0y  +  1  :  n = 0

 lda #$10
 bit SWCHA
	BEQ .skipL025
.condpart8
	LDA n
	CMP #4
     BCC .skip8then
.condpart9
	INC player0y
	LDA #0
	STA n
.skip8then
.skipL025
.
 ;;line 101;; 

.
 ;;line 102;; 

.L026 ;;line 103;;  if collision(player0,playfield) then player0y = b

	bit 	CXP0FB
	BPL .skipL026
.condpart10
	LDA b
	STA player0y
.skipL026
.
 ;;line 104;; 

.
 ;;line 105;; 

.
 ;;line 106;; 

.L027 ;;line 107;;  if player0x  >  150 then if o  <  2 then o = o  +  1  :  gosub LoadRoom  :  player0x = 18

	LDA #150
	CMP player0x
     BCS .skipL027
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
.skipL027
.
 ;;line 108;; 

.L028 ;;line 109;;  if player0x  <  18 then if o  >  0 then o = o  -  1  :  gosub LoadRoom  :  player0x = 148

	LDA player0x
	CMP #18
     BCS .skipL028
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
.skipL028
.
 ;;line 110;; 

.
 ;;line 111;; 

.L029 ;;line 112;;  if player0x  <  18 then player0x = 18

	LDA player0x
	CMP #18
     BCS .skipL029
.condpart15
	LDA #18
	STA player0x
.skipL029
.L030 ;;line 113;;  if player0x  >  148 then player0x = 148

	LDA #148
	CMP player0x
     BCS .skipL030
.condpart16
	LDA #148
	STA player0x
.skipL030
.L031 ;;line 114;;  if player0y  <  10 then player0y = 10

	LDA player0y
	CMP #10
     BCS .skipL031
.condpart17
	LDA #10
	STA player0y
.skipL031
.L032 ;;line 115;;  if player0y  >  80 then player0y = 80

	LDA #80
	CMP player0y
     BCS .skipL032
.condpart18
	LDA #80
	STA player0y
.skipL032
.
 ;;line 116;; 

.
 ;;line 117;; 

.L033 ;;line 118;;  if joy0fire then if f = 0 then f = 1  :  missile0x = player0x  +  3  :  missile0y = player0y  +  2

 bit INPT4
	BMI .skipL033
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
.skipL033
.L034 ;;line 119;;  if f = 1 then if e = 1 then missile0x = missile0x  +  3

	LDA f
	CMP #1
     BNE .skipL034
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
.skipL034
.L035 ;;line 120;;  if f = 1 then if e = 0 then missile0x = missile0x  -  3

	LDA f
	CMP #1
     BNE .skipL035
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
.skipL035
.L036 ;;line 121;;  if f = 1 then if missile0x  <  1 then f = 0

	LDA f
	CMP #1
     BNE .skipL036
.condpart25
	LDA missile0x
	CMP #1
     BCS .skip25then
.condpart26
	LDA #0
	STA f
.skip25then
.skipL036
.L037 ;;line 122;;  if f = 1 then if missile0x  >  150 then f = 0

	LDA f
	CMP #1
     BNE .skipL037
.condpart27
	LDA #150
	CMP missile0x
     BCS .skip27then
.condpart28
	LDA #0
	STA f
.skip27then
.skipL037
.L038 ;;line 123;;  if f = 1 then if collision(missile0,playfield) then f = 0

	LDA f
	CMP #1
     BNE .skipL038
.condpart29
	bit 	CXM0FB
	BPL .skip29then
.condpart30
	LDA #0
	STA f
.skip29then
.skipL038
.L039 ;;line 124;;  if !joy0fire then f = 0

 bit INPT4
	BPL .skipL039
.condpart31
	LDA #0
	STA f
.skipL039
.
 ;;line 125;; 

.
 ;;line 126;; 

.L040 ;;line 127;;  if joy0down then if i = 0 then if g  >  0 then i = 1  :  h = 30  :  g = g  -  1

 lda #$20
 bit SWCHA
	BNE .skipL040
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
.skipL040
.L041 ;;line 128;;  if i = 1 then h = h  -  1

	LDA i
	CMP #1
     BNE .skipL041
.condpart35
	DEC h
.skipL041
.L042 ;;line 129;;  if h  <=  0 then i = 0

	LDA #0
	CMP h
     BCC .skipL042
.condpart36
	LDA #0
	STA i
.skipL042
.
 ;;line 130;; 

.
 ;;line 131;; 

.L043 ;;line 132;;  if j  >  0 then j = j  +  k

	LDA #0
	CMP j
     BCS .skipL043
.condpart37
	LDA j
	CLC
	ADC k
	STA j
.skipL043
.L044 ;;line 133;;  if j  <  40 then k = 1

	LDA j
	CMP #40
     BCS .skipL044
.condpart38
	LDA #1
	STA k
.skipL044
.L045 ;;line 134;;  if j  >  120 then k =  - 1

	LDA #120
	CMP j
     BCS .skipL045
.condpart39
	LDA #255
	STA k
.skipL045
.L046 ;;line 135;;  if j  >  0 then player1x = j

	LDA #0
	CMP j
     BCS .skipL046
.condpart40
	LDA j
	STA player1x
.skipL046
.L047 ;;line 136;;  if j  >  0 then player1y = 50

	LDA #0
	CMP j
     BCS .skipL047
.condpart41
	LDA #50
	STA player1y
.skipL047
.
 ;;line 137;; 

.
 ;;line 138;; 

.L048 ;;line 139;;  if d = 1 then c = c  -  1

	LDA d
	CMP #1
     BNE .skipL048
.condpart42
	DEC c
.skipL048
.L049 ;;line 140;;  if c  <=  0 then gosub GameOver

	LDA #0
	CMP c
     BCC .skipL049
.condpart43
 jsr .GameOver

.skipL049
.
 ;;line 141;; 

.
 ;;line 142;; 

.L050 ;;line 143;;  pfscore1 = 0

	LDA #0
	STA pfscore1
.L051 ;;line 144;;  if m = 4 then pfscore1 = 31

	LDA m
	CMP #4
     BNE .skipL051
.condpart44
	LDA #31
	STA pfscore1
.skipL051
.L052 ;;line 145;;  if m = 3 then pfscore1 = 15

	LDA m
	CMP #3
     BNE .skipL052
.condpart45
	LDA #15
	STA pfscore1
.skipL052
.L053 ;;line 146;;  if m = 2 then pfscore1 = 7

	LDA m
	CMP #2
     BNE .skipL053
.condpart46
	LDA #7
	STA pfscore1
.skipL053
.L054 ;;line 147;;  if m = 1 then pfscore1 = 3

	LDA m
	CMP #1
     BNE .skipL054
.condpart47
	LDA #3
	STA pfscore1
.skipL054
.L055 ;;line 148;;  if m = 0 then pfscore1 = 0

	LDA m
	CMP #0
     BNE .skipL055
.condpart48
	LDA #0
	STA pfscore1
.skipL055
.
 ;;line 149;; 

.L056 ;;line 150;;  pfscore2 = 0

	LDA #0
	STA pfscore2
.L057 ;;line 151;;  if c  >  87 then pfscore2 = 255

	LDA #87
	CMP c
     BCS .skipL057
.condpart49
	LDA #255
	STA pfscore2
.skipL057
.L058 ;;line 152;;  if c  >  75 then pfscore2 = 224

	LDA #75
	CMP c
     BCS .skipL058
.condpart50
	LDA #224
	STA pfscore2
.skipL058
.L059 ;;line 153;;  if c  >  62 then pfscore2 = 192

	LDA #62
	CMP c
     BCS .skipL059
.condpart51
	LDA #192
	STA pfscore2
.skipL059
.L060 ;;line 154;;  if c  >  50 then pfscore2 = 160

	LDA #50
	CMP c
     BCS .skipL060
.condpart52
	LDA #160
	STA pfscore2
.skipL060
.L061 ;;line 155;;  if c  >  37 then pfscore2 = 128

	LDA #37
	CMP c
     BCS .skipL061
.condpart53
	LDA #128
	STA pfscore2
.skipL061
.L062 ;;line 156;;  if c  >  25 then pfscore2 = 96

	LDA #25
	CMP c
     BCS .skipL062
.condpart54
	LDA #96
	STA pfscore2
.skipL062
.L063 ;;line 157;;  if c  >  12 then pfscore2 = 64

	LDA #12
	CMP c
     BCS .skipL063
.condpart55
	LDA #64
	STA pfscore2
.skipL063
.L064 ;;line 158;;  if c  >  6 then pfscore2 = 32

	LDA #6
	CMP c
     BCS .skipL064
.condpart56
	LDA #32
	STA pfscore2
.skipL064
.L065 ;;line 159;;  if c  >  3 then pfscore2 = 16

	LDA #3
	CMP c
     BCS .skipL065
.condpart57
	LDA #16
	STA pfscore2
.skipL065
.L066 ;;line 160;;  if c  >  0 then pfscore2 = 8

	LDA #0
	CMP c
     BCS .skipL066
.condpart58
	LDA #8
	STA pfscore2
.skipL066
.L067 ;;line 161;;  if c = 0 then pfscore2 = 0

	LDA c
	CMP #0
     BNE .skipL067
.condpart59
	LDA #0
	STA pfscore2
.skipL067
.
 ;;line 162;; 

.
 ;;line 163;; 

.L068 ;;line 164;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L069 ;;line 165;;  COLUPF = $28

	LDA #$28
	STA COLUPF
.L070 ;;line 166;;  COLUP0 = $C6

	LDA #$C6
	STA COLUP0
.L071 ;;line 167;;  COLUP1 = $1C

	LDA #$1C
	STA COLUP1
.L072 ;;line 168;;  scorecolor = $36

	LDA #$36
	STA scorecolor
.
 ;;line 169;; 

.L073 ;;line 170;;  drawscreen

 sta temp7
 lda #>(ret_point2-1)
 pha
 lda #<(ret_point2-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point2
.L074 ;;line 171;;  goto main

 jmp .main

.
 ;;line 172;; 

.PlayerHit
 ;;line 173;; PlayerHit

.L075 ;;line 174;;  COLUBK = $34

	LDA #$34
	STA COLUBK
.L076 ;;line 175;;  m = m  -  1

	DEC m
.L077 ;;line 176;;  player0x = 80

	LDA #80
	STA player0x
.L078 ;;line 177;;  player0y = 30

	LDA #30
	STA player0y
.L079 ;;line 178;;  j = 0

	LDA #0
	STA j
.L080 ;;line 179;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L081 ;;line 180;;  if m  <=  0 then gosub GameOver

	LDA #0
	CMP m
     BCC .skipL081
.condpart60
 jsr .GameOver

.skipL081
.L082 ;;line 181;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 182;; 

.GameOver
 ;;line 183;; GameOver

.L083 ;;line 184;;  c = 100

	LDA #100
	STA c
.L084 ;;line 185;;  g = 6

	LDA #6
	STA g
.L085 ;;line 186;;  m = 4

	LDA #4
	STA m
.L086 ;;line 187;;  o = 0

	LDA #0
	STA o
.L087 ;;line 188;;  player0x = 80

	LDA #80
	STA player0x
.L088 ;;line 189;;  player0y = 30

	LDA #30
	STA player0y
.L089 ;;line 190;;  gosub LoadRoom

 jsr .LoadRoom

.L090 ;;line 191;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 192;; 

.LoadRoom
 ;;line 193;; LoadRoom

.L091 ;;line 194;;  pfclear

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	ldx #28
	stx DF0WRITE
	LDA #0
	sta DF0WRITE
	lda #255
	sta CALLFUNCTION
.
 ;;line 195;; 

.LoadRoom0
 ;;line 196;; LoadRoom0

.L092 ;;line 197;;  pfhline 0 0 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #0
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L093 ;;line 198;;  pfhline 0 1 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #1
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L094 ;;line 199;;  pfhline 6 1 7 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #7
	STA DF0WRITE
	LDY #1
	STY DF0WRITE
	LDA #6
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L095 ;;line 200;;  pfhline 22 1 23 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #23
	STA DF0WRITE
	LDY #1
	STY DF0WRITE
	LDA #22
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L096 ;;line 201;;  pfhline 30 1 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #1
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L097 ;;line 202;;  pfhline 0 2 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #2
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L098 ;;line 203;;  pfhline 6 2 7 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #7
	STA DF0WRITE
	LDY #2
	STY DF0WRITE
	LDA #6
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L099 ;;line 204;;  pfhline 22 2 23 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #23
	STA DF0WRITE
	LDY #2
	STY DF0WRITE
	LDA #22
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0100 ;;line 205;;  pfhline 30 2 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #2
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0101 ;;line 206;;  pfhline 0 3 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #3
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0102 ;;line 207;;  pfhline 30 3 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #3
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0103 ;;line 208;;  pfhline 0 4 7 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #7
	STA DF0WRITE
	LDY #4
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0104 ;;line 209;;  pfhline 30 4 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #4
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0105 ;;line 210;;  pfhline 0 5 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #5
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0106 ;;line 211;;  pfhline 30 5 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #5
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0107 ;;line 212;;  pfhline 0 6 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #6
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0108 ;;line 213;;  pfhline 30 6 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #6
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0109 ;;line 214;;  pfhline 0 7 7 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #7
	STA DF0WRITE
	LDY #7
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0110 ;;line 215;;  pfhline 30 7 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #7
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0111 ;;line 216;;  pfhline 0 8 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #8
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0112 ;;line 217;;  pfhline 20 8 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #8
	STY DF0WRITE
	LDA #20
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0113 ;;line 218;;  pfhline 0 9 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #9
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0114 ;;line 219;;  pfhline 30 9 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #9
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0115 ;;line 220;;  pfhline 0 10 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #10
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0116 ;;line 221;;  pfhline 30 10 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #10
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0117 ;;line 222;;  pfhline 0 11 11 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #11
	STA DF0WRITE
	LDY #11
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0118 ;;line 223;;  pfhline 20 11 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #11
	STY DF0WRITE
	LDA #20
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0119 ;;line 224;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 225;; 

.LoadRoom1
 ;;line 226;; LoadRoom1

.L0120 ;;line 227;;  pfhline 0 0 11 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #11
	STA DF0WRITE
	LDY #0
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0121 ;;line 228;;  pfhline 20 0 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #0
	STY DF0WRITE
	LDA #20
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0122 ;;line 229;;  pfhline 0 1 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #1
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0123 ;;line 230;;  pfhline 30 1 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #1
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0124 ;;line 231;;  pfhline 0 2 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #2
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0125 ;;line 232;;  pfhline 30 2 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #2
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0126 ;;line 233;;  pfhline 0 3 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #3
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0127 ;;line 234;;  pfhline 30 3 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #3
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0128 ;;line 235;;  pfhline 0 4 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #4
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0129 ;;line 236;;  pfhline 30 4 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #4
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0130 ;;line 237;;  pfhline 0 5 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #5
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0131 ;;line 238;;  pfhline 30 5 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #5
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0132 ;;line 239;;  pfhline 0 6 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #6
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0133 ;;line 240;;  pfhline 30 6 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #6
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0134 ;;line 241;;  pfhline 0 7 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #7
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0135 ;;line 242;;  pfhline 30 7 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #7
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0136 ;;line 243;;  pfhline 0 8 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #8
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0137 ;;line 244;;  pfhline 30 8 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #8
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0138 ;;line 245;;  pfhline 0 9 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #9
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0139 ;;line 246;;  pfhline 30 9 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #9
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0140 ;;line 247;;  pfhline 0 10 1 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #1
	STA DF0WRITE
	LDY #10
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0141 ;;line 248;;  pfhline 30 10 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #10
	STY DF0WRITE
	LDA #30
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0142 ;;line 249;;  pfhline 0 11 31 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #31
	STA DF0WRITE
	LDY #11
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0143 ;;line 250;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 251;; 

.L0144 ;;line 252;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
 if ECHO2
 echo "    ",[(start_bank2 - *)]d , "bytes of ROM space left in bank 2")
 endif
ECHO2 = 1
 ORG $2FF4-bscode_length
 RORG $3FF4-bscode_length
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
 RORG $3FFC
 .word (start_bank2 & $ffff)
 .word (start_bank2 & $ffff)
 ORG $3000
 RORG $5000
 repeat 129
 .byte 0
 repend
 if ECHO3
 echo "    ",[(start_bank3 - *)]d , "bytes of ROM space left in bank 3")
 endif
ECHO3 = 1
 ORG $3FF4-bscode_length
 RORG $5FF4-bscode_length
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
 RORG $5FFC
 .word (start_bank3 & $ffff)
 .word (start_bank3 & $ffff)
 ORG $4000
 RORG $7000
 repeat 129
 .byte 0
 repend
 if ECHO4
 echo "    ",[(start_bank4 - *)]d , "bytes of ROM space left in bank 4")
 endif
ECHO4 = 1
 ORG $4FF4-bscode_length
 RORG $7FF4-bscode_length
start_bank4 ldx #$ff
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
 ORG $4FFC
 RORG $7FFC
 .word (start_bank4 & $ffff)
 .word (start_bank4 & $ffff)
 ORG $5000
 RORG $9000
 repeat 129
 .byte 0
 repend
 if ECHO5
 echo "    ",[(start_bank5 - *)]d , "bytes of ROM space left in bank 5")
 endif
ECHO5 = 1
 ORG $5FF4-bscode_length
 RORG $9FF4-bscode_length
start_bank5 ldx #$ff
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
 ORG $5FFC
 RORG $9FFC
 .word (start_bank5 & $ffff)
 .word (start_bank5 & $ffff)
 ORG $6000
 RORG $B000
 repeat 129
 .byte 0
 repend
 if ECHO6
 echo "    ",[(start_bank6 - *)]d , "bytes of ROM space left in bank 6")
 endif
ECHO6 = 1
 ORG $6FF4-bscode_length
 RORG $BFF4-bscode_length
start_bank6 ldx #$ff
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
 ORG $6FFC
 RORG $BFFC
 .word (start_bank6 & $ffff)
 .word (start_bank6 & $ffff)
 ORG $7000
 RORG $D000
 repeat 129
 .byte 0
 repend
; bB.asm file is split here
PF_data1
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
playerL05_0
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
playerL06_1
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
       echo "    ",[(DPC_graphics_end - *)]d , "bytes of ROM space left in graphics bank")
 endif 
ECHOFIRST = 1
 
 
 
