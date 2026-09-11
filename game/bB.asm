game
.
 ;;line 1;; 

.
 ;;line 2;; 

.
 ;;line 3;; 

.L00 ;;line 4;;  set kernel DPC + 

.L01 ;;line 5;;  set kernel_options collision(playfield,player0)

DPC_kernel_options = 	CXP0FB+$40
.
 ;;line 6;; 

.L02 ;;line 7;;  goto start bank2

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
 ;;line 8;; 

.L03 ;;line 9;;  bank 2

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
 ;;line 10;; start

.
 ;;line 11;; 

.L04 ;;line 12;;  playfield:

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
 ;;line 26;; 

.L05 ;;line 27;;  scorecolors:

	lda #<scoredata
	STA DF0LOW
	lda #((>scoredata) & $0f)
	STA DF0HI
	lda #$00
	sta DF0WRITE
	lda #$00
	sta DF0WRITE
	lda #$00
	sta DF0WRITE
	lda #$00
	sta DF0WRITE
	lda #$00
	sta DF0WRITE
	lda #$00
	sta DF0WRITE
	lda #$00
	sta DF0WRITE
	lda #$00
	sta DF0WRITE
.
 ;;line 37;; 

.player0:
 ;;line 38;; player0:

.%00011000
 ;;line 39;; %00011000

.%00111100
 ;;line 40;; %00111100

.%00111100
 ;;line 41;; %00111100

.%00111100
 ;;line 42;; %00111100

.%00100100
 ;;line 43;; %00100100

.%00100100
 ;;line 44;; %00100100

.%00111100
 ;;line 45;; %00111100

.%00111100
 ;;line 46;; %00111100

.%00111100
 ;;line 47;; %00111100

.%00011000
 ;;line 48;; %00011000

.%00011000
 ;;line 49;; %00011000

.
 ;;line 51;; 

.L06 ;;line 52;;  player1:

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
 ;;line 65;; 

.
 ;;line 66;; 

.L07 ;;line 67;;  dim startRoom = k

.L08 ;;line 68;;  dim startX = l

.L09 ;;line 69;;  dim startY = m

.L010 ;;line 70;;  dim minerRoom = q

.L011 ;;line 71;;  dim minerX = r

.L012 ;;line 72;;  dim minerY = s

.L013 ;;line 73;;  dim maxRoom = t

.L014 ;;line 74;;  a = 72  :  b = 40  :  c = 100

	LDA #72
	STA a
	LDA #40
	STA b
	LDA #100
	STA c
.L015 ;;line 75;;  d = 0  :  e = 1  :  f = 0

	LDA #0
	STA d
	LDA #1
	STA e
	LDA #0
	STA f
.L016 ;;line 76;;  g = 6  :  h = 0  :  i = 0

	LDA #6
	STA g
	LDA #0
	STA h
	STA i
.L017 ;;line 77;;  j = 0  :  n = 0  :  o = 0

	LDA #0
	STA j
	STA n
	STA o
.L018 ;;line 78;;  score = 123456

	LDA #$56
	STA score+2
	LDA #$34
	STA score+1
	LDA #$12
	STA score
.
 ;;line 79;; 

.
 ;;line 80;; 

.L019 ;;line 81;;  var0 = 0  :  var1 = 0  :  var2 = 1  :  var3 = 0  :  var4 = 30

	LDA #0
	STA var0
	STA var1
	LDA #1
	STA var2
	LDA #0
	STA var3
	LDA #30
	STA var4
.
 ;;line 82;; 

.
 ;;line 83;; 

.
 ;;line 84;; 

.
 ;;line 85;; 

.L020 ;;line 86;;  startRoom = 0

	LDA #0
	STA startRoom
.L021 ;;line 87;;  startX = 50

	LDA #50
	STA startX
.L022 ;;line 88;;  startY = 32

	LDA #32
	STA startY
.
 ;;line 89;; 

.L023 ;;line 90;;  minerRoom = 1

	LDA #1
	STA minerRoom
.L024 ;;line 91;;  minerX = 70

	LDA #70
	STA minerX
.L025 ;;line 92;;  minerY = 160

	LDA #160
	STA minerY
.
 ;;line 93;; 

.L026 ;;line 94;;  maxRoom = 1

	LDA #1
	STA maxRoom
