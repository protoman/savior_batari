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

.%00011000
 ;;line 43;; %00011000

.%00111100
 ;;line 44;; %00111100

.%00111100
 ;;line 45;; %00111100

.%00111100
 ;;line 46;; %00111100

.%00100100
 ;;line 47;; %00100100

.%00100100
 ;;line 48;; %00100100

.%00111100
 ;;line 49;; %00111100

.%00111100
 ;;line 50;; %00111100

.%00111100
 ;;line 51;; %00111100

.%00011000
 ;;line 52;; %00011000

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
.L011 ;;line 74;;  j = 0  :  k =  - 1  :  m = 4

	LDA #0
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

.L021 ;;line 92;;  p = 0

	LDA #0
	STA p
.L022 ;;line 93;;  d = 0

	LDA #0
	STA d
.
 ;;line 94;; 

.
 ;;line 95;; 

.L023 ;;line 96;;  if joy0left then player0x = player0x  -  1  :  p = 255  :  e = 0

 bit SWCHA
	BVS .skipL023
.condpart0
	DEC player0x
	LDA #255
	STA p
	LDA #0
	STA e
.skipL023
.L024 ;;line 97;;  if joy0right then player0x = player0x  +  1  :  p = 1  :  e = 1

 bit SWCHA
	BMI .skipL024
.condpart1
	INC player0x
	LDA #1
	STA p
	STA e
.skipL024
.
 ;;line 98;; 

.
 ;;line 99;; 

.L025 ;;line 100;;  if joy0up then if j = 0 then player0y = player0y  -  1  :  d = 255  :  n = 0

 lda #$10
 bit SWCHA
	BNE .skipL025
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
.skipL025
.
 ;;line 101;; 

.
 ;;line 102;; 

.L026 ;;line 103;;  if !joy0up then n = n  +  1

 lda #$10
 bit SWCHA
	BEQ .skipL026
.condpart4
	INC n
.skipL026
.L027 ;;line 104;;  if !joy0up then if n  >=  2 then player0y = player0y  +  1  :  d = 1  :  n = 0

 lda #$10
 bit SWCHA
	BEQ .skipL027
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
.skipL027
.
 ;;line 105;; 

.
 ;;line 106;; 

.
 ;;line 107;; 

.L028 ;;line 108;;  if player0x  >  150 then if o  <  2 then o = o  +  1  :  gosub LoadRoom  :  player0x = 18

	LDA #150
	CMP player0x
     BCS .skipL028
.condpart7
	LDA o
	CMP #2
     BCS .skip7then
.condpart8
	INC o
 jsr .LoadRoom
	LDA #18
	STA player0x
.skip7then
.skipL028
.
 ;;line 109;; 

.L029 ;;line 110;;  if player0x  <  18 then if o  >  0 then o = o  -  1  :  gosub LoadRoom  :  player0x = 148

	LDA player0x
	CMP #18
     BCS .skipL029
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
.skipL029
.
 ;;line 111;; 

.
 ;;line 112;; 

.L030 ;;line 113;;  if joy0fire then if f = 0 then f = 1  :  missile0x = player0x  +  3  :  missile0y = player0y  +  2

 bit INPT4
	BMI .skipL030
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
.skipL030
.L031 ;;line 114;;  if f = 1 then if e = 1 then missile0x = missile0x  +  3

	LDA f
	CMP #1
     BNE .skipL031
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
.skipL031
.L032 ;;line 115;;  if f = 1 then if e = 0 then missile0x = missile0x  -  3

	LDA f
	CMP #1
     BNE .skipL032
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
.skipL032
.L033 ;;line 116;;  if f = 1 then if missile0x  <  1 then f = 0

	LDA f
	CMP #1
     BNE .skipL033
.condpart17
	LDA missile0x
	CMP #1
     BCS .skip17then
.condpart18
	LDA #0
	STA f
.skip17then
.skipL033
.L034 ;;line 117;;  if f = 1 then if missile0x  >  150 then f = 0

	LDA f
	CMP #1
     BNE .skipL034
.condpart19
	LDA #150
	CMP missile0x
     BCS .skip19then
.condpart20
	LDA #0
	STA f
.skip19then
.skipL034
.L035 ;;line 118;;  if f = 1 then if collision(missile0,playfield) then f = 0

	LDA f
	CMP #1
     BNE .skipL035
.condpart21
	bit 	CXM0FB
	BPL .skip21then
.condpart22
	LDA #0
	STA f
.skip21then
.skipL035
.L036 ;;line 119;;  if !joy0fire then f = 0

 bit INPT4
	BPL .skipL036
.condpart23
	LDA #0
	STA f
.skipL036
.
 ;;line 120;; 

.
 ;;line 121;; 

