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

.L05 ;;line 27;;  pfcolors:

	LDA #<PFCOLS
	STA DF0LOW
	LDA #(>PFCOLS) & $0F
	STA DF0HI
	LDA #<playfieldcolorL05
	STA PARAMETER
	LDA #((>playfieldcolorL05) & $0f) | (((>playfieldcolorL05) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #1
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ;;line 30;; 

.L06 ;;line 31;;  scorecolors:

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
 ;;line 41;; 

.player0:
 ;;line 42;; player0:

.%00111100
 ;;line 43;; %00111100

.%01111110
 ;;line 44;; %01111110

.%01111110
 ;;line 45;; %01111110

.%00111100
 ;;line 46;; %00111100

.%00100100
 ;;line 47;; %00100100

.%00100100
 ;;line 48;; %00100100

.%01111110
 ;;line 49;; %01111110

.%00111100
 ;;line 50;; %00111100

.%00111100
 ;;line 51;; %00111100

.%00111100
 ;;line 52;; %00111100

.%00011000
 ;;line 53;; %00011000

.
 ;;line 55;; 

.L07 ;;line 56;;  player1:

	lda #<(playerpointers+0)
	sta DF0LOW
	lda #(>(playerpointers+0)) & $0F
	sta DF0HI
	LDX #<playerL07_1
	STX DF0WRITE
	LDA #((>playerL07_1) & $0f) | (((>playerL07_1) / 2) & $70)
	STA DF0WRITE
	LDA #11
	STA player1height
.
 ;;line 69;; 

.
 ;;line 70;; 

.L08 ;;line 71;;  a = 72  :  b = 40  :  c = 100

	LDA #72
	STA a
	LDA #40
	STA b
	LDA #100
	STA c
.L09 ;;line 72;;  d = 0  :  e = 1  :  f = 0

	LDA #0
	STA d
	LDA #1
	STA e
	LDA #0
	STA f
.L010 ;;line 73;;  g = 6  :  h = 0  :  i = 0

	LDA #6
	STA g
	LDA #0
	STA h
	STA i
.L011 ;;line 74;;  j = 120  :  k =  - 1  :  m = 4

	LDA #120
	STA j
	LDA #255
	STA k
	LDA #4
	STA m
.L012 ;;line 75;;  n = 0  :  o = 0

	LDA #0
	STA n
	STA o
.L013 ;;line 76;;  score = 123456

	LDA #$56
	STA score+2
	LDA #$34
	STA score+1
	LDA #$12
	STA score
.
 ;;line 77;; 

.
 ;;line 78;; 

.L014 ;;line 79;;  gosub LoadRoom

 jsr .LoadRoom

.
 ;;line 80;; 

.L015 ;;line 81;;  player0x = 80

	LDA #80
	STA player0x
.L016 ;;line 82;;  player0y = 30

	LDA #30
	STA player0y
.
 ;;line 83;; 

.main
 ;;line 84;; main

.
 ;;line 85;; 

.L017 ;;line 86;;  DF0FRACINC = 20

	LDA #20
	STA DF0FRACINC
.L018 ;;line 87;;  DF1FRACINC = 20

	LDA #20
	STA DF1FRACINC
.L019 ;;line 88;;  DF2FRACINC = 20

	LDA #20
	STA DF2FRACINC
.L020 ;;line 89;;  DF3FRACINC = 20

	LDA #20
	STA DF3FRACINC
.
 ;;line 90;; 

.
 ;;line 91;; 

.L021 ;;line 92;;  if f = 1 then if collision(missile0,player1) then j = 0  :  f = 0

	LDA f
	CMP #1
     BNE .skipL021
.condpart0
	bit 	CXM0P
	BPL .skip0then
.condpart1
	LDA #0
	STA j
	STA f
.skip0then
.skipL021
.
 ;;line 93;; 

.
 ;;line 94;; 

.L022 ;;line 95;;  if collision(player0,player1) then gosub PlayerHit

	bit 	CXPPMM
	BPL .skipL022
