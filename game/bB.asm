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

.
 ;;line 81;; 

.
 ;;line 82;; 

.L019 ;;line 83;;  startRoom = 0

	LDA #0
	STA startRoom
.L020 ;;line 84;;  startX = 50

	LDA #50
	STA startX
.L021 ;;line 85;;  startY = 32

	LDA #32
	STA startY
.
 ;;line 86;; 

.L022 ;;line 87;;  minerRoom = 1

	LDA #1
	STA minerRoom
.L023 ;;line 88;;  minerX = 132

	LDA #132
	STA minerX
.L024 ;;line 89;;  minerY = 160

	LDA #160
	STA minerY
.
 ;;line 90;; 

.L025 ;;line 91;;  maxRoom = 1

	LDA #1
	STA maxRoom
.
 ;;line 92;; 

.
 ;;line 93;; 

.
 ;;line 94;; 

.L026 ;;line 95;;  o = startRoom

	LDA startRoom
	STA o
.L027 ;;line 96;;  gosub LoadRoom

 jsr .LoadRoom

.
 ;;line 97;; 

.L028 ;;line 98;;  player0x = startX

	LDA startX
	STA player0x
.L029 ;;line 99;;  player0y = startY

	LDA startY
	STA player0y
.
 ;;line 100;; 

.main
 ;;line 101;; main

.
 ;;line 102;; 

.L030 ;;line 103;;  DF0FRACINC = 20

	LDA #20
	STA DF0FRACINC
.L031 ;;line 104;;  DF1FRACINC = 20

	LDA #20
	STA DF1FRACINC
.L032 ;;line 105;;  DF2FRACINC = 20

	LDA #20
	STA DF2FRACINC
.L033 ;;line 106;;  DF3FRACINC = 20

	LDA #20
	STA DF3FRACINC
.L034 ;;line 107;;  DF4FRACINC = 255

	LDA #255
	STA DF4FRACINC
.
 ;;line 108;; 

.
 ;;line 109;; 

.L035 ;;line 110;;  p = 0

	LDA #0
	STA p
.L036 ;;line 111;;  d = 0

	LDA #0
	STA d
.
 ;;line 112;; 

.
 ;;line 113;; 

.L037 ;;line 114;;  if joy0left then player0x = player0x  -  1  :  p = 255  :  e = 0

 bit SWCHA
	BVS .skipL037
.condpart0
	DEC player0x
	LDA #255
	STA p
	LDA #0
	STA e
.skipL037
.L038 ;;line 115;;  if joy0right then player0x = player0x  +  1  :  p = 1  :  e = 1

 bit SWCHA
	BMI .skipL038
.condpart1
	INC player0x
	LDA #1
	STA p
	STA e
.skipL038
.
 ;;line 116;; 

.
 ;;line 117;; 

.L039 ;;line 118;;  if joy0up then if j = 0 then player0y = player0y  -  1  :  d = 255  :  n = 0

 lda #$10
 bit SWCHA
	BNE .skipL039
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
.skipL039
.
 ;;line 119;; 

.
 ;;line 120;; 

.L040 ;;line 121;;  if !joy0up then n = n  +  1

 lda #$10
 bit SWCHA
	BEQ .skipL040
.condpart4
	INC n
.skipL040
.L041 ;;line 122;;  if !joy0up then if n  >=  2 then player0y = player0y  +  1  :  d = 1  :  n = 0

 lda #$10
 bit SWCHA
	BEQ .skipL041
.condpart5
	LDA n
	CMP #2
     BCC .skip5then
.condpart6
	INC player0y
	LDA #1
	STA d
	LDA #0
	STA n
.skip5then
.skipL041
.
 ;;line 123;; 

.
 ;;line 124;; 

.
 ;;line 125;; 

.L042 ;;line 126;;  if player0x  >  150 then if o  <  maxRoom then o = o  +  1  :  gosub LoadRoom  :  player0x = 18

	LDA #150
	CMP player0x
     BCS .skipL042
.condpart7
	LDA o
	CMP maxRoom
     BCS .skip7then
.condpart8
	INC o
 jsr .LoadRoom
	LDA #18
	STA player0x
.skip7then
.skipL042
.
 ;;line 127;; 

.L043 ;;line 128;;  if player0x  <  18 then if o  >  0 then o = o  -  1  :  gosub LoadRoom  :  player0x = 148

	LDA player0x
	CMP #18
     BCS .skipL043
.condpart9
	LDA #0
	CMP o
     BCS .skip9then
