
        WORD      52    ;Code 10:  Baud rate = 2400
        WORD      35    ;Code 11:  Baud ra$ TYPE msprn.asm
;[bios.apricot.ram]msprn.asm
	title 	'[bios.apricot.ram]msprn.asm'



        include 'legal.asi'




;************************************************************************
;*                                                                      *
;*                            M S P R N                                 *
;*                                                                      *
;*       	 MSDOS interface to ROM printer device driver.		*
;*                                                                      *
;*      FILENAME:       [BIOS.APRICOT.RAM]msprn.asm                   	*
;*      AUTHOR:         Ray Woolcock                                    *
;*      WRITTEN:        29-may-84                                       *
;*                                                                      *
;*      REVISION HISTORY:                                               *
;*			Generic RAM BIOS version 15/6/84 GK		*
;*                      Apricot RAMBIOS Version 4/9/84 GK               *
;*                                                                      *
;*                                                                      *
;*                                                                      *
;************************************************************************
  page



        include 'DRSoffs.asi'
        include 'GENEQU.asi'
	include 'mserror.asi'


        global  CODEbaseqq, DATABASEQQ

        Assume CS:CODEbaseqq, DS:DATAbaseqq



;************************************************************************
;*************************  DATA SECTION  *******************************
;************************************************************************


        Section msprn.DATA, align (1), class = DataQQ





;CALL TABLE FOR ROM BIOS CALLS

CALL_TABLE	BLOCK	6		;call table space

;definitions for get and receive string
c_count		equ	CALL_TABLE+0	;byte count
c_ptr		equ     CALL_TABLE+2	;DWORD pointer


;INTERNAL VARIABLES
DRS_ptr		block   4		;DWORD - pointer to drs




;************************************************************************
;**************************  CODE SECTION  ******************************
;************************************************************************


        Section msprn.CODE, align (1), class = InstrQQ


;ENTRY ADDRESS
        Global  msprn_driver


   page
;************************************************************************
;**********************  SUBROUTINE  msprn  *****************************
;************************************************************************
;*                                                                      *
;*                                                                      *
;*      This subroutine is called by MSINTER to handle all  calls       *
;*      to the printer device. This module is RAM resident and makes    *
;*      calls to the ROM bios by  using software interrupts.            *
;*                                                                      *
;*      Note that throughout this program es:di is kept pointing        *
;*      to the DRS.                                                     *
;*                                                                      *
;*                                                                      *
;*                                                                      *
;*      On Entry:                                                       *
;*              The stack contains the dword pointer to the DRS,        *
;*              ie,                                                     *
;*                      [sp+4] = DRS segment                            *
;*                      [sp+2] = DRS offset                             *
;*                      [sp+0] = return offset                          *
;*                                                                      *
;*      On Exit:                                                        *
;*              DRS updated as appropriate                              *
;*                                                                      *
;*                                                                      *
;************************************************************************



msprn_driver


;GET POINTER TO DRS FROM STACK, INTO ES:DI AND SAVE IT
        mov     bp,sp
        les     di,2[bp]                        ;load DRS address

	mov	DRS_ptr,di			;save offset
	mov	DRS_ptr+2,es			;save segment


;IF INVALID COMMAND: EXIT WITH ERROR MESSAGE
        mov	ah,#0                           ;get command
        mov     al,es:(DRS_HD_command)[di]      ;

        cmp     al,#12                          ;invalid command ?
        jbe     NO_cmd_err                      ;no, jump
        mov     al,#3                           ;load command error value
NO_cmd_err


;COMMAND CORRECT: EXECUTE COMMAND
        shl     ax,#1				;adjust for words
        mov     si,ax				;
        
	call    [cs:DCONTBL][si]                ;call via the jump table


;SUBROUTINE RETURNS WITH STATUS IN AX
	les	di,DRS_ptr			;point to DRS        
	or      ax,#0100h   			;set done bit
	mov     es:(DRS_HD_status)[di],ax   	;


        ret     #4



;************************************************************************
;									;
; 	           LOOK UP TABLE OF msprn FUNCTIONS			;
;									;
;***********************************************************************;


