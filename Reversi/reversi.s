	.equ SWI_Exit, 0x11
	.equ SWI_OPEN, 0x66
	.equ SWI_printstr, 0x69
	.equ SWI_printint, 0x6b
	.equ SWI_CLOSE, 0x68
	.equ SWI_KEY_INPUT, 0x203
	.equ SWI_DISPLAY_CHAR, 0x207 
	.equ SWI_DISPLAY_INT, 0x205
	.equ SWI_DISPLAY_STRING, 0x204
	.equ SWI_CLEAR,0x206
	.equ SWI_CLEAR_LINE,0x208
	
.data
	END: .space 4
	BLACKMOVE: .space 4
	WHITEMOVE: .space 4
	COUNTR: .space 4
        COUNTC: .space 4
	BLACKMOVEVALID: .space 4
	WHITEMOVEVALID: .space 4
	BMC: .space 100
	WMC: .space 100
	BMR: .space 100
	WMR: .space 100
	BOARD: .space 256
	BOARDROW: .space 4
	BOARDCOL: .space 4
	ISVALIDARG: .space 4
	ISVALID: .space 4
	MOVES: .space 4
	INVALID: .asciz "Invalid move"
	

.text
		ldr r0,=END  @@@@Main is starting 
		mov r1,#0
		str r1,[r0]
		ldr r0,=BLACKMOVE
		mov r1,#1
		str r1,[r0]
		ldr r0,=WHITEMOVE
		mov r1,#1
		str r1,[r0]
		mov r2,#0 @r2=col of board
		mov r3,#0 @r3=row of board
		ldr r0,=BOARD @r0= address of board
		mov r1,#2
	g:	mov r2,#0
	f: 	add r4,r2,r3
		str r1,[r0,r4]
		add r2,r2,#4
		cmp r2,#28
		ble f
		add r3,r3,#32
		cmp r3,#224
		ble g
		
		mov r1,#0
		str r1,[r0,#108]
		str r1,[r0,#144]
		mov r1,#1
		str r1,[r0,#112]
		str r1,[r0,#140]
		
		
		@@@@@ Printboard here
		
	wh:	
		ldr r0,=BLACKMOVE
		mov r1,#1
		str r1,[r0]
		ldr r0,=WHITEMOVE
		str r1,[r0]
		ldr r0,=BLACKMOVEVALID
		mov r1,#0
		str r1,[r0]
		ldr r0,=WHITEMOVEVALID
		str r1,[r0]
		
		
		@@@@@#Black move
	g0:	
		@print the output here 
		bl prin
		ldr r1,=BMC
		swi SWI_KEY_INPUT
		str lr,[sp,#-4]!
		bl pow2
		ldr lr,[sp],#4
		str r0,[r1]
		ldr r1,=BMR
		swi SWI_KEY_INPUT
		str lr,[sp,#-4]!
		bl pow2
		ldr lr,[sp],#4
		str r0,[r1]
		ldr r0,=ISVALIDARG		@1 for black and 0 for white
		mov r1,#1
		str r1,[r0]
		bl isv
		ldr r0,=ISVALID			@After Valid
		ldr r0,[r0]
		cmp r0,#1
		bne g1
		ldr r2,=BMC
		ldr r2,[r2]
		ldr r3,=BMR
		ldr r3,[r3]
		mov r11,#4
		mul r10,r2,r11
		mov r2,r10
		mov r11,#32
		mul r10,r3,r11
		mov r3,r10
		add r1,r2,r3
		ldr r5,=BOARD
		mov r0,#1
		str r0,[r5,r1]
		ldr r4,=MOVES
		ldr r4,[r4]		@r4 = k=change_x.size
	g3:	cmp r4,#0
		beq g2
		ldr r3,[sp],#4
		ldr r2,[sp],#4
		add r1,r2,r3
		str r0,[r5,r1]
		sub r4,r4,#1
		b g3
	g2:	ldr r0,=BLACKMOVE
		mov r1,#0
		str r1,[r0]
		mov r0,#10
		swi SWI_CLEAR_LINE
		b g4
	g1: ldr r0,=BLACKMOVE
		mov r1,#1
		str r1,[r0]
		mov r0,#0
		mov r1,#10
		ldr r2,=INVALID
		swi SWI_DISPLAY_STRING
		b g4
	g4: ldr r0,=BLACKMOVE
		ldr r0,[r0]
		cmp r0,#1
		beq g0
		
		
		@@@@@#white move
	m0:	
		@print the output here 
		bl prin
		ldr r1,=BMC
		swi SWI_KEY_INPUT
		str lr,[sp,#-4]!
		bl pow2
		ldr lr,[sp],#4
		str r0,[r1]
		ldr r1,=BMR
		swi SWI_KEY_INPUT
		str lr,[sp,#-4]!
		bl pow2
		ldr lr,[sp],#4
		str r0,[r1]
		ldr r0,=ISVALIDARG		@1 for black and 0 for white
		mov r1,#0
		str r1,[r0]
		bl isv
		ldr r0,=ISVALID			@After Valid
		ldr r0,[r0]
		cmp r0,#1
		bne m1
		ldr r2,=BMC
		ldr r2,[r2]
		ldr r3,=BMR
		ldr r3,[r3]
		mov r11,#4
		mul r10,r2,r11
		mov r2,r10
		mov r11,#32
		mul r10,r3,r11
		mov r3,r10
		add r1,r2,r3
		ldr r5,=BOARD
		mov r0,#0 
		str r0,[r5,r1]
		ldr r4,=MOVES
		ldr r4,[r4]		@r4 = k=change_x.size
	m3:	cmp r4,#0
		beq m2
		ldr r3,[sp],#4
		ldr r2,[sp],#4
		add r1,r2,r3
		str r0,[r5,r1]
		sub r4,r4,#1
		b m3
	m2:	ldr r0,=WHITEMOVE
		mov r1,#0
		str r1,[r0]
		mov r0,#10
		swi SWI_CLEAR_LINE
		b m4
	m1: ldr r0,=WHITEMOVE
		mov r1,#1
		str r1,[r0]
		mov r0,#0
		mov r1,#10
		ldr r2,=INVALID
		swi SWI_DISPLAY_STRING
		b m4
	m4: ldr r0,=WHITEMOVE
		ldr r0,[r0]
		cmp r0,#1
		beq m0
		
		b wh 			@@for now making an infinite loop of while 
	
		
		
		
	isv:ldr r10,=ISVALID
		mov r6,#0
		str r6,[r10]
		ldr r0,=MOVES
		mov r1,#0
		str r1,[r0]
		ldr r0,=BMC	@
		ldr r0,[r0]
		ldr r1,=BMR
		ldr r1,[r1]
		mov r9,#0
		mov r11,#4
		mul r10,r0,r11	@r0 = col
		mov r0,r10
		mov r11,#32
		mul r10,r1,r11	@r1 = row 
		mov r1,r10
		mov r2,r0		@r2 = x_temp
		mov r3,r1		@r3 = y_temp
		ldr r5,=BOARD	@r5 = address of board
		add r8,r3,r2
		ldr r5,[r5,r8]
        cmp r5,#0
        beq rbout1
        cmp r5,#1
        beq rbout1		
		ldr r4,=ISVALIDARG
		ldr r4,[r4]
		cmp r4,#1
		bne e
		mov r4,#0		@r4 = counter
		b e0
	e:	mov r4,#1
		
		
	e0:	@above
		mov r6,#0		@r6 = maybe
		sub r3,r3,#32
		mov r7,#0		@r7 = validpart
		cmp r3,#-32
		beq  aout1
	w1: 
		ldr r5,=BOARD	@r5 = address of board
		add r8,r3,r2
		ldr r5,[r5,r8]
		mov r10, #2
                cmp r5, r10
                beq aouto
                mov r10, #3
                cmp r5, r10
                beq aouto
		cmp r5,r4		@comparing with counter
		bne e2
	e1:	mov r6,#1
		str r2,[sp,#-4]!
		str r3,[sp,#-4]!
		add r9,r9,#1
	e2: ldr r0,=ISVALIDARG
		ldr r0,[r0]
		cmp r5,r0			@comparing with z
		bne e3
		cmp r6,#1
		bne e4
		ldr r0,=ISVALID
		str r6,[r0]			@setting valid true
		mov r7,#1
	e4: b aouto
    e3: sub r3,r3,#32
        cmp r3, #-32
        bne w1
     aouto: cmp r7, #0
            bne aout1
     aw2: cmp r9, #0
            beq aout1
            ldr r0, [sp,#4]!    
	    ldr r0, [sp,#4]!
	    sub r9,r9,#1
            b aw2			@arguments remaining: check for initial y_temp!=0 and the first if statement 
			

           @below
     aout1:	ldr r0,=MOVES
				ldr r1,[r0]
				add r1,r9,r1
				str r1,[r0]
                ldr r0,=BMC	@
		ldr r0,[r0]
		ldr r1,=BMR
		ldr r1,[r1]
		mov r9,#0
		
		mov r11,#4
		mul r10,r0,r11	@r0 = col
		mov r0,r10
		mov r11,#32
		mul r10,r1,r11	@r1 = row 
		mov r1,r10
		mov r2,r0		@r2 = x_temp
		mov r3,r1		@r3 = y_temp
                mov r6,#0		@r6 = maybe
		add r3,r3,#32
		mov r7,#0		@r7 = validpart
		cmp r3,#256
		beq  bout1
	bw1: 
		ldr r5,=BOARD	@r5 = address of board
		add r8,r3,r2
		ldr r5,[r5,r8]
		mov r10, #2
                cmp r5, r10
                beq bouto
                mov r10, #3
                cmp r5, r10
                beq bouto
		cmp r5,r4
		bne be2
	be1:	mov r6,#1
		str r2,[sp,#-4]!
		str r3,[sp,#-4]!
		add r9,r9,#1
	be2: ldr r0,=ISVALIDARG
		ldr r0,[r0]
		cmp r5,r0
		bne be3
		cmp r6,#1
		bne be4
		ldr r0,=ISVALID
		str r6,[r0]
		mov r7,#1
	be4: b bouto
        be3: add r3,r3,#32
            cmp r3, #256
            bne bw1
     bouto: cmp r7, #0
            bne bout1
     bw2: cmp r9, #0
            beq bout1
            ldr r0, [sp,#4]!    
	    ldr r0, [sp,#4]!
	    sub r9,r9,#1
            b bw2
     bout1:
	 
			@left
			
		ldr r0,=MOVES
		ldr r1,[r0]
		add r1,r9,r1
		str r1,[r0]
        ldr r0,=BMC	@
		ldr r0,[r0]
		ldr r1,=BMR
		ldr r1,[r1]
		mov r9,#0
		
		mov r11,#4
		mul r10,r0,r11	@r0 = col
		mov r0,r10
		mov r11,#32
		mul r10,r1,r11	@r1 = row 
		mov r1,r10
		mov r2,r0		@r2 = x_temp
		mov r3,r1		@r3 = y_temp
                mov r6,#0		@r6 = maybe
		sub r2,r2,#4
		mov r7,#0		@r7 = validpart
		cmp r2,#-4							@should be 0 (no because inputs are from 0 to 7
		beq lout1
	lw1: 
		ldr r5,=BOARD	@r5 = address of board
		add r8,r3,r2
		ldr r5,[r5,r8]
			mov r10, #2
                cmp r5, r10
                beq louto
                mov r10, #3
                cmp r5, r10
                beq louto
		cmp r5,r4
		bne le2
	le1:	mov r6,#1
		str r2,[sp,#-4]!
		str r3,[sp,#-4]!
		add r9,r9,#1
	le2: ldr r0,=ISVALIDARG
		ldr r0,[r0]
		cmp r5,r0
		bne le3
		cmp r6,#1
		bne le4
		ldr r0,=ISVALID
		str r6,[r0]
		mov r7,#1
	le4: b louto
        le3: sub r2,r2,#4
            cmp r2, #-4
            bne lw1
     louto: cmp r7, #0
            bne lout1
     lw2: cmp r9, #0
            beq lout1
            ldr r0, [sp,#4]!    
	    ldr r0, [sp,#4]!
	    sub r9,r9,#1
            b lw2
     lout1:
	 
			@right
			ldr r0,=MOVES
				ldr r1,[r0]
				add r1,r9,r1
				str r1,[r0]
                ldr r0,=BMC	@
		ldr r0,[r0]
		ldr r1,=BMR
		ldr r1,[r1]
		mov r9,#0
		
		mov r11,#4
		mul r10,r0,r11	@r0 = col
		mov r0,r10
		mov r11,#32
		mul r10,r1,r11	@r1 = row 
		mov r1,r10
		mov r2,r0		@r2 = x_temp
		mov r3,r1		@r3 = y_temp
                mov r6,#0		@r6 = maybe
		add r2,r2,#4
		mov r7,#0		@r7 = validpart
		cmp r2,#32
		beq rout1
	rw1: 
		ldr r5,=BOARD	@r5 = address of board
		add r8,r3,r2
		ldr r5,[r5,r8]
		 mov r10, #2
                cmp r5, r10
                beq routo
                mov r10, #3
                cmp r5, r10
                beq routo
		cmp r5,r4
		bne re2
	re1:	mov r6,#1
		str r2,[sp,#-4]!
		str r3,[sp,#-4]!
		add r9,r9,#1
	re2: ldr r0,=ISVALIDARG
		ldr r0,[r0]
		cmp r5,r0
		bne re3
		cmp r6,#1
		bne re4
		ldr r0,=ISVALID
		str r6,[r0]
		mov r7,#1
	re4: b routo
        re3: add r2,r2,#4
            cmp r2, #32
            bne rw1
     routo: cmp r7, #0
            bne rout1
     rw2: cmp r9, #0
            beq rout1
            ldr r0, [sp,#4]!    
	    ldr r0, [sp,#4]!
	    sub r9,r9,#1
            b rw2
     rout1:
	 
		@left up diagonal
		ldr r0,=MOVES
				ldr r1,[r0]
				add r1,r9,r1
				str r1,[r0]
                ldr r0,=BMC	@
		ldr r0,[r0]
		ldr r1,=BMR
		ldr r1,[r1]
		mov r9,#0
		
		mov r11,#4
		mul r10,r0,r11	@r0 = col
		mov r0,r10
		mov r11,#32
		mul r10,r1,r11	@r1 = row 
		mov r1,r10
		mov r2,r0		@r2 = x_temp
		mov r3,r1		@r3 = y_temp
                mov r6,#0		@r6 = maybe
                sub r3,r3,#32
		sub r2,r2,#4
		mov r7,#0		@r7 = validpart
		cmp r2,#-4
		beq laout1
                cmp r3,#-32
                beq laout1
	law1: 
		ldr r5,=BOARD	@r5 = address of board
		add r8,r3,r2
		ldr r5,[r5,r8]
			mov r10, #2
                cmp r5, r10
                beq laouto
                mov r10, #3
                cmp r5, r10
                beq laouto
		cmp r5,r4
		bne lae2
	lae1:	mov r6,#1
		str r2,[sp,#-4]!
		str r3,[sp,#-4]!
		add r9,r9,#1
	lae2: ldr r0,=ISVALIDARG
		ldr r0,[r0]
		cmp r5,r0
		bne lae3
		cmp r6,#1
		bne lae4
		ldr r0,=ISVALID
		str r6,[r0]
		mov r7,#1
	lae4: b laouto
        lae3: sub r2,r2,#4
              sub r3,r3,#32
            cmp r2, #-4
            beq laouto
            cmp r3, #-32
			beq laouto
            b law1
     laouto: cmp r7, #0
            bne laout1
     law2: cmp r9, #0
            beq laout1
            ldr r0, [sp,#4]!    
	    ldr r0, [sp,#4]!
	    sub r9,r9,#1
            b law2
     
	 
	 
	 laout1:
		@right up diagonal
		ldr r0,=MOVES
				ldr r1,[r0]
				add r1,r9,r1
				str r1,[r0]
                ldr r0,=BMC	@
		ldr r0,[r0]
		ldr r1,=BMR
		ldr r1,[r1]
		mov r9,#0
		
		mov r11,#4
		mul r10,r0,r11	@r0 = col
		mov r0,r10
		mov r11,#32
		mul r10,r1,r11	@r1 = row 
		mov r1,r10
		mov r2,r0		@r2 = x_temp
		mov r3,r1		@r3 = y_temp
                mov r6,#0		@r6 = maybe
                sub r3,r3,#32
		add r2,r2,#4
		mov r7,#0		@r7 = validpart
		cmp r2,#32
		beq raout1
                cmp r3,#-32
                beq raout1
	raw1: 
		ldr r5,=BOARD	@r5 = address of board
		add r8,r3,r2
		ldr r5,[r5,r8]
		mov r10, #2
                cmp r5, r10
                beq raouto
                mov r10, #3
                cmp r5, r10
                beq raouto
		cmp r5,r4
		bne rae2
	rae1:	mov r6,#1
		str r2,[sp,#-4]!
		str r3,[sp,#-4]!
		add r9,r9,#1
	rae2: ldr r0,=ISVALIDARG
		ldr r0,[r0]
		cmp r5,r0
		bne rae3
		cmp r6,#1
		bne rae4
		ldr r0,=ISVALID
		str r6,[r0]
		mov r7,#1
	rae4: b raouto
        rae3: add r2,r2,#4
              sub r3,r3,#32
            cmp r2, #32
            beq raouto
            cmp r3, #-32
            beq raouto
			b raw1
     raouto: cmp r7, #0
            bne raout1
     raw2: cmp r9, #0
            beq raout1
            ldr r0, [sp,#4]!    
	    ldr r0, [sp,#4]!
	    sub r9,r9,#1
            b raw2
     raout1:
	 
	 
	 
		@left down diagonal
		ldr r0,=MOVES
				ldr r1,[r0]
				add r1,r9,r1
				str r1,[r0]
                ldr r0,=BMC	@
		ldr r0,[r0]
		ldr r1,=BMR
		ldr r1,[r1]
		mov r9,#0
		
		mov r11,#4
		mul r10,r0,r11	@r0 = col
		mov r0,r10
		mov r11,#32
		mul r10,r1,r11	@r1 = row 
		mov r1,r10
		mov r2,r0		@r2 = x_temp
		mov r3,r1		@r3 = y_temp
                mov r6,#0		@r6 = maybe
                add r3,r3,#32
		sub r2,r2,#4
		mov r7,#0		@r7 = validpart
		cmp r2,#-4
		beq lbout1
                cmp r3,#256
                beq lbout1
	lbw1: 
		ldr r5,=BOARD	@r5 = address of board
		add r8,r3,r2
		ldr r5,[r5,r8]
		mov r10, #2
                cmp r5, r10
                beq lbouto
                mov r10, #3
                cmp r5, r10
                beq lbouto
		cmp r5,r4
		bne lbe2
	lbe1:	mov r6,#1
		str r2,[sp,#-4]!
		str r3,[sp,#-4]!
		add r9,r9,#1
	lbe2: ldr r0,=ISVALIDARG
		ldr r0,[r0]
		cmp r5,r0
		bne lbe3
		cmp r6,#1
		bne lbe4
		ldr r0,=ISVALID
		str r6,[r0]
		mov r7,#1
	lbe4: b lbouto
        lbe3: sub r2,r2,#4
              add r3,r3,#32
            cmp r2, #-4
            beq lbouto
            cmp r3, #256
            beq lbouto
			b lbw1
     lbouto: cmp r7, #0
            bne lbout1
     lbw2: cmp r9, #0
            beq lbout1
            ldr r0, [sp,#4]!    
	    ldr r0, [sp,#4]!
	    sub r9,r9,#1
            b lbw2
     lbout1:	
	 
	 @ right down diagonal
			ldr r0,=MOVES
				ldr r1,[r0]
				add r1,r9,r1
				str r1,[r0]
                ldr r0,=BMC	@
		ldr r0,[r0]
		ldr r1,=BMR
		ldr r1,[r1]
		mov r9,#0
		mov r11,#4
		mul r10,r0,r11	@r0 = col
		mov r0,r10
		mov r11,#32
		mul r10,r1,r11	@r1 = row 
		mov r1,r10
		mov r2,r0		@r2 = x_temp
		mov r3,r1		@r3 = y_temp
                mov r6,#0		@r6 = maybe
                add r3,r3,#32
		add r2,r2,#4
		mov r7,#0		@r7 = validpart
		cmp r2,#32
		beq rbout1
                cmp r3,#256
                beq rbout1
	rbw1: 
		ldr r5,=BOARD	@r5 = address of board
		add r8,r3,r2
		ldr r5,[r5,r8]
			mov r10, #2
                cmp r5, r10
                beq rbouto
                mov r10, #3
                cmp r5, r10
                beq rbouto
		cmp r5,r4
		bne rbe2
	rbe1:	mov r6,#1
		str r2,[sp,#-4]!
		str r3,[sp,#-4]!
		add r9,r9,#1
	rbe2: ldr r0,=ISVALIDARG
		ldr r0,[r0]
		cmp r5,r0
		bne rbe3
		cmp r6,#1
		bne rbe4
		ldr r0,=ISVALID
		str r6,[r0]
		mov r7,#1
	rbe4: b rbouto
        rbe3: add r2,r2,#4
              add r3,r3,#32
            cmp r2, #32
            beq rbouto
            cmp r3, #256
            beq rbouto
			b rbw1
     rbouto: cmp r7, #0
            bne rbout1
     rbw2: cmp r9, #0
            beq rbout1
            ldr r0, [sp,#4]!    
	    ldr r0, [sp,#4]!
	    sub r9,r9,#1
            b rbw2
     rbout1:	mov pc,lr
	 
	 
	 
	 
	 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@print function
	 prin:
			swi SWI_CLEAR
			ldr r5,=BOARD	@r5=address of board
			mov r0,#1		@r0 = column number for output
			mov r1,#1		@r1 = line number for output
			mov r6,#0		@r6 column index for access
			mov r3,#0		@r3 row index for access
	gprin:		
				mov r6,#0
				mov r0,#1
	fprin: 		
			add r4,r6,r3
			ldr r2,[r5,r4]
			cmp r2,#1
			blt er1
			bgt er2
			mov r2,#'X
			b p2
	er1:	mov r2,#'O
			b p2
	er2:	mov r2,#'_
	p2:		swi SWI_DISPLAY_CHAR
			add r6,r6,#4
			add r0,r0,#1
			cmp r6,#28
			ble fprin
			add r1,r1,#1
			add r3,r3,#32
			cmp r3,#224
			ble gprin
			mov pc,lr
							
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@power of 2 function
	
	pow2:	
		mov r10,r0
		mov r0,#0
		ands r11,r10,#0xFF
		addeq r0,r0,#8
		moveq r10,r10,LSR#8
		ands r11,r10,#0xF
		addeq r0,r0,#4
		moveq r10,r10,LSR#4
		ands r11,r10,#0x3
		addeq r0,r0,#2
		moveq r10,r10,LSR#2
		ands r11,r10,#0x1
		addeq r0,r0,#1
		moveq r10,r10,LSR#1
		mov pc,lr
		
		
		
		
		
		
	rere:	
		
		swi SWI_Exit
		.end
		
		
		
	
