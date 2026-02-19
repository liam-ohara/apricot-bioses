      ;send second frequency byte
        movb    cl,#16                  ;wait again
   $ TYPE ioqueues.asm
; [bios.apricot.rom]IOqueues.asm
        INCLUDE 'legal.asi'
;****************************************************************************
;*                                                                          *
;*		            I O Q U E U E S				    *
;*                                                                          *
;*  Old file name:                  /usr/geoff/keybd/KBqueues.asm           *
;*                                                                          *
;*  New file name:                  [bios.apricot.rom]IOqueues.asm          *
;*                                                                          *
;*  Original Programmer:            G. Kurth                                *
;*  Original implementation date:   8th April 1983                          *
;*  Language:                       Tektronix 8086/88 assembler.            *
;*  Revision history:               Re-created 11-may-1983                  *
;*                                                                          *
;*  Adopted for apricot:             21ST March 1984                        *
;*  Programmer:                     Vince CORBIN / G. Kurth                 *
;*  Status:                         Temporary                               *
;*                                  VAX version 2/5/84 GK                   *
;*				Queues for both KBD and AUX 15/5/84 GK	    *
;*				rom version 25/5/84 GK			    *
;*				XON handler, 26/6/84  RJW.		    *
;*				Keyboard output queue GK 1/8/84		    *
;*				XON/XOFF hysteresis, 13/11/84 RJW	    *
;*				Soft DTR DSR protocol 31/1/85 GK	    *
;*                                                                          *
;****************************************************************************
        page
        title   'AUX & KBD Queue routines'
        stitle  'module initialisation'
;
        NAME    IO_queues
;
        GLOBAL  databaseqq                      ;global data segment
        GLOBAL  codebaseqq                      ;global code segment
;
        ASSUME  DS:databaseqq, SS:databaseqq, CS:codebaseqq

        INCLUDE 'ioregs.asi'
	INCLUDE 'copyregs.asi'

        ;General equates

SERKBD		EQU	0		;SET TO 0 IF WE DO NOT SUPPORT SERIAL KEYBOARD

txqmax          equ     512             ;default length of transmit queue
rxqmax          equ     512             ;default length of receive queue
prnqmax		equ	2048		;default length of printer queue
kbdqmax		equ	80		;length of keyboard queue
kbdoqmax	equ	100		;length of keyboard output queue

        ;Global definitions - data

        GLOBAL  AUX_rxqueue             ;Recieve data queue
        GLOBAL  AUX_rxq_max
        GLOBAL  AUX_rxq_count
        GLOBAL  AUX_rxq_ipt
        GLOBAL  AUX_rxq_opt
        
        GLOBAL  AUX_txqueue             ;transmit data queue
        GLOBAL  AUX_txq_max
        GLOBAL  AUX_txq_count
        GLOBAL  AUX_txq_ipt
        GLOBAL  AUX_txq_opt

	Global	AUX_errors
        
	GLOBAL	KBD_queue		;Keyboard queue
	GLOBAL	KBD_q_count
	GLOBAL	KBD_q_ipt
	GLOBAL	KBD_q_opt

	GLOBAL	KBD_oqueue		;Keyboard output queue
	GLOBAL	KBD_oq_count
	GLOBAL	KBD_oq_ipt
	GLOBAL	KBD_oq_opt

	GLOBAL	RX_xon_xoff_flag	;imported from SIOINT
	GLOBAL	AUX_tx_interrupt	;imported from SIOINT
	GLOBAL  xon_xoff_request	;1=xoff request, 2=xon request

	GLOBAL	CNF_rx_xonxoff		;imported variables from config table
	GLOBAL	CNF_RX_X_limit		;
	GLOBAL	CNF_xon_char		;
	GLOBAL	CNF_dtr_dsr
	GLOBAL	CNF_lst_dev

	GLOBAL	KD_trans_off		;keyboard transmit disable flag

        GLOBAL  PRN_queue               ;printer output queue

        ;Global definitions - code
        
        GLOBAL  AUX_qinit               ;AUX device queue initialisation
        GLOBAL  AUX_rxq_put             ;recieve queue filler
        GLOBAL  AUX_rxq_check           ;recieve queue checker
        GLOBAL  AUX_rxq_get             ;recieve queue emptier
        GLOBAL  AUX_txq_put             ;transmit queue filler
        GLOBAL  AUX_transmit            ;transmit queu emptier

	GLOBAL	KBD_oqflush		;keyboard output queue flush
	GLOBAL	KBD_qinit		;Keyboard queue initialisation
	GLOBAL	KBD_q_out		;keyboard queue filler
	GLOBAL	KBD_q_get		;keyboard queue emptier

	GLOBAL	KC_kbdq_out		;keyboard output queue filler
	GLOBAL	KC_transmit		;keyboard output queue emptier
        
	GLOBAL	XON_handler		;exported, entered on rx queue flush
        GLOBAL  KC_bell, SCREEN_ACTIVE