.condpart2
 jsr .PlayerHit

.skipL022
.
 ;;line 96;; 

.
 ;;line 97;; 

.L023 ;;line 98;;  a = player0x

	LDA player0x
	STA a
.L024 ;;line 99;;  b = player0y

	LDA player0y
	STA b
.L025 ;;line 100;;  d = 0

	LDA #0
	STA d
.
 ;;line 101;; 

.
 ;;line 102;; 

.L026 ;;line 103;;  if joy0left then player0x = player0x  -  1  :  d = 1  :  e = 0

 bit SWCHA
	BVS .skipL026
.condpart3
	DEC player0x
	LDA #1
	STA d
	LDA #0
	STA e
.skipL026
.L027 ;;line 104;;  if joy0right then player0x = player0x  +  1  :  d = 1  :  e = 1

 bit SWCHA
	BMI .skipL027
.condpart4
	INC player0x
	LDA #1
	STA d
	STA e
.skipL027
.
 ;;line 105;; 

.
 ;;line 106;; 

.L028 ;;line 107;;  if collision(playfield,player0) then player0x = a

	bit 	CXP0FB
	BPL .skipL028
.condpart5
	LDA a
	STA player0x
.skipL028
.
 ;;line 108;; 

.
 ;;line 109;; 

.L029 ;;line 110;;  if joy0up then player0y = player0y  -  1  :  d = 1  :  n = 0

 lda #$10
 bit SWCHA
	BNE .skipL029
.condpart6
	DEC player0y
	LDA #1
	STA d
	LDA #0
	STA n
.skipL029
.
 ;;line 111;; 

.
 ;;line 112;; 

.L030 ;;line 113;;  if !joy0up then n = n  +  1

 lda #$10
 bit SWCHA
	BEQ .skipL030
.condpart7
	INC n
.skipL030
.L031 ;;line 114;;  if !joy0up then if n  >=  4 then player0y = player0y  +  1  :  n = 0

 lda #$10
 bit SWCHA
	BEQ .skipL031
.condpart8
	LDA n
	CMP #4
     BCC .skip8then
.condpart9
	INC player0y
	LDA #0
	STA n
.skip8then
.skipL031
.
 ;;line 115;; 

.
 ;;line 116;; 

.L032 ;;line 117;;  if collision(playfield,player0) then player0y = b

	bit 	CXP0FB
	BPL .skipL032
.condpart10
	LDA b
	STA player0y
.skipL032
.
 ;;line 118;; 

.
 ;;line 119;; 

.
 ;;line 120;; 

.L033 ;;line 121;;  if player0x  >  150 then if o  <  2 then o = o  +  1  :  gosub LoadRoom  :  player0x = 18

	LDA #150
	CMP player0x
     BCS .skipL033
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
.skipL033
.
 ;;line 122;; 

.L034 ;;line 123;;  if player0x  <  18 then if o  >  0 then o = o  -  1  :  gosub LoadRoom  :  player0x = 148

	LDA player0x
	CMP #18
     BCS .skipL034
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
.skipL034
.
 ;;line 124;; 

.
 ;;line 125;; 

.L035 ;;line 126;;  if player0x  <  18 then player0x = 18

	LDA player0x
	CMP #18
     BCS .skipL035
.condpart15
	LDA #18
	STA player0x
.skipL035
.L036 ;;line 127;;  if player0x  >  148 then player0x = 148

	LDA #148
	CMP player0x
     BCS .skipL036
.condpart16
	LDA #148
	STA player0x
.skipL036
.L037 ;;line 128;;  if player0y  <  10 then player0y = 10

	LDA player0y
	CMP #10
     BCS .skipL037
.condpart17
	LDA #10
	STA player0y
.skipL037
.L038 ;;line 129;;  if player0y  >  80 then player0y = 80

	LDA #80
	CMP player0y
     BCS .skipL038
.condpart18
	LDA #80
	STA player0y
.skipL038
.
 ;;line 130;; 

.
 ;;line 131;; 

