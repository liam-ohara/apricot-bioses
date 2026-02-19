taQQ
;
DISK_SCRA$ TYPE screen.asm
; [bios.apricot.rom]screen.asm
	title	'[bios.apricot.rom]screen.asm'
        INCLUDE 'legal.asi'
;************************************************************************
;
; MODULE:               [bios.apricot]nscreen.asm
; Programmer:           G. Kurth
; Implemented:          23-may-84
; Modifications:	
;			ROM BIOS version 23-may-84 GK
;			Apricot version 9-aug-84 GK
;
;************************************************************************
;------------------------------------------------------------------------
; This module provides the ROM BIOS screen interface.
;------------------------------------------------------------------------
;
        name    scrcon

        INCLUDE 'ioregs.asi'
	INCLUDE	'copyregs.asi'
        
        Global  CodebaseQQ, DatabaseQQ
        
        Assume  CS:CodebaseQQ, DS:DatabaseQQ
        
	GLOBAL	XRESET
	GLOBAL	PUT_VEC
	GLOBAL	SCR_drv_graphics
 	GLOBAL	SCR_Config
	GLOBAL	SCREEN_OUT
	GLOBAL	LCD_out
	GLOBAL	RESET_ALL

	GLOBAL	KD_status
	GLOBAL	LCD_echo_on
	GLOBAL	LCD_screen_on
	GLOBAL	SCREEN_ACTIVE

stop_on	equ	02h	;stop mode active bit in KD_status

;-----------------------------------------------------------------------------
        section scrcon.data, align(1), class=dataQQ

count		block	2		;counter for display string
dword_ptr	block	4		;dword pointer to the string
       

        section scrcon.code, align(1), class=InstrQQ
;
;------------------------------------------------------------------------------
; SCR_Config  -       Screen configurator
;               enter with data in registers:
;               AX = fail status 0FFFFh
;		CX = Command
;		DX = data
;               or DX:SI = pointer
;               returns with status in AX
;
;
SCR_Config
        mov     bx,cx			;command in bx
        cmpw    bx,#5	                ;valid 0-5?
        ja      SCR_Con_x
        shlw    bx,#1                   ;convert to word pointer
        jmp     [cs:SCR_CTAB][bx]	;go to routines
SCR_Con_ok
        xorw    ax,ax                   ;return OK status
	ret
SCR_Con_o1
	mov	ax,#1			;return a 1
SCR_Con_x
        ret				;return status in ax
;
SCR_CTAB
        WORD    SCR_con_init-CodebaseQQ	;0 - Init & return status
        WORD    SCR_con_grph-CodebaseQQ	;1 - get/set graphics/text
        WORD    SCR_con_disp-CodebaseQQ	;2 - get/set display on/off
        WORD    SCR_con_ok-CodebaseQQ	;3 - copy virtual screen to real
        WORD    SCR_con_out-CodebaseQQ	;4 - print character
        WORD    SCR_con_str-CodebaseQQ	;5 - print string
;
;--------------------------------------------------------------------------
;	0 - Init The Screen
;
SCR_con_init				;initialise screen
	call	RESET_ALL
	jmp	SCR_con_ok		;return ok status
;
;-------------------------------------------------------------------------
;	1 - Get/Set graphics/text mode
;
SCR_con_grph				;get/set graphics /text
	cmp	dl,#1			;valid 0 or 1?
	je	SCR_con_gr_G		;1 - set graphics
	jb	SCR_con_gr_T		;0 - text
	in	al,#PIO_PORB		;get PIO port
	test	al,#10h			;check display switch
	jnz	SCR_con_gr_TX		;TEXT - return 0
	jmpsh	SCR_con_gr_GR		;GRAPHICS - return 1
;
SCR_con_gr_T				;set text mode
	call	xreset			;use screen driver to re-init
SCR_con_gr_TX				;text mode - return 0
	jmp	SCR_con_ok		;
;
SCR_con_gr_G				;set graphics mode
	call	SCR_drv_graphics	;enable graphics mode in screen
	pushf
	cli
	in	al,#PIO_PORB		;get control port
	and	al,#0EFh		;set graphics mode
	out	#PIO_PORB,al
	popf
SCR_con_gr_GR
	jmp	SCR_con_o1		;return 1 - graphics mode
;
;---------------------------------------------------------------------------
;	2 - Get/Set screen on/off
;
SCR_con_disp				;get/set screen on
	pushf
	cli
	cmp	dl,#1			;valid 0 or 1?
	je	SCR_con_di_1		;1 - screen off
	jb	SCR_con_di_0		;0 - screen on
	in	al,#PIO_PORB		;get PIO port
	test	al,#08h			;check display switch
	jnz	SCR_con_di_00		;ON - return 0
	jmpsh	SCR_con_di_11		;OFF - return 1
;
SCR_con_di_0			;set screen on
	in	al,#PIO_PORB
	and	al,#0F7h			;clear port bit
	out	#PIO_PORB,al
SCR_con_di_00				;screen on - return 0
	popf
	jmp	SCR_con_ok		;
;
SCR_con_di_1			;set screen off
	in	al,#PIO_PORB
	or	al,#008h		;set port bit
	out	#PIO_PORB,al
SCR_con_di_11				;screen off - return 0
	popf
	jmp	SCR_con_o1		;
;
;---------------------------------------------------------------------------
;	4 - Print character
;
SCR_con_out				;print character
	mov	al,dl			;character in al
	call	Screen_out
	jmp	SCR_con_ok
;
;--------------------------------------------------------------------------
;	5 - Print String
;
SCR_con_str				;print string
	push	es			;get input data packet
	mov	es,dx			;point to packet
	mov	ax,es:[si]		;get count
	mov	count,ax		;save
	les	bx,es:2[si]		;get dword pointer in es:bx
	mov	dword_ptr,bx		;save it
	mov	dword_ptr+2,es		;
	pop	es			;

	cmpw	count,#0		;all chars done ?
	je	end_string		;yes, exit

next_string_char
	push	es			;get next char
	les	bx,dword_ptr		;point to character with es:bx
	mov	al,es:[bx]		;get char
	pop	es			;
	
	call	screen_out		;display character

	incw	dword_ptr		;increment offset
	decw	count			;decrement count
	jnz	next_string_char	;loop back if count not zero

end_string
	jmp	SCR_con_ok		;return status ok
;
	page
;-------------------------------------------------------------------------
; Screen_out	- called by INT 29H & INT 0F1h
;		single character in al sent to screen
;
SCREEN_OUT
	mov	ah,#1			;set up true status
	testb	KD_status,#stop_on	;stop mode on?
	jz	nostop			;no - get on with it
	cmp	LCD_echo_on,ah		;stop on - but are we in echo mode?
	je	nostop			;yes - skip
	sti				;allo keyboard ints in
	jmpsh	SCREEN_OUT
;
nostop
	movb	screen_active,ah	;say screen active
	cmp	LCD_echo_on,ah		;in echo mode?
	jne	nolcd			;no - skip LCD output
	cmp	LCD_screen_on,ah	;is screen output on?
	pushf				;save test result
	push	ax			;save character
	push	ax			;send character
	call	LCD_out			;send to LCD
	pop	ax			;restore character
	popf				;restore test result
	jne	noscreen		;no - skip SCREEN output
nolcd
	call	[put_vec]		;send character to screen
noscreen
	movb	screen_active,#0	;say screen inactive
	ret				;done
;
;
;-----------------------------------------------------------------------
;	RESET_ALL
;		Resets the screen driver
;
RESET_ALL
	push	es
	push	ds
	call	XRESET
	pop	ds
	pop	es
	ret
;
;
        End

$ 