;
        page
        stitle  'KBD & AUX Queue data'
        
;
        SECTION IOqueues.data, ALIGN(2), CLASS = DataQQ
;
;       Recieve Queue
AUX_rxq_max     BLOCK   2       ;Maximum queue length
AUX_rxq_count   BLOCK   2       ;Queue count
AUX_rxq_ipt     BLOCK   2       ;Input pointer
AUX_rxq_opt     BLOCK   2       ;Output pointer
;       Transmit Queue
AUX_txq_max     BLOCK   2       ;Maximum queue length
AUX_txq_count   BLOCK   2       ;Queue count
AUX_txq_ipt     BLOCK   2       ;Input pointer
AUX_txq_opt     BLOCK   2       ;Output pointer
;	Keyboard Queue
KBD_q_count	BLOCK	2	;Queue count
KBD_q_ipt	BLOCK	2	;Input pointer
KBD_q_opt	BLOCK	2	;Output pointer
;	Keyboard Output Queue
KBD_oq_count	BLOCK	2	;Queue count
KBD_oq_ipt	BLOCK	2	;Input pointer
KBD_oq_opt	BLOCK	2	;Output pointer
;
;	Buffers
AUX_txqueue     BLOCK   512     ;transmit data queue
PRN_queue       BLOCK   2048    ;Printer output queue
AUX_rxqueue     BLOCK   512     ;Recieve data queue
KBD_queue	BLOCK	80	;Keyboard queue
KBD_oqueue	BLOCK	100	;Keyboard output queue
;
        page
        stitle  'AUX queue initialisation'
;
;
        SECTION IOqueues.code, ALIGN(1), CLASS = INSTRQQ
;
;       AUX_qinit       -       Initialises the transmit & Recieve queues
;
;       CALLED BY:      AUX device initialisation
;       INPUTS:         None
;       OUTPUTS:        None
;       USES:           AX
;
AUX_qinit       pushf                   ;stop other people messing
                cli
                xorw    ax,ax
                movw    AUX_rxq_count,ax
                movw    AUX_rxq_ipt,ax
                movw    AUX_rxq_opt,ax
                movw    AUX_txq_count,ax
                movw    AUX_txq_ipt,ax
                movw    AUX_txq_opt,ax
                movw    AUX_txq_max,#txqmax
                movw    AUX_rxq_max,#rxqmax
		cmpb	CNF_lst_dev,#1		;serial print device?
		jne	not_ser
		addw	AUX_txq_max,#prnqmax	;yes - add on printer queue
not_ser
                popf
                ret
;
        page
        stitle  'AUX Receive queue filler'
;
;
;       AUX_rxq_put     -       Sends bytes of data to the AUX receive data
;                       queue.
;                       If space is not available in queue then data is lost
;                       and error status is returned in AL
;
;       CALLED BY:      SIO receive data interrupt routine.
;
;       INPUTS:         Single word entry on stack
;                       Low byte = Received Character
;
;       OUTPUTS:        AL = 0 - space is/was available for the character
;                       AL <>0 - no - space for character - rejected
;
;       CALLS:          KC_bell
;
;       USES:           AX, BX, + called routines
;
;
AUX_rxq_put     movw    bp,sp                   ;point into stack with bp

	IF SERKBD = 1
				; TEMPORARY SERIAL KEYBOARD SUPPORT
		MOV	AL,#1
		JMP	KBD_Q_XXX
	ENDIF
                movw    ax,2[bp]                ;get data
                movw    bx,AUX_rxq_count        ;get current queue count
                cmpw    bx,AUX_rxq_max          ;is queue full?
                jae     AUX_rxq_pf              ;yes - abort
                pushf                           ;save interrupt state
                cli                             ;disable interrupts
                movw    bx,AUX_rxq_ipt          ;get the queue input pointer
                movb    AUX_rxqueue[bx],al      ;put character in buffer
                incw    bx                      ;bump pointer
                cmpw    bx,AUX_rxq_max          ;loop round?
                jb      AUX_rxq_p1              ;no - skip
                xorw    bx,bx                   ;reset pointer