.L039 ;;line 132;;  if joy0fire then if f = 0 then f = 1  :  missile0x = player0x  +  3  :  missile0y = player0y  +  2

 bit INPT4
	BMI .skipL039
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
.skipL039
.L040 ;;line 133;;  if f = 1 then if e = 1 then missile0x = missile0x  +  3

	LDA f
	CMP #1
     BNE .skipL040
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
.skipL040
.L041 ;;line 134;;  if f = 1 then if e = 0 then missile0x = missile0x  -  3

	LDA f
	CMP #1
     BNE .skipL041
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
.skipL041
.L042 ;;line 135;;  if f = 1 then if missile0x  <  1 then f = 0

	LDA f
	CMP #1
     BNE .skipL042
.condpart25
	LDA missile0x
	CMP #1
     BCS .skip25then
.condpart26
	LDA #0
	STA f
.skip25then
.skipL042
.L043 ;;line 136;;  if f = 1 then if missile0x  >  150 then f = 0

	LDA f
	CMP #1
     BNE .skipL043
.condpart27
	LDA #150
	CMP missile0x
     BCS .skip27then
.condpart28
	LDA #0
	STA f
.skip27then
.skipL043
.L044 ;;line 137;;  if f = 1 then if collision(missile0,playfield) then f = 0

	LDA f
	CMP #1
     BNE .skipL044
.condpart29
	bit 	CXM0FB
	BPL .skip29then
.condpart30
	LDA #0
	STA f
.skip29then
.skipL044
.L045 ;;line 138;;  if !joy0fire then f = 0

 bit INPT4
	BPL .skipL045
.condpart31
	LDA #0
	STA f
.skipL045
.
 ;;line 139;; 

.
 ;;line 140;; 

.L046 ;;line 141;;  if joy0down then if i = 0 then if g  >  0 then i = 1  :  h = 30  :  g = g  -  1

 lda #$20
 bit SWCHA
	BNE .skipL046
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
.skipL046
.L047 ;;line 142;;  if i = 1 then h = h  -  1

	LDA i
	CMP #1
     BNE .skipL047
.condpart35
	DEC h
.skipL047
.L048 ;;line 143;;  if h  <=  0 then i = 0

	LDA #0
	CMP h
     BCC .skipL048
.condpart36
	LDA #0
	STA i
.skipL048
.
 ;;line 144;; 

.
 ;;line 145;; 

.L049 ;;line 146;;  if j  >  0 then j = j  +  k

	LDA #0
	CMP j
     BCS .skipL049
.condpart37
	LDA j
	CLC
	ADC k
	STA j
.skipL049
.L050 ;;line 147;;  if j  <  40 then k = 1

	LDA j
	CMP #40
     BCS .skipL050
.condpart38
	LDA #1
	STA k
.skipL050
.L051 ;;line 148;;  if j  >  120 then k =  - 1

	LDA #120
	CMP j
     BCS .skipL051
.condpart39
	LDA #255
	STA k
.skipL051
.L052 ;;line 149;;  if j  >  0 then player1x = j

	LDA #0
	CMP j
     BCS .skipL052
.condpart40
	LDA j
	STA player1x
.skipL052
.L053 ;;line 150;;  if j  >  0 then player1y = 50

	LDA #0
	CMP j
     BCS .skipL053
.condpart41
	LDA #50
	STA player1y
.skipL053
.
 ;;line 151;; 

.
 ;;line 152;; 

.L054 ;;line 153;;  if d = 1 then c = c  -  1

	LDA d
	CMP #1
     BNE .skipL054
.condpart42
	DEC c
.skipL054
.L055 ;;line 154;;  if c  <=  0 then gosub GameOver

	LDA #0
	CMP c
     BCC .skipL055
.condpart43
 jsr .GameOver

.skipL055
.
 ;;line 155;; 

.
 ;;line 156;; 

.L056 ;;line 157;;  COLUPF = $28

	LDA #$28
	STA COLUPF