.
 ;;line 95;; 

.
 ;;line 96;; 

.
 ;;line 97;; 

.
 ;;line 98;; 

.
 ;;line 99;; 

.
 ;;line 100;; 

.L027 ;;line 101;;  o = startRoom

	LDA startRoom
	STA o
.L028 ;;line 102;;  gosub LoadRoom

 jsr .LoadRoom

.
 ;;line 103;; 

.L029 ;;line 104;;  player0x = startX

	LDA startX
	STA player0x
.L030 ;;line 105;;  player0y = startY

	LDA startY
	STA player0y
.
 ;;line 106;; 

.main
 ;;line 107;; main

.
 ;;line 108;; 

.L031 ;;line 109;;  DF0FRACINC = 20

	LDA #20
	STA DF0FRACINC
.L032 ;;line 110;;  DF1FRACINC = 20

	LDA #20
	STA DF1FRACINC
.L033 ;;line 111;;  DF2FRACINC = 20

	LDA #20
	STA DF2FRACINC
.L034 ;;line 112;;  DF3FRACINC = 20

	LDA #20
	STA DF3FRACINC
.L035 ;;line 113;;  DF4FRACINC = 255

	LDA #255
	STA DF4FRACINC
.
 ;;line 114;; 

.
 ;;line 115;; 

.L036 ;;line 116;;  p = 0

	LDA #0
	STA p
.L037 ;;line 117;;  d = 0

	LDA #0
	STA d
.
 ;;line 118;; 

.
 ;;line 119;; 

.L038 ;;line 120;;  if joy0left then player0x = player0x  -  1  :  p = 255  :  e = 0

 bit SWCHA
	BVS .skipL038
.condpart0
	DEC player0x
	LDA #255
	STA p
	LDA #0
	STA e
.skipL038
.L039 ;;line 121;;  if joy0right then player0x = player0x  +  1  :  p = 1  :  e = 1

 bit SWCHA
	BMI .skipL039
.condpart1
	INC player0x
	LDA #1
	STA p
	STA e
.skipL039
.
 ;;line 122;; 

.
 ;;line 123;; 

.L040 ;;line 124;;  if joy0up then if j = 0 then player0y = player0y  -  1  :  d = 255  :  n = 0

 lda #$10
 bit SWCHA
	BNE .skipL040
.condpart2
	LDA j
	CMP #0
     BNE .skip2then
.condpart3
	DEC player0y
	LDA #255
	STA d
	LDA #0
	STA n
.skip2then
.skipL040
.
 ;;line 125;; 

.
 ;;line 126;; 

.L041 ;;line 127;;  if !joy0up then if j = 0 then n = n  +  1

 lda #$10
 bit SWCHA
	BEQ .skipL041
.condpart4
	LDA j
	CMP #0
     BNE .skip4then
.condpart5
	INC n
.skip4then
.skipL041
.L042 ;;line 128;;  if !joy0up then if j = 0 then if n  >=  1 then player0y = player0y  +  1  :  d = 1  :  n = 0

 lda #$10
 bit SWCHA
	BEQ .skipL042
.condpart6
	LDA j
	CMP #0
     BNE .skip6then
.condpart7
	LDA n
	CMP #1
     BCC .skip7then
.condpart8
	INC player0y
	LDA #1
	STA d
	LDA #0
	STA n
.skip7then
.skip6then
.skipL042
.
 ;;line 129;; 

.
 ;;line 130;; 

.L043 ;;line 131;;  if joy0up then AUDC0 = 8  :  AUDF0 = 4  :  AUDV0 = 8

 lda #$10
 bit SWCHA
	BNE .skipL043
.condpart9
	LDA #8
	STA AUDC0
	LDA #4
	STA AUDF0
	LDA #8
	STA AUDV0
.skipL043
.L044 ;;line 132;;  if !joy0up then AUDV0 = 0

 lda #$10
 bit SWCHA
	BEQ .skipL044
.condpart10
	LDA #0
	STA AUDV0
.skipL044
.
 ;;line 133;; 

.
 ;;line 134;; 

.L045 ;;line 135;;  if var4  >  var3 then var0 = var0  +  var2

	LDA var3
	CMP var4
     BCS .skipL045
.condpart11
	LDA var0
	CLC
	ADC var2
	STA var0
