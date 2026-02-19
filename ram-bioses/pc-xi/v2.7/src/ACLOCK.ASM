
$ TYPE diag.asm

%TYPE-W-OPENIN, err
$ TYPE clock.asm

; [bios.apricot.ram]clock.asm
	title	'[bios.apricot.ram]clock.asm'
	INCLUDE	'legal.asi'
;****************************************************************************
;*                                                                          *
;*  Old file name:                  /usr/apricot/testbios/msclock.asm       *
;*  New file name:                  [bios.apricot.ram]clock.asm              *
;*  Original programmer:            G. Kurth                                *
;*  Original implementation date:   11-Apr-83.                              *
;*  Language:                       Tektronix 8086/88 assembler.            *
;*  Project name:                   apricot MS-DOS 2.0 BIOS.                *
;*  Revision history:                                                       *
;*                                                                          *
;*                                                                          *
;*  Rewritten from Pascal to Assembler for the apricot                      *
;*  Code from the Timer.asm module added to this module                     *
;*  Amendment done:                 12th March 1984                         *
;*  New Programmer:                 Vince CORBIN                            *
;*                                  VAX version 2/5/84 GK                   *
;*				ROM BIOS version 21-may-84 GK		    *
;*				RAM BIOS version 5/9/84 GK		    *
;*                                                                          *
;****************************************************************************

;---------------------------------------------------------------------------
;  Clock module. This module is the ROM BIOS clock driver.
;                  It is called by the interrupt handler.
;---------------------------------------------------------------------------

        NAME    CLOCK

        Global  CODEBASEQQ,     DATABASEQQ

        Assume  CS:CODEBASEQQ,  DS:DATABASEQQ

        INCLUDE 'ioregs.asi'
        INCLUDE 'Genequ.asi'

; INTERNAL

        Global  SH_wake_me_up   ;two word procedure
                                ;SH_wake_me_up(sleeper(word),count(word))
        Global  TMR_init        ;Timer initialisation - called on init
        Global  TMR_int         ;Timer interrupt - called by INTERRUPT
        Global  Wake_count
        Global  Wake_on
        Global  CLK_config	;System clock - called by int FCh
        Global  CLK_key_in	;routine to update the system clock
                                ;from the keyboard.
;
; EXTERNAL
;
	Global	KC_repeat	;keyboard auto-repeat handler
	Global	KC_kbdq_out	;keyboard queue output
        Global  TMR_cursor
        Global  Sound_int       ;Sound timer coundown
        Global  DO_end_hd_delay ;disk head delay
        Global  DO_hd_Tout      ;head deselect delay 
	Global	FR_time_out	;disk registration timeout
        Global  PRN_Tout        ;printer character transmit timeout
        Global  WI_park_hd1	;winchester 1 head park timeout
	Global  WI_park_hd2	;winchester 2 head park timeout
	Global	WI_tick		;Winchester timeout tick

        page
;
        Section clock.data, Align(2), class=DataQQ
;
;       Data area for scheduler - each sleeper has one byte in WAKE_ON to say
;       that it is active (0=inactive, 1=active), and a word in WAKE_COUNT to
;       keep the 20mS clock ticks in.
;
Wake_count      BLOCK   (Max_sleep*2)   ;one word for each sleeper
Wake_on         BLOCK   Max_sleep       ;one byte for each sleeper
;
;       Clock restart data area
;
correction	equ	7		;approximate correction value
;
TMR_tick        BLOCK   1               ;No. of 20ms int's since last update
                                        ;of the real time clock.
;
;       Real time clock data area
;
MSCLK_time_days BLOCK   2               ;days since 1-1-80
MSCLK_time_mins BLOCK   1               ;minutes count
MSCLK_time_hrs  BLOCK   1               ;hours count
MSCLK_time_hsec BLOCK   1               ;hundredths of seconds count
MSCLK_time_secs BLOCK   1               ;seconds count
;
Sday		BLOCK	1		;temp day save
Smonth		BLOCK	1		;temp month save
Syear		BLOCK	1		;temp year save
;
CLK_data_ip	BLOCK	2		;keyboard -> clock input pointer
CLK_data_in	BLOCK	14		;keyboard -> clock input buffer
;
        Section clock.const, Align(2), class=ConstQQ
