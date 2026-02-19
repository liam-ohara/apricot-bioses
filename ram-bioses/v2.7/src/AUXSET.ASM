t
        word    254*4                   ;int 254 address
     $ TYPE auxset.asm
; [bios.apricot.rom]auxset.asm
        title '[bios.apricot.rom]auxset.asm'



        Include 'legal.asi'



;***************************************************************************
;*                                                                         *
;*                          A U X S E T                                    *
;*                                                                         *
;*           Set up routine for Side-A (RS 232) of the SIO device.         *
;*                                                                         *
;*      FILENAME:       [bios.apricot.rom]auxset.asm                       *
;*      PROGRAMMER:     R. J. WOOLCOCK.                                    *
;*      IMPLEMENTED:    19-JUN-84                                          *
;*      MODIFIED:       MODDED FOR THE APRICOT 13/8/84 GK                  *
;*			Rx mask implemented 10/10/84 GK			   *
;*                                                                         *
;***************************************************************************
  page





;***************************************************************************
;*                                                                         *
;*                                                                         *
;*      FILE     'AUXSET'                                                  *
;*      =================                                                  *
;*                                                                         *
;*      This file contains the set up routine for side-A of the SIO        *
;*      The entry address is AUXSET. The routine is called  from           *
;*      the control interface program 'auxcon'.                            *
;*                                                                         *
;*                                                                         *
;***************************************************************************
  page
        name AUXSET

        Include 'ioregs.asi'
        Include 'align.asi'
        Include 'copyregs.asi'

;***************************   D A T A   A R E A   **************************


        Section auxset.data,align(2),class=dataQQ


;CONFIGURATION CONSTANTS (external variables defined in CONTAB)
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


;OTHER EXTERNAL VARIABLES
	GLOBAL	RX_mask			;bit mask for RX characters
        GLOBAL  AUX_fill_cnt            ;null filler counter
        GLOBAL  AUX_CR_detect           ;carriage return detected flag
   page
;**********************   P R O G R A M    A R E A   ************************


        Section  auxset.instr,align(1),class=instrQQ


        Global   CodeBaseQQ,DataBaseQQ  ;set during link
        Global   AUXSET                 ;entry address for this module


        Assume ds:DataBaseQQ, cs:CodeBaseQQ



;
   page