.skipL045
.L046 ;;line 136;;  if var0  <=  var3 then var2 = 1

	LDA var3
	CMP var0
     BCC .skipL046
.condpart12
	LDA #1
	STA var2
.skipL046
.L047 ;;line 137;;  if var0  >=  var4 then var2 = 255

	LDA var0
	CMP var4
     BCC .skipL047
.condpart13
	LDA #255
	STA var2
.skipL047
.
 ;;line 138;; 

.
 ;;line 139;; 

.
 ;;line 140;; 

.L048 ;;line 141;;  if player0x  >  150 then if o  <  maxRoom then o = o  +  1  :  gosub LoadRoom  :  player0x = 18

	LDA #150
	CMP player0x
     BCS .skipL048
.condpart14
	LDA o
	CMP maxRoom
     BCS .skip14then
.condpart15
	INC o
 jsr .LoadRoom
	LDA #18
	STA player0x
.skip14then
.skipL048
.L049 ;;line 142;;  if player0x  >  149 then player0x = 149

	LDA #149
	CMP player0x
     BCS .skipL049
.condpart16
	LDA #149
	STA player0x
.skipL049
.
 ;;line 143;; 

.L050 ;;line 144;;  if player0x  <  18 then if o  >  0 then o = o  -  1  :  gosub LoadRoom  :  player0x = 148

	LDA player0x
	CMP #18
     BCS .skipL050
.condpart17
	LDA #0
	CMP o
     BCS .skip17then
.condpart18
	DEC o
 jsr .LoadRoom
	LDA #148
	STA player0x
.skip17then
.skipL050
.L051 ;;line 145;;  if player0x  <  14 then player0x = 14

	LDA player0x
	CMP #14
     BCS .skipL051
.condpart19
	LDA #14
	STA player0x
.skipL051
.
 ;;line 146;; 

.L052 ;;line 147;;  if player0y  >=  150 then if o  <  maxRoom then o = o  +  1  :  gosub LoadRoom

	LDA player0y
	CMP #150
     BCC .skipL052
.condpart20
	LDA o
	CMP maxRoom
     BCS .skip20then
.condpart21
	INC o
 jsr .LoadRoom

.skip20then
.skipL052
.L053 ;;line 148;;  if player0y  >=  150 then player0y = 20

	LDA player0y
	CMP #150
     BCC .skipL053
.condpart22
	LDA #20
	STA player0y
.skipL053
.
 ;;line 149;; 

.L054 ;;line 150;;  if player0y  <=  5 then if o  >  0 then o = o  -  1  :  gosub LoadRoom

	LDA #5
	CMP player0y
     BCC .skipL054
.condpart23
	LDA #0
	CMP o
     BCS .skip23then
.condpart24
	DEC o
 jsr .LoadRoom

.skip23then
.skipL054
.L055 ;;line 151;;  if player0y  <=  5 then player0y = 130

	LDA #5
	CMP player0y
     BCC .skipL055
.condpart25
	LDA #130
	STA player0y
.skipL055
.
 ;;line 152;; 

.
 ;;line 153;; 

.L056 ;;line 154;;  if joy0fire then if f = 0 then f = 1  :  missile0x = player0x  +  3  :  missile0y = player0y  +  2

 bit INPT4
	BMI .skipL056
.condpart26
	LDA f
	CMP #0
     BNE .skip26then
.condpart27
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
.skip26then
.skipL056
.L057 ;;line 155;;  if f = 1 then if e = 1 then missile0x = missile0x  +  3

	LDA f
	CMP #1
     BNE .skipL057
.condpart28
	LDA e
	CMP #1
     BNE .skip28then
.condpart29
	LDA missile0x
	CLC
	ADC #3
	STA missile0x
.skip28then
.skipL057
.L058 ;;line 156;;  if f = 1 then if e = 0 then missile0x = missile0x  -  3

	LDA f
	CMP #1
     BNE .skipL058
.condpart30
	LDA e
	CMP #0
     BNE .skip30then
.condpart31
	LDA missile0x
	SEC
	SBC #3
	STA missile0x
.skip30then
.skipL058
.L059 ;;line 157;;  if f = 1 then if missile0x  <  1 then f = 0

	LDA f
	CMP #1
     BNE .skipL059
.condpart32
	LDA missile0x
	CMP #1
     BCS .skip32then
