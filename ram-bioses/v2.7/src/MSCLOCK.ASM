    SUB     AX,CHRBASE
        JMP     SCR_drv_write
        

        PAGE
;* ****$ TYPE msclock.asm
;[bios.apricot.ram]msclock.asm
	title 	'[bios.apricot.ram]msclock.asm'



        include 'legal.asi'




;************************************************************************
;*                                                                      *
;*                         M S C L O C K                                *
;*                                                                      *
;*	      MSDOS interface to ROM based clock driver.		*
;*                                                                      *
;*      FILENAME:       [BIOS.APRICOT.RAM]msclock.asm                  	*
;*      AUTHOR:         Ray Woolcock                                    *
;*      WRITTEN:        29-may-84                                       *
;*                                                                      *
;*      REVISION HISTORY:                                               *
;*			Generic RAM BIOS version 15/6/84 GK		*
;*                      APRICOT RAMBIOS 4/9/84 GK                       *
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

        Section msclock.DATA, align (1), class = DataQQ





;CALL TABLE FOR ROM BIOS CALLS

CALL_TABLE	BLOCK	6		;call table space

;definitions for set/get time
c_days		equ	CALL_TABLE+0	;WORD - days since 1-1-80
c_mins		equ     CALL_TABLE+2	;BYTE - minutes
c_hours		equ     CALL_TABLE+2	;BYTE - hours
c_hun_sec	equ     CALL_TABLE+2	;BYTE - hundredths of seconds
c_sec		equ     CALL_TABLE+2	;BYTE - seconds


;INTERNAL VARIABLES
DRS_ptr		block   4		;DWORD - pointer to drs




;************************************************************************
;**************************  CODE SECTION  ******************************
;************************************************************************


        Section msclock.CODE, align (1), class = InstrQQ


;ENTRY ADDRESS
        Global  msclk_driver


   page
;************************************************************************
;**********************  SUBROUTINE  msclock  ***************************
;************************************************************************
;*                                                                      *
;*                                                                      *
;*      This subroutine is called by MSINTER to handle all  calls       *
;*      to the clock device. This module is RAM resident and makes    	*
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



msclk_driver


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

	les	di,DRS_ptr			;point to DRS        
	or      ax,#0100h   			;set done bit
	mov     es:(DRS_HD_status)[di],ax   	;


        ret     #4



;***********************************************************************;
;									;
; 	           LOOK UP TABLE OF msclock FUNCTIONS			;
;									;
;***********************************************************************;


DCONTBL word    dexit	        -CODEbaseqq     ;0 - N/A Init Driver
        word    Cmd_Error       -CODEbaseqq     ;1 - N/A Media Check
        word    Cmd_Error       -CODEbaseqq     ;2 - N/A Get BPB
        word    Cmd_Error       -CODEbaseqq     ;3 - N/A IO Control,unused
        word    READ	        -CODEbaseqq     ;4 - Clock read
        word	dexit		-CODEbaseqq     ;5 - N/A Non-destructive read
        word    dexit           -CODEbaseqq     ;6 - N/A Return status,unused
        word    dexit 	        -CODEbaseqq     ;7 - N/A Flush input buffer,unused
        word    WRITE	        -CODEbaseqq     ;8 - Set clock
        word    WRITE	        -CODEbaseqq     ;9 - SET clock (with verify)
        word    dexit           -CODEbaseqq     ;10- N/A Return output status
        word    dexit           -CODEbaseqq     ;11- N/A Flush output buffer
        word    Cmd_Error       -CODEbaseqq     ;12- N/A IO Control,unused


;DUMMY ROUTINE
dexit
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
;****************************   READ   *********************************;
;***********************************************************************;
;									;
; Read the clock.							;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------


READ


;GET TRANSFER ADDRESS FROM THE DRS INTO dx:si
	mov	si,es:DRS_RW_Taddr[di]		;get transfer offset	
	mov	dx,es:DRS_RW_Taddr+2[di]	;get transfer segment


;CALL ROM BIOS TO READ THE CLOCK
	mov	cx,#0002h			;command for read clock
	mov	bx,#0037h			;clock device number
	int	#0FCh				;call ROM BIOS


        xor     ax,ax				;code for no error
        ret		                    	;RETURN
   page
;***********************************************************************;
;****************************  WRITE   *********************************;
;***********************************************************************;
;									;
; Set the clock.							;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------


WRITE


;GET TRANSFER ADDRESS FROM THE DRS INTO dx:si
	mov	si,es:DRS_RW_Taddr[di]		;get transfer offset	
	mov	dx,es:DRS_RW_Taddr+2[di]	;get transfer segment


;CALL ROM BIOS TO SET THE CLOCK
	mov	cx,#0001h			;command for read clock
	mov	bx,#0037h			;clock device number
	int	#0FCh				;call ROM BIOS

        xor     ax,ax				;code for no error

        ret		                    	;RETURN




        end
$ 