buffers=20
country=44
 @$ TYPE hidriver.asm
%TYPE-W-OPENIN, error op[?3h$ TYPE lcd.asm
; [bios.apricot.ram]lcd.asm
	Title	'[bios.apricot.ram]lcd.asm'
	Include	'Legal.asi'
;****************************************************************************
;*                                                                          *
;*  File name:                      [bios.apricot.ram]lcd.asm               *
;*  File status:                    Assembler module.                       *
;*  Programmer:                     G. Kurth                                *
;*  Original implementation date:   6-aug-84.                               *
;*  Language:                       Tektronix 8086/88 Assembler.            *
;*  Project name:                   Apricot MS-DOS 2.0 BIOS.                *
;*  Revision history:               Re-created 11-may-1983                  *
;*                                  New echo enable/disble 10-8-83 GK       *
;*                                  International Microscreen lookup 16/2/84*
;*				Apricot ROM BIOS version 6-aug-84 GK        *
;*				Apricot RAM BIOS version 5/9/84 GK	    *
;*                                                                          *
;****************************************************************************

	name Lcd

	Global	DatabaseQQ, CodebaseQQ
	Assume	cs:CodebaseQQ, ds:DatabaseQQ, ss:DatabaseQQ, es:DatabaseQQ

	Include	'copyregs.asi'
	Include	'ioregs.asi'
	Include	'Genequ.asi'

;	 External procedures - assembler

	GLOBAL	KBD_OQFLUSH	; KEYBOARD OUTPUT QUEUE FLUSH
	Global	KC_kbdq_out	;  {character to keyboard routine}
	Global	KC_led_set	;  { led set routine  }
	Global	reset_all	; screen reset

	Section	LCD.data, Align(2), class=DataQQ

calc_on		equ	04h	;KD_status calc flag bit
;
;	External Data
;
	Global	CNF_Mscrn_mode	; microscreen startup mode
	Global	KD_status	; Keyboard Status Byte
	Global	KD_shift_cnt	; shift keys down count
	Global	KBD_oq_count	; keyboard output buffer count

	Global	LCD_screen_on	;screen output enabled flag
	Global	LCD_echo_on	;LCD output enabled flag
	Global	LCD_calc_on	;LCD calc output on flag
;
LCD_screen	BLOCK	80	;copy of LCD screen
LCD_curpos	BLOCK	1	;cursor position save
LCD_cursav	BLOCK	1	;second save
LCD_leds_save	BLOCK	1	;led status save
LCD_esc_state	BLOCK	1	;status of LCD/echo output
                                ; 0 = normal character output
                                ; 1 = 'ESC' received
                                ; 2 = 'ESC \' received
                                ; 3 = 'ESC Y' received
                                ; 4 = 'ESC Y x' received
LCD_cursor_on	BLOCK	1	; cursor on flag
LCD_time_on	BLOCK	1	; time & date display on
LCD_calc_on	BLOCK	1	; calculator mode on
LCD_screen_on	BLOCK	1	; screen output on flag
LCD_echo_on	BLOCK	1	; LCD output enabled
LCD_scroll_on	BLOCK	1	; last character scroll enabled

	page
;
	Section LCD.code, Align(1), class=InstrQQ

	Global	LCD_echo_dis
	Global	LCD_echo_en
	Global	LCD_init
	Global	LCD_out
	Global	LCD_config
	Global	LCD_calc_out
	Global	KLCD_restore

;------------------------------------------------------------------------
;	Screen handler subroutines
;
LCD_chsend	;send character with optional Shift in code to Microscreen
		
		test	al,#80h			;top bit set?
		jz	LCD_send		;no - just send character
		and	al,#7Fh			;normalise character
		push	ax			;and save
		mov	al,#0D7h		;send Shift in code
		call	LCD_send
		pop	ax			;then character	
;
LCD_send	;Send character in AL to MicroScreen
		
		cmpb	LCD_calc_on,#1		;is the calculator on?
		je	LCD_sendx		;yes - abort
		cmpb	KBD_oq_count,#95	;is buffer getting full?
		jb	LCD_sendo		;no - ok
		mov	ah,al			;save char
		in	al,#SIO_B_STAT		;get output status
		test	al,#4			;check for tx buffer empty
		mov	al,ah			;restore char
		jz	LCD_send		;oh dear - wait
LCD_sendo	call	KC_kbdq_out		;transmit character
LCD_sendx	ret
;
;
LCD_clear	;clear MicroScreen

		cld
		lea	di,LCD_screen		;point at screen buffer
		mov	cx,#40			;40 words of image
		mov	ax,#2020h		;ax = spaces
		rep	stow			;fill buffer (assume ES = DS)
		movb	LCD_curpos,#80h		;set cursor to home
		mov	al,#0D0h		;send clear screen
		call	LCD_send		;to keyboard
		movb	LCD_time_on,#0		;time now off
		ret
;
;
LCD_scroll	;scroll Microscreen

		testb	KD_status,#02h		;check for STOP on
		jz	LCD_scroll_2		;nope - skip
		cmpb	KD_shift_cnt,#0		;shift down?
		jnz	LCD_scroll		;yes - wait
LCD_scroll_1	testb	KD_status,#02h		;check for STOP on
		jz	LCD_scroll_2		;nope - skip
		cmpb	KD_shift_cnt,#0		;shift down?
		jz	LCD_scroll_1		;no - wait again
LCD_scroll_2	mov	al,#0D4h		;cursor off code
		call	LCD_send
		mov	al,#0D0h		;clear screen code
		call	LCD_send
		movb	LCD_time_on,#0		;set time off
		cld
		lea	di,LCD_screen		;point at LCD buffer
		mov	cx,#40			;40 characters to zap
LCD_scroll_3	mov	al,#20h			;space in al
		xchg	al,40[di]		;get char from second, replace
		stob				;put second line char in buffer
		push	cx
		push	di
		call	LCD_chsend		;send to microscreen
		pop	di
		pop	cx
		loop	LCD_scroll_3		;do all 40 characters		
		cmpb	LCD_cursor_on,#0	;cursor on?
		jz	LCD_scroll_x		;no - done
		mov	al,#0D3h		;cursor on code
		call	LCD_send
LCD_scroll_x	ret				;done
;
;
LCD_creturn	;Perform a carriage return

		mov	al,#080h		;set up curpos for first line
		cmpb	LCD_curpos,#0A7h	;on second line?
		jbe	LCD_cret_1		;no - first
		mov	al,#0A8h		;set up for second line
LCD_cret_1	mov	LCD_curpos,al		;set up copy
		call	LCD_send		;and tell the MicroScreen
		ret
;
;
LCD_linefeed	;perform line feed on Microscreen

		call	LCD_scroll		;scroll up 1 line
		mov	al,LCD_curpos		;get current cursor
		cmp	al,#0A8h		;on first line?
		jae	LCD_linef_1		;no - skip
		add	al,#40			;yes - move cursor
		mov	LCD_curpos,al		;update position
LCD_linef_1	call	LCD_send		;send cursor pos
		ret				;done
;
;
LCD_backspace	;Move the cursor back one position

		mov	al,LCD_curpos		;get current
		dec	al			;back!
		cmp	al,#80h			;past front?
		jae	LCD_back_1		;no - skip
		mov	al,#0CFh		;put at end of display
LCD_back_1	mov	LCD_curpos,al		;update
		call	LCD_send		;and send to MicroScreen
		ret
;
;
LCD_echo_dis	;Disable LCD echo mode

		xor	ax,ax
		mov	LCD_echo_on,al		;mode = no echo
		mov	LCD_cursor_on,al	;cursor off
		inc	al
		mov	LCD_screen_on,al	;screen enabled
		call	LCD_clear		;clear LCD
		movb	LCD_time_on,#01		;time on
		mov	al,#0D4h		;cursor off
		call	LCD_send
		mov	al,#0E2h		;switch on time
		call	LCD_send
		ret
;
;
LCD_echo_en	;Enable LCD screen echo

		mov	al,#01
		mov	LCD_echo_on,al		;echo enabled
		mov	LCD_cursor_on,al	;cursor on
		mov	LCD_screen_on,al	;screen on
		call	LCD_clear		;clear MicroScreen
		mov	al,#0D3h		;send cursor on code
		call	LCD_send
		ret
;
;
LCD_restore	;Restore microscreen contents from image

		mov	al,#0D0h		;clear screen command
		call	LCD_send
		lea	si,LCD_screen		;point at screen image
		mov	cx,#80			;80 characters
		cld
LCD_rest_1	lodb				;get char
		push	cx
		push	si
		call	LCD_chsend		;send to screen
		pop	si
		pop	cx
		loop	LCD_rest_1		;do all 80 characters
		mov	al,LCD_curpos		;and update cursor
		call	LCD_send
		ret
;
;
LCD_del_end_scr	;Delete from cursor to end of screen

		mov	cx,#00D0h		;set up for max
		mov	al,LCD_curpos		;get curpos
		sub	cl,al			;form count
		jmpsh	LCD_del_gen		;and do the rest
;
;
LCD_del_beg_scr	;Delete from cursor to start of screen

		xor	cx,cx
		mov	cl,LCD_curpos		;form count
		sub	cl,#7Fh			;by normalizing
		mov	al,#80h			;position for start of buffer
		jmpsh	LCD_del_gen		;and do the rest
;
;
LCD_del_lin	;Delete Current Line

		mov	cx,#40			;set up count
		mov	al,#0A8h		;load up for second line
		cmp	al,LCD_curpos		;which line?
		jbe	LCD_del_lin_1		;second - skip
		mov	al,#080h		;set up first
LCD_del_lin_1	mov	LCD_curpos,al		;set new position
;
LCD_del_gen	lea	di,LCD_screen		;point at buffer
		and	ax,#007Fh		;normalise it
		add	di,ax			;index in
		add	ax,cx			;check valid count
		cmp	ax,#80			;only 80 characters on uS
		ja	LCD_del_ex		;invalid - abort op
		mov	al,#20h			;space character
		cld
		rep	stob			;fill buffer
		call	LCD_restore		;reprint screen
LCD_del_ex	ret
;
;
LCD_del_end_lin	;Delete from cursor to end of line

		mov	cx,#00D0h		;set up for max
		mov	al,LCD_curpos		;get curpos
		cmp	al,#0A8h		;on second line?
		jae	LCD_del_el_1		;yes - skip
		mov	cl,#0A8H		;set up for first line
LCD_del_el_1	sub	cl,al			;form count
		jmpsh	LCD_del_gen		;and do the rest
;
;
LCD_del_lin_beg	;Delete from cursor to beginning of line

		mov	al,#0A8h		;load up for second line
		cmp	al,LCD_curpos		;which line?
		jbe	LCD_del_lb_1		;second - skip
		mov	al,#080h		;set up first
LCD_del_lb_1	xor	cx,cx			;set up count
		mov	cl,LCD_curpos		;
		sub	cl,al			;remove start
		inc	cl			;adjust
		jmpsh	LCD_del_gen		;and do it
;
;
	page
;
;---------------------------------------------------------------------------
;
;	LCD_out	- Send character to microscreen
;		Input character on stack
;
LCD_out
		mov	bp,sp
		mov	ax,2[bp]		;get character
		xor	bx,bx
		mov	bl,LCD_esc_state	;form pointer
		cmp	bl,#4			;valid?
		ja	LCD_out_x		;no - abort
		shl	bx,#1			;form word pointer
		call	[CS:LCD_CTAB][bx]	;jump to handler
		jmpsh	LCD_out_xx
;
;
LCD_out_x	movb	LCD_esc_state,#0	;reset escape sequence state
LCD_out_xx	ret	#2			;return & pop
;
;      
LCD_CTAB	WORD	CASE0-CodebaseQQ	;0 - normal output
		WORD	CASE1-CodebaseQQ	;1 - ESC detected
		WORD	CASE2-CodebaseQQ	;2 - ESC \ detected
		WORD	CASE3-CodebaseQQ	;3 - ESC Y detected
		WORD	CASE4-CodebaseQQ	;4 - ESC Y x detected
;
CASE0		cmp	al,#1Fh			;printable?
		jbe	CASE02			;no - control code
		call	LCD_lookup		;translate the character
		push	ax
		call	LCD_chsend		;send to Microscreen
		pop	ax
		lea	di,LCD_screen		;point at screen image
		mov	bl,LCD_curpos
		and	bx,#007Fh		;form offset
		mov	[bx][di],al		;put in buffer
		incb	LCD_curpos		;bump cursor pos
		cmpb	LCD_curpos,#0CFh	;past end?
		ja	CASE01			;yes - do scroll etc
		ret				;done - exit
;
CASE01		movb	LCD_curpos,#80h		;setup for no scroll
		cmpb	LCD_scroll_on,#0	;no scroll mode?
		jz	CASE0x			;yes - done
		call	LCD_scroll		;scroll the LCD
		mov	al,#0A8h		;cursor on second line
		movb	LCD_curpos,al		;put cursor on second line
		call	LCD_send		;tell the LCD
		ret				;done
;
CASE02		cmp	al,#008h		;backspace?
		jne	CASE03			;no - skip
		call	LCD_backspace		;yes - do it
		ret				;done
;
CASE03		cmp	al,#00Ah		;linefeed?
		jb	CASE04			;no - skip
		cmp	al,#00Ch		;linefeed?
		ja	CASE04			;no - skip
		call	LCD_linefeed		;do the linefeed
		ret				;done
;
CASE04		cmp	al,#0Dh			;return?
		jne	CASE05			;nope
		call	LCD_creturn
		ret				;done
;
CASE05		cmp	al,#01Bh		;escape?
		jne	CASE0x			;no - done
		movb	LCD_esc_state,#01	;set state to 1
;
CASE0x		ret
;
	page
;
;	CASE1 - ESCAPE code received
;
CASE1		call	CASE1B			;call case handler
		cmpb	LCD_esc_state,#1	;state still 1?
		jne	CASE1A			;no - skip
		movb	LCD_esc_state,#0	;reset state
CASE1A		ret
;
CASE1B		cmp	al,#47			; / - set leds?
		jne	CASE11			; no - skip
		movb	LCD_esc_state,#02	;yes - set state
		ret				;done
;
CASE11		cmp	al,#60			; < - display Time & Date?
		jne	CASE12			; no - skip
		movb	LCD_time_on,#01		;say time on
		mov	al,#0E2h		;on code
		jmp	LCD_send		;send & return
;
CASE12		cmp	al,#65			; A - cursor up
		jne	CASE13			; no - skip
		mov	al,LCD_curpos		;get cursor
		cmp	al,#0A8h		;on second line?
		jb	CASE12x			;no - skip
		sub	al,#40			;move up
		mov	LCD_curpos,al		;update
		call	LCD_send		;and out to Microscreen
CASE12x		ret				;done - reset state
;
CASE13		cmp	al,#66			; B - cursor down
		jne	CASE14			; no - skip
		mov	al,LCD_curpos		;get cursor
		cmp	al,#0A8h		;on first line?
		jae	CASE13x			;no - skip
		add	al,#40			;move down
		mov	LCD_curpos,al		;update
		call	LCD_send		;and out to Microscreen
CASE13x		ret				;done - reset state
;
CASE14		cmp	al,#67			; C - cursor right
		jne	CASE15			; no - skip
		mov	al,LCD_curpos
		inc	al
		cmp	al,#0D0h		;fallen off?
		jb	CASE14a			;no
		mov	al,#080h		;back at start
CASE14a		mov	LCD_curpos,al		;update
		jmp	LCD_send		;and tell, return
;
CASE15		cmp	al,#68			; D - cursor left
		jne	CASE16			;no - skip
		jmp	LCD_backspace		;clear & return
;
CASE16		cmp	al,#69			; E - clear screen?
		jne	CASE17			; no - skip
		jmp	LCD_clear		;clear & return
;
CASE17		cmp	al,#72			; H - home cursor
		jne	CASE18			;no - skip
		mov	al,#080h		;home value
		mov	LCD_curpos,al
		jmp	LCD_send		;clear & return
;
CASE18		cmp	al,#74			; J - delete to end of screen
		jne	CASE19			; no - skip
		jmp	LCD_del_end_scr		; delete & return
;
CASE19		cmp	al,#75			; K - delete to end of line
		jne	CASE110			; no - skip
		jmp	LCD_del_end_lin		; delete & return
;
CASE110		cmp	al,#85			; U - enable MSCREEN echo & screen
		jne	CASE111			; no - skip
		mov	al,#01
		mov	LCD_echo_on,al		;say echo on
		mov	LCD_screen_on,al	;and screen on
		ret
;
CASE111		cmp	al,#86			; V - Disable Mscreen echo ?
		jne	CASE112			; no - skip
		movb	LCD_echo_on,#0		;no echo
		movb	LCD_screen_on,#1	;screen on
		ret
;
CASE112		cmp	al,#87			; W - Disable screen output
		jne	CASE113			; no - skip
		movb	LCD_echo_on,#1		; echo on
		movb	LCD_screen_on,#0	; screen off
		ret
;
CASE113		cmp	al,#89			; Y - cursor positioning
		jne	CASE114			; no - skip
		movb	LCD_esc_state,#3	;set state
		ret
;
CASE114		cmp	al,#98			; b - delete to start
		jne	CASE115			; no - skip
		jmp	LCD_del_beg_scr		;do it & return
;
CASE115		cmp	al,#99			; c - wrap on 80th line
		jne	CASE116			; no - skip
		movb	LCD_scroll_on,#0	; - set no scroll
		ret
;
CASE116		cmp	al,#100			; d - CR,LF on 80th line
		jne	CASE117			;no - skip
		movb	LCD_scroll_on,#1	; - set scroll
		ret
;
CASE117		cmp	al,#101			; e - cursor on
		jne	CASE118
		movb	LCD_cursor_on,#1	;say cursor on		
		mov	al,#0D3H		; cursor on code
		jmp	LCD_send		;do it & return
;
CASE118		cmp	al,#102			; f - cursor off
		jne	CASE119
		movb	LCD_cursor_on,#0	;say cursor off		
		mov	al,#0D4H		; cursor off code
		jmp	LCD_send		;do it & return
;				
CASE119		cmp	al,#103			; g - Time display off
		jne	CASE120
		xor	ax,ax
		xchg	LCD_time_on,al		;clear time
		cmp	al,ah
		jz	CASE119a		;was not on
		call	LCD_restore		;repaint LCD
CASE119a	ret
;
CASE120		cmp	al,#106			; j - Save Cursor position
		jne	CASE121
		mov	al,LCD_curpos
		mov	LCD_cursav,al
		ret
;
CASE121		cmp	al,#107			; k - restore Cursor position
		jne	CASE122
		mov	al,LCD_cursav		;get saved position
		mov	LCD_curpos,al
		jmp	LCD_send		;send & return
;
CASE122		cmp	al,#108			; l - Delete line
		jne	CASE123
		jmp	LCD_del_lin		;delete & return
;
CASE123		cmp	al,#111			; o - Delete to beginning of line
		jne	CASE124
		jmp	LCD_del_lin_beg		;delete & return
;
CASE124		cmp	al,#114			; r - initiate MSCREEN echo
		jne	CASE125
		jmp	LCD_echo_en		;start & return
;
CASE125		cmp	al,#115			; s - disable MSCREEN echo
		jne	CASE126
		jmp	LCD_echo_dis		;stop & return
;
CASE126		cmp	al,#122			; z - panic reset
		jne	CASE1x			;no - done
		call	LCD_clear		;clear LCD
		mov	al,#1
		cmpb	LCD_screen_on,al	;screen off?
		je	CASE1x			;no - skip
		movb	LCD_screen_on,al
		call	reset_all		;reset the screen driver
CASE1x		ret
;
	page
;
CASE2		;LED setup sequence received ESC /
		
		mov	LCD_leds_save,al	;save copy
		mov	ah,#0
		mov	LCD_esc_state,ah	;reset escape state
		cmpb	LCD_calc_on,ah		;calculator on?
		jnz	CASE2x			;yes - skip
		call	KC_led_set		;set up led's
CASE2x		ret
;
;
CASE3		;Cursor positioning sequence ESC Y ? received

		movb	LCD_esc_state,#4	;set next state
		ret
;
;
CASE4		;Cursor position final code received

		cmp	al,#20h			;in range?
		jb	CASE4x			;no
		cmp	al,#6Fh
		ja	CASE4x
		add	al,#060h		;adjust
		mov	LCD_curpos,al
		call	LCD_send
CASE4x		movb	LCD_esc_state,#0	;reset escape state
		ret
;
	page
;------------------------------------------------------------------------
;
;	KLCD_restore	- Full microscreen restore for keyboard
;
;
KLCD_restore	call	LCD_restore		;rewrite LCD contents
		mov	al,#0D4h		;load no cursor code
		cmpb	LCD_cursor_on,#0	;is it on?
		jz	KLCD_rest_1		;no - skip
		mov	al,#0D3h		;load cursor on code
KLCD_rest_1	call	KC_kbdq_out		;send to keyboard
		cmpb	LCD_time_on,#1		;time on?
		jne	KLCD_rest_2		;no - skip
		mov	al,#0E2h		;replace time
		call	KC_kbdq_out
KLCD_rest_2	mov	al,LCD_leds_save	;get old leds
		call	KC_led_set		;and set up
		ret				;done
;
;
;------------------------------------------------------------------------
;
;	LCD_init	- LCD initialisation routine
;
LCD_init	xor	ax,ax			;set up false flags
		mov	LCD_leds_save,al	;LEDs off
		mov	LCD_esc_state,al	;normal output
		mov	LCD_calc_on,al		;calculator off
		inc	al			;set up true flags
		mov	LCD_screen_on,al	;screen on
		mov	LCD_scroll_on,al	;scrolling enabled
		cmp	CNF_Mscrn_mode,al	;in echo mode
		jne	LCD_init_1		;no - skip
		call	LCD_echo_en		;enable echo
		jmpsh	LCD_init_x		;done
LCD_init_1	call	LCD_echo_dis		;disable echo - put up time
LCD_init_x	ret				;done!
;
; 
	page
;-----------------------------------------------------------------------
;	LCD_config	- Microscreen INT FCh handler
;		On Entry:	AX = 0FFFFh	- preloaded fail
;				CX = command
;				DX = data
;		On Exit:	AX = status
;
LCD_config	cmp	cl,#0			;0 - INIT?
		jz	LC_init			;yes
		cmp	cl,#1			;1 - print character?
		jz	LC_print		;yes
		cmp	cl,#2			;2 - raw output?
		jz	LC_raw			;yes
		jmpsh	LCD_con_x		;return error status
;
LCD_con_ok	xor	ax,ax
LCD_con_x	ret
;
LC_init		call	LCD_init		;init Microscreen
		jmpsh	LCD_con_ok		;return ok
;
LC_print	push	dx			;send char
		call	LCD_out			;to driver
		jmpsh	LCD_con_ok		;return ok
;
LC_raw		mov	ax,dx			;char in al
		call	KC_kbdq_out		;send straight to keyboard
		jmpsh	LCD_con_ok
;
;
	page
;--------------------------------------------------------------------------
;	LCD_calc_out	- Output to calculator
;		Input character on stack
;
LCD_calc_out	mov	bp,sp
		mov	ax,2[bp]		;get char
		cmp	al,#0			;zero?
		jnz	LCD_calc_1		;no - skip
		movb	LCD_calc_on,#1		;say calc on
		CALL	KBD_OQFLUSH		;FLUSH BUFFER
		mov	al,#0D0h		;clear screen for calc
		call	KC_kbdq_out
		mov	al,#0D4h
		call	KC_kbdq_out
		mov	al,#0FFh		;switch on all the LEDs
		call	KC_led_set
		jmpsh	LCD_calc_x		;done
;
LCD_calc_1	cmp	al,#0FFh		;off command?
		jne	LCD_calc_2		;no - skip
		movb	LCD_calc_on,#0		;calc off
		andb	KD_status,#\calc_on	;tell keyboard
		call	KLCD_restore		;restore the screen
		jmpsh	LCD_calc_x		;done
;
LCD_calc_2	call	KC_kbdq_out		;else simply send character
LCD_calc_x	ret	#2			;done
;
	page
;-------------------------------------------------------------------------
;	LCD_lookup	- translates byte in AL via the public LCD lookup
;			table - output in AL
;
LCD_lookup 
		xor     ah,ah           ;* clear AH
        	;* al has the old ASCII value in it
        
        	push    ds              ;* save DS
        	xor     bx,bx           ;* point to bottom segment
        	mov     ds,bx
        	lds	bx,ds:71Eh	;* get seg:offset in ds:bx
        
				        ;-- Now we translate
        	xlat
        				;-- Translate is done
        
        	pop     ds              ;* restore ds
        	ret			;* back to driver
;
;
        Section LCDTAB.const, Align (2), Class = ConstQQ
        
        Global  LCDXLAT

        ;256 byte table for LCD character lookup

LCDXLAT
        byte    0,1,2,3,4,5,6,7
        byte    8,9,10,11,12,13,14,15
        byte    16,17,18,19,20,21,22,23
        byte    24,25,26,27,28,29,30,31
        byte    32,33,34,35,36,37,38,39
        byte    40,41,42,43,44,45,46,47
        byte    48,49,50,51,52,53,54,55
        byte    56,57,58,59,60,61,62,63
        byte    64,65,66,67,68,69,70,71
        byte    72,73,74,75,76,77,78,79
        byte    80,81,82,83,84,85,86,87
        byte    88,89,90,91,05,93,94,95
        byte    96,97,98,99,100,101,102,103
        byte    104,105,106,107,108,109,110,111
        byte    112,113,114,115,116,117,118,119
        byte    120,121,122,123,124,125,008,12h
        byte    0,1,2,3,4,5,6,7
        byte    8,9,10,11,12,13,14,15
        byte    16,17,18,19,20,21,22,23
        byte    24,25,26,27,12,29,30,31
        byte    32,33,34,35,36,37,38,39
        byte    40,41,42,43,44,45,46,47
        byte    48,49,50,51,52,53,54,55
        byte    56,57,58,59,60,61,62,63
        byte    64,65,66,67,68,69,70,71
        byte    72,73,74,75,76,77,78,79
        byte    80,81,82,83,84,85,86,87
        byte    88,89,90,91,5Ch,93,94,95
        byte    96,97,98,99,100,101,102,103
        byte    104,105,106,107,108,109,110,111
        byte    112,113,114,115,116,117,118,119
        byte    120,121,122,123,124,125,7Eh,7Fh
        
        
        end

$ 