.condpart33
	LDA #0
	STA f
.skip32then
.skipL059
.L060 ;;line 158;;  if f = 1 then if missile0x  >  150 then f = 0

	LDA f
	CMP #1
     BNE .skipL060
.condpart34
	LDA #150
	CMP missile0x
     BCS .skip34then
.condpart35
	LDA #0
	STA f
.skip34then
.skipL060
.L061 ;;line 159;;  if f = 1 then if collision(missile0,playfield) then f = 0

	LDA f
	CMP #1
     BNE .skipL061
.condpart36
	bit 	CXM0FB
	BPL .skip36then
.condpart37
	LDA #0
	STA f
.skip36then
.skipL061
.L062 ;;line 160;;  if !joy0fire then f = 0

 bit INPT4
	BPL .skipL062
.condpart38
	LDA #0
	STA f
.skipL062
.
 ;;line 161;; 

.
 ;;line 162;; 

.L063 ;;line 163;;  if joy0down then if i = 0 then if g  >  0 then i = 1  :  h = 30  :  g = g  -  1

 lda #$20
 bit SWCHA
	BNE .skipL063
.condpart39
	LDA i
	CMP #0
     BNE .skip39then
.condpart40
	LDA #0
	CMP g
     BCS .skip40then
.condpart41
	LDA #1
	STA i
	LDA #30
	STA h
	DEC g
.skip40then
.skip39then
.skipL063
.L064 ;;line 164;;  if i = 1 then h = h  -  1

	LDA i
	CMP #1
     BNE .skipL064
.condpart42
	DEC h
.skipL064
.L065 ;;line 165;;  if h  <=  0 then i = 0

	LDA #0
	CMP h
     BCC .skipL065
.condpart43
	LDA #0
	STA i
.skipL065
.
 ;;line 166;; 

.
 ;;line 167;; 

.L066 ;;line 168;;  player1x = var0

	LDA var0
	STA player1x
.L067 ;;line 169;;  player1y = var1

	LDA var1
	STA player1y
.
 ;;line 170;; 

.
 ;;line 171;; 

.L068 ;;line 172;;  COLUP0 = $0E

	LDA #$0E
	STA COLUP0
.L069 ;;line 173;;  COLUP1 = $1C

	LDA #$1C
	STA COLUP1
.L070 ;;line 174;;  scorecolor = $0E

	LDA #$0E
	STA scorecolor
.L071 ;;line 175;;  DF6FRACINC = 255

	LDA #255
	STA DF6FRACINC
.L072 ;;line 176;;  player0:

	LDX #<playerL072_0
	STX player0pointerlo
	LDA #((>playerL072_0) & $0f) | (((>playerL072_0) / 2) & $70)
	STA player0pointerhi
	LDA #11
	STA player0height
.L073 ;;line 189;;  bkcolors:

	LDA #<BKCOLS
	STA DF0LOW
	LDA #(>BKCOLS) & $0F
	STA DF0HI
	LDA #<backgroundcolorL073
	STA PARAMETER
	LDA #((>backgroundcolorL073) & $0f) | (((>backgroundcolorL073) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #145
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ;;line 336;; 

.L074 ;;line 337;;  pfcolors:

	LDA #<PFCOLS
	STA DF0LOW
	LDA #(>PFCOLS) & $0F
	STA DF0HI
	LDA #<playfieldcolorL074
	STA PARAMETER
	LDA #((>playfieldcolorL074) & $0f) | (((>playfieldcolorL074) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #176
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ;;line 515;; 

.L075 ;;line 516;;  drawscreen

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
.
 ;;line 517;; 

.
 ;;line 518;; 

.L076 ;;line 519;;  if collision(player0,playfield) then player0x = player0x  -  p

	bit 	CXP0FB
	BPL .skipL076
.condpart44
	LDA player0x
	SEC
	SBC p
	STA player0x
.skipL076
.L077 ;;line 520;;  if collision(player0,playfield) then player0y = player0y  -  d

	bit 	CXP0FB
	BPL .skipL077
.condpart45
	LDA player0y
	SEC
	SBC d
	STA player0y
.skipL077
.
 ;;line 521;; 

.
 ;;line 522;; 

.L078 ;;line 523;;  j = 0

	LDA #0
	STA j
