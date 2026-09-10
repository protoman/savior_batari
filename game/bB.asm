game
.
 ;;line 1;; 

.
 ;;line 2;; 

.
 ;;line 3;; 

.L00 ;;line 4;;  set kernel DPC + 

.
 ;;line 5;; 

.L01 ;;line 6;;  goto start bank2

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
 ;;line 7;; 

.L02 ;;line 8;;  bank 2

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
 ;;line 9;; start

.
 ;;line 10;; 

.L03 ;;line 11;;  playfield:

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
 ;;line 25;; 

.L04 ;;line 26;;  pfcolors:

	LDA #<PFCOLS
	STA DF0LOW
	LDA #(>PFCOLS) & $0F
	STA DF0HI
	LDA #<playfieldcolorL04
	STA PARAMETER
	LDA #((>playfieldcolorL04) & $0f) | (((>playfieldcolorL04) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #1
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ;;line 29;; 

.L05 ;;line 30;;  scorecolors:

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
 ;;line 40;; 

.player0:
 ;;line 41;; player0:

.%00111100
 ;;line 42;; %00111100

.%01111110
 ;;line 43;; %01111110

.%01111110
 ;;line 44;; %01111110

.%00111100
 ;;line 45;; %00111100

.%00100100
 ;;line 46;; %00100100

.%00100100
 ;;line 47;; %00100100

.%01111110
 ;;line 48;; %01111110

.%00111100
 ;;line 49;; %00111100

.%00111100
 ;;line 50;; %00111100

.%00111100
 ;;line 51;; %00111100

.%00011000
 ;;line 52;; %00011000

.
 ;;line 54;; 

.L06 ;;line 55;;  player1:

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
 ;;line 68;; 

.
 ;;line 69;; 

.L07 ;;line 70;;  a = 72  :  b = 40  :  c = 100

	LDA #72
	STA a
	LDA #40
	STA b
	LDA #100
	STA c
.L08 ;;line 71;;  d = 0  :  e = 1  :  f = 0

	LDA #0
	STA d
	LDA #1
	STA e
	LDA #0
	STA f
.L09 ;;line 72;;  g = 6  :  h = 0  :  i = 0

	LDA #6
	STA g
	LDA #0
	STA h
	STA i
.L010 ;;line 73;;  j = 120  :  k =  - 1  :  m = 4

	LDA #120
	STA j
	LDA #255
	STA k
	LDA #4
	STA m
.L011 ;;line 74;;  n = 0  :  o = 0

	LDA #0
	STA n
	STA o
.L012 ;;line 75;;  score = 123456

	LDA #$56
	STA score+2
	LDA #$34
	STA score+1
	LDA #$12
	STA score
.
 ;;line 76;; 

.
 ;;line 77;; 

.L013 ;;line 78;;  gosub LoadRoom

 jsr .LoadRoom

.
 ;;line 79;; 

.L014 ;;line 80;;  player0x = 80

	LDA #80
	STA player0x
.L015 ;;line 81;;  player0y = 30

	LDA #30
	STA player0y
.
 ;;line 82;; 

.main
 ;;line 83;; main

.
 ;;line 84;; 

.L016 ;;line 85;;  DF0FRACINC = 20

	LDA #20
	STA DF0FRACINC
.L017 ;;line 86;;  DF1FRACINC = 20

	LDA #20
	STA DF1FRACINC
.L018 ;;line 87;;  DF2FRACINC = 20

	LDA #20
	STA DF2FRACINC
.L019 ;;line 88;;  DF3FRACINC = 20

	LDA #20
	STA DF3FRACINC
.
 ;;line 89;; 

.
 ;;line 90;; 

.L020 ;;line 91;;  if f = 1 then if collision(missile0,player1) then j = 0  :  f = 0

	LDA f
	CMP #1
     BNE .skipL020
.condpart0
	bit 	CXM0P
	BPL .skip0then
.condpart1
	LDA #0
	STA j
	STA f
.skip0then
.skipL020
.
 ;;line 92;; 

.
 ;;line 93;; 

.L021 ;;line 94;;  if collision(player0,player1) then gosub PlayerHit

	bit 	CXPPMM
	BPL .skipL021