;
; Sleeper call table
;
Sleep_tab
        Word    DO_end_hd_delay-CodebaseQQ
	Word	FR_time0-CodebaseQQ
	Word	FR_time1-CodebaseQQ
        Word    PRN_Tout-CodebaseQQ
        Word    WI_park_hd1-CodebaseQQ
        Word    WI_park_hd2-CodebaseQQ
;
; MSCLK_daze	- days in month frig table for date conversion
;		(see Set_Clock)
;
MSCLK_daze
	WORD	0,31,59,90,120,151,181,212,243,273,304,334
;        
        page


        Section clock.code, Align(1), class=InstrQQ
;
;
;------------------------------------------------------------------------
; TMR_init - initialises all clock activities and sets off 20mS interrupts
;
TMR_init
	xor ax,ax        
	movw    MSCLK_time_days,ax      ;{ reset days count }
        movw    MSCLK_time_mins,ax      ;{ and minutes, and hours }
        movw    MSCLK_time_hsec,ax      ;{ and hundredths andseconds }
	movw	CLK_data_ip,ax		;zero receive data pointer
	inc	al
        movb    TMR_tick,al             ;number of 20ms int's for clock= 1
;
; NOW - initialise the sheduler - set all sleepers to inactive
;
        xorw    ax,ax                   ;ax=0 - inactive
        movw    cx,#Max_sleep           ;number of sleepers
        movw    di,#Wake_on-DatabaseQQ  ;point at sleeper active table
        rep     stob ds:                ;make them sleep
;
; NOW - set off the PIT and enable the interrupt
;
        movb    al,#00110000b           ;select counter 0, mode 0
                                        ;read/load 2 bytes, binary count
        out     #PIT_COM,al
        movw    ax,#05000		;20mS count (0.25 MHz)
        out     #PIT_CN0,al             ;LSB
        mov     al,ah
        out     #PIT_CN0,al             ;MSB
        in      al,#PIC_IW1             ;interrupt mask register
        and     al,#0BFh                ;AND mask (enable clock interrupt)
        out     #PIC_IW1,al
        ret                             ;Timer functions now initialised
;
;------------------------------------------------------------------------
; TMR_int - 20mS interrupt handler
; Called only from INTERRUPT module
; PERFORMS:     0) ROM-BIOS clock upkeep
;               1) Sound timeout countdown
;               2) Scheduling for cursor timeout,
;                       floppy motor off, & floppy head load
;               3) PIT channel 0 re-start.
;-----------------------------------------------------------------------
;
TMR_int

;
; Normal 20ms counter calls
;
        call    TMR_cursor
        call    Sound_Int               ;count down sound timer
	call	WI_tick			;count down wini timer
	call	KC_repeat		;keyboard auto-repeat
;
;
Tmr_int_1
;
;
; NOW - perform scheduling
;
;
        movw    cx,#Max_sleep         ;count of sleepers
        movw    bx,#Wake_count-DatabaseQQ
        movw    si,#Wake_on-DatabaseQQ
SH_tick_loop
        cmpb    [si],#0                 ;active?
        jz      SH_tick_nxt             ;no-skip
        decw    [bx]			;count down
        jnz     SH_tick_nxt             ;skip if non zero
        movb    [si],#0                 ;say inactive (count=0)
        movw    [bx],#0                 ;set counter to zero
        push    cx                      ;save count
        push    bx                      ;save pointers
        push    si
        subw    bx,#Wake_count-DatabaseQQ
        call    [ds:sleep_tab][bx]      ;call sleeper
        pop     si
        pop     bx
        pop     cx
SH_tick_nxt
        incw    si                      ;bump active pointer
        incw    bx                      ;bump count pointer
        incw    bx
        loop    SH_tick_loop            ;check all sleepers
;
;       Update the real time clock by 20ms
;
;
;       lets stop DOS from playing while we do the update
;
        cli
;
	mov	al,TMR_tick		;get tick
	shl	al,#1			;double it
        add     MSCLK_time_hsec,al      ;bump 1/100s seconds count
        cmpb    MSCLK_time_hsec,#99     ;by 60ms
        jle     MSCLK_time_exit         ;jump if 1 sec has NOT expired

        subb    MSCLK_time_hsec,#100    ;reset hundredths count
        incb    MSCLK_time_secs         ;bump seconds count
        cmpb    MSCLK_time_secs,#59
        jle     MSCLK_time_exit         ;jump if 1 minute has NOT expired

        movb    MSCLK_time_secs,#0      ;reset the seconds count
        incb    MSCLK_time_mins         ;bump minutes count
        cmpb    MSCLK_time_mins,#59
        jle     MSCLK_time_exit         ;jump if 1 hour has NOT expired

        movb    MSCLK_time_mins,#0      ;reset the minutes count
        incb    MSCLK_time_hrs          ;bump hours count
        cmpb    MSCLK_time_hrs,#23
        jle     MSCLK_time_exit         ;jump if 1 day has NOT passed

        movb    MSCLK_time_hrs,#0       ;reset the hours count
        incw    MSCLK_time_days         ;bump days count

MSCLK_time_exit
;
;	NOW RESTART THE TIMER
;
	xor	cx,cx			; Tick stored in c
	mov	ax,cx			;code to latch counter
        mov     bx,#05000		;20ms delay - (0.25 MHz clock)
        out     #PIT_COM,al             ;Latch counter 0

;---------------------------------------; Timing is Now to be calculated

        in      al,#PIT_CN0             ;latched counter LSB
        mov     ah,al
        in      al,#PIT_CN0             ;latched counter MSB
	xchg	al,ah
re_tick
	add	ax,bx			; Calculate new counter contents
	inc	cx			; keep a count of loop times
	cmp	ax,bx
	jae	re_tick			; if not above then re-tick

	mov	TMR_tick,cl		; set up count for clock
	sub	ax,cx			; take away 2*tick as rough loop
	sub	ax,cx			; correction.

	sub	ax,#correction		; and a bit more

        out     #PIT_CN0,al             ;send 20ms delay to PIT
        mov     al,ah
        out     #PIT_CN0,al

;---------------------------------------; Stop timing - all done

	int	#0FFh			;do the timer int for other people
        sti                             ;all clear - reset interrupts
        ret

;
;-------------------------------------------------------------------------
        page
;--------------------------------------------------------------------------
; SH_wake_me_up - a two-word procedure called by pascal routines to request
; a wake-up, deepest word=sleeper identity, other=count (20mS intervals).
;
SH_wake_me_up
        movw    bp,sp
        movw    bx,4[bp]                ;get sleeper
        cmpw    bx,#Max_sleep           ;valid identity?
        jae     SH_wake_ex              ;no-skip
        pushf
        cli
        movb    Wake_on[bx],#1          ;set active
        shl     bx,#1                   ;form word pointer
        movw    ax,2[bp]                ;get count
        movw    Wake_count[bx],ax       ;and set up
        popf
SH_wake_ex
        ret     #4

	page
;--------------------------------------------------------------------------
;	FR_time0 & FR_time1 - dummies to get round parameter procedure
;--------------------------------------------------------------------------

FR_time0
	xor	ax,ax			;parameter = 0
	jmpsh	FR_timex		;go
FR_time1
	mov	ax,#1			;parameter = 1
FR_timex
	call	FR_time_out		;and go for it
	ret

;--------------------------------------------------------------------------
;  Dummy routine
;--------------------------------------------------------------------------

Dummy

        ret

	page
	stitle	'Clock configuration'
;---------------------------------------------------------------------------
;	CLK_Config	- handle clock reset, set and read calls
;		Enter with:
;		AX = 0FFFFH	;preloaded fail status
;		CX = Command
;		DX = data
;		or DX:SI = pointer
;		Return with AX = status
;
CLK_Config
		pushf
		cli
		mov	bx,cx			;command in cx
		cmp	bx,#0002h		;valid?
		ja	CLK_con_x		;no - abort
		shl	bx,#1			;convert to word
		jmp	[cs:CLK_CTAB][bx]	;go to routine
;
CLK_con_ok	xor	ax,ax			;return ok status
;
CLK_con_x	popf
		ret				;return status
;
CLK_CTAB	WORD	CLK_con_ini-CodebaseQQ	;0 - initialise clock
		WORD	CLK_con_set-CodebaseQQ	;1 - set time
		WORD	CLK_con_get-CodebaseQQ	;2 - get time
;

CLK_con_ini	;init
	xor ax,ax        
	movw    MSCLK_time_days,ax      ;{ reset days count }
        movw    MSCLK_time_mins,ax      ;{ and minutes, and hours }
        movw    MSCLK_time_hsec,ax      ;{ and hundredths andseconds }
        jmpsh	CLK_con_ok	
;
CLK_con_get	;get time and date - table pointed to by DX:SI
	push	es
	cld
	mov	di,si
	lea	si,MSCLK_time_days	;point at clock table
	mov	es,dx
	mov	cx,#3			;3 words to move (6 bytes)
	rep movw			;DS:SI -> ES:DI
	pop	es
	jmpsh	CLK_con_ok
;
CLK_con_set	;set time and date - table pointed to by DX:SI
	push	ds
	cld
	lea	di,MSCLK_time_days	;point at clock table
	mov	ds,dx
	mov	cx,#3			;3 words (6 bytes) to move
	rep movw			;DS:SI -> ES:DI
	pop	ds
;
;	Now we convert the clock data and send it to the keyboard
;
	mov	si,#80			;year in si
	mov	ax,MSCLK_time_days	;get days count
	mov	cx,#1461		;leap year days count
	cmpw	ax,cx			;within?
	jb	CLK_con_s1		;yes - skip
	xor	dx,dx
	div	cx			;days left in DX, leap years in ax
	shlw	ax,#1			;mult LY by 4
	shlw	ax,#1
	add	si,ax			;and add to year
	xchg	dx,ax			;days in ax
CLK_con_s1
	mov	cx,#365			;ordinary year count
	cmp	ax,cx
	jbe	CLK_con_s2		;skip if within
	sub	ax,#366
	inc	si			;bump year
	cmp	ax,cx
	jb	CLK_con_s2
	xor	dx,dx
	div	cx			;years in AX, days left in DX
	add	si,ax			;add in years
	xchg	dx,ax			;days in ax
CLK_con_s2
	inc	ax			;adjust days
	test	si,#3			;leap year?
	jnz	CLK_con_s3		;no
	cmp	ax,#60			;feb 29th?
	jb	CLK_con_s3		;below - skip
	ja	CLK_con_s4		;above - adjust days count
	movb	Smonth,#2		;say feb
	movb	Sday,#29		;the 29th
	jmpsh	CLK_con_s7		;and skip out
CLK_con_s4
	dec	ax			;adjust for after leap day
CLK_con_s3
	mov	cl,#1			;start on month 1
	mov	bx,#2			;second entry in table
CLK_con_s5	
	cmp	MSCLK_daze[bx],ax	;check against daze in month
	jae	CLK_con_s6		;got the month
	inc	cl
	inc	bx
	inc	bx
	jmpsh	CLK_con_s5		;loop till month found
CLK_con_s6
	movb	Smonth,cl		;set month
	dec	bx
	dec	bx
	sub	ax,MSCLK_daze[bx]	;and days
	movb	Sday,al			;set up
CLK_con_s7
	mov	ax,si			;get year
	test	al,#1			;
	jz	CLK_con_s8		;may be a leap
	test	al,#2
	jz	CLK_con_s10		;not the year before
	cmpb	Smonth,#2		;year before - is it after feb?
	jbe	CLK_con_s10		;no - argh!
CLK_con_s9
	addb	Sday,#40		;set the leap year bit for the keyboard
	jmpsh	CLK_con_s10		;done
CLK_con_s8
	test	al,#3			;leap year?
	jnz	CLK_con_s10		;nope
	cmpb	Smonth,#3		;and is month less than 3?
	jb	CLK_con_s9		;yes!!
CLK_con_s10
	mov	bx,#100
CLK_con_s11
	cmp	ax,bx			;get rid of hundreds
	jb	CLK_con_s12
	sub	ax,bx
	jmpsh	CLK_con_s11		;loop!
CLK_con_s12
	movb	Syear,al		;and save in Syear
	mov	al,#0E4h		;set time & date command
	call	KC_kbdq_out		;to keyboard
	mov	al,Syear		;first the year
	call	CLK_con_so		;to keyboard
	mov	al,Smonth		;then month
	call	CLK_con_so		;to keyboard
	mov	al,Sday			;then date
	call	CLK_con_so		;to keyboard
	mov	ax,MSCLK_time_days	;work out day of week
	inc	ax
	xor	dx,dx
	mov	cx,#0007		;which is days+1 mod 7
	div	cx
	mov	al,dl			;mod 7 in al
	or	al,#0F0h		;set top nibble
	call	KC_kbdq_out		;send to keyboard
	mov	al,MSCLK_time_hrs	;then hours
	call	CLK_con_so		;to keyboard
	mov	al,MSCLK_time_mins	;then mins
	call	CLK_con_so
	xor	ax,ax			;set seconds & hudredths to zero
	movw	MSCLK_time_hsec,ax
	call	CLK_con_so		;send to keyboard
	jmp	CLK_con_ok		;done
