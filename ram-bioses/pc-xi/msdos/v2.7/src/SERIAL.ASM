 Section 7 - General            (offset 70H)
;
CNF_dummy_sec	WORD	0		;no dummy size
CNF_signon	BYTE	0		;sign-on on $ TYPE serial.asm
; [bios.apricot.rom] serial.asm
        title '[bios.apricot.rom]serial.asm'



        Include 'legal.asi'



;***************************************************************************
;*                                                                         *
;*                           S E R I A L                                   *
;*                                                                         *
;*              ROM BIOS interface for the AUX device.                     *
;*                                                                         *
;*      PROGRAMMER:     R. J. WOOLCOCK.                                    *
;*      IMPLEMENTED:    10-MAY-84                                          *
;*      MODIFIED:                                                          *
;*		* Extensions to provide comprehensive interface to	   *
;*	            the ROM BIOS. 31/5/84 RJW.				   *
;*		* Support for serial mouse, 12/6/84, RJW.		   *
;*		* Variable queue length,    19/6/84, RJW.		   *
;*		* Apricot version,          09/8/84, GK.		   *
;*		* Auto enables bit set/reset immediately. 31/8/84	   *
;*		* Calls to return number of chars in rx & tx queues	   *
;*		    Call 1F waits until all chars in buffer.5/10/84  RJW.  *
;*		* BIOS 2.4 COMPATIBLE VERSION 19/10/84 GK		   *
;*		* XOFF received flag cleared on calls 3 & A 12/11/84 RJW   *
;*		* Soft DTR DSR protocol 31/1/85 GK			   *
;*		* notice of serial error report 5/2/85 GK		   *
;*		* Ext/stat ints enabled for extrn SIO control 17/4/85 GK   *
;*                                                                         *
;***************************************************************************
  page
        name serial

        Include 'ioregs.asi'
        Include 'copyregs.asi'



;***************************   D A T A   A R E A   **************************

        Section serial.data,align(2),class=dataQQ

;CONFIGURATION CONSTANTS - bytes - (external variables defined in CONTAB)
        GLOBAL  CNF_Tx_brate            ;30H    Tx baud rate
                                                ;1=50, 2=75, 3=110, 4=134.5, 5=150, 6=300
                                                ;7=600, 8=1200, 9=1800, 10=2400, 11=3600
                                                ;12=4800, 13=7200, 13=7200, 14=9600, 15=19200
        GLOBAL  CNF_Rx_brate            ;31H    Rx baud rate (as above)
        GLOBAL  CNF_Tx_bits             ;32H    Transmit bits per char (5 - 8)
        GLOBAL  CNF_Rx_bits             ;33H    Receive bits per char (5 - 8)
        GLOBAL  CNF_stop_bits           ;34H    stop bits (1=1, 2=1.5, 3=2)
        GLOBAL  CNF_parity_chk          ;35H    Receive parity check (0=off, 1=on)
        GLOBAL  CNF_parity_typ          ;36H    parity type
                                                ;(0=none, 1=odd, 2=even, 3=mark, 4=space)
        GLOBAL  CNF_Tx_xonxoff          ;37H    Transmit xon/xoff protocol (0=off, 1=on)
        GLOBAL  CNF_Rx_xonxoff          ;38H    Receive xon/xoff protocol (0=off, 1=on)
        GLOBAL  CNF_xon_char            ;39H    XON character code
        GLOBAL  CNF_xoff_char           ;3AH    XOFF character code
        GLOBAL  CNF_Rx_X_limit          ;3BH    XON/XOFF receive buffer limit
        GLOBAL  CNF_dtr_dsr             ;3DH    DTR/DSR protocol (0=off, 1=on)
        GLOBAL  CNF_cts_rts             ;3EH    CTS/RTS protocol (0=off, 1=on)
        GLOBAL  CNF_CR_null             ;3FH    number of nulls to send after CR (0-255)
        GLOBAL  CNF_FF_null             ;40H    nulls * 10 to send after FF (0-255)
        GLOBAL  CNF_s_cr_lf             ;41H    insert LF after CR
	GLOBAL	CNF_s_bioserr		;42H	error return enable

;OTHER EXTERNAL VARIABLES - words
        GLOBAL  AUX_fill_cnt            ;current null count (module SIO_INT)
	GLOBAL	xon_xoff_request	;1=send xoff request, 2=send xon

        GLOBAL  AUX_rxq_count           ;no. of chars available in read queue
        GLOBAL  AUX_rxq_ipt		;receive buffer input pointer
        GLOBAL  AUX_rxq_opt		;receive queue output pointer
	GLOBAL	AUX_rxq_max		;receiver queue length
        GLOBAL  AUX_txq_count           ;no. of chars available in tx queue
        GLOBAL  AUX_txq_ipt		;transmitter buffer input pointer
        GLOBAL  AUX_txq_opt		;transmitter queue output pointer
	GLOBAL	AUX_txq_max		;transmitter queue length

;OTHER EXTERNAL VARIABLES - bytes
	GLOBAL	aux_CR_detect		;request for auto linefeed
	GLOBAL	TX_xon_xoff_flag	;xoff received (switch off tx)
	GLOBAL	RX_xon_xoff_flag	;xoff sent (rx buffer full)

;OTHER INTERNAL VARIABLES - bytes
	GLOBAL	AUX_ext_on		;ext handling of SIO interrupt, flag
	GLOBAL	serial_mouse		;serial mouse enabled
	GLOBAL	aux_errors		;latched parity/frame/overrun errors