;**************************************************************************
;**********************   SUBROUTINE    AUXSET   **************************
;**************************************************************************
;
;  Subroutine to set up the A-Side of the SIO (RS 232C) using the data
;  from the configuration table (contab). Use is made of 'copy_regs',
;  which are a copies of important write only I/O registers.
;
;
;
;  On Entry:
;       Configuration table contains set up details of SIO.
;
;  On Exit:
;       SIO will be set up for side-A.
;       The copy of the SIO write only registers in `copy_regs'
;       will be updated.
;
;--------------------------------------------------------------------------


AUXSET


;ENSURE THAT INTERRUPTS ARE DISABLED
        pushf                   	;save interrupt status
        cli                   	  	;disable interrupts


;DO CHANNEL RESET ON CHANNEL A (must be delay before subsequent access - 4 clocks)
	mov	al,#18h			;master reset
	out	#SIO_A_COM,al		;

;SELECT SPLIT BAUD RATES BY SETTING CHANNEL B RTS & DTR BITS HIGH

	mov	al,#5
	out	#SIO_B_COM,al		;select channel B write register 5
	mov	al,COPY_SIO_W5B		;get channel B write register 5
	or	al,#082h		;set DTR & RTS outputs low - split rates
	mov	COPY_SIO_W5B,al		;update copy
	out	#SIO_B_COM,al		;and sio

;SET UP BAUD RATES IN PIT

	mov	al,#0B6h		;command for loading ch 2, mode 3
	out	#PIT_COM,al		;
	mov	al,#076h		;command for loading ch 1, mode 3
	out	#PIT_COM,al		;


        mov     al,CNF_Tx_brate         ;SET UP TRANSMITTER BAUD RATE
        call    convert_brate           ;convert to a time value

        out     #PIT_CN2,al             ;store time value in PIT
        mov     al,ah                   ;
        out     #PIT_CN2,al             ;

        mov     al,CNF_Rx_brate         ;SET UP RECEIVER BAUD RATE
        call    convert_brate           ;convert to a time value

        out     #PIT_CN1,al             ;store time value in PIT
        mov     al,ah                   ;
        out     #PIT_CN1,al             ;

BAUD_RATES_DONE


;SET UP WRITE REGISTER 4A: CLOCK DIVIDER, STOP BITS, AND PARITY
;--------------------------------------------------------------


;SELECT WRITE REGISTER 4A
        mov     al,#4                   ;select write register 4A
        out     #SIO_A_COM,al           ;


;SET UP PARITY
        mov     al,CNF_parity_typ       ;parity: 0=none; 1=odd; 2=even
        and     al,#3                   ;mask out unwanted bits
        cmp     al,#1                   ;are bits already correct ?
        jbe     parity_done             ;yes, jump
        mov     al,#3                   ;set parity for: enabled, even
parity_done


;SET UP STOP BITS
        mov     ah,CNF_stop_bits        ;stop bits: 1=one; 2=1.5; 3=two
        and     ah,#3                   ;mask out unwanted bits
        shl     ah,#1                   ;move to correct bit position
        shl     ah,#1                   ;
        or      al,ah                   ;enter into mask


;SET UP CLOCK MODE
        or      al,#40h                 ;select divide by 16 


;OUTPUT BYTE TO WRITE REGISTER 4A
        mov     COPY_SIO_W4A,al         ;update copy of register
        out     #SIO_A_COM,al           ;output the byte


;SET UP WRITE REGISTER 3A: BITS PER RX CHARACTER, AND RX ENABLE
;--------------------------------------------------------------


;SELECT WRITE REGISTER 3A
        mov     al,#3                   ;select write register 3
        out     #SIO_A_COM,al           ;


;SET UP NUMBER OF BITS FOR RECEIVE CHARACTER
        mov     al,CNF_Rx_bits          ;bits per rx character (5-8)
        sub     al,#5                   ;convert al to 0 - 3
        and     al,#3                   ;mask out unwanted bits

	mov	cx,#0FF03h		;set up RX mask in ch,shift count in cl
	sub	cl,al			;cl=0 for 8, 1 for 7 etc
	jz	noshift			;if zero no change to mask
	shr	ch,cl			;setup mask
noshift
	mov	RX_mask,ch		;set up receive mask

	mov	ah,al			;swap bits 0 and 1
	shr	al,#1			;
	and	ah,#1			;
	shl	ah,#1			;
	or	al,ah			;

        ror     al,#1                   ;move to bits 6 & 7
        ror     al,#1                   ;


;ENABLE THE RECEIVER
        or      al,#1                   ;enable receiver


;UPDATE DCD/CTS AUTO ENABLES BIT
	cmpb	CNF_cts_rts,#2		;auto enable selected ?
	je	set_auto_enab		;yes, jump
        cmpb    CNF_dtr_dsr,#2          ;auto enable selected ?
        jne     auto_enable_done        ;no, jump
set_auto_enab
        or      al,#20h                 ;set auto enables bit
auto_enable_done


;OUTPUT BYTE TO WRITE REGISTER 3A
        mov     COPY_SIO_W3A,al         ;update copy of write register
        out     #SIO_A_COM,al           ;output byte


;SET UP WRITE REGISTER 5A: DTR; BITS PER TX CHAR; TX ENABLE; RTS
;---------------------------------------------------------------


;SELECT WRITE REGISTER 5A
        mov     al,#5                   ;select write register 5
        out     #SIO_A_COM,al           ;


;SET UP NUMBER OF BITS FOR TRANSMITTER CHARACTER
        mov     al,CNF_Tx_bits          ;bits per tx character (5-8)
        sub     al,#5                   ;convert al to 0 - 3
        and     al,#3                   ;mask out unwanted bits

	mov	ah,al			;swap bits 0 and 1
	shr	al,#1			;
	and	ah,#1			;
	shl	ah,#1			;
	or	al,ah			;

        ror     al,#1                   ;move to bits 5 & 6
        ror     al,#1                   ;
        ror     al,#1                   ;
	and	al,#01100000b		;mask down

;ENABLE THE TRANSMITTER
        or      al,#08h                 ;enable transmitter

;AND PUT IN THE OLD RTS DtR BITS
	mov	ah,COPY_SIO_W5A
	and	ah,#10000010b		;mask to old RTS DtR
	or	al,ah

;OUTPUT BYTE TO WRITE REGISTER 5A
        mov     COPY_SIO_W5A,al         ;update copy of write register
        out     #SIO_A_COM,al           ;output byte


;SET UP WRITE REGISTER 1A: TX INTERRUPT ENABLE
;-----------------------------------------------------

;SELECT WRITE REGISTER 1A
        mov     al,#1                   ;select write register 1
        out     #SIO_A_COM,al           ;


;ENABLE TRANSMITTER; PARITY, STATUS AFFECTS VECTOR
        mov     al,#016h                ;

;CHECK FOR CTS RTS PROTOCOL if on enable ext/status
	cmpb	CNF_cts_rts,#1
	jne	not_cts_rts		;not on
	or	al,#001			;set ext status enable
not_cts_rts

;OUTPUT BYTE TO WRITE REGISTER 1A
        mov     COPY_SIO_W1A,al         ;update copy of write register
        out     #SIO_A_COM,al           ;output byte


;INITIALISE EXTERNAL REGISTERS
;-----------------------------

        movw    AUX_fill_cnt,#0         ;initialise null fill count
        movb    AUX_CR_detect,#0        ;CR not detected yet


;EXIT THE SUBROUTINE
;-------------------

        popf                            ;restore interrupt status
        ret                             ;RETURN
   page
	stitle	'SUBROUTINE:  CONVERT_BRATE'




;***************************************************************************
;********************   SUBROUTINE  CONVERT_BRATE   ************************
;***************************************************************************
;
; This routine converts the baud rate code to the required timer value
; for the PIT.
;
;   On Entry:
;       al = baud rate code (1-15)
;
;   On Exit:
;       ax = timer value for PIT
;       (if code was illegal: timer value for 9600 baud is returned)
;
;---------------------------------------------------------------------------


CONVERT_BRATE


;IF AL IS ILLEGAL: SET IT TO DEFAULT VALUE
        dec     al                      ;make ax 0 - 14

        cmp     al,#14                  ;is al valid ?
        jbe     baud_valid              ;yes, jump
        mov     al,#14-1                ;point to 9600 baud as default
baud_valid


;CALCULATE INDEX POINTER TO TABLE
        shl     al,#1                   ;convert to word pointer
        mov     bl,al                   ;form index pointer in bx
        xor     bh,bh                   ;


;GET REQUIRED VALUE FROM THE TABLE AND RETURN IT IN AX
        mov     ax,cs:BAUD_TABLE[bx]    ;get value from look up table

        ret                             ;RETURN  ---  time value in ax




;****************  LOOK UP TABLE OF BAUD-RATE TIME CONSTANTS  ******************
;******************************************************************************

BAUD_TABLE

        WORD    2500    ;Code  1:  Baud rate = 50
        WORD    1667    ;Code  2:  Baud rate = 75
        WORD    1136    ;Code  3:  Baud rate = 110
        WORD     929    ;Code  4:  Baud rate = 134.5
        WORD     833    ;Code  5:  Baud rate = 150
        WORD     417    ;Code  6:  Baud rate = 300
        WORD     208    ;Code  7:  Baud rate = 600
        WORD     104    ;Code  8:  Baud rate = 1200
        WORD      69    ;Code  9:  Baud rate = 1800
        WORD      52    ;Code 10:  Baud rate = 2400
        WORD      35    ;Code 11:  Baud rate = 3600    (-0.8%)
        WORD      26    ;Code 12:  Baud rate = 4800
        WORD      17    ;Code 13:  Baud rate = 7200    (+2%)
        WORD      13    ;Code 14:  Baud rate = 9600
        WORD       7    ;Code 15:  Baud rate = 19200   (-7%)




        End

$ 