.condpart10
	DEC o
 jsr .LoadRoom
	LDA #148
	STA player0x
.skip9then
.skipL043
.
 ;;line 129;; 

.
 ;;line 130;; 

.L044 ;;line 131;;  if joy0fire then if f = 0 then f = 1  :  missile0x = player0x  +  3  :  missile0y = player0y  +  2

 bit INPT4
	BMI .skipL044
.condpart11
	LDA f
	CMP #0
     BNE .skip11then
.condpart12
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
.skip11then
.skipL044
.L045 ;;line 132;;  if f = 1 then if e = 1 then missile0x = missile0x  +  3

	LDA f
	CMP #1
     BNE .skipL045
.condpart13
	LDA e
	CMP #1
     BNE .skip13then
.condpart14
	LDA missile0x
	CLC
	ADC #3
	STA missile0x
.skip13then
.skipL045
.L046 ;;line 133;;  if f = 1 then if e = 0 then missile0x = missile0x  -  3

	LDA f
	CMP #1
     BNE .skipL046
.condpart15
	LDA e
	CMP #0
     BNE .skip15then
.condpart16
	LDA missile0x
	SEC
	SBC #3
	STA missile0x
.skip15then
.skipL046
.L047 ;;line 134;;  if f = 1 then if missile0x  <  1 then f = 0

	LDA f
	CMP #1
     BNE .skipL047
.condpart17
	LDA missile0x
	CMP #1
     BCS .skip17then
.condpart18
	LDA #0
	STA f
.skip17then
.skipL047
.L048 ;;line 135;;  if f = 1 then if missile0x  >  150 then f = 0

	LDA f
	CMP #1
     BNE .skipL048
.condpart19
	LDA #150
	CMP missile0x
     BCS .skip19then
.condpart20
	LDA #0
	STA f
.skip19then
.skipL048
.L049 ;;line 136;;  if f = 1 then if collision(missile0,playfield) then f = 0

	LDA f
	CMP #1
     BNE .skipL049
.condpart21
	bit 	CXM0FB
	BPL .skip21then
.condpart22
	LDA #0
	STA f
.skip21then
.skipL049
.L050 ;;line 137;;  if !joy0fire then f = 0

 bit INPT4
	BPL .skipL050
.condpart23
	LDA #0
	STA f
.skipL050
.
 ;;line 138;; 

.
 ;;line 139;; 

.L051 ;;line 140;;  if joy0down then if i = 0 then if g  >  0 then i = 1  :  h = 30  :  g = g  -  1

 lda #$20
 bit SWCHA
	BNE .skipL051
.condpart24
	LDA i
	CMP #0
     BNE .skip24then
.condpart25
	LDA #0
	CMP g
     BCS .skip25then
.condpart26
	LDA #1
	STA i
	LDA #30
	STA h
	DEC g
.skip25then
.skip24then
.skipL051
.L052 ;;line 141;;  if i = 1 then h = h  -  1

	LDA i
	CMP #1
     BNE .skipL052
.condpart27
	DEC h
.skipL052
.L053 ;;line 142;;  if h  <=  0 then i = 0

	LDA #0
	CMP h
     BCC .skipL053
.condpart28
	LDA #0
	STA i
.skipL053
.
 ;;line 143;; 

.
 ;;line 144;; 

.L054 ;;line 145;;  COLUP0 = $0E

	LDA #$0E
	STA COLUP0
.L055 ;;line 146;;  COLUP1 = $1C

	LDA #$1C
	STA COLUP1
.L056 ;;line 147;;  scorecolor = $0E

	LDA #$0E
	STA scorecolor
.L057 ;;line 148;;  DF6FRACINC = 255

	LDA #255
	STA DF6FRACINC
.L058 ;;line 149;;  player0:

	LDX #<playerL058_0
	STX player0pointerlo
	LDA #((>playerL058_0) & $0f) | (((>playerL058_0) / 2) & $70)
	STA player0pointerhi
	LDA #11
	STA player0height
.L059 ;;line 162;;  bkcolors:

	LDA #<BKCOLS
	STA DF0LOW
	LDA #(>BKCOLS) & $0F
	STA DF0HI
	LDA #<backgroundcolorL059
	STA PARAMETER
	LDA #((>backgroundcolorL059) & $0f) | (((>backgroundcolorL059) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #145
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ;;line 309;; 

