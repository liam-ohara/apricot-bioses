ng sent
	ret				;done
        $ TYPE mscon.asm
;[bios.apricot.ram]mscon.asm
	title 	'[bios.apricot.ram]MSCON.asm'



        include 'legal.asi'




;************************************************************************
;*                                                                      *
;*                            M S C O N                                 *
;*                                                                      *
;*      MSDOS interface to ROM based keyboard and screen drivers.	*
;*                                                                      *
;*      FILENAME:       [BIOS.apricot.ram]mscon.asm                   	*
;*      AUTHOR:         Ray Woolcock                                    *
;*      WRITTEN:        13-JUN-84                                       *
;*                                                                      *
;*      REVISION HISTORY:                                               *
;*			Generic RAM BIOS version 15/6/84 GK		*
;*                      Apricot RAM BIOS version 4/9/84                 *
;*                                                                      *
;*                                                                      *
;*                                                                      *
;************************************************************************
  page



        include 'DRSoffs.asi'
        include 'GENEQU.asi'
	include 'mserror.asi'


        global  CODEBASEQQ, DATABASEQQ

        Assume CS:CODEbaseQQ, DS:DATAbaseQQ



;************************************************************************
;*************************  DATA SECTION  *******************************
;************************************************************************


        Section mscon.DATA, align (1), class = DataQQ





;CALL TABLE FOR ROM BIOS CALLS

CALL_TABLE	BLOCK	6		;call table space

;definitions for read string and write string
c_count		equ	CALL_TABLE+0	;byte count
c_ptr		equ     CALL_TABLE+2	;DWORD pointer


;INTERNAL VARIABLES
DRS_ptr		block   4		;DWORD - pointer to drs

;EXTERNAL VARIABLES
	GLOBAL	KBD_Q_COUNT



;************************************************************************
;**************************  CODE SECTION  ******************************
;************************************************************************


        Section mscon.CODE, align (1), class = InstrQQ


;ENTRY ADDRESS
        Global  MSCON_driver


   page
;************************************************************************
;**********************  SUBROUTINE  mscon  *****************************
;************************************************************************
;*                                                                      *
;*                                                                      *
;*      This subroutine is called by MSINTER to handle all  calls       *
;*      to the console device. This module is RAM resident and makes    *
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



MSCON_driver


;GET POINTER TO DRS FROM STACK, INTO ES:BX AND SAVE IT
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

	les	di,DRS_ptr			;point to DRS        
	or      ax,#0100h   			;set done bit
	mov     es:(DRS_HD_status)[di],ax   	;


        ret     #4



;************************************************************************
;									;
; 	           LOOK UP TABLE OF mscon FUNCTIONS			;
;									;
;***********************************************************************;


DCONTBL word    INIT	        -CODEbaseqq     ;0 - Init Driver
        word    Cmd_Error       -CODEbaseqq     ;1 - N/A Media Check
        word    Cmd_Error       -CODEbaseqq     ;2 - N/A Get BPB
        word    Cmd_Error       -CODEbaseqq     ;3 - N/A IO Control, unused
        word    READ	        -CODEbaseqq     ;4 - Block read
        word	LOOK_AHEAD	-CODEbaseqq     ;5 - Non-destructive read
        word    ISTAT           -CODEbaseqq     ;6 - Return status - INPUT
        word    FLUSH_INPUT     -CODEbaseqq     ;7 - Flush input buffer
        word    WRITE	        -CODEbaseqq     ;8 - Output
        word    WRITE	        -CODEbaseqq     ;9 - Output with verify
        word    DEXIT           -CODEbaseqq     ;10- N/A Return output status
        word    DEXIT           -CODEbaseqq     ;11- N/A Flush output buffer
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
;                       * Console device				;
; On Entry:								;
;	DRS_ptr = es:di   points to the DRS				;
;									;
;------------------------------------------------------------------------


INIT


;INITIALISE KEYBOARD
	mov	bx,#32h			;keyboard device code
	mov	cx,#0			;init keyboard command
	int	#0FCh			;call ROM bios



	xor 	ax,ax			;return no-error code



        ret
   page