.condpart2
 jsr .PlayerHit

.skipL021
.
 ;;line 95;; 

.
 ;;line 96;; 

.L022 ;;line 97;;  a = player0x

	LDA player0x
	STA a
.L023 ;;line 98;;  b = player0y

	LDA player0y
	STA b
.L024 ;;line 99;;  d = 0

	LDA #0
	STA d
.
 ;;line 100;; 

.
 ;;line 101;; 

.L025 ;;line 102;;  if joy0left then player0x = player0x  -  1  :  d = 1  :  e = 0

 bit SWCHA
	BVS .skipL025
.condpart3
	DEC player0x
	LDA #1
	STA d
	LDA #0
	STA e
.skipL025
.L026 ;;line 103;;  if joy0right then player0x = player0x  +  1  :  d = 1  :  e = 1

 bit SWCHA
	BMI .skipL026
.condpart4
	INC player0x
	LDA #1
	STA d
	STA e
.skipL026
.
 ;;line 104;; 

.
 ;;line 105;; 

.L027 ;;line 106;;  if collision(player0,playfield) then player0x = a

	bit 	CXP0FB
	BPL .skipL027
.condpart5
	LDA a
	STA player0x
.skipL027
.
 ;;line 107;; 

.
 ;;line 108;; 

.L028 ;;line 109;;  if joy0up then player0y = player0y  -  1  :  d = 1  :  n = 0

 lda #$10
 bit SWCHA
	BNE .skipL028
.condpart6
	DEC player0y
	LDA #1
	STA d
	LDA #0
	STA n
.skipL028
.
 ;;line 110;; 

.
 ;;line 111;; 

.L029 ;;line 112;;  if !joy0up then n = n  +  1

 lda #$10
 bit SWCHA
	BEQ .skipL029
.condpart7
	INC n
.skipL029
.L030 ;;line 113;;  if !joy0up then if n  >=  4 then player0y = player0y  +  1  :  n = 0

 lda #$10
 bit SWCHA
	BEQ .skipL030
.condpart8
	LDA n
	CMP #4
     BCC .skip8then
.condpart9
	INC player0y
	LDA #0
	STA n
.skip8then
.skipL030
.
 ;;line 114;; 

.
 ;;line 115;; 

.L031 ;;line 116;;  if collision(player0,playfield) then player0y = b

	bit 	CXP0FB
	BPL .skipL031
.condpart10
	LDA b
	STA player0y
.skipL031
.
 ;;line 117;; 

.
 ;;line 118;; 

.
 ;;line 119;; 

.L032 ;;line 120;;  if player0x  >  150 then if o  <  2 then o = o  +  1  :  gosub LoadRoom  :  player0x = 18

	LDA #150
	CMP player0x
     BCS .skipL032
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
.skipL032
.
 ;;line 121;; 

.L033 ;;line 122;;  if player0x  <  18 then if o  >  0 then o = o  -  1  :  gosub LoadRoom  :  player0x = 148

	LDA player0x
	CMP #18
     BCS .skipL033
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
.skipL033
.
 ;;line 123;; 

.
 ;;line 124;; 

.L034 ;;line 125;;  if player0x  <  18 then player0x = 18

	LDA player0x
	CMP #18
     BCS .skipL034
.condpart15
	LDA #18
	STA player0x
.skipL034
.L035 ;;line 126;;  if player0x  >  148 then player0x = 148

	LDA #148
	CMP player0x
     BCS .skipL035
.condpart16
	LDA #148
	STA player0x
.skipL035
.L036 ;;line 127;;  if player0y  <  10 then player0y = 10

	LDA player0y
	CMP #10
     BCS .skipL036
.condpart17
	LDA #10
	STA player0y
.skipL036
.L037 ;;line 128;;  if player0y  >  80 then player0y = 80

	LDA #80
	CMP player0y
     BCS .skipL037
.condpart18
	LDA #80
	STA player0y
.skipL037
.
 ;;line 129;; 

.
 ;;line 130;; 