.L060 ;;line 310;;  pfcolors:

	LDA #<PFCOLS
	STA DF0LOW
	LDA #(>PFCOLS) & $0F
	STA DF0HI
	LDA #<playfieldcolorL060
	STA PARAMETER
	LDA #((>playfieldcolorL060) & $0f) | (((>playfieldcolorL060) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #176
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ;;line 488;; 

.L061 ;;line 489;;  drawscreen

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
 ;;line 490;; 

.
 ;;line 491;; 

.L062 ;;line 492;;  if collision(player0,playfield) then player0x = player0x  -  p

	bit 	CXP0FB
	BPL .skipL062
.condpart29
	LDA player0x
	SEC
	SBC p
	STA player0x
.skipL062
.L063 ;;line 493;;  if collision(player0,playfield) then player0y = player0y  -  d

	bit 	CXP0FB
	BPL .skipL063
.condpart30
	LDA player0y
	SEC
	SBC d
	STA player0y
.skipL063
.
 ;;line 494;; 

.
 ;;line 495;; 

.L064 ;;line 496;;  j = 0

	LDA #0
	STA j
.L065 ;;line 497;;  if collision(player0,playfield) then j = 1

	bit 	CXP0FB
	BPL .skipL065
.condpart31
	LDA #1
	STA j
.skipL065
.
 ;;line 498;; 

.
 ;;line 499;; 

.L066 ;;line 500;;  if player0x  >  148 then player0x = 148

	LDA #148
	CMP player0x
     BCS .skipL066
.condpart32
	LDA #148
	STA player0x
.skipL066
.
 ;;line 501;; 

.L067 ;;line 502;;  goto main

 jmp .main

.
 ;;line 503;; 

.PlayerHit
 ;;line 504;; PlayerHit

.L068 ;;line 505;;  COLUBK = $34

	LDA #$34
	STA COLUBK
.L069 ;;line 506;;  m = m  -  1

	DEC m
.L070 ;;line 507;;  player0x = 80

	LDA #80
	STA player0x
.L071 ;;line 508;;  player0y = 30

	LDA #30
	STA player0y
.L072 ;;line 509;;  j = 0

	LDA #0
	STA j
.L073 ;;line 510;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L074 ;;line 511;;  if m  <=  0 then gosub GameOver

	LDA #0
	CMP m
     BCC .skipL074
.condpart33
 jsr .GameOver

.skipL074
.L075 ;;line 512;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 513;; 

.GameOver
 ;;line 514;; GameOver

.L076 ;;line 515;;  c = 100

	LDA #100
	STA c
.L077 ;;line 516;;  g = 6

	LDA #6
	STA g
.L078 ;;line 517;;  m = 4

	LDA #4
	STA m
.L079 ;;line 518;;  o = 0

	LDA #0
	STA o
.L080 ;;line 519;;  player0x = 80

	LDA #80
	STA player0x
.L081 ;;line 520;;  player0y = 30

	LDA #30
	STA player0y
.L082 ;;line 521;;  gosub LoadRoom

 jsr .LoadRoom

.L083 ;;line 522;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 523;; 

.LoadRoom
 ;;line 524;; LoadRoom

.L084 ;;line 525;;  pfclear

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
.LoadRoom0
 ;;line 526;; LoadRoom0

.L085 ;;line 527;;  pfhline 0 0 12 on

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
.L086 ;;line 528;;  pfhline 19 0 31 on

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
.L087 ;;line 529;;  pfhline 0 1 3 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #3
	STA DF0WRITE
	LDY #1
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L088 ;;line 530;;  pfhline 28 1 31 on

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
	LDA #28
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L089 ;;line 531;;  pfhline 0 2 3 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #3
	STA DF0WRITE
	LDY #2
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L090 ;;line 532;;  pfhline 28 2 31 on

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
	LDA #28
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L091 ;;line 533;;  pfhline 0 3 3 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #3
	STA DF0WRITE
	LDY #3
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L092 ;;line 534;;  pfhline 28 3 31 on

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
	LDA #28
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L093 ;;line 535;;  pfhline 0 4 1 on

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
.L094 ;;line 536;;  pfhline 30 4 31 on

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
.L095 ;;line 537;;  pfhline 0 5 1 on

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
.L096 ;;line 538;;  pfhline 30 5 31 on

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
.L097 ;;line 539;;  pfhline 0 6 1 on

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
.L098 ;;line 540;;  pfhline 30 6 31 on

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
.L099 ;;line 541;;  pfhline 0 7 1 on

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
.L0100 ;;line 542;;  pfhline 30 7 31 on

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
.L0101 ;;line 543;;  pfhline 0 8 13 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #13
	STA DF0WRITE
	LDY #8
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0102 ;;line 544;;  pfhline 19 8 31 on

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
	LDA #19
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0103 ;;line 545;;  pfhline 0 9 13 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #13
	STA DF0WRITE
	LDY #9
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0104 ;;line 546;;  pfhline 19 9 31 on

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
	LDA #19
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0105 ;;line 547;;  pfhline 0 10 13 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #13
	STA DF0WRITE
	LDY #10
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0106 ;;line 548;;  pfhline 19 10 31 on

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
	LDA #19
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0107 ;;line 549;;  pfhline 0 11 13 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #13
	STA DF0WRITE
	LDY #11
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0108 ;;line 550;;  pfhline 19 11 31 on

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
.L0109 ;;line 551;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 552;; 