AUX_rxq_p1      movw    AUX_rxq_ipt,bx          ;update pointer
                incw    AUX_rxq_count           ;bump count
                popf                            ;restore int status
                xorw    ax,ax                   ;return ok result
                jmpsh   AUX_rxq_px              ;and exit
;
AUX_rxq_pf	orb	AUX_errors,#20H		;set overrun bit
		call    KC_bell                 ;sound the alarm
                movb    al,#0FFH                ;set up fail
;
AUX_rxq_px      ret     #2
;
;
        page
        stitle  'AUX Receive  Queue Input - check'
;
;       AUX_rxq_check   -       Subroutine which returns the next character
;                       in the MS-DOS queue, but does not update pointers.
;                       (Queue look-ahead).
;
;       CALLED BY:      MS-DOS Non-destructive read routine
;       INPUTS:         none
;       OUTPUTS:        character in AL.
;       USES:           AX, BX
;       CALLS:          none
;
AUX_rxq_check   xorw    ax,ax                   ;clear accumulator
                cmpw    AUX_rxq_count,ax        ;character count 0?
                jz      AUX_rxq_ch1             ;yes - skip input
                movw    bx,AUX_rxq_opt          ;get queue output pointer
                movb    al,AUX_rxqueue[bx]      ;get character from queue
AUX_rxq_ch1     ret                             ;and return character
;
        page
        stitle  'AUX Receive queue emptier'
;
;       AUX_rxq_get     -       Reads one character from the AUX receive
;                       buffer and returns it in AL.
;                       Waits for character if there is not one available.
;
;       CALLED BY:      MS-DOS character read
;       INPUTS:         none
;       OUTPUTS:        AL = character.
;       USES:           AX, BX
;       CALLS:          none
;
AUX_rxq_get     pushf                           ;save interrupt status
                sti                             ;enable interrupts
AUX_rxq_g1      cmpw    AUX_rxq_count,#0        ;characters in buffer?
                jz      AUX_rxq_g1              ;no - loop until available
                cli                             ;disable interrupts
		xor	ax,ax
                movw    bx,AUX_rxq_opt          ;get queue output pointer
                movb    al,AUX_rxqueue[bx]      ;get character from queue
                incw    bx                      ;bump pointer
                cmpw    bx,AUX_rxq_max          ;loop round?
                jb      AUX_rxq_g2              ;no leave as is
                xorw    bx,bx                   ;reset pointer to zero
AUX_rxq_g2      movw    AUX_rxq_opt,bx          ;update pointer
                decw    AUX_rxq_count           ;and count down

		push	ax			;save the character
		call	XON_handler		;transmit XON if needed
		pop	ax			;restore the character in al

                popf                            ;restore interrupt flag
                ret

     page
        stitle  'AUX  XON-handler'
;
;       XON_handler  -  Requests transmission XON character if an XOFF
;		        character has been transmitted and there is now room 
;			in the receive buffer.
;			OR sets DTR on if Software DTR DSR protocol on
;			and buffer has room.
;	ASSUMES CALLED WITH INTERRUPTS DISABLED
;
;       CALLED BY:      AUX_rxq_get (above), And Receive Buffer Flush
;       INPUTS:         none
;       OUTPUTS:        none
;       USES:           AX, BX
;       CALLS:          none
;


XON_handler


;IF XON/XOFF PROTOCOL (CONTROLLING RX) SWITCHED OFF: SKIP XON CHECK
	cmpb	CNF_rx_xonxoff,#0	;receiver xon/xoff protocol disabled ?
	je	skip_xon		;yes, jump

	
;IF AN XOFF CHARACTER HAS NOT BEEN TRANSMITTED: SKIP XON CHECK
	cmpb	RX_xon_xoff_flag,#0	;xoff been transmitted ?
	je	skip_xon		;no, jump

	
;IF BUFFER STILL FULL: SKIP TRANSMISSION REQUEST OF XON
	mov	ax,AUX_rxq_max		;calculate number of characters...
	sub	ax,CNF_Rx_X_limit	;...received before xoff necessary
	sub	ax,#20			;hysteresis 20 chars added (13/12/84)

	cmp	ax,#1			;limit valid (>0) ?
	jge	rx_limit_ok		;yes, jump
	mov	ax,#1			;no, set to minimum value
rx_limit_ok

	cmp	AUX_rxq_count,ax	;still near end of buffer ?
	jae	skip_xon		;yes, jump


