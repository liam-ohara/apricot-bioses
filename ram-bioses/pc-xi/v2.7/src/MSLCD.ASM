er 3
COPY_SIO_[?3h$ TYPE mslcd.asm
;[bios.apricot.ram]mslcd.asm
	title 	'[bios.apricot.ram]mslcd.asm'



        include 'legal.asi'




;************************************************************************
;*                                                                      *
;*                            M S L C D                                 *
;*                                                                      *
;*      MSDOS interface to ROM based MicroScreen driver.		*
;*                                                                      *
;*      FILENAME:       [BIOS.APRICOT.RAM]mslcd.asm                    	*
;*      AUTHOR:         Ray Woolcock                                    *
;*      WRITTEN:        13-JUN-84                                       *
;*                                                                      *
;*      REVISION HISTORY:                                               *
;*			Generic RAM BIOS version 15/6/84 GK		*
;*                      MicroScreen version from MSCON 16/8/84 GK       *
;*                      Apricot RAMBIOS version 4/9/84 GK               *
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


        Section mslcd.DATA, align (1), class = DataQQ





;CALL TABLE FOR ROM BIOS CALLS

CALL_TABLE	BLOCK	6		;call table space

;definitions for read string and write string
c_count		equ	CALL_TABLE+0	;byte count
c_ptr		equ     CALL_TABLE+2	;DWORD pointer


;INTERNAL VARIABLES
DRS_ptr		block   4		;DWORD - pointer to drs




;************************************************************************
;**************************  CODE SECTION  ******************************
;************************************************************************


        Section mslcd.CODE, align (1), class = InstrQQ


;ENTRY ADDRESS
        Global  mslcd_driver


   page
;************************************************************************
;**********************  SUBROUTINE  mslcd  *****************************
;************************************************************************
;*                                                                      *
;*                                                                      *
;*      This subroutine is called by MSINTER to handle all  calls       *
;*      to the MSCREEN device. This module is RAM resident and makes    *
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



mslcd_driver


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
        
	call    [cs:DLCDTBL][si]                ;call via the jump table

	les	di,DRS_ptr			;point to DRS        
	or      ax,#0100h   			;set done bit
	mov     es:(DRS_HD_status)[di],ax   	;


        ret     #4



;************************************************************************
;									;
; 	           LOOK UP TABLE OF mslcd FUNCTIONS			;
;									;
;***********************************************************************;


DLCDTBL word    INIT	        -CODEbaseqq     ;0 - Init Driver
        word    Cmd_Error       -CODEbaseqq     ;1 - N/A Media Check
        word    Cmd_Error       -CODEbaseqq     ;2 - N/A Get BPB
        word    Cmd_Error       -CODEbaseqq     ;3 - N/A IO Control
        word    DEXIT	        -CODEbaseqq     ;4 - Block read
        word	DEXIT		-CODEbaseqq     ;5 - Non-destructive read
        word    DEXIT           -CODEbaseqq     ;6 - N/A Return status,unused
        word    DEXIT		-CODEbaseqq     ;7 - Flush input buffer
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
;                       * Mscreen device				;
; On Entry:								;
;	DRS_ptr = es:di   points to the DRS				;
;									;
;------------------------------------------------------------------------


INIT


;INITIALISE MSCREEN
	mov	bx,#33h			;MicroScreen device code
	mov	cx,#0			;init keyboard command
	int	#0FCh			;call ROM bios

	xor 	ax,ax			;return no-error code

        ret
   page

    page
;***********************************************************************;
;***************************  WRITE  ***********************************;
;***********************************************************************;
;									;
; Output a string to the MicroScreen. 					;
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
        xor	dx,dx
	mov	bx,#33h				;MSCREEN DEVICE

;ENTER LOOP TO OUTPUT THE STRING, ONE CHARACTER AT A TIME
screen_loop
	lodb					;get next char in al
	mov	dl,al				;put in dl
	push	cx
	push	si
	mov	cx,#1				;print char command
	int	#0FCh				;call rom bios
	pop	si
	pop	cx
	loop	screen_loop


;RESTORE DATA SEGMENT
	pop	ds


;ALL TRANSMITTED: RETURN OK CODE 
        xor     ax,ax				;code for no error
	ret					;RETURN
   page



        end
$ 