.LoadRoom1
 ;;line 553;; LoadRoom1

.L0110 ;;line 554;;  pfhline 0 0 5 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #5
	STA DF0WRITE
	LDY #0
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0111 ;;line 555;;  pfhline 10 0 21 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #21
	STA DF0WRITE
	LDY #0
	STY DF0WRITE
	LDA #10
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0112 ;;line 556;;  pfhline 26 0 31 on

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
	LDA #26
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0113 ;;line 557;;  pfhline 0 1 0 on

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
.L0114 ;;line 558;;  pfhline 15 1 16 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #16
	STA DF0WRITE
	LDY #1
	STY DF0WRITE
	LDA #15
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0115 ;;line 559;;  pfhline 31 1 31 on

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
.L0116 ;;line 560;;  pfhline 0 2 0 on

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
.L0117 ;;line 561;;  pfhline 15 2 16 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #16
	STA DF0WRITE
	LDY #2
	STY DF0WRITE
	LDA #15
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0118 ;;line 562;;  pfhline 31 2 31 on

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
.L0119 ;;line 563;;  pfhline 0 3 0 on

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
.L0120 ;;line 564;;  pfhline 15 3 16 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #16
	STA DF0WRITE
	LDY #3
	STY DF0WRITE
	LDA #15
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0121 ;;line 565;;  pfhline 31 3 31 on

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
.L0122 ;;line 566;;  pfhline 0 4 0 on

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
.L0123 ;;line 567;;  pfhline 15 4 16 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #16
	STA DF0WRITE
	LDY #4
	STY DF0WRITE
	LDA #15
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0124 ;;line 568;;  pfhline 31 4 31 on

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
.L0125 ;;line 569;;  pfhline 0 5 0 on

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
.L0126 ;;line 570;;  pfhline 15 5 16 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #16
	STA DF0WRITE
	LDY #5
	STY DF0WRITE
	LDA #15
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0127 ;;line 571;;  pfhline 31 5 31 on

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
.L0128 ;;line 572;;  pfhline 0 6 0 on

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
.L0129 ;;line 573;;  pfhline 15 6 16 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #16
	STA DF0WRITE
	LDY #6
	STY DF0WRITE
	LDA #15
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0130 ;;line 574;;  pfhline 31 6 31 on

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
.L0131 ;;line 575;;  pfhline 0 7 0 on

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
.L0132 ;;line 576;;  pfhline 15 7 16 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #16
	STA DF0WRITE
	LDY #7
	STY DF0WRITE
	LDA #15
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0133 ;;line 577;;  pfhline 31 7 31 on

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
.L0134 ;;line 578;;  pfhline 0 8 0 on

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
.L0135 ;;line 579;;  pfhline 15 8 16 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #16
	STA DF0WRITE
	LDY #8
	STY DF0WRITE
	LDA #15
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0136 ;;line 580;;  pfhline 31 8 31 on

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
.L0137 ;;line 581;;  pfhline 0 9 0 on

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
.L0138 ;;line 582;;  pfhline 15 9 16 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #16
	STA DF0WRITE
	LDY #9
	STY DF0WRITE
	LDA #15
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0139 ;;line 583;;  pfhline 31 9 31 on

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
.L0140 ;;line 584;;  pfhline 0 10 0 on

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
.L0141 ;;line 585;;  pfhline 15 10 16 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #16
	STA DF0WRITE
	LDY #10
	STY DF0WRITE
	LDA #15
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0142 ;;line 586;;  pfhline 31 10 31 on

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
.L0143 ;;line 587;;  pfhline 0 11 31 on

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
.L0144 ;;line 588;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 589;; 

.return
 ;;line 590;; return

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
playerL058_0
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
backgroundcolorL059
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
playfieldcolorL060
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
 
 
 