DCONTBL word    INIT	        -CODEbaseqq     ;0 - Init Driver
        word    Cmd_Error       -CODEbaseqq     ;1 - N/A Media Check
        word    Cmd_Error       -CODEbaseqq     ;2 - N/A Get BPB
        word    Cmd_Error       -CODEbaseqq     ;3 - N/A IO control
        word    dexit	        -CODEbaseqq     ;4 - N/A Block read
        word	dexit		-CODEbaseqq     ;5 - N/A Non-destructive read
        word    dexit           -CODEbaseqq     ;6 - N/A Return status,unused
        word    dexit	        -CODEbaseqq     ;7 - N/A Flush input buffer,unused
        word    WRITE	        -CODEbaseqq     ;8 - Output
        word    WRITE	        -CODEbaseqq     ;9 - Output with verify
        word    STATUS          -CODEbaseqq     ;10- Return output status
        word    FLUSH_OUTPUT    -CODEbaseqq     ;11- Flush output buffer
        word    Cmd_Error       -CODEbaseqq     ;12- N/A IO Control,unused


;DUMMY ROUTINE
DEXIT
	xor	ax,ax
        ret                                     ;dummy routine


;COMMAND ERROR: EXIT WITH ERROR CODE
Cmd_Error
        mov     ax,#MSE_Bad_Cmd
        ret


;RETURN BUSY FLAG
Busy_exit
        mov     ax,#0200h
        ret
   page


;***********************************************************************;
;****************************    INIT   ********************************;
;***********************************************************************;
;									;
;       INIT            * Called at boot-up to initialize the		;
;                       * Printer device				;
; On Entry:								;
;	DRS_ptr = es:di   points to the DRS				;
;									;
;------------------------------------------------------------------------


INIT


;RETURN OK CODE
	xor	ax,ax	
        ret
   page
;***********************************************************************;
;***************************  WRITE  ***********************************;
;***********************************************************************;
;									;
; Setup for a write operation.						;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------


WRITE


;SET UP CALL TABLE FOR WRITE STRING
        mov     ax,es:(DRS_RW_count)[di]        ;get count
	mov	c_count,ax			;store in call table

        mov     ax,es:(DRS_RW_taddr)[di]        ;get transfer address
        mov     bx,es:(DRS_RW_taddr+2)[di]	;
	mov	c_ptr,ax			;store offset
	mov	c_ptr+2,bx			;store segment
        

;CALL ROM BIOS TO TRANSMIT THE STRING
	lea	si,CALL_TABLE		  	;point to the table
	mov	dx,ds			   	;

	mov	cx,#0009h			;command for transmit string
	mov	bx,#0035h			;device number
	int	#0FCh				;call ROM BIOS


;IF NOT ALL CHARACTERS OUTPUT: UPDATE COUNT IN DRS (es:di points to DRS)
	cmp	ax,#0				;error ?
	je	all_transmitted			;no, jump

	mov	cx,c_count			;get returned count
	mov	es:DRS_RW_count[di],cx		;return the actual number output

	ret					;RETURN  ---  error AX
all_transmitted


;ALL TRANSMITTED: RETURN OK CODE 
        xor     ax,ax				;code for no error
	ret					;RETURN  ---  ok
  page
;***********************************************************************;
;***************************  STATUS  **********************************;
;***********************************************************************;
;									;
; Return printer status.						;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------


STATUS

;CALL ROM BIOS TO GET STATUS
	mov	cx,#000Ah			;command for get status
	mov	bx,#0035h			;device number
	int	#0FCh				;call ROM BIOS

;RETURN THE STATUS (status in ax)
	ret					;RETURN  --- status in ax


  page
;***********************************************************************;
;***************************  FLUSH OUTPUT  ****************************;
;***********************************************************************;
;									;
; Throw away characters yet to be printed.				;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------


FLUSH_OUTPUT


;CALL ROM BIOS TO FLUSH THE PRINTER BUFFER
	mov	cx,#0008h			;command for flush buffer
	mov	bx,#0035h			;device number
	int	#0FCh				;call ROM BIOS

	xor	ax,ax				;ok code
	ret					;RETURN --- ok




        end
$ 