.L079 ;;line 524;;  if collision(player0,playfield) then j = 1

	bit 	CXP0FB
	BPL .skipL079
.condpart46
	LDA #1
	STA j
.skipL079
.
 ;;line 525;; 

.L080 ;;line 526;;  goto main

 jmp .main

.
 ;;line 527;; 

.PlayerHit
 ;;line 528;; PlayerHit

.L081 ;;line 529;;  COLUBK = $34

	LDA #$34
	STA COLUBK
.L082 ;;line 530;;  m = m  -  1

	DEC m
.L083 ;;line 531;;  player0x = 80

	LDA #80
	STA player0x
.L084 ;;line 532;;  player0y = 30

	LDA #30
	STA player0y
.L085 ;;line 533;;  j = 0

	LDA #0
	STA j
.L086 ;;line 534;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L087 ;;line 535;;  if m  <=  0 then gosub GameOver

	LDA #0
	CMP m
     BCC .skipL087
.condpart47
 jsr .GameOver

.skipL087
.L088 ;;line 536;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 537;; 

.GameOver
 ;;line 538;; GameOver

.L089 ;;line 539;;  c = 100

	LDA #100
	STA c
.L090 ;;line 540;;  g = 6

	LDA #6
	STA g
.L091 ;;line 541;;  m = 4

	LDA #4
	STA m
.L092 ;;line 542;;  o = 0

	LDA #0
	STA o
.L093 ;;line 543;;  player0x = 80

	LDA #80
	STA player0x
.L094 ;;line 544;;  player0y = 30

	LDA #30
	STA player0y
.L095 ;;line 545;;  gosub LoadRoom

 jsr .LoadRoom

.L096 ;;line 546;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 547;; 

.LoadRoom
 ;;line 548;; LoadRoom

.L097 ;;line 549;;  pfclear

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
.L098 ;;line 550;;  if o = 0 then gosub Room0

	LDA o
	CMP #0
     BNE .skipL098
.condpart48
 jsr .Room0

.skipL098
.L099 ;;line 551;;  if o = 1 then gosub Room1

	LDA o
	CMP #1
     BNE .skipL099
.condpart49
 jsr .Room1

.skipL099
.L0100 ;;line 552;;  gosub LoadEnemies

 jsr .LoadEnemies

.L0101 ;;line 553;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.Room0
 ;;line 554;; Room0

.Room0Data
 ;;line 555;; Room0Data

.L0102 ;;line 556;;  pfhline 0 0 31 on

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
.L0103 ;;line 557;;  pfhline 0 1 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #1
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0104 ;;line 558;;  pfhline 31 1 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0105 ;;line 559;;  pfhline 0 2 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #2
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0106 ;;line 560;;  pfhline 31 2 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0107 ;;line 561;;  pfhline 0 3 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #3
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0108 ;;line 562;;  pfhline 31 3 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0109 ;;line 563;;  pfhline 0 4 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #4
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0110 ;;line 564;;  pfhline 12 4 12 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #12
	STA DF0WRITE
	LDY #4
	STY DF0WRITE
	LDA #12
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0111 ;;line 565;;  pfhline 31 4 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0112 ;;line 566;;  pfhline 0 5 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #5
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0113 ;;line 567;;  pfhline 12 5 12 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #12
	STA DF0WRITE
	LDY #5
	STY DF0WRITE
	LDA #12
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0114 ;;line 568;;  pfhline 31 5 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0115 ;;line 569;;  pfhline 0 6 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #6
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0116 ;;line 570;;  pfhline 12 6 12 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #12
	STA DF0WRITE
	LDY #6
	STY DF0WRITE
	LDA #12
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0117 ;;line 571;;  pfhline 31 6 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0118 ;;line 572;;  pfhline 0 7 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #7
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0119 ;;line 573;;  pfhline 12 7 12 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #12
	STA DF0WRITE
	LDY #7
	STY DF0WRITE
	LDA #12
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0120 ;;line 574;;  pfhline 31 7 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0121 ;;line 575;;  pfhline 0 8 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #8
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0122 ;;line 576;;  pfhline 31 8 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0123 ;;line 577;;  pfhline 0 9 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #9
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0124 ;;line 578;;  pfhline 31 9 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0125 ;;line 579;;  pfhline 0 10 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #10
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0126 ;;line 580;;  pfhline 31 10 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0127 ;;line 581;;  pfhline 0 11 12 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #12
	STA DF0WRITE
	LDY #11
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0128 ;;line 582;;  pfhline 19 11 31 on

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
	LDA #19
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0129 ;;line 583;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 584;; 