;***********************************************************************;
;****************************    ISTAT   *******************************;
;***********************************************************************;
;									;
;       ISTAT           * Called to check keyboard input status		;
;                       * sets busy bit if no characters available	;
; On Entry:								;
;	DRS_ptr = es:di   points to the DRS				;
;									;
;------------------------------------------------------------------------


ISTAT

	XOR	AX,AX			;PRESET CHARACTER AVAILABLE
	CMP	KBD_Q_COUNT,AX		;KEY AVAILABLE?
	JZ	BUSY_EXIT		;NO - SET BUSY BIT
	RET

        
   page


;***********************************************************************;
;****************************   READ   *********************************;
;***********************************************************************;
;									;
; Return string from keyboard when available.				;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------


READ


;SET UP CALL TABLE FOR READ STRING
        mov     ax,es:(DRS_RW_count)[di]        ;get count
	mov	c_count,ax			;store in call table

        mov     ax,es:(DRS_RW_taddr)[di]        ;get transfer address
        mov     bx,es:(DRS_RW_taddr+2)[di]	;
	mov	c_ptr,ax			;store offset
	mov	c_ptr+2,bx			;store segment
        

;CALL ROM BIOS TO READ THE STRING AND EXIT
	lea	si,CALL_TABLE			;point to the table
	mov	dx,ds			   	;

	mov	cx,#000Eh			;command for read string
	mov	bx,#0032h			;keyboard device number
	int	#0FCh				;call ROM BIOS

        xor     ax,ax				;code for no error
        ret		                    	;RETURN
   page


;***********************************************************************;
;*************************  LOOK_AHEAD  ********************************;
;***********************************************************************;
;									;
; Non-destructive read of next key if available.			;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
; On Exit:								;
;     if character is available	it is stored in DRS_ND_data		;
;     else a device busy code is returned.				;
;									;
;------------------------------------------------------------------------


LOOK_AHEAD



;CALL ROM BIOS TO READ NEXT CHARACTER
	mov	cx,#000Ch		;non-destructive read command
	mov	bx,#0032h		;device number
	int	#0FCh			;call ROM BIOS


;IF NO CHARACTER AVAILABLE RETURN BUSY CODE
	cmp	ax,#0FFFFh		;character returned in al ?
	jne	char_returned		;yes, jump

	jmp	busy_exit		;return busy code
char_returned


;STORE LOOK AHEAD CHARACTER (al) IN DRS
        mov     es:(DRS_ND_data)[di],al ;store the character


;RETURN CODE FOR NO ERROR
        xor     ax,ax                   ;ok code

	ret				;RETURN
    page
;***********************************************************************;
;***************************  WRITE  ***********************************;
;***********************************************************************;
;									;
; Output a string to the screen. This uses interrupt 0F1h.		;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------


WRITE


;SAVE DATA SEGMENT
	push	ds


;GET COUNT AND ADDRESS FROM DRS
        mov     cx,es:(DRS_RW_count)[di]        ;get count in cx

        mov     si,es:(DRS_RW_taddr)[di]        ;get transfer address
        mov     ds,es:(DRS_RW_taddr+2)[di]	; ... in ds:si
        

;ENTER LOOP TO OUTPUT THE STRING, ONE CHARACTER AT A TIME
screen_loop
	lodb					;get next char in al
	int	#0F1h				;call rom bios
	loop	screen_loop


;RESTORE DATA SEGMENT
	pop	ds


;ALL TRANSMITTED: RETURN OK CODE 
        xor     ax,ax				;code for no error
	ret					;RETURN
   page


;***********************************************************************;
;***************************  FLUSH INPUT  *****************************;
;***********************************************************************;
;									;
; Throw away keys in input buffer					;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------


FLUSH_INPUT



;FLUSH INPUT QUEUE
	mov	bx,#0032h		;keyboard device code
	mov	cx,#0005h		;flush input buffer command
	int	#0FCh			;call ROM bios

	xor	ax,ax			;no-error code
	ret				;RETURN


        end
$ 