;LOCAL VARIABLES
str_ptr		block	4		;DWORD string pointer
count		block   2		;string count
call_tab_ptr	Block	4		;temporary table pointer store

AUX_ext_on	Block	1		;External SIO handling flag
AUX_errors	Block	1		;Received data error store
serial_mouse	Block	1		;serial mouse enabled


;**********************   P R O G R A M    A R E A   ************************


        Section  serial.instr,align(1),class=instrQQ
        Global   CodeBaseQQ,DataBaseQQ  ;set during link

        Assume ds:DataBaseQQ, cs:CodeBaseQQ


;EXPORTED ADDRESSES
        Global  AUX_config              ;entry address for this module
	Global	SER_init		;aux device software initialisation


;EXTERNAL SUBROUTINE ADDRESSES
        Global  AUX_txq_put             ;put character in tx queue
        Global  AUX_rxq_check           ;examine next char in rx queue
        Global  AUX_rxq_get             ;get next char from rx queue
        Global  auxset	                ;set up side-A of SIO
	Global	AUX_qinit		;initialisation of aux buffers
	Global	XON_handler		;entered for rx queue flush
   page
	stitle	'SUBROUTINE:  SER_init'
;**************************************************************************
;**********************   SUBROUTINE    SER_init   ************************
;**************************************************************************
;
;  Subroutine to initialise the software of the auxiliary device.
;  Called at restart by bios module, and by ROM BIOS call <0>.
;
;  On Entry:
;	nil
;
;--------------------------------------------------------------------------

SER_init


;INITIALISE THE AUX QUEUES
	call	AUX_qinit		;initialise queues


;CLEAR REGISTERS
	xor	ax,ax			;store zero in aux registers
 
	movw	AUX_fill_cnt,ax		;no nulls to be transmitted
	movw	xon_xoff_request,ax	;no xon or xoff chars to send

	movb	aux_errors,al		;no parity, overrun or framing errors
	movb	AUX_CR_detect,al	;no auto linefeed to send
	movb	TX_xon_xoff_flag,al	;xoff not received
	movb	RX_xon_xoff_flag,al	;xoff not sent
	movb	serial_mouse,al		;disable serial mouse
	movb    AUX_ext_on,al		;aux interrupt not external


	ret				;RETURN
   page
	stitle	'SUBROUTINE: AUX_config'
;**************************************************************************
;**********************   SUBROUTINE    AUX_config   **********************
;**************************************************************************
;
;  Subroutine to configure the auxiliary device.
;
;  On Entry:
; 	  cx = command	
;	  dx = data
;  or, dx:si = pointer to table of data
;
;  On Exit:
;	  ax = status/returned data
;
;--------------------------------------------------------------------------

AUX_config


;SAVE INTERRUPT STATUS (SOME FUNCTIONS DISABLE INTERRUPTS)
        pushf                           ;save interrupt status


;IF THE FUNCTION NUMBER IS INVALID: EXIT
	mov	bx,cx			;get function in bx
        cmp     bx,#max_func            ;illegal function ?
        ja      EXIT_FAIL               ;yes, jmp


;MOVE THE DATA INTO CX (AS WELL AS DX)
	mov	cx,dx			;data in dx and cx, or at dx:si


;ENTER REQUIRED ROUTINE VIA JUMP TABLE
        shl     bx,#1                   ; x 2 for words
        jmp     [cs:JUMP_TABLE][bx]     ;enter the routine


;EXIT THE SUBROUTINE WITHOUT AN ERROR
EXIT_GOOD
        popf                            ;restore interrupts
        xor     ax,ax                   ;return ax = 0 (no error)
        ret    	 	                ;RETURN 


;EXIT THE SUBROUTINE WITH AN ERROR
EXIT_FAIL
        popf                            ;restore interrupts
        mov     ax,#0FFFFh              ;return ax set to indicate failure
        ret                             ;RETURN 


;EXIT WITH DATA/STATUS IN AL
EXIT_WITH_AL
        popf                            ;restore interrupts
        xor     ah,ah                   ;clear ah
        ret                             ;RETURN 


;EXIT WITH DATA/STATUS IN AX
EXIT_WITH_AX
        popf                            ;restore interrupts
        ret                             ;RETURN 