;
CLK_con_so	;send byte in al to keyboard as two BCD nibbles with top set
	mov	cl,#10			;set up 10 for division
	sub	ah,ah
	div	cl			;divide by 10 (10's in al, units in ah)
	or	ax,#0F0F0h		;set top nibbles of both
	xchg	al,ah			;units in al for second call
	push	ax			;save for later
	xchg	al,ah			;tens in al for first call
	call	KC_kbdq_out		;to the keyboard
	pop	ax			;send tens
	call	KC_kbdq_out		;then units
	ret				;done
	
;
	page
;--------------------------------------------------------------------------
;	CLK_key_in	-	Keyboard time & date collection
;			Called by keyboard handler with Clock data
;			in AL.
;--------------------------------------------------------------------------
CLK_key_in
	mov	bx,CLK_data_ip		;get buffer pointer
	movb	CLK_data_in[bx],al	;put data in buffer
	incw	bx			;bump pointer
	cmpw	bx,#13			;buffer full?
	jae	Set_clock		;Yes - set BIOS clock
	jmp	CLK_key_inx		;no - abort
Set_clock
	cld
	lea	si,CLK_data_in		;point at setup buffer
	call	Set_tran		;translate year
	mov	Syear,al		;temporary store
	call	Set_tran		;translate month
	mov	Smonth,al		;temporary store
	call	Set_tran		;translate date
	mov	Sday,al			;temporary store
	inc	si			;skip day entry
	call	Set_tran		;translate HOURS
	mov	MSCLK_time_hrs,al	;set up hours
	call	Set_tran		;translate Minutes
	mov	MSCLK_time_mins,al	;and mins
	call	Set_tran		;translate Seconds
	mov	MSCLK_time_secs,al	;set secs
	
; Now convert date month year to days since 1-1-80
;
	xor	bx,bx
	mov	ax,bx
	mov	bl,Smonth		;form index into table
	dec	bx			;adjust for 0-11
	shl	bx,#1			;form word index	
	mov	al,Sday			;get day of month
	dec	ax			;adjust for zero base
	add	ax,MSCLK_daze[bx]	;get month adjust
        testb	Syear,#3		;is year a multiple of 4?
	jnz	Set_Clock_1		;no - skip
	cmpb	Smonth,#2		;and month >2?
	jbe	Set_clock_1		;no - skip
	inc	ax			;add in leap day
Set_Clock_1
	xor	bx,bx
	mov	bl,Syear		;get year
	cmpb	bl,#80			;is year 1980?
	je	Set_Clock_4		;yes -done
	ja	Set_Clock_2		;above = 1981 - 1999
	addb	bl,#100			;adjust for 2000 +
Set_Clock_2
	sub	bl,#80			;adjust for year 1980 = 0
	mov	cx,bx			;save in cx
	shr	bx,#1
	shr	bx,#1			;get leap year count
	testb	Syear,#3		;is this a leap year?
	jz	Set_Clock_3		;yes skip odd adjust
	inc	bx			;adjust odd year
Set_Clock_3
	add	bx,ax			;and add to days count
	mov	ax,#365			;year multiplier in ax
	mul	cx			;multiply by normalised year
	add	ax,bx			;and add to days
Set_Clock_4
	mov	MSCLK_time_days,ax	;and update days count
	xor	bx,bx			;reset buffer pointer
CLK_key_inx
	movw	CLK_data_ip,bx		;update pointer	
	ret				;done

;
;	Set_Tran - conversion routine to extract two bytes from
;		table in SI, and convert low nibbles into byte in al
Set_Tran
	lodw				;get word from table
	andw	ax,#0F0Fh		;strip to bottom nibbles
	shl	al,#1			;tens *2
	add	ah,al			;add to units
	shl	al,#1
	shl	al,#1			;tens *8
	add	al,ah			;add tens *2 to units + tens *8
	ret
;
        end     ;{of module MSClock}



$ 