.L057 ;;line 158;;  COLUP0 = $0E

	LDA #$0E
	STA COLUP0
.L058 ;;line 159;;  COLUP1 = $1C

	LDA #$1C
	STA COLUP1
.L059 ;;line 160;;  scorecolor = $0E

	LDA #$0E
	STA scorecolor
.L060 ;;line 161;;  DF6FRACINC = 255

	LDA #255
	STA DF6FRACINC
.L061 ;;line 162;;  player0:

	LDX #<playerL061_0
	STX player0pointerlo
	LDA #((>playerL061_0) & $0f) | (((>playerL061_0) / 2) & $70)
	STA player0pointerhi
	LDA #11
	STA player0height
.L062 ;;line 175;;  bkcolors:

	LDA #<BKCOLS
	STA DF0LOW
	LDA #(>BKCOLS) & $0F
	STA DF0HI
	LDA #<backgroundcolorL062
	STA PARAMETER
	LDA #((>backgroundcolorL062) & $0f) | (((>backgroundcolorL062) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #146
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ;;line 323;; 

.L063 ;;line 324;;  drawscreen

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
.L064 ;;line 325;;  goto main

 jmp .main

.
 ;;line 326;; 

.PlayerHit
 ;;line 327;; PlayerHit

.L065 ;;line 328;;  COLUBK = $34

	LDA #$34
	STA COLUBK
.L066 ;;line 329;;  m = m  -  1

	DEC m
.L067 ;;line 330;;  player0x = 80

	LDA #80
	STA player0x
.L068 ;;line 331;;  player0y = 30

	LDA #30
	STA player0y
.L069 ;;line 332;;  j = 0

	LDA #0
	STA j
.L070 ;;line 333;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L071 ;;line 334;;  if m  <=  0 then gosub GameOver

	LDA #0
	CMP m
     BCC .skipL071
.condpart44
 jsr .GameOver

.skipL071
.L072 ;;line 335;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 336;; 

.GameOver
 ;;line 337;; GameOver

.L073 ;;line 338;;  c = 100

	LDA #100
	STA c
.L074 ;;line 339;;  g = 6

	LDA #6
	STA g
.L075 ;;line 340;;  m = 4

	LDA #4
	STA m
.L076 ;;line 341;;  o = 0

	LDA #0
	STA o
.L077 ;;line 342;;  player0x = 80

	LDA #80
	STA player0x
.L078 ;;line 343;;  player0y = 30

	LDA #30
	STA player0y
.L079 ;;line 344;;  gosub LoadRoom

 jsr .LoadRoom

.L080 ;;line 345;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 346;; 

.LoadRoom
 ;;line 347;; LoadRoom

.L081 ;;line 348;;  pfclear

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
 ;;line 349;; 

.LoadRoom0
 ;;line 350;; LoadRoom0

.L082 ;;line 351;;  pfhline 0 0 31 on

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
.L083 ;;line 352;;  pfhline 0 1 0 on

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
.L084 ;;line 353;;  pfhline 31 1 31 on

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
.L085 ;;line 354;;  pfhline 0 2 0 on

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
.L086 ;;line 355;;  pfhline 31 2 31 on

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
.L087 ;;line 356;;  pfhline 0 3 0 on

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
.L088 ;;line 357;;  pfhline 31 3 31 on

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
.L089 ;;line 358;;  pfhline 0 4 0 on

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
.L090 ;;line 359;;  pfhline 31 4 31 on

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
.L091 ;;line 360;;  pfhline 0 5 0 on

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
.L092 ;;line 361;;  pfhline 31 5 31 on

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
.L093 ;;line 362;;  pfhline 0 6 0 on

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
.L094 ;;line 363;;  pfhline 31 6 31 on

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
.L095 ;;line 364;;  pfhline 0 7 3 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #3
	STA DF0WRITE
	LDY #7
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L096 ;;line 365;;  pfhline 28 7 31 on

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
	LDA #28
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L097 ;;line 366;;  pfhline 0 8 0 on

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
.L098 ;;line 367;;  pfhline 10 8 21 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #21
	STA DF0WRITE
	LDY #8
	STY DF0WRITE
	LDA #10
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L099 ;;line 368;;  pfhline 31 8 31 on

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
.L0100 ;;line 369;;  pfhline 0 9 0 on

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
.L0101 ;;line 370;;  pfhline 31 9 31 on

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
.L0102 ;;line 371;;  pfhline 0 10 0 on

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
.L0103 ;;line 372;;  pfhline 31 10 31 on

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
.L0104 ;;line 373;;  pfhline 0 11 5 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #5
	STA DF0WRITE
	LDY #11
	STY DF0WRITE
	LDA #0
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0105 ;;line 374;;  pfhline 10 11 21 on

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #8
	STX DF0WRITE
	LDA #21
	STA DF0WRITE
	LDY #11
	STY DF0WRITE
	LDA #10
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0106 ;;line 375;;  pfhline 26 11 31 on

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
	LDA #26
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0107 ;;line 376;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 377;; 