.L037 ;;line 122;;  if joy0down then if i = 0 then if g  >  0 then i = 1  :  h = 30  :  g = g  -  1

 lda #$20
 bit SWCHA
	BNE .skipL037
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
.skipL037
.L038 ;;line 123;;  if i = 1 then h = h  -  1

	LDA i
	CMP #1
     BNE .skipL038
.condpart27
	DEC h
.skipL038
.L039 ;;line 124;;  if h  <=  0 then i = 0

	LDA #0
	CMP h
     BCC .skipL039
.condpart28
	LDA #0
	STA i
.skipL039
.
 ;;line 125;; 

.
 ;;line 126;; 

.L040 ;;line 127;;  COLUPF = $28

	LDA #$28
	STA COLUPF
.L041 ;;line 128;;  COLUP0 = $0E

	LDA #$0E
	STA COLUP0
.L042 ;;line 129;;  COLUP1 = $1C

	LDA #$1C
	STA COLUP1
.L043 ;;line 130;;  scorecolor = $0E

	LDA #$0E
	STA scorecolor
.L044 ;;line 131;;  DF6FRACINC = 255

	LDA #255
	STA DF6FRACINC
.L045 ;;line 132;;  player0:

	LDX #<playerL045_0
	STX player0pointerlo
	LDA #((>playerL045_0) & $0f) | (((>playerL045_0) / 2) & $70)
	STA player0pointerhi
	LDA #11
	STA player0height
.L046 ;;line 145;;  bkcolors:

	LDA #<BKCOLS
	STA DF0LOW
	LDA #(>BKCOLS) & $0F
	STA DF0HI
	LDA #<backgroundcolorL046
	STA PARAMETER
	LDA #((>backgroundcolorL046) & $0f) | (((>backgroundcolorL046) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #146
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ;;line 293;; 

.L047 ;;line 294;;  drawscreen

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
 ;;line 295;; 

.
 ;;line 296;; 

.L048 ;;line 297;;  if collision(player0,playfield) then player0x = player0x  -  p

	bit 	CXP0FB
	BPL .skipL048
.condpart29
	LDA player0x
	SEC
	SBC p
	STA player0x
.skipL048
.L049 ;;line 298;;  if collision(player0,playfield) then player0y = player0y  -  d

	bit 	CXP0FB
	BPL .skipL049
.condpart30
	LDA player0y
	SEC
	SBC d
	STA player0y
.skipL049
.
 ;;line 299;; 

.
 ;;line 300;; 

.L050 ;;line 301;;  j = 0

	LDA #0
	STA j
.L051 ;;line 302;;  if collision(player0,playfield) then j = 1

	bit 	CXP0FB
	BPL .skipL051
.condpart31
	LDA #1
	STA j
.skipL051
.
 ;;line 303;; 

.
 ;;line 304;; 

.L052 ;;line 305;;  if player0x  <  18 then player0x = 18

	LDA player0x
	CMP #18
     BCS .skipL052
.condpart32
	LDA #18
	STA player0x
.skipL052
.L053 ;;line 306;;  if player0x  >  148 then player0x = 148

	LDA #148
	CMP player0x
     BCS .skipL053
.condpart33
	LDA #148
	STA player0x
.skipL053
.L054 ;;line 307;;  if player0y  <  10 then player0y = 10

	LDA player0y
	CMP #10
     BCS .skipL054
.condpart34
	LDA #10
	STA player0y
.skipL054
.
 ;;line 308;; 

.L055 ;;line 309;;  goto main

 jmp .main

.
 ;;line 310;; 

.PlayerHit
 ;;line 311;; PlayerHit

.L056 ;;line 312;;  COLUBK = $34

	LDA #$34
	STA COLUBK
.L057 ;;line 313;;  m = m  -  1

	DEC m
.L058 ;;line 314;;  player0x = 80

	LDA #80
	STA player0x
.L059 ;;line 315;;  player0y = 30

	LDA #30
	STA player0y
.L060 ;;line 316;;  j = 0

	LDA #0
	STA j
.L061 ;;line 317;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L062 ;;line 318;;  if m  <=  0 then gosub GameOver

	LDA #0
	CMP m
     BCC .skipL062
.condpart35
 jsr .GameOver

.skipL062
.L063 ;;line 319;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 320;; 

.GameOver
 ;;line 321;; GameOver

.L064 ;;line 322;;  c = 100

	LDA #100
	STA c
.L065 ;;line 323;;  g = 6

	LDA #6
	STA g
.L066 ;;line 324;;  m = 4

	LDA #4
	STA m
.L067 ;;line 325;;  o = 0

	LDA #0
	STA o
.L068 ;;line 326;;  player0x = 80

	LDA #80
	STA player0x
.L069 ;;line 327;;  player0y = 30

	LDA #30
	STA player0y
.L070 ;;line 328;;  gosub LoadRoom

 jsr .LoadRoom