.Room1
 ;;line 585;; Room1

.L0130 ;;line 586;;  pfhline 0 0 12 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #12
	STA DF0WRITE
	LDY #0
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0131 ;;line 587;;  pfhline 19 0 31 on

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
	LDA #19
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0132 ;;line 588;;  pfhline 0 1 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #1
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0133 ;;line 589;;  pfhline 31 1 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0134 ;;line 590;;  pfhline 0 2 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #2
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0135 ;;line 591;;  pfhline 31 2 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0136 ;;line 592;;  pfhline 0 3 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #3
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0137 ;;line 593;;  pfhline 31 3 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0138 ;;line 594;;  pfhline 0 4 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #4
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0139 ;;line 595;;  pfhline 31 4 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0140 ;;line 596;;  pfhline 0 5 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #5
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0141 ;;line 597;;  pfhline 31 5 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0142 ;;line 598;;  pfhline 0 6 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #6
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0143 ;;line 599;;  pfhline 31 6 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0144 ;;line 600;;  pfhline 0 7 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #7
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0145 ;;line 601;;  pfhline 20 7 20 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #20
	STA DF0WRITE
	LDY #7
	STY DF0WRITE
	LDA #20
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0146 ;;line 602;;  pfhline 31 7 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0147 ;;line 603;;  pfhline 0 8 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #8
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0148 ;;line 604;;  pfhline 20 8 20 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #20
	STA DF0WRITE
	LDY #8
	STY DF0WRITE
	LDA #20
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0149 ;;line 605;;  pfhline 31 8 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0150 ;;line 606;;  pfhline 0 9 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #9
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0151 ;;line 607;;  pfhline 20 9 20 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #20
	STA DF0WRITE
	LDY #9
	STY DF0WRITE
	LDA #20
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0152 ;;line 608;;  pfhline 31 9 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0153 ;;line 609;;  pfhline 0 10 0 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #0
	STA DF0WRITE
	LDY #10
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0154 ;;line 610;;  pfhline 20 10 20 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #20
	STA DF0WRITE
	LDY #10
	STY DF0WRITE
	LDA #20
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0155 ;;line 611;;  pfhline 31 10 31 on

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
	LDA #31
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0156 ;;line 612;;  pfhline 0 11 31 on

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
.L0157 ;;line 613;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.LoadEnemies
 ;;line 614;; LoadEnemies

.L0158 ;;line 615;;  if o = 0 then var0 = 98  :  var1 = 48  :  var2 = 1  :  var3 = 34  :  var4 = 82

	LDA o
	CMP #0
     BNE .skipL0158
.condpart50
	LDA #98
	STA var0
	LDA #48
	STA var1
	LDA #1
	STA var2
	LDA #34
	STA var3
	LDA #82
	STA var4
.skipL0158
.L0159 ;;line 616;;  if o = 1 then var0 = 82  :  var1 = 160  :  var2 = 1  :  var3 = 34  :  var4 = 66

	LDA o
	CMP #1
     BNE .skipL0159
.condpart51
	LDA #82
	STA var0
	LDA #160
	STA var1
	LDA #1
	STA var2
	LDA #34
	STA var3
	LDA #66
	STA var4
.skipL0159
.L0160 ;;line 617;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 618;; 

.return
 ;;line 619;; return

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
playerL072_0
	.byte  %00011000
	.byte  %00111100
	.byte  %00111100
	.byte  %00111100
	.byte  %00100100
	.byte  %00100100
	.byte  %00111100
	.byte  %00111100
	.byte  %00111100
	.byte  %00011000
	.byte  %00011000
backgroundcolorL073
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $00
	.byte  $74
	.byte  $74
	.byte  $74
	.byte  $74
	.byte  $74
	.byte  $74
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
	.byte  $04
playfieldcolorL074
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $B4
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
	.byte  $32
 if ECHOFIRST
       echo "    ",[(DPC_graphics_end - *)]d , "bytes of ROM space left in graphics bank")
 endif 
ECHOFIRST = 1
 
 
 