.L038 ;;line 131;;  if joy0fire then if f = 0 then f = 1  :  missile0x = player0x  +  3  :  missile0y = player0y  +  2

 bit INPT4
	BMI .skipL038
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
.skipL038
.L039 ;;line 132;;  if f = 1 then if e = 1 then missile0x = missile0x  +  3

	LDA f
	CMP #1
     BNE .skipL039
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
.skipL039
.L040 ;;line 133;;  if f = 1 then if e = 0 then missile0x = missile0x  -  3

	LDA f
	CMP #1
     BNE .skipL040
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
.skipL040
.L041 ;;line 134;;  if f = 1 then if missile0x  <  1 then f = 0

	LDA f
	CMP #1
     BNE .skipL041
.condpart25
	LDA missile0x
	CMP #1
     BCS .skip25then
.condpart26
	LDA #0
	STA f
.skip25then
.skipL041
.L042 ;;line 135;;  if f = 1 then if missile0x  >  150 then f = 0

	LDA f
	CMP #1
     BNE .skipL042
.condpart27
	LDA #150
	CMP missile0x
     BCS .skip27then
.condpart28
	LDA #0
	STA f
.skip27then
.skipL042
.L043 ;;line 136;;  if f = 1 then if collision(missile0,playfield) then f = 0

	LDA f
	CMP #1
     BNE .skipL043
.condpart29
	bit 	CXM0FB
	BPL .skip29then
.condpart30
	LDA #0
	STA f
.skip29then
.skipL043
.L044 ;;line 137;;  if !joy0fire then f = 0

 bit INPT4
	BPL .skipL044
.condpart31
	LDA #0
	STA f
.skipL044
.
 ;;line 138;; 

.
 ;;line 139;; 

.L045 ;;line 140;;  if joy0down then if i = 0 then if g  >  0 then i = 1  :  h = 30  :  g = g  -  1

 lda #$20
 bit SWCHA
	BNE .skipL045
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
.skipL045
.L046 ;;line 141;;  if i = 1 then h = h  -  1

	LDA i
	CMP #1
     BNE .skipL046
.condpart35
	DEC h
.skipL046
.L047 ;;line 142;;  if h  <=  0 then i = 0

	LDA #0
	CMP h
     BCC .skipL047
.condpart36
	LDA #0
	STA i
.skipL047
.
 ;;line 143;; 

.
 ;;line 144;; 

.L048 ;;line 145;;  if j  >  0 then j = j  +  k

	LDA #0
	CMP j
     BCS .skipL048
.condpart37
	LDA j
	CLC
	ADC k
	STA j
.skipL048
.L049 ;;line 146;;  if j  <  40 then k = 1

	LDA j
	CMP #40
     BCS .skipL049
.condpart38
	LDA #1
	STA k
.skipL049
.L050 ;;line 147;;  if j  >  120 then k =  - 1

	LDA #120
	CMP j
     BCS .skipL050
.condpart39
	LDA #255
	STA k
.skipL050
.L051 ;;line 148;;  if j  >  0 then player1x = j

	LDA #0
	CMP j
     BCS .skipL051
.condpart40
	LDA j
	STA player1x
.skipL051
.L052 ;;line 149;;  if j  >  0 then player1y = 50

	LDA #0
	CMP j
     BCS .skipL052
.condpart41
	LDA #50
	STA player1y
.skipL052
.
 ;;line 150;; 

.
 ;;line 151;; 

.L053 ;;line 152;;  if d = 1 then c = c  -  1

	LDA d
	CMP #1
     BNE .skipL053
.condpart42
	DEC c
.skipL053
.L054 ;;line 153;;  if c  <=  0 then gosub GameOver

	LDA #0
	CMP c
     BCC .skipL054
.condpart43
 jsr .GameOver

.skipL054
.
 ;;line 154;; 

.
 ;;line 155;; 

.L055 ;;line 156;;  COLUPF = $28

	LDA #$28
	STA COLUPF
.L056 ;;line 157;;  COLUP0 = $C6

	LDA #$C6
	STA COLUP0
.L057 ;;line 158;;  COLUP1 = $1C

	LDA #$1C
	STA COLUP1
.L058 ;;line 159;;  scorecolor = $0E

	LDA #$0E
	STA scorecolor