.L071 ;;line 329;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 330;; 

.LoadRoom
 ;;line 331;; LoadRoom

.L072 ;;line 332;;  pfclear

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
 ;;line 333;; LoadRoom0

.L073 ;;line 334;;  pfhline 0 0 12 on

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
.L074 ;;line 335;;  pfhline 19 0 31 on

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
.L075 ;;line 336;;  pfhline 0 1 0 on

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
.L076 ;;line 337;;  pfhline 31 1 31 on

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
.L077 ;;line 338;;  pfhline 0 2 0 on

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
.L078 ;;line 339;;  pfhline 31 2 31 on

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
.L079 ;;line 340;;  pfhline 0 3 0 on

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
.L080 ;;line 341;;  pfhline 31 3 31 on

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
.L081 ;;line 342;;  pfhline 0 4 0 on

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
.L082 ;;line 343;;  pfhline 31 4 31 on

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
.L083 ;;line 344;;  pfhline 0 5 0 on

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
.L084 ;;line 345;;  pfhline 31 5 31 on

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
.L085 ;;line 346;;  pfhline 0 6 0 on

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
.L086 ;;line 347;;  pfhline 31 6 31 on

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
.L087 ;;line 348;;  pfhline 0 7 3 on

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
.L088 ;;line 349;;  pfhline 28 7 31 on

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
.L089 ;;line 350;;  pfhline 0 8 0 on

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
.L090 ;;line 351;;  pfhline 10 8 21 on

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
.L091 ;;line 352;;  pfhline 31 8 31 on

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
.L092 ;;line 353;;  pfhline 0 9 0 on

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
.L093 ;;line 354;;  pfhline 31 9 31 on

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
.L094 ;;line 355;;  pfhline 0 10 0 on

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
.L095 ;;line 356;;  pfhline 31 10 31 on

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
.L096 ;;line 357;;  pfhline 0 11 5 on

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
.L097 ;;line 358;;  pfhline 10 11 21 on

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
.L098 ;;line 359;;  pfhline 26 11 31 on

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
.L099 ;;line 360;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 361;; 

.LoadRoom1
 ;;line 362;; LoadRoom1

.L0100 ;;line 363;;  pfhline 0 0 5 on

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
.L0101 ;;line 364;;  pfhline 10 0 21 on

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
.L0102 ;;line 365;;  pfhline 26 0 31 on

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
.L0103 ;;line 366;;  pfhline 0 1 0 on

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
.L0104 ;;line 367;;  pfhline 15 1 16 on

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
.L0105 ;;line 368;;  pfhline 31 1 31 on

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
.L0106 ;;line 369;;  pfhline 0 2 0 on

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
.L0107 ;;line 370;;  pfhline 15 2 16 on

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
.L0108 ;;line 371;;  pfhline 31 2 31 on

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
.L0109 ;;line 372;;  pfhline 0 3 0 on

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
.L0110 ;;line 373;;  pfhline 15 3 16 on

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
.L0111 ;;line 374;;  pfhline 31 3 31 on

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
.L0112 ;;line 375;;  pfhline 0 4 0 on

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
.L0113 ;;line 376;;  pfhline 15 4 16 on

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
.L0114 ;;line 377;;  pfhline 31 4 31 on

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
.L0115 ;;line 378;;  pfhline 0 5 0 on

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
.L0116 ;;line 379;;  pfhline 15 5 16 on

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
.L0117 ;;line 380;;  pfhline 31 5 31 on

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
.L0118 ;;line 381;;  pfhline 0 6 0 on

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
.L0119 ;;line 382;;  pfhline 15 6 16 on

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
.L0120 ;;line 383;;  pfhline 31 6 31 on

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
.L0121 ;;line 384;;  pfhline 0 7 0 on

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
.L0122 ;;line 385;;  pfhline 15 7 16 on

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
.L0123 ;;line 386;;  pfhline 31 7 31 on

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
.L0124 ;;line 387;;  pfhline 0 8 0 on

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
.L0125 ;;line 388;;  pfhline 15 8 16 on

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
.L0126 ;;line 389;;  pfhline 31 8 31 on

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
.L0127 ;;line 390;;  pfhline 0 9 0 on

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
.L0128 ;;line 391;;  pfhline 15 9 16 on

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
.L0129 ;;line 392;;  pfhline 31 9 31 on

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
.L0130 ;;line 393;;  pfhline 0 10 0 on

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
.L0131 ;;line 394;;  pfhline 15 10 16 on

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
.L0132 ;;line 395;;  pfhline 31 10 31 on

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
.L0133 ;;line 396;;  pfhline 0 11 31 on

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
.L0134 ;;line 397;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 398;; 

.return
 ;;line 399;; return

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
playerL045_0
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
backgroundcolorL046
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
 
 
 