;*************************   JUMP  TABLE   *************************
;     The length of the table is given by the equate `max_func'.    
JUMP_TABLE
        word    AUX_FUNC_0 - CodeBaseQQ ;return status
        word    AUX_FUNC_1 - CodeBaseQQ ;transmit character
        word    AUX_FUNC_2 - CodeBaseQQ ;receive character
        word    AUX_FUNC_3 - CodeBaseQQ ;update SIO settings
        word    AUX_FUNC_4 - CodeBaseQQ ;get/set tx baud rate (1-15)
        word    AUX_FUNC_5 - CodeBaseQQ ;get/set rx baud rate (1-15)
        word    AUX_FUNC_6 - CodeBaseQQ ;get/set tx bits per char (5-8)
        word    AUX_FUNC_7 - CodeBaseQQ ;get/set rx bits per char (5-8)
        word    AUX_FUNC_8 - CodeBaseQQ ;get/set stop bits per char (1-3)
        word    AUX_FUNC_9 - CodeBaseQQ ;get/set parity (0-2)
        word    AUX_FUNC_A - CodeBaseQQ ;get/set tx XON/XOFF protocol
        word    AUX_FUNC_B - CodeBaseQQ ;get/set rx XON/XOFF protocol
        word    AUX_FUNC_C - CodeBaseQQ ;get/change RTS line
        word    AUX_FUNC_D - CodeBaseQQ ;get/change DTR line
        word    AUX_FUNC_E - CodeBaseQQ ;get/change tx enable
        word    AUX_FUNC_F - CodeBaseQQ ;get/change rx enable
        word    AUX_FUNC_10- CodeBaseQQ ;get CTS line status
        word    AUX_FUNC_11- CodeBaseQQ ;get DCD line status
        word    AUX_FUNC_12- CodeBaseQQ ;get DSR line status
        word    AUX_FUNC_13- CodeBaseQQ ;set/reset nulls after CR
        word    AUX_FUNC_14- CodeBaseQQ ;set/reset nulls after FF
        word    AUX_FUNC_15- CodeBaseQQ ;set/reset auto LF after CR
        word    AUX_FUNC_16- CodeBaseQQ ;enable external serial mouse handler
        word    AUX_FUNC_17- CodeBaseQQ ;disenable ext. serial mouse handler
        word    AUX_FUNC_18- CodeBaseQQ ;set/reset RTS/CTS protocol
        word    AUX_FUNC_19- CodeBaseQQ ;set/reset DTR/DSR protocol
        word    AUX_FUNC_1A- CodeBaseQQ ;set/reset external SIO control
        word    AUX_FUNC_1B- CodeBaseQQ ;non-destructive read of next char
        word    AUX_FUNC_1C- CodeBaseQQ ;flush transmitter buffer
        word    AUX_FUNC_1D- CodeBaseQQ ;flush receive buffer
        word    AUX_FUNC_1E- CodeBaseQQ ;get and clear receive error status
        word    AUX_FUNC_1F- CodeBaseQQ ;transmit string
        word    AUX_FUNC_20- CodeBaseQQ ;receive string
        word    AUX_FUNC_21- CodeBaseQQ ;set/get receive queue length
        word    AUX_FUNC_22- CodeBaseQQ ;set/get transmitter queue length
        word    AUX_FUNC_23- CodeBaseQQ ;get number of chars in rx queue
        word    AUX_FUNC_24- CodeBaseQQ ;get number of chars in tx queue
			

;MAXIMUM FUNCTION NUMBER !!
max_func        equ    	 24h            ;maximum function number

  page
;*****************************   AUX_FUNC_0   *****************************
;-------------------------  Initialise AUX Driver  ------------------------

AUX_FUNC_0


;INITIALISE THE AUX QUEUES
	call	SER_init		;initialise queues and registers


;CONFIGURE THE SIO USING DATA IN CONFIGURATION TABLE LOADED FROM DISK
	call	auxset			;set up SIO


;RETURN STATUS OK
        jmp     EXIT_GOOD




;*****************************   AUX_FUNC_1   *****************************
;-------------------------   Transmit Character  --------------------------

AUX_FUNC_1
;
; **** BIOS 2.4 COMPATABILITY MODS *****
;

	XOR	CH,CH
AUX_FUNC1_L
	PUSH	CX		;SAVE CHAR IN CASE OF ERROR

;TRANSMIT THE CHARACTER
        push    cx              ;push the character
        call    AUX_txq_put     ;put the character on the queue


;IF A ERROR OCCURRED (BUFFER FULL) KEEP ON LOOPING
	POP	CX
        cmp     al,#0           ;subroutine returned an error ?
        je	EXIT_GOOD       ;no - return OK

	CMPB	CNF_S_BIOSERR,#1	;error report enabled?
	jne	AUX_FUNC1_L		;no - loop on error
	jmp	EXIT_FAIL


;*****************************   AUX_FUNC_2   *****************************
;--------------------------  Receive  Character  --------------------------

AUX_FUNC_2


;IF NO CHARACTER AVAILABLE: EXIT FAIL
        cmpw    AUX_rxq_count,#0        ;character available ?
        jz      EXIT_FAIL               ;no, jump


;GET THE CHARACTER
        call    AUX_rxq_get             ;get the character in al


;EXIT WITH CHARACTER IN AL
        jmp     EXIT_WITH_AL            ;




;*****************************   AUX_FUNC_3   *****************************
;-----------------------  Update all SIO settings  ------------------------
;
; Calls auxset, in external module auxset.asm, in order to set up    
; all of the A-Side of the SIO.                                            
;

AUX_FUNC_3


;SET UP SIDE-A OF SIO
        call    auxset	                ;set up side-A of SIO

	movb	TX_xon_xoff_flag,#0	;xoff not received

        jmp     EXIT_GOOD               ;RETURN




;*****************************   AUX_FUNC_4   *****************************
;----------------  Get/Set transmit baud rate (data = 1-15)  --------------

AUX_FUNC_4


;IF DATA =  0, OR DATA > 15: IGNORE UPDATE
        jcxz    skip_tx_rate_update     ;jump if data = 0

        cmp     cx,#15                  ;data > 15 ?
        ja      skip_tx_rate_update     ;yes, jump


;UPDATE THE TRANSMIT BAUD RATE CONFIGURATION REGISTER
        mov     CNF_Tx_Brate,cl         ;store new baud rate
skip_tx_rate_update


;RETURN THE CURRENT SETTING OF THE BAUD RATE IN AL
        mov     al,CNF_Tx_Brate         ;get baud rate code
        jmp     EXIT_WITH_AL            ;RETURN



;*****************************   AUX_FUNC_5   *****************************
;----------------  Get/Set Receive baud rate (data = 1-15)  ---------------
;

AUX_FUNC_5


;IF DATA =  0, OR DATA > 15: IGNORE UPDATE
        jcxz    skip_rx_rate_update     ;jump if data = 0

        cmp     cx,#15                  ;data > 15 ?
        ja      skip_rx_rate_update     ;yes, jump


;UPDATE THE RECEIVE BAUD RATE CONFIGURATION REGISTER
        mov     CNF_Rx_Brate,cl         ;store new baud rate
skip_rx_rate_update


;RETURN THE CURRENT SETTING OF THE BAUD RATE IN AL
        mov     al,CNF_Rx_Brate         ;get baud rate code
        jmp     EXIT_WITH_AL            ;RETURN



;*****************************   AUX_FUNC_6   *****************************
;-----  Get/Set Number of Transmit Bits per Character (data = 5-8)  -------

AUX_FUNC_6


;IF DATA < 5, OR DATA > 8: IGNORE UPDATE
        cmp     cx,#5                   ;data < 5 ?
        jb      skip_tx_bits_update     ;yes, jump

        cmp     cx,#8                   ;data > 8 ?
        ja      skip_tx_bits_update     ;yes, jump


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     CNF_Tx_bits,cl          ;store new value
skip_tx_bits_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,CNF_Tx_bits          ;get current value in al
        jmp     EXIT_WITH_AL            ;RETURN



;*****************************   AUX_FUNC_7   *****************************
;-----  Get/Set Number of Receive Bits per Character (data = 5-8)  -------

AUX_FUNC_7


;IF DATA < 5, OR DATA > 8: IGNORE UPDATE
        cmp     cx,#5                   ;data < 5 ?
        jb      skip_rx_bits_update     ;yes, jump

        cmp     cx,#8                   ;data > 8 ?
        ja      skip_rx_bits_update     ;yes, jump


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     CNF_Rx_bits,cl          ;store new value
skip_rx_bits_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,CNF_Rx_bits          ;get current value in al
        jmp     EXIT_WITH_AL            ;RETURN



;*****************************   AUX_FUNC_8    *****************************
;-------  Get/Set Number of Stop Bits per Character (data = 1-3)  ----------
;

AUX_FUNC_8


;IF DATA < 1, OR DATA > 3: IGNORE UPDATE
        jcxz    skip_stop_update        ;jump if data = 0

        cmp     cx,#3                   ;data > 3 ?
        ja      skip_stop_update        ;yes, jump


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     CNF_stop_bits,cl        ;store new value
skip_stop_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,CNF_stop_bits        ;get current value in al
        jmp     EXIT_WITH_AL            ;RETURN



;*****************************   AUX_FUNC_9   *****************************
;---------------------Get/Set Parity Type (data = 0-2)---------------------

AUX_FUNC_9


;IF DATA > 2: IGNORE UPDATE
        cmp     cx,#2                   ;data > 2 ?
        ja      skip_parity_update      ;yes, jump


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     CNF_parity_typ,cl       ;store new value
skip_parity_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,CNF_parity_typ       ;get current value in al
        jmp     EXIT_WITH_AL            ;RETURN





;*****************************   AUX_FUNC_A   *****************************
;------------Get/Set Transmit XON/XOFF protocol (data = 0 or 1)------------

AUX_FUNC_A


;IF DATA > 1: IGNORE UPDATE
        cmp     cx,#1                   ;data > 1 ?
        ja      skip_tx_xon_update      ;yes, jump


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     CNF_Tx_xonxoff,cl       ;store new value
skip_tx_xon_update


;SAY XOFF NOT RECEIVED
	movb	TX_xon_xoff_flag,#0	;xoff not received


;RETURN THE CURRENT VALUE IN AL
        mov     al,CNF_Tx_xonxoff       ;get current value in al
        jmp     EXIT_WITH_AL            ;RETURN


;*****************************   AUX_FUNC_B   *****************************
;-------------Get/Set Receive XON/XOFF protocol (data = 0 or 1)------------

AUX_FUNC_B


;IF DATA > 1: IGNORE UPDATE
        cmp     cx,#1                   ;data > 1 ?
        ja      skip_rx_xon_update      ;yes, jump


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     CNF_Rx_xonxoff,cl       ;store new value
skip_rx_xon_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,CNF_Rx_xonxoff       ;get current value in al
        jmp     EXIT_WITH_AL            ;RETURN


;*****************************   AUX_FUNC_C   *****************************
;------------------  Get/Set RTS line (data = 0 or 1)---------------------

AUX_FUNC_C


;DISABLE INTERRUPTS
	cli


;IF DATA > 1: IGNORE UPDATE
        cmp     cx,#1                   ;data > 1 ?
        ja      skip_rts_update         ;yes, jump


;UPDATE COPY OF SIO REGISTER (FROM COPY_REGS)
        mov     ah,COPY_SIO_W5A         ;get the copy
        and     ah,#0FDh                ;clear the RTS bit
        shl     cl,#1                   ;form mask
        or      ah,cl                   ;set RTS if cx was 1
        mov     COPY_SIO_W5A,ah         ;update copy


;UPDATE THE RELEVANT SIO REGISTER 	(ah = new value for register)
        mov     al,#5                   ;select write register 5
        out     #SIO_A_COM,al           ;


        mov     al,ah			;output the new byte to W5
        out     #SIO_A_COM,al           ;
skip_rts_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,COPY_SIO_W5A         ;get the current value of RTS
        and     al,#02h                 ;
        shr     al,#1                   ;return 0 or 1
        jmp     EXIT_WITH_AL            ;RETURN
        


;*****************************   AUX_FUNC_D   *****************************
;------------------  Get/Set DTR line (data = 0 or 1)  --------------------

AUX_FUNC_D


;DISABLE INTERRUPTS
	cli


;IF DATA > 1: IGNORE UPDATE
        cmp     cx,#1                   ;data > 1 ?
        ja      skip_dtr_update         ;yes, jump


;UPDATE COPY OF SIO REGISTER (FROM COPY_REGS)
        mov     ah,COPY_SIO_W5A         ;get the copy
	and     ah,#07Fh                ;clear the DTR bit
        ror     cl,#1                   ;form mask: b7
        or      ah,cl                   ;set DTR if cx was 1
        mov     COPY_SIO_W5A,ah         ;update copy


;UPDATE THE RELEVANT SIO REGISTER
        mov     al,#5                   ;select write register 5
        out     #SIO_A_COM,al           ;


        mov     al,ah                   ;output the new byte to W5
        out     #SIO_A_COM,al           ;
skip_dtr_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,COPY_SIO_W5A         ;get the current value of DTR
        and     al,#080h                ;
        rol     al,#1                   ;return 0 or 1
        jmp     EXIT_WITH_AL            ;RETURN
        



;*****************************   AUX_FUNC_E   *****************************
;----------------  Get/Set Transmit Enable (data = 0 or 1)  ---------------

AUX_FUNC_E


;DISABLE INTERRUPTS
	cli


;IF DATA > 1: IGNORE UPDATE
        cmp     cx,#1                   ;data > 1 ?
        ja      skip_tx_enab_update     ;yes, jump


;UPDATE COPY OF SIO REGISTER (FROM COPY_REGS)
        mov     ah,COPY_SIO_W5A         ;get the copy
        and     ah,#0F7h                ;clear the tx enable bit
        shl     cl,#1                   ;form mask: b3
        shl     cl,#1                   ;
        shl     cl,#1                   ;
        or      ah,cl                   ;set bit if cx was 1
        mov     COPY_SIO_W5A,ah         ;update copy


;UPDATE THE RELEVANT SIO REGISTER
        mov     al,#5                   ;select write register 5
        out     #SIO_A_COM,al           ;


        mov     al,ah                   ;output the new byte to W5
        out     #SIO_A_COM,al           ;
skip_tx_enab_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,COPY_SIO_W5A         ;get the current value of tx enab
        and     al,#08h                 ;
        mov     cl,#3                   ;shift to bit 0
        shr     al,cl                   ;return 0 or 1
        jmp     EXIT_WITH_AL            ;RETURN
        



;*****************************   AUX_FUNC_F   *****************************
;----------------  Get/Set Receive Enable (data = 0 or 1)  ---------------

AUX_FUNC_F


;DISABLE INTERRUPTS
	cli


;IF DATA > 1: IGNORE UPDATE
        cmp     cx,#1                   ;data > 1 ?
        ja      skip_rx_enab_update     ;yes, jump


;UPDATE COPY OF SIO REGISTER (FROM COPY_REGS)
        mov     ah,COPY_SIO_W3A         ;get the copy
        and     ah,#0FEh                ;clear the rx enable bit
        or      ah,cl                   ;set bit if cx was 1
        mov     COPY_SIO_W3A,ah         ;update copy


;UPDATE THE RELEVANT SIO REGISTER
        mov     al,#3                   ;select write register 3
        out     #SIO_A_COM,al           ;

        mov     al,ah                   ;output the new byte to W3
        out     #SIO_A_COM,al           ;
skip_rx_enab_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,COPY_SIO_W3A         ;get the current value of rx enab
        and     al,#01h                 ;
        jmp     EXIT_WITH_AL            ;RETURN
        



;*****************************   AUX_FUNC_10  *****************************
;-----------------------  Get CTS (data = 0 or 1)  ------------------------

AUX_FUNC_10


;DISABLE INTERRUPTS
	cli


;RESET EXTERNAL INTERRUPTS IN ORDER TO READ CURRENT VALUE
	mov	al,#10h			;reset ext interrupts
	out	#SIO_A_COM,al		;
	

;RETURN THE CURRENT VALUE IN AL
        mov     al,#0                   ;select SIO read register 0
        out     #SIO_A_COM,al           ;

        in      al,#SIO_A_STAT          ;read the register

        and     al,#20h                 ;shift the bit to b0
        mov     cl,#5                   ;
        shr     al,cl                   ;

        jmp     EXIT_WITH_AL            ;RETURN




;*****************************   AUX_FUNC_11  *****************************
;------------------  Get DCD (data = 0 or 1)  -------------------

AUX_FUNC_11


;DISABLE INTERRUPTS
	cli


;RESET EXTERNAL INTERRUPTS IN ORDER TO READ CURRENT VALUE
	mov	al,#10h			;reset ext interrupts
	out	#SIO_A_COM,al		;


;RETURN THE CURRENT VALUE IN AL
        mov     al,#0                   ;select SIO read register 0
        out     #SIO_A_COM,al           ;

        in      al,#SIO_A_STAT          ;read the register

        and     al,#08h                 ;shift the bit to b0
        mov     cl,#3                   ;
        shr     al,cl                   ;

        jmp     EXIT_WITH_AL            ;RETURN




;*****************************   AUX_FUNC_12  *****************************
;-----------------------  Get DSR (data = 0 or 1)  ------------------------
;
; Note that the DSR comes in on PIO port C bit 08h.


AUX_FUNC_12


;DISABLE INTERRUPTS
	cli


;RETURN THE CURRENT VALUE IN AL

        in      al,#PIO_PORC		;read the register

	not	al			;invert it
        and     al,#08h                 ;shift the bit to b0
        mov     cl,#3                   ;
        shr     al,cl                   ;

        jmp     EXIT_WITH_AL            ;RETURN



;*****************************   AUX_FUNC_13   *****************************
;------------  Get/Set Number of Nulls after CR  (data = 1-255)  -----------
;

AUX_FUNC_13


;IF DATA > 255: IGNORE UPDATE
    
        cmp     ch,#0                   ;data > 255 ?
        jne     skip_cr_nulls_update    ;yes, jump


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     CNF_CR_null,cl          ;store new value
        movw    AUX_fill_cnt,#0         ;zero current count
skip_cr_nulls_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,CNF_CR_null          ;get current value in al
        jmp     EXIT_WITH_AL            ;RETURN




;*****************************   AUX_FUNC_14   *****************************
;------------  Get/Set Number of Nulls after FF  (data = 1-255)  -----------
;

AUX_FUNC_14


;IF DATA > 255: IGNORE UPDATE

        cmp     ch,#0                   ;data > 255 ?
        jne     skip_ff_nulls_update    ;yes, jump


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     CNF_FF_null,cl          ;store new value
        movw    AUX_fill_cnt,#0         ;zero current count
skip_ff_nulls_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,CNF_FF_null          ;get current value in al
        jmp     EXIT_WITH_AL            ;RETURN




;*****************************   AUX_FUNC_15   *****************************
;----------------  Get/Set auto LF after CR(data = 0 or 1)  ----------------
;

AUX_FUNC_15


;IF DATA > 1: IGNORE UPDATE
        cmp     cx,#1                   ;data > 1 ?
        ja      skip_auto_LF_update     ;yes, jump


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     CNF_s_cr_lf,cl          ;store new value
skip_auto_LF_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,CNF_s_cr_lf          ;get current value in al
        jmp     EXIT_WITH_AL            ;RETURN



;*****************************   AUX_FUNC_16   *****************************
;--------------------------  ENABLE SERIAL MOUSE  --------------------------
;

AUX_FUNC_16

;ENABLE EXTERNAL SERIAL MOUSE MOUSE HANDLER
	movb	serial_mouse,#1		;enable serial mouse


        jmp     EXIT_GOOD




;*****************************   AUX_FUNC_17   *****************************
;------------------------  DISENABLE SERIAL MOUSE  -------------------------
;

AUX_FUNC_17


;DISENABLE EXTERINAL SERIAL MOUSE HANDLER
	movb	serial_mouse,#0		;disenable serial mouse


        jmp     EXIT_GOOD




;*****************************   AUX_FUNC_18   *****************************
;---------------  Get/Set RTS/CTS Protocol (data = 0, 1)  ---------------
;
;	Sets RTS on, Enable EXT/STATUS interrupts for hang kicking
;
AUX_FUNC_18


;IF DATA > 1: IGNORE UPDATE
        cmp     cx,#1                   ;data > 1 ?
        ja      skip_CTS_RTS_update     ;yes, jump

;SET OR CLEAR EXT/STATUS INTERRUPT BIT
	cli
	andb	COPY_SIO_W1A,#0FEh	;preclear ext/stat enable
	cmp	cx,#1			;set protocol?
	jne	not_cts_rts		;no
	orb	COPY_SIO_W1A,#001h	;set ext/stat enable
not_cts_rts
	mov	al,#01			;select write register 1
	out	#SIO_A_COM,al
	mov	al,COPY_SIO_W1A		;and update it
	out	#SIO_A_COM,al

;SET RTS ON
	orb	COPY_SIO_W5A,#02H	;set copy high
	mov	al,#5			;talk to write register 5
	out	#SIO_A_COM,al
	mov	al,COPY_SIO_W5A		;and update it
	out	#SIO_A_COM,al	


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     CNF_cts_rts,cl          ;store new value
skip_CTS_RTS_update


;RETURN THE CURRENT VALUE IN AL
        mov     al,CNF_cts_rts          ;get current value in al
        jmp     EXIT_WITH_AL            ;RETURN




;*****************************   AUX_FUNC_19   *****************************
;---------------  Get/Set DTR/DSR Protocol (data = 0, 1, 2)  ---------------
;
; (2 = auto enables)
;
; ACTION:
;	0 -	Disable Auto-enables, SET DTR
;	1 -	Disable Auto-enables, SET DTR
;	2 -	Enable Auto-enables, SET DTR,RTS, Disable S/W CTS-RTS protocol

AUX_FUNC_19

;DISABLE INTERRUPTS
	cli

;IF DATA > 2: IGNORE UPDATE
        cmp     cx,#2                   ;data > 2 ?
        ja      skip_DTR_DSR_update     ;yes, jump


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     CNF_dtr_dsr,cl          ;store new value


;SET UP REGISTER COPY WITH CURRENT VALUE OF AUTO ENABLES BIT
	andb	COPY_SIO_W3A,#0DFh	;preclear the bit
	cmp	cx,#2			;set auto enables ?
	jne	not_auto_enable		;no, jump
	orb	COPY_SIO_W3A,#020h	;set auto enables bit copy
	movb	CNF_cts_rts,#0		;disable S/W CTS/RTS protocol
	andb	COPY_SIO_W1A,#0FEh	;preclear ext/stat enable
	mov	al,#01			;select write register 1
	out	#SIO_A_COM,al
	mov	al,COPY_SIO_W1A		;and update it
	out	#SIO_A_COM,al


not_auto_enable

;UPDATE THE SIO WITH CURRENT VALUE OF AUTO ENABLES BIT
	mov	al,#3			;select register 3
	out	#SIO_A_COM,al		;

	mov	al,COPY_SIO_W3A		;output current values
	out	#SIO_A_COM,al		;

;SET THE DTR (AND RTS IF REQUIRED) OUTPUT HIGH
	orb	COPY_SIO_W5A,#080H	;Set DTR on
	cmp	cx,#2			;auto enables?
	jne	not_auto_en2		;no - skip
	orb	COPY_SIO_W5A,#002H	;set RTS on
not_auto_en2
	mov	al,#5			;talk to write register 5
	out	#SIO_A_COM,al
	mov	al,COPY_SIO_W5A		;and update it
	out	#SIO_A_COM,al	
	
;RETURN THE CURRENT VALUE IN AL
skip_DTR_DSR_update
        mov     al,CNF_dtr_dsr          ;get current value in al
        jmp     EXIT_WITH_AL            ;RETURN





;*****************************   AUX_FUNC_1A   *****************************
;-------------------  Set/Reset External SIO control  ----------------------
;

AUX_FUNC_1A


;IF DATA > 1: IGNORE UPDATE
        cmp     cx,#1                   ;data > 1 ?
        ja      skip_ext_int_update     ;yes, jump


;UPDATE THE RELEVANT CONFIGURATION REGISTER
        mov     AUX_ext_on,cl           ;store new value

;Ensure interrupts are enabled as appropriate
	mov	al,#1			;point at write reg 1
	out	#SIO_A_COM,al
	mov	al,COPY_SIO_W1A		;get copy
	cmp	cl,#1			;going?
	je	going_for_ext		;yes
	mov	al,#00010110b		;set rx & tx ints on
	cmpb	CNF_cts_rts,#1		;protocol on?
	jne	not_ctsrts		;no
going_for_ext
	or	al,#00000001b		;set ext/status int on
not_ctsrts
	out	#SIO_A_COM,al		;update reg
	mov	COPY_SIO_W1A,al		;and copy


skip_ext_int_update


;RETURN THE SIO BASE ADDRESS IN AL, AND CHANNEL INDICATOR IN AH
        mov     al,#SIO_A_DAT           ;get base address in AL
	mov	ah,#0			;and 0 = channel A RS232
        jmp     EXIT_WITH_AX            ;RETURN




;*****************************   AUX_FUNC_1B   *****************************
;-----------------  Non-destructive read of next character -----------------
;

AUX_FUNC_1B


;IF NO CHARACTER AVAILABLE: RETURN CODE
	cmpw	AUX_rxq_count,#0	;any characters in queue ?
	jne	get_look_ahead		;yes, jump

	jmp	EXIT_FAIL		;RETURN  --- no character available
get_look_ahead


;RETURN THE NEXT CHARACTER IN AL
	call	AUX_rxq_check		;get the character
	jmp	EXIT_WITH_AL		;return
	


;*****************************   AUX_FUNC_1C   *****************************
;----------------------   Flush the Transmit Buffer   ----------------------
;

AUX_FUNC_1C


;DISABLE INTERRUPTS
	cli


;FLUSH THE TRANSMIT BUFFER
	xor	ax,ax			;set all pointers to zero
	mov	AUX_txq_count,ax	;
	mov	AUX_txq_ipt,ax		;
	mov	AUX_txq_opt,ax		;


	jmp	EXIT_GOOD		;return ax = 0




;*****************************   AUX_FUNC_1D   *****************************
;----------------------   Flush the Receive Buffer   -----------------------
;

AUX_FUNC_1D


;DISABLE INTERRUPTS
	cli


;FLUSH THE RECEIVE BUFFER
	xor	ax,ax			;set all pointers to zero
	mov	AUX_rxq_count,ax	;
	mov	AUX_rxq_ipt,ax		;
	mov	AUX_rxq_opt,ax		;


;SEND XON IF XOFF HAS BEEN SENT
	call	XON_handler		;send xon if needed


;CLEAR THE LATCHED ERROR STATUS FOR THE RECEIVER
	mov	aux_errors,al		;no parity/framing/overrun errors now


	jmp	EXIT_GOOD		;return ax = 0




;*****************************   AUX_FUNC_1E   *****************************
;--------------  Return and Reset the Latched Error Status    --------------
;

AUX_FUNC_1E



;GET THE LATCHED ERROR STATUS
	mov	al,aux_errors		;return SIO error status


;CLEAR THE LATCHED ERROR STATUS FOR THE RECEIVER
	movb	aux_errors,#0		;no parity/framing/overrun errors now

	
	jmp	EXIT_WITH_AL		;return al



;*****************************   AUX_FUNC_1F   *****************************
;--------------------------   Transmit a String    -------------------------
;
; This routine places a string into the aux transmit buffer. If the buffer
; is full the routine will keep trying until it has done it.
;
; On Entry:
;	dx:si points to a data packet as follows:
;	
;	[dx:si + 0] = WORD - number of characters
;	[dx:si + 2] = DWORD- pointer to the string
;
; On Exit;
;	[dx:si + 0] =  updated with number of characters ouput,
;	         ax = 0      if string transmitted
;


AUX_FUNC_1F


;ENSURE THAT INTERRUPTS ARE ENABLED
	sti


;SAVE THE CALL TABLE POINTER
	mov	call_tab_ptr,si		;store offset
	mov	call_tab_ptr+2,dx	;store segment


;GET COUNT AND STRING POINTER AND SAVE THEM
	push	es			;save es
	mov	es,dx			;point to input table with es:si

	mov	cx,es:[si]		;get the count and...
	mov	count,cx		;save count

	les	bx,es:2[si]		;get string pointer in es:bx and...
	mov	str_ptr,bx		;save pointer
	mov	str_ptr+2,es		;

	pop	es			;restore es


;IF NO CHARACTERS TO DO: EXIT  (cx=count)
	jcxz	all_tx_done		;exit if all done


;ENTER LOOP TO TRANSMIT ONE CHARACTER AT A TIME
loop_tx_string


;GET THE NEXT CHARACTER
	push	es			;save es
	les	bx,str_ptr		;get pointer in es:bx

	mov	al,es:[bx]		;get the character
	pop	es			;


;KEEP TRYING TO TRANSMIT THE CHARACTER (al = char)
	xor	ah,ah			;character in ax

try_tx_char_again
	push	ax			;save the value

	push	ax			;send to routine
	call	AUX_txq_put		;put char in the queue

	cmp	al,#0			;buffer full ?
	pop	ax			;(restore the character)
	jne	try_tx_char_again	;yes, jump: try again


;SET UP POINTERS FOR NEXT CHARACTER
	decw	count			;character counter
	jz	all_tx_done		;exit if all done

	incw	str_ptr			;increment offset
	jnz	no_tx_wrap		;
	addw	str_ptr+2,#01000h	;next segment
no_tx_wrap

 
;LOOP BACK FOR NEXT CHARACTER
	jmp	loop_tx_string


;ALL CHARACTERS DONE: RETURN OK CODE
all_tx_done
	jmp	EXIT_GOOD		;return ok code



;*****************************   AUX_FUNC_20   *****************************
;--------------------------   Receive a String    -------------------------
;
; On Entry:
;	dx:si points to a data packet as follows:
;	
;	[dx:si + 0] = WORD - number of characters
;	[dx:si + 2] = DWORD- pointer to space for the string
;
; On Exit;
;	ax = 0
;


AUX_FUNC_20


;GET COUNT AND STRING POINTER AND SAVE THEM
	push	es			;save es
	mov	es,dx			;point to input table with es:si

	mov	cx,es:[si]		;get the count and...
	mov	count,cx		;save count

	les	bx,es:2[si]		;get string pointer in es:bx and...
	mov	str_ptr,bx		;save pointer
	mov	str_ptr+2,es		;

	pop	es			;restore es


;IF NO CHARACTERS TO GET: EXIT  (cx=count)
	jcxz	all_rx_done		;exit if all done


;ENTER LOOP TO GET ONE CHARACTER AT A TIME
loop_rx_string


;GET THE NEXT CHARACTER
	call	AUX_rxq_get		;get character in al (wait if necessary)


;STORE THE CHARACTER
	push	es			;save es
	les	bx,str_ptr		;get pointer in es:bx

	mov	es:[bx],al		;store the character
	pop	es			;


;SET UP POINTERS FOR NEXT CHARACTER
	decw	count			;character counter
	jz	all_rx_done		;exit if all done

	incw	str_ptr			;increment offset
	jnz	no_rx_wrap		;
	addw	str_ptr+2,#01000h	;next segment
no_rx_wrap

 
;LOOP BACK FOR NEXT CHARACTER
	jmp	loop_rx_string


;ALL CHARACTERS DONE: RETURN OK CODE
all_rx_done
	jmp	EXIT_GOOD		;return ok code



;*****************************   AUX_FUNC_21   *****************************
;--------------------  Set/Get Receiver Queue Length    --------------------
;

AUX_FUNC_21


;IF DATA <1 OR >512: DO NOT UPDATE THE QUEUE LENGTH
	jcxz	skip_rxq_max		;jump if < 1

	cmp	cx,#512			;greater than 512
	ja	skip_rxq_max		;yes, jump

	mov	AUX_rxq_max,cx		;update the register
skip_rxq_max


;RETURN THE CURRENT VALUE OF THE QUEUE LENGTH IN AX
	mov	ax,AUX_rxq_max		;get current value

	
	jmp	EXIT_WITH_AX		;return ax



;*****************************   AUX_FUNC_22   *****************************
;--------------------  Set/Get Transmitter Queue Length    -----------------
;

AUX_FUNC_22


;IF DATA <1, OR >512: DO NOT UPDATE THE QUEUE LENGTH
	jcxz	skip_txq_max		;jump if < 1

	cmp	cx,#512			;greater than 512
	ja	skip_txq_max		;yes, jump

	mov	AUX_txq_max,cx		;update the register
skip_txq_max


;RETURN THE CURRENT VALUE OF THE QUEUE LENGTH IN AX
	mov	ax,AUX_txq_max		;get current value

	
	jmp	EXIT_WITH_AX		;return ax



;*****************************   AUX_FUNC_23   *****************************
;-----------------  Get Number of Bytes in Receive Queue  ------------------
;

AUX_FUNC_23


;RETURN THE CURRENT VALUE OF THE QUEUE COUNT IN AX
	mov	ax,AUX_rxq_count		;get current value

	
	jmp	EXIT_WITH_AX		;return ax




;*****************************   AUX_FUNC_24   *****************************
;-----------------  Get Number of Bytes in Transmitter Queue  --------------
;
AUX_FUNC_24


;RETURN THE CURRENT VALUE OF THE QUEUE COUNT IN AX
	mov	ax,AUX_txq_count		;get current value
	and	ax,ax				;zero?
	jnz	AUX_FUNC24_x			;no - return count
	cli
	mov	al,#1				;read SIO register 1
	out	#SIO_A_COM,al
	push	ax				;ax = 0001
	in	al,#SIO_A_STAT			;get reg 1 contents
	test	al,#1				;check for all sent
	pop	ax
	jz	AUX_FUNC24_x			;return count of 1 if not
	xor	ax,ax				;say count now zero
AUX_FUNC24_x	
	jmp	EXIT_WITH_AX		;return ax






        End

$ 