.L059 ;;line 160;;  DF6FRACINC = 255

	LDA #255
	STA DF6FRACINC
.L060 ;;line 161;;  bkcolors:

	LDA #<BKCOLS
	STA DF0LOW
	LDA #(>BKCOLS) & $0F
	STA DF0HI
	LDA #<backgroundcolorL060
	STA PARAMETER
	LDA #((>backgroundcolorL060) & $0f) | (((>backgroundcolorL060) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #80
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ;;line 243;; 

.L061 ;;line 244;;  drawscreen

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
.L062 ;;line 245;;  goto main

 jmp .main

.
 ;;line 246;; 

.PlayerHit
 ;;line 247;; PlayerHit

.L063 ;;line 248;;  COLUBK = $34

	LDA #$34
	STA COLUBK
.L064 ;;line 249;;  m = m  -  1

	DEC m
.L065 ;;line 250;;  player0x = 80

	LDA #80
	STA player0x
.L066 ;;line 251;;  player0y = 30

	LDA #30
	STA player0y
.L067 ;;line 252;;  j = 0

	LDA #0
	STA j
.L068 ;;line 253;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L069 ;;line 254;;  if m  <=  0 then gosub GameOver

	LDA #0
	CMP m
     BCC .skipL069
.condpart44
 jsr .GameOver

.skipL069
.L070 ;;line 255;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 256;; 

.GameOver
 ;;line 257;; GameOver

.L071 ;;line 258;;  c = 100

	LDA #100
	STA c
.L072 ;;line 259;;  g = 6

	LDA #6
	STA g
.L073 ;;line 260;;  m = 4

	LDA #4
	STA m
.L074 ;;line 261;;  o = 0

	LDA #0
	STA o
.L075 ;;line 262;;  player0x = 80

	LDA #80
	STA player0x
.L076 ;;line 263;;  player0y = 30

	LDA #30
	STA player0y
.L077 ;;line 264;;  gosub LoadRoom

 jsr .LoadRoom

.L078 ;;line 265;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 266;; 

.LoadRoom
 ;;line 267;; LoadRoom

.L079 ;;line 268;;  pfclear

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
 ;;line 269;; 

.LoadRoom0
 ;;line 270;; LoadRoom0

.L080 ;;line 271;;  pfhline 0 0 31 on

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
.L081 ;;line 272;;  pfhline 0 1 0 on

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
.L082 ;;line 273;;  pfhline 31 1 31 on

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
.L083 ;;line 274;;  pfhline 0 2 0 on

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
.L084 ;;line 275;;  pfhline 31 2 31 on

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
.L085 ;;line 276;;  pfhline 0 3 0 on

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
.L086 ;;line 277;;  pfhline 31 3 31 on

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
.L087 ;;line 278;;  pfhline 0 4 0 on

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
.L088 ;;line 279;;  pfhline 31 4 31 on

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
.L089 ;;line 280;;  pfhline 0 5 0 on

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
.L090 ;;line 281;;  pfhline 31 5 31 on

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
.L091 ;;line 282;;  pfhline 0 6 0 on

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
.L092 ;;line 283;;  pfhline 31 6 31 on

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
.L093 ;;line 284;;  pfhline 0 7 3 on

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
.L094 ;;line 285;;  pfhline 28 7 31 on

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
.L095 ;;line 286;;  pfhline 0 8 0 on

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
.L096 ;;line 287;;  pfhline 10 8 21 on

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
.L097 ;;line 288;;  pfhline 31 8 31 on

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
.L098 ;;line 289;;  pfhline 0 9 0 on

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
.L099 ;;line 290;;  pfhline 31 9 31 on

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
.L0100 ;;line 291;;  pfhline 0 10 0 on

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
.L0101 ;;line 292;;  pfhline 31 10 31 on

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
.L0102 ;;line 293;;  pfhline 0 11 5 on

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
.L0103 ;;line 294;;  pfhline 10 11 21 on

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
.L0104 ;;line 295;;  pfhline 26 11 31 on

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
.L0105 ;;line 296;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 297;; 

.LoadRoom1
 ;;line 298;; LoadRoom1

.L0106 ;;line 299;;  pfhline 0 0 5 on

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
.L0107 ;;line 300;;  pfhline 10 0 21 on

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
.L0108 ;;line 301;;  pfhline 26 0 31 on

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
.L0109 ;;line 302;;  pfhline 0 1 0 on

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
.L0110 ;;line 303;;  pfhline 15 1 16 on

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
.L0111 ;;line 304;;  pfhline 31 1 31 on

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
.L0112 ;;line 305;;  pfhline 0 2 0 on

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
.L0113 ;;line 306;;  pfhline 15 2 16 on

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
.L0114 ;;line 307;;  pfhline 31 2 31 on

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
.L0115 ;;line 308;;  pfhline 0 3 0 on

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
.L0116 ;;line 309;;  pfhline 15 3 16 on

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
.L0117 ;;line 310;;  pfhline 31 3 31 on

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
.L0118 ;;line 311;;  pfhline 0 4 0 on

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
.L0119 ;;line 312;;  pfhline 15 4 16 on

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
.L0120 ;;line 313;;  pfhline 31 4 31 on

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
.L0121 ;;line 314;;  pfhline 0 5 0 on

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
.L0122 ;;line 315;;  pfhline 15 5 16 on

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
.L0123 ;;line 316;;  pfhline 31 5 31 on

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
.L0124 ;;line 317;;  pfhline 0 6 0 on

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
.L0125 ;;line 318;;  pfhline 15 6 16 on

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
.L0126 ;;line 319;;  pfhline 31 6 31 on

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
.L0127 ;;line 320;;  pfhline 0 7 0 on

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
.L0128 ;;line 321;;  pfhline 15 7 16 on

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
.L0129 ;;line 322;;  pfhline 31 7 31 on

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
.L0130 ;;line 323;;  pfhline 0 8 0 on

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
.L0131 ;;line 324;;  pfhline 15 8 16 on

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
.L0132 ;;line 325;;  pfhline 31 8 31 on

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
.L0133 ;;line 326;;  pfhline 0 9 0 on

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
.L0134 ;;line 327;;  pfhline 15 9 16 on

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
.L0135 ;;line 328;;  pfhline 31 9 31 on

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
.L0136 ;;line 329;;  pfhline 0 10 0 on

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
.L0137 ;;line 330;;  pfhline 15 10 16 on

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
.L0138 ;;line 331;;  pfhline 31 10 31 on

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
.L0139 ;;line 332;;  pfhline 0 11 31 on

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
.L0140 ;;line 333;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 334;; 

.L0141 ;;line 335;;  return

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
playfieldcolorL04
	.byte  $28
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
backgroundcolorL060
	.byte  $44
	.byte  $44
	.byte  $44
	.byte  $44
	.byte  $44
	.byte  $44
	.byte  $44
	.byte  $44
	.byte  $44
	.byte  $44
	.byte  $46
	.byte  $46
	.byte  $46
	.byte  $46
	.byte  $46
	.byte  $46
	.byte  $46
	.byte  $46
	.byte  $46
	.byte  $46
	.byte  $48
	.byte  $48
	.byte  $48
	.byte  $48
	.byte  $48
	.byte  $48
	.byte  $48
	.byte  $48
	.byte  $48
	.byte  $48
	.byte  $84
	.byte  $84
	.byte  $84
	.byte  $84
	.byte  $84
	.byte  $84
	.byte  $84
	.byte  $84
	.byte  $84
	.byte  $84
	.byte  $C4
	.byte  $C4
	.byte  $C4
	.byte  $C4
	.byte  $C4
	.byte  $C4
	.byte  $C4
	.byte  $C4
	.byte  $C4
	.byte  $C4
	.byte  $24
	.byte  $24
	.byte  $24
	.byte  $24
	.byte  $24
	.byte  $24
	.byte  $24
	.byte  $24
	.byte  $24
	.byte  $24
	.byte  $14
	.byte  $14
	.byte  $14
	.byte  $14
	.byte  $14
	.byte  $14
	.byte  $14
	.byte  $14
	.byte  $14
	.byte  $14
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
 
 
 