;IF XOFF REQUEST IS PENDING CANCEL IT INSTEAD OF TRANSMITTING XON
	cmpb	xon_xoff_request,#1	;waiting for tx of an xoff ?
	jne	skip_cancel		;no, jump
	movw	xon_xoff_request,#0	;cancel xoff request
	jmp	done_xon		;no need to request xon
skip_cancel


;REQUEST TRANSMISSION OF XON
	movw	xon_xoff_request,#2	;request xon chararcter


;TRANSMIT THE XON CHARACTER NOW IF TX BUFFER IS EMPTY
	call	AUX_tx_interrupt	;transmit the XOFF if buffer empty	
done_xon


;FLAG THAT XON HAS BEEN TRANSMITTED
	movb	RX_xon_xoff_flag,#0	;flag that xon transmitted
skip_xon

;ARE WE RUNNING SOFTWARE DTR DSR PROTOCOL?
	cmpb	CNF_dtr_dsr,#1		;soft DTR DSR protocol set?
	jne	skip_dtr		;nope
	testb	COPY_SIO_W5A,#080h	;is DTR already on?
	jnz	skip_dtr		;yes - skip
	
;IF BUFFER STILL FULL: SKIP SETTING OF DTR
	mov	ax,AUX_rxq_max		;calculate number of characters...
	sub	ax,CNF_Rx_X_limit	;...received before xoff necessary
	sub	ax,#20			;hysteresis 20 chars added (13/12/84)

	cmp	ax,#1			;limit valid (>0) ?
	jge	drx_limit_ok		;yes, jump
	mov	ax,#1			;no, set to minimum value
drx_limit_ok

	cmp	AUX_rxq_count,ax	;still near end of buffer ?
	jae	skip_dtr		;yes, jump
	
;BUFFER IS A LITTLE EMPTIER SO SET DTR ON
	orb	COPY_SIO_W5A,#080H	;set DTR in copy
	mov	al,#5			;talk to sio register 5
	out	#SIO_A_COM,al
	mov	al,COPY_SIO_W5A
	out	#SIO_A_COM,al		;done!

skip_dtr

	ret				;RETURN


        page
        stitle  'AUX transmit queue filler'
;
;       AUX_txq_put     -       Sends bytes of data to the SIO AUX
;                       transmit queue. (data from MS-DOS to AUX).
;                       if there is no room in the queue then the character
;                       is ignored (for the present)
;
;       INPUTS:         Single word entry on stack
;                       Low byte = Character to be sent
;       OUTPUTS:        AL = Error flag (0FFh=error)
;
;       CALLS:          AUX_tx_interrupt
;
;       USES:           AX, BX, BP + called routines
;
AUX_txq_put     movw    bx,AUX_txq_count        ;get queue count
                cmpw    bx,AUX_txq_max          ;buffer full?
                jae     AUX_txq_px              ;yes - abort
                movw    bp,sp                   ;point into stack with bp
                movw    ax,2[bp]                ;get data to be sent
                pushf                           ;save interrupt status
                cli                             ;disable interrupts
                movw    bx,AUX_txq_ipt          ;get the queue input pointer
                movb    AUX_txqueue[bx],al      ;put character in buffer
                incw    bx                      ;bump pointer
                cmpw    bx,AUX_txq_max          ;loop round?
                jb      AUX_txq_p1              ;no - skip
                xorw    bx,bx                   ;reset pointer
AUX_txq_p1      movw    AUX_txq_ipt,bx          ;update pointer
                incw    AUX_txq_count           ;bump count
                call    AUX_tx_interrupt        ;try to transmit char
                xorw    ax,ax                   ;Load success flag
                popf                            ;restore interrupt status
                jmpsh   AUX_txq_pe              ;skip error
AUX_txq_px      movb    al,#0FFh                ;Load abort flag
AUX_txq_pe
                ret     #2

        page
        stitle  'AUX transmit routine'