.LoadRoom1
 ;;line 378;; LoadRoom1

.L0108 ;;line 379;;  pfhline 0 0 5 on

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
.L0109 ;;line 380;;  pfhline 10 0 21 on

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
.L0110 ;;line 381;;  pfhline 26 0 31 on

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
.L0111 ;;line 382;;  pfhline 0 1 0 on

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
.L0112 ;;line 383;;  pfhline 15 1 16 on

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
.L0113 ;;line 384;;  pfhline 31 1 31 on

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
.L0114 ;;line 385;;  pfhline 0 2 0 on

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
.L0115 ;;line 386;;  pfhline 15 2 16 on

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
.L0116 ;;line 387;;  pfhline 31 2 31 on

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
.L0117 ;;line 388;;  pfhline 0 3 0 on

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
.L0118 ;;line 389;;  pfhline 15 3 16 on

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
.L0119 ;;line 390;;  pfhline 31 3 31 on

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
.L0120 ;;line 391;;  pfhline 0 4 0 on

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
.L0121 ;;line 392;;  pfhline 15 4 16 on

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
.L0122 ;;line 393;;  pfhline 31 4 31 on

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
.L0123 ;;line 394;;  pfhline 0 5 0 on

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
.L0124 ;;line 395;;  pfhline 15 5 16 on

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
.L0125 ;;line 396;;  pfhline 31 5 31 on

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
.L0126 ;;line 397;;  pfhline 0 6 0 on

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
.L0127 ;;line 398;;  pfhline 15 6 16 on

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
.L0128 ;;line 399;;  pfhline 31 6 31 on

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
.L0129 ;;line 400;;  pfhline 0 7 0 on

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
.L0130 ;;line 401;;  pfhline 15 7 16 on

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
.L0131 ;;line 402;;  pfhline 31 7 31 on

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
.L0132 ;;line 403;;  pfhline 0 8 0 on

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
.L0133 ;;line 404;;  pfhline 15 8 16 on

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
.L0134 ;;line 405;;  pfhline 31 8 31 on

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
.L0135 ;;line 406;;  pfhline 0 9 0 on

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
.L0136 ;;line 407;;  pfhline 15 9 16 on

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
.L0137 ;;line 408;;  pfhline 31 9 31 on

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
.L0138 ;;line 409;;  pfhline 0 10 0 on

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
.L0139 ;;line 410;;  pfhline 15 10 16 on

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
.L0140 ;;line 411;;  pfhline 31 10 31 on

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
.L0141 ;;line 412;;  pfhline 0 11 31 on

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
.L0142 ;;line 413;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 414;; 

.L0143 ;;line 415;;  return

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
playfieldcolorL05
	.byte  $28
playerL07_1
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
playerL061_0
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
backgroundcolorL062
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
	.byte  $04
 if ECHOFIRST
       echo "    ",[(DPC_graphics_end - *)]d , "bytes of ROM space left in graphics bank")
 endif 
ECHOFIRST = 1
 
 
 
