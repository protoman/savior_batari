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

.L021 ;;line 92;;  rem if f = 1 then if collision(missile0, player1) then j = 0 : f = 0

.
 ;;line 93;; 

.
 ;;line 94;; 

.L022 ;;line 95;;  rem if collision(player0, player1) then gosub PlayerHit

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
.
 ;;line 100;; 

.
 ;;line 101;; 

.L025 ;;line 102;;  if joy0left then player0x = player0x  -  1  :  e = 0

 bit SWCHA
	BVS .skipL025
.condpart0
	DEC player0x
	LDA #0
	STA e
.skipL025
.L026 ;;line 103;;  if joy0right then player0x = player0x  +  1  :  e = 1

 bit SWCHA
	BMI .skipL026
.condpart1
	INC player0x
	LDA #1
	STA e
.skipL026
.
 ;;line 104;; 

.
 ;;line 105;; 

.L027 ;;line 106;;  if player0x  <  a then if pfread ( player0x  /  4 ,  player0y  /  20 )  then player0x = a

	LDA player0x
	CMP a
     BCS .skipL027
.condpart2
	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
    lda #24
    sta DF0WRITE
	LDA player0x
	STA DF0WRITE
	LDY #4
	STY DF0WRITE
	lda #255
	sta CALLFUNCTION
    LDA DF0DATA
	BNE .skip2then
.condpart3