;
;       AUX_transmit    -       Called by SIO transmitter buffer
;                       empty routine 
;                       And the transmit buffer filler AUX_txq_put.
;                       If queue has no characters - returns.
;                       otherwise sends next queue character to
;                       SIO.
;
;       INPUTS:         none (characters pulled from queue)
;       OUTPUTS:        (characters sent to sio) al=character sent
;       CALLS:          none
;                       
;       USES:           AX, BX,
;
;
AUX_transmit    cmpw    AUX_txq_count,#0        ;Any characters in the buffer?
                jz      AUX_trans_end           ;nope - exit
                pushf                           ;save interrupt status
                cli                             ;disable interrupts
                movw    bx,AUX_txq_opt          ;load pointer
                mov     al,#0                   ;set SIO for read of register 0
                out     #SIO_A_COM,al
                in      al,#SIO_A_STAT          ;get details from register 0
                and     al,#04                  ;extract Tx buffer empty flag
                jz      AUX_trans_ex            ;if Tx buffer full - give up
                movb    al,AUX_txqueue[bx]      ;get next queue character in al
                out     #SIO_A_DAT,al           ;transmit the data
                incw    bx                      ;bump output pointer
                cmpw    bx,AUX_txq_max          ;loop round?
                jb      AUX_trans_1             ;no - skip
                xorw    bx,bx                   ;zero pointer
AUX_trans_1     movw    AUX_txq_opt,bx          ;update pointer
                decw    AUX_txq_count           ;decrement queue count
;
AUX_trans_ex    popf                            ;restore interrupt status
AUX_trans_end   ret                             ;RETURN  --- char still in al
;
;
	page
	stitle	'KBD queue initialisation'

;       KBD_qinit       -       Initialises the keyboard queue
;
;       CALLED BY:      CON device initialisation
;       INPUTS:         None
;       OUTPUTS:        None
;       USES:           AX
;
KBD_qinit       pushf                   ;stop other people messing
                cli
                xorw    ax,ax
                movw    KBD_q_count,ax
                movw    KBD_q_ipt,ax
                movw    KBD_q_opt,ax
KBD_qinit1
                movw    KBD_oq_count,ax
                movw    KBD_oq_ipt,ax
                movw    KBD_oq_opt,ax
                popf
                ret
;
;
;       KBD_oqflush       -       Initialises the keyboard output queue
;
;       CALLED BY:      calc init/deinit
;       INPUTS:         None
;       OUTPUTS:        None
;       USES:           AX
;
KBD_oqflush	pushf                   ;stop other people messing
                cli
                xorw    ax,ax
		jmpsh	KBD_qinit1
;
        page
        stitle  'KBD queue filler'
;
;
;       KBD_q_out     -       Sends bytes of data to the KBD receive data
;                       queue.
;			Data is passed through INT 0FAH in AX & BX,
;			If AX=0 on return data should be ignored,
;			Else converted data in BX should be used.
;                       If space is not available in queue then data is lost
;                       and error status is returned in AL
;
;       CALLED BY:      KBDhandler recieve interrupt routine.
;
;       INPUTS:         Single word entry on stack
;                       Low byte = Received Character
;			high byte = count of characters
;
;       OUTPUTS:        AL = 0 - space is/was available for the character
;                       AL <>0 - no - space for character - rejected
;
;       CALLS:          KC_bell
;
;       USES:           AX, BX, + called routines
;

KBD_q_out	movw    bp,sp                   ;point into stack with bp
                movb    al,3[bp]                ;get count
KBD_Q_XXX	cbw
                add	ax,KBD_q_count		;add to queue count
		cmpw    ax,#kbdqmax		;is queue full?
                jae     KBD_q_of		;yes - abort
                mov	ax,2[bp]		;get data in al
		mov	bx,ax			;copy into BX
		int	#0F9h			;do keyboard int
		and	ax,ax			;shouldd we drop the data?
		jz	KBD_q_ox		;yes
		mov	ax,bx			;get (possibly) converted data
		pushf                           ;save interrupt state
                cli                             ;disable interrupts
                movw    bx,KBD_q_ipt		;get the queue input pointer
                movb    KBD_queue[bx],al	;put character in buffer
                incw    bx                      ;bump pointer
                cmpw    bx,#kbdqmax		;loop round?
                jb      KBD_q_o1		;no - skip
                xorw    bx,bx                   ;reset pointer
KBD_q_o1	movw    KBD_q_ipt,bx		;update pointer
                incw    KBD_q_count		;bump count
                popf                            ;restore int status
                xorw    ax,ax                   ;return ok result
                jmpsh   KBD_q_ox		;and exit
;
KBD_q_of	call    KC_bell                 ;sound the alarm
                movw    ax,#0FFFFH              ;set up fail
;
KBD_q_ox	ret     #2
;

;
;
        page
        stitle  'KBD Recieve queue emptier'
