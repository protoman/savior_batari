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

.L01 ;;line 13;;  goto start bank2

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
 ;;line 14;; 

.L02 ;;line 15;;  bank 2

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
 ;;line 16;; start

.
 ;;line 17;; 

.
 ;;line 18;; 

.L03 ;;line 19;;  playfield:

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
 ;;line 33;; 

.L04 ;;line 34;;  player0:

	LDX #<playerL04_0
	STX player0pointerlo
	LDA #((>playerL04_0) & $0f) | (((>playerL04_0) / 2) & $70)
	STA player0pointerhi
	LDA #11
	STA player0height
.
 ;;line 47;; 

.L05 ;;line 48;;  player1:

	lda #<(playerpointers+0)
	sta DF0LOW
	lda #(>(playerpointers+0)) & $0F
	sta DF0HI
	LDX #<playerL05_1
	STX DF0WRITE
	LDA #((>playerL05_1) & $0f) | (((>playerL05_1) / 2) & $70)
	STA DF0WRITE
	LDA #11
	STA player1height
.
 ;;line 61;; 

.
 ;;line 62;; 

.L06 ;;line 63;;  a = 72  :  b = 40  :  c = 100

	LDA #72
	STA a
	LDA #40
	STA b
	LDA #100
	STA c
.L07 ;;line 64;;  d = 0  :  e = 1  :  f = 0

	LDA #0
	STA d
	LDA #1
	STA e
	LDA #0
	STA f
.L08 ;;line 65;;  g = 6  :  h = 0  :  i = 0

	LDA #6
	STA g
	LDA #0
	STA h
	STA i
.L09 ;;line 66;;  j = 120  :  k =  - 1  :  m = 4

	LDA #120
	STA j
	LDA #255
	STA k
	LDA #4
	STA m
.L010 ;;line 67;;  n = 0  :  o = 0

	LDA #0
	STA n
	STA o
.
 ;;line 68;; 

.
 ;;line 69;; 

.L011 ;;line 70;;  gosub LoadRoom

 jsr .LoadRoom

.
 ;;line 71;; 

.L012 ;;line 72;;  player0x = 80

	LDA #80
	STA player0x
.L013 ;;line 73;;  player0y = 30

	LDA #30
	STA player0y
.
 ;;line 74;; 

.main
 ;;line 75;; main

.
 ;;line 76;; 

.L014 ;;line 77;;  DF0FRACINC = 16

	LDA #16
	STA DF0FRACINC
.L015 ;;line 78;;  DF1FRACINC = 16

	LDA #16
	STA DF1FRACINC
.L016 ;;line 79;;  DF2FRACINC = 16

	LDA #16
	STA DF2FRACINC
.L017 ;;line 80;;  DF3FRACINC = 32

	LDA #32
	STA DF3FRACINC
.
 ;;line 81;; 

.
 ;;line 82;; 

.L018 ;;line 83;;  if f = 1 then if collision(missile0,player1) then j = 0  :  f = 0

	LDA f
	CMP #1
     BNE .skipL018
.condpart0
	bit 	CXM0P
	BPL .skip0then
.condpart1
	LDA #0
	STA j
	STA f
.skip0then
.skipL018
.
 ;;line 84;; 

.
 ;;line 85;; 

.L019 ;;line 86;;  if collision(player0,player1) then gosub PlayerHit

	bit 	CXPPMM
	BPL .skipL019
.condpart2
 jsr .PlayerHit

.skipL019
.
 ;;line 87;; 

.
 ;;line 88;; 

.L020 ;;line 89;;  a = player0x

	LDA player0x
	STA a
.L021 ;;line 90;;  b = player0y

	LDA player0y
	STA b
.L022 ;;line 91;;  d = 0

	LDA #0
	STA d
.
 ;;line 92;; 

.
 ;;line 93;; 

.L023 ;;line 94;;  if joy0left then player0x = player0x  -  1  :  d = 1  :  e = 0

 bit SWCHA
	BVS .skipL023
.condpart3
	DEC player0x
	LDA #1
	STA d
	LDA #0
	STA e
.skipL023
.L024 ;;line 95;;  if joy0right then player0x = player0x  +  1  :  d = 1  :  e = 1

 bit SWCHA
	BMI .skipL024
.condpart4
	INC player0x
	LDA #1
	STA d
	STA e
.skipL024
.
 ;;line 96;; 

.
 ;;line 97;; 

.L025 ;;line 98;;  if collision(player0,playfield) then player0x = a

	bit 	CXP0FB
	BPL .skipL025
.condpart5
	LDA a
	STA player0x
.skipL025
.
 ;;line 99;; 

.
 ;;line 100;; 

.L026 ;;line 101;;  if joy0up then player0y = player0y  -  1  :  d = 1  :  n = 0

 lda #$10
 bit SWCHA
	BNE .skipL026
.condpart6
	DEC player0y
	LDA #1
	STA d
	LDA #0
	STA n
.skipL026
.
 ;;line 102;; 

.
 ;;line 103;; 

.L027 ;;line 104;;  if !joy0up then n = n  +  1

 lda #$10
 bit SWCHA
	BEQ .skipL027
.condpart7
	INC n
.skipL027
.L028 ;;line 105;;  if !joy0up then if n  >=  4 then player0y = player0y  +  1  :  n = 0

 lda #$10
 bit SWCHA
	BEQ .skipL028
.condpart8
	LDA n
	CMP #4
     BCC .skip8then
.condpart9
	INC player0y
	LDA #0
	STA n
.skip8then
.skipL028
.
 ;;line 106;; 

.
 ;;line 107;; 

.L029 ;;line 108;;  if collision(player0,playfield) then player0y = b

	bit 	CXP0FB
	BPL .skipL029
.condpart10
	LDA b
	STA player0y
.skipL029
.
 ;;line 109;; 

.
 ;;line 110;; 

.
 ;;line 111;; 

.L030 ;;line 112;;  if player0x  >  150 then if o  <  2 then o = o  +  1  :  gosub LoadRoom  :  player0x = 18

	LDA #150
	CMP player0x
     BCS .skipL030
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
.skipL030
.
 ;;line 113;; 

.L031 ;;line 114;;  if player0x  <  18 then if o  >  0 then o = o  -  1  :  gosub LoadRoom  :  player0x = 148

	LDA player0x
	CMP #18
     BCS .skipL031
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
.skipL031
.
 ;;line 115;; 

.
 ;;line 116;; 

.L032 ;;line 117;;  if player0x  <  18 then player0x = 18

	LDA player0x
	CMP #18
     BCS .skipL032
.condpart15
	LDA #18
	STA player0x
.skipL032
.L033 ;;line 118;;  if player0x  >  148 then player0x = 148

	LDA #148
	CMP player0x
     BCS .skipL033
.condpart16
	LDA #148
	STA player0x
.skipL033
.L034 ;;line 119;;  if player0y  <  10 then player0y = 10

	LDA player0y
	CMP #10
     BCS .skipL034
.condpart17
	LDA #10
	STA player0y
.skipL034
.L035 ;;line 120;;  if player0y  >  80 then player0y = 80

	LDA #80
	CMP player0y
     BCS .skipL035
.condpart18
	LDA #80
	STA player0y
.skipL035
.
 ;;line 121;; 

.
 ;;line 122;; 

.L036 ;;line 123;;  if joy0fire then if f = 0 then f = 1  :  missile0x = player0x  +  3  :  missile0y = player0y  +  2

 bit INPT4
	BMI .skipL036
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
.skipL036
.L037 ;;line 124;;  if f = 1 then if e = 1 then missile0x = missile0x  +  3

	LDA f
	CMP #1
     BNE .skipL037
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
.skipL037
.L038 ;;line 125;;  if f = 1 then if e = 0 then missile0x = missile0x  -  3

	LDA f
	CMP #1
     BNE .skipL038
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
.skipL038
.L039 ;;line 126;;  if f = 1 then if missile0x  <  1 then f = 0

	LDA f
	CMP #1
     BNE .skipL039
.condpart25
	LDA missile0x
	CMP #1
     BCS .skip25then
.condpart26
	LDA #0
	STA f
.skip25then
.skipL039
.L040 ;;line 127;;  if f = 1 then if missile0x  >  150 then f = 0

	LDA f
	CMP #1
     BNE .skipL040
.condpart27
	LDA #150
	CMP missile0x
     BCS .skip27then
.condpart28
	LDA #0
	STA f
.skip27then
.skipL040
.L041 ;;line 128;;  if f = 1 then if collision(missile0,playfield) then f = 0

	LDA f
	CMP #1
     BNE .skipL041
.condpart29
	bit 	CXM0FB
	BPL .skip29then
.condpart30
	LDA #0
	STA f
.skip29then
.skipL041
.L042 ;;line 129;;  if !joy0fire then f = 0

 bit INPT4
	BPL .skipL042
.condpart31
	LDA #0
	STA f
.skipL042
.
 ;;line 130;; 

.
 ;;line 131;; 

.L043 ;;line 132;;  if joy0down then if i = 0 then if g  >  0 then i = 1  :  h = 30  :  g = g  -  1

 lda #$20
 bit SWCHA
	BNE .skipL043
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
.skipL043
.L044 ;;line 133;;  if i = 1 then h = h  -  1

	LDA i
	CMP #1
     BNE .skipL044
.condpart35
	DEC h
.skipL044
.L045 ;;line 134;;  if h  <=  0 then i = 0

	LDA #0
	CMP h
     BCC .skipL045
.condpart36
	LDA #0
	STA i
.skipL045
.
 ;;line 135;; 

.
 ;;line 136;; 

.L046 ;;line 137;;  if j  >  0 then j = j  +  k

	LDA #0
	CMP j
     BCS .skipL046
.condpart37
	LDA j
	CLC
	ADC k
	STA j
.skipL046
.L047 ;;line 138;;  if j  <  40 then k = 1

	LDA j
	CMP #40
     BCS .skipL047
.condpart38
	LDA #1
	STA k
.skipL047
.L048 ;;line 139;;  if j  >  120 then k =  - 1

	LDA #120
	CMP j
     BCS .skipL048
.condpart39
	LDA #255
	STA k
.skipL048
.L049 ;;line 140;;  if j  >  0 then player1x = j

	LDA #0
	CMP j
     BCS .skipL049
.condpart40
	LDA j
	STA player1x
.skipL049
.L050 ;;line 141;;  if j  >  0 then player1y = 50

	LDA #0
	CMP j
     BCS .skipL050
.condpart41
	LDA #50
	STA player1y
.skipL050
.
 ;;line 142;; 

.
 ;;line 143;; 

.L051 ;;line 144;;  if d = 1 then c = c  -  1

	LDA d
	CMP #1
     BNE .skipL051
.condpart42
	DEC c
.skipL051
.L052 ;;line 145;;  if c  <=  0 then gosub GameOver

	LDA #0
	CMP c
     BCC .skipL052
.condpart43
 jsr .GameOver

.skipL052
.
 ;;line 146;; 

.
 ;;line 147;; 

.L053 ;;line 148;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L054 ;;line 149;;  COLUPF = $28

	LDA #$28
	STA COLUPF
.L055 ;;line 150;;  COLUP0 = $C6

	LDA #$C6
	STA COLUP0
.L056 ;;line 151;;  COLUP1 = $1C

	LDA #$1C
	STA COLUP1
.
 ;;line 152;; 

.L057 ;;line 153;;  drawscreen

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
.L058 ;;line 154;;  goto main

 jmp .main

.
 ;;line 155;; 

.PlayerHit
 ;;line 156;; PlayerHit

.L059 ;;line 157;;  COLUBK = $34

	LDA #$34
	STA COLUBK
.L060 ;;line 158;;  m = m  -  1

	DEC m
.L061 ;;line 159;;  player0x = 80

	LDA #80
	STA player0x
.L062 ;;line 160;;  player0y = 30

	LDA #30
	STA player0y
.L063 ;;line 161;;  j = 0

	LDA #0
	STA j
.L064 ;;line 162;;  COLUBK = $02

	LDA #$02
	STA COLUBK
.L065 ;;line 163;;  if m  <=  0 then gosub GameOver

	LDA #0
	CMP m
     BCC .skipL065
.condpart44
 jsr .GameOver

.skipL065
.L066 ;;line 164;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 165;; 

.GameOver
 ;;line 166;; GameOver

.L067 ;;line 167;;  c = 100

	LDA #100
	STA c
.L068 ;;line 168;;  g = 6

	LDA #6
	STA g
.L069 ;;line 169;;  m = 4

	LDA #4
	STA m
.L070 ;;line 170;;  o = 0

	LDA #0
	STA o
.L071 ;;line 171;;  player0x = 80

	LDA #80
	STA player0x
.L072 ;;line 172;;  player0y = 30

	LDA #30
	STA player0y
.L073 ;;line 173;;  gosub LoadRoom

 jsr .LoadRoom

.L074 ;;line 174;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 175;; 

.LoadRoom
 ;;line 176;; LoadRoom

.L075 ;;line 177;;  pfclear

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
 ;;line 178;; 

.LoadRoom0
 ;;line 179;; LoadRoom0

.L076 ;;line 180;;  pfhline 0 0 31 on

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
.L077 ;;line 181;;  pfhline 0 1 1 on

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
.L078 ;;line 182;;  pfhline 6 1 7 on

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
.L079 ;;line 183;;  pfhline 22 1 23 on

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
.L080 ;;line 184;;  pfhline 30 1 31 on

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
.L081 ;;line 185;;  pfhline 0 2 1 on

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
.L082 ;;line 186;;  pfhline 6 2 7 on

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
.L083 ;;line 187;;  pfhline 22 2 23 on

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
.L084 ;;line 188;;  pfhline 30 2 31 on

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
.L085 ;;line 189;;  pfhline 0 3 1 on

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
.L086 ;;line 190;;  pfhline 30 3 31 on

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
.L087 ;;line 191;;  pfhline 0 4 7 on

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
.L088 ;;line 192;;  pfhline 30 4 31 on

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
.L089 ;;line 193;;  pfhline 0 5 1 on

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
.L090 ;;line 194;;  pfhline 30 5 31 on

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
.L091 ;;line 195;;  pfhline 0 6 1 on

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
.L092 ;;line 196;;  pfhline 30 6 31 on

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
.L093 ;;line 197;;  pfhline 0 7 7 on

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
.L094 ;;line 198;;  pfhline 30 7 31 on

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
.L095 ;;line 199;;  pfhline 0 8 1 on

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
.L096 ;;line 200;;  pfhline 20 8 31 on

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
.L097 ;;line 201;;  pfhline 0 9 1 on

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
.L098 ;;line 202;;  pfhline 30 9 31 on

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
.L099 ;;line 203;;  pfhline 0 10 1 on

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
.L0100 ;;line 204;;  pfhline 30 10 31 on

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
.L0101 ;;line 205;;  pfhline 0 11 11 on

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
.L0102 ;;line 206;;  pfhline 20 11 31 on

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
.L0103 ;;line 207;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 208;; 

.LoadRoom1
 ;;line 209;; LoadRoom1

.L0104 ;;line 210;;  pfhline 0 0 11 on

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
.L0105 ;;line 211;;  pfhline 20 0 31 on

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
.L0106 ;;line 212;;  pfhline 0 1 1 on

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
.L0107 ;;line 213;;  pfhline 30 1 31 on

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
.L0108 ;;line 214;;  pfhline 0 2 1 on

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
.L0109 ;;line 215;;  pfhline 30 2 31 on

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
.L0110 ;;line 216;;  pfhline 0 3 1 on

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
.L0111 ;;line 217;;  pfhline 30 3 31 on

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
.L0112 ;;line 218;;  pfhline 0 4 1 on

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
.L0113 ;;line 219;;  pfhline 30 4 31 on

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
.L0114 ;;line 220;;  pfhline 0 5 1 on

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
.L0115 ;;line 221;;  pfhline 30 5 31 on

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
.L0116 ;;line 222;;  pfhline 0 6 1 on

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
.L0117 ;;line 223;;  pfhline 30 6 31 on

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
.L0118 ;;line 224;;  pfhline 0 7 1 on

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
.L0119 ;;line 225;;  pfhline 30 7 31 on

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
.L0120 ;;line 226;;  pfhline 0 8 1 on

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
.L0121 ;;line 227;;  pfhline 30 8 31 on

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
.L0122 ;;line 228;;  pfhline 0 9 1 on

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
.L0123 ;;line 229;;  pfhline 30 9 31 on

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
.L0124 ;;line 230;;  pfhline 0 10 1 on

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
.L0125 ;;line 231;;  pfhline 30 10 31 on

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
.L0126 ;;line 232;;  pfhline 0 11 31 on

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
.L0127 ;;line 233;;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ;;line 234;; 

.L0128 ;;line 235;;  return

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
playerL04_0
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
playerL05_1
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
 
 
 