;
;       KBD_q_get     -       Reads one character from the KBD recieve
;                       buffer and returns it in AL.
;                       Waits for character if there is not one available.
;
;       CALLED BY:      MS-DOS character read
;       INPUTS:         none
;       OUTPUTS:        AL = character.
;       USES:           AX, BX
;       CALLS:          none
;
KBD_q_get	pushf                           ;save interrupt status
                sti                             ;enable interrupts
KBD_q_g1	cmpw    KBD_q_count,#0		;characters in buffer?
                jz      KBD_q_g1		;no - loop until available
                cli                             ;disable interrupts
		xor	ax,ax			;clear ah for char in al
                movw    bx,KBD_q_opt		;get queue output pointer
                movb    al,KBD_queue[bx]	;get character from queue
                incw    bx                      ;bump pointer
                cmpw    bx,#kbdqmax		;loop round?
                jb      KBD_q_g2		;no leave as is
                xorw    bx,bx                   ;reset pointer to zero
KBD_q_g2	movw    KBD_q_opt,bx		;update pointer
                decw    KBD_q_count		;and count down
                popf                            ;restore interrupt flag
                ret
        ;

        page
        stitle  'KBD output queue filler'
;
;
;       KC_kbdq_out     -       Sends bytes of data to the KBD transmit data
;                       queue.
;			If space is not available in queue then data is lost
;
;       CALLED BY:      KBDhandler/MSCRNhandler/clock/led control routines.
;
;       INPUTS:         Single character in AL
;
;       OUTPUTS:        none
;
;       CALLS:          KC_transmit
;
;       USES:           AX, BX, + called routines
;

KC_kbdq_out	cmpw	KBD_oq_count,#kbdoqmax	;buffer full
		jae	KC_kbdq_ox		;yes - abort
		pushf				;we want to be alone
		cli
		movw    bx,KBD_oq_ipt		;get the queue input pointer
                movb    KBD_oqueue[bx],al	;put character in buffer
                incw    bx                      ;bump pointer
                cmpw    bx,#kbdoqmax		;loop round?
                jb      KC_kbdq_o1		;no - skip
                xorw    bx,bx                   ;reset pointer
KC_kbdq_o1	movw    KBD_oq_ipt,bx		;update pointer
                incw    KBD_oq_count		;bump count
		call	KC_transmit		;try to transmit
		popf
;
; THIS IS A FUDGE FOR NASTY PROBLEM IN KEYBOARD
; DELAY AFTER TRANSMISSION OF CERTAIN CODES
;
		cmp	al,#0E2h		;DISPLAY TIME?
		je	KC_kbdq_owt		;yes
		cmp	al,#0D0h		;CLEAR SCREEN?
		je	KC_kbdq_owt
		jmpsh	KC_kbdq_ox		;no wait

KC_kbdq_owt
		mov	ax,#60			;approx 10ms wait
KC_kbdq_owt1
		mov	cl,#200
		shl	cx,cl
		dec	ax
		jnz	KC_kbdq_owt1

; END OF FUDGE
;

KC_kbdq_ox	ret
;

;
;
        page
        stitle  'KBD Transmit queue emptier'
;
;       KC_transmit     -       Reads one character from the KBD transmit
;                       buffer and sends it to the SIO.
;			If queue emptyor transmit disabled -  aborts.
;                       Waits for character if there is not one available.
;
;       CALLED BY:      Keyboard transmit queue filler & SIO interrupt
;       INPUTS:         none, ASSUMES INTERRUPTS DISABLED
;       OUTPUTS:        queue character sent to SIO (also returned in al)
;       USES:           AX, BX
;       CALLS:          none
;
KC_transmit
	xor	ax,ax
	cmp	KBD_oq_count,ax		;queue empty?
	jz	KC_trans_end		;yes - abort
	cmp	KD_trans_off,al		;transmit disabled?
	jnz	KC_trans_end		;yes - abort
	in	al,#SIO_B_STAT		;get SIO status
	test	al,#4			;Tx empty?
	jz	KC_trans_end		;no - abort
	mov	bx,KBD_oq_opt		;get output pointer
	mov	al,KBD_oqueue[bx]	;get character
	out	#SIO_B_DAT,al		;transmit it
	inc	bx			;bump pointer
	cmp	bx,#kbdoqmax		;loop round
	jb	KC_trans_1		;no - skip
	xor	bx,bx			;reset pointer
KC_trans_1
	mov	KBD_oq_opt,bx		;update output pointer
	decw	KBD_oq_count		;decrement queue count
	ret

KC_trans_end
	xor	ax,ax			;nothing sent
	ret				;done
        ;

;
                end

;

$ 