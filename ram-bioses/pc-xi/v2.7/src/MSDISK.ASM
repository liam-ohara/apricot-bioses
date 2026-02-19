E OF THE QUEUE COUNT IN AX
	mov	ax,AUX_txq_count	$ TYPE msdisk.asm
;[bios.apricot.ram]msdisk.asm
	title 	'[bios.apricot.ram]MSDISK.asm'



        include 'legal.asi'




;************************************************************************
;*                                                                      *
;*                            M S D I S K                               *
;*                                                                      *
;*             MSDOS interface to ROM based disk drivers.               *
;*                                                                      *
;*      FILENAME:       [BIOS.APRICOT.RAM]msdisk.asm                 	*
;*      AUTHOR:         Ray Woolcock                                    *
;*      WRITTEN:        25-may-84                                       *
;*                                                                      *
;*      REVISION HISTORY:                                               *
;*			Generic RAM BIOS version GK 15/6/84		*
;*                      Apricot RAM BIOS version 4/9/84 GK              *
;*                                                                      *
;*                                                                      *
;*                                                                      *
;************************************************************************
  page



        include 'DRSoffs.asi'
        include 'GENEQU.asi'
	include 'mserror.asi'


        global  CODEbaseqq, DATABASEQQ

        Assume CS:CODEbaseqq, DS:DATAbaseQQ





;************************************************************************
;*************************  DATA SECTION  *******************************
;************************************************************************


        Section msdisk.DATA, align (1), class = DataQQ

;Externals
	Global	CNF_dummy_sec	;dummy sector size for external drivers


;INTERNAL VARIABLES
units           block	2	;DRS_HD_unit value
		

;CALL TABLE FOR ROM BIOS DISK HANDLER CALL

CALL_TABLE

;definitions for read/write/verify operations
c_drive		block	2	;drive number
c_command	block	2	;read/write/verify command
c_start_sec	block	2	;starting sector
c_num_sec	block	2	;number of sectors to access
c_mem_offs	block	2	;transfer address (offset)
c_mem_seg	block	2	;transfer address (segment)

;definitions for get BPB call
c_BPB_drive	equ	CALL_TABLE+0	;drive number
c_BPB_offs	equ     CALL_TABLE+2	;pointer for get BPB call (offset)
c_BPB_seg	equ	CALL_TABLE+4	;pointer for get BPB call (segment)





;************************************************************************
;**************************  CODE SECTION  ******************************
;************************************************************************


        Section msdisk.CODE, align (1), class = InstrQQ


;ENTRY ADDRESS
        Global  MSD_driver


   page
;************************************************************************
;**********************  SUBROUTINE  MSDISK  ****************************
;************************************************************************
;*                                                                      *
;*                                                                      *
;*      This subroutine is called by MSINTER to handle all  calls       *
;*      to the disk system. This module is RAM resident and makes       *
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



MSD_driver


;GET POINTER TO DRS FROM STACK, INTO ES:DI
        mov     bp,sp
        les     di,2[bp]                        ;load DRS address
        push    ds                              ;save ds


;RETRIEVE COMMONLY USED VARIABLES FROM THE DRS AND STORE IN SCRATCH REGISTERS
        mov     al,es:(DRS_HD_unit)[di]         ;drive unit number
        cbw                                     ;
        mov     units,ax                        ;


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
        
	or      es:(DRS_HD_status)[di],#0100h   ;set done bit
        pop     ds                              ;restore ds
        ret     #4




;************************************************************************
;									;
; 	           LOOK UP TABLE OF MSDISK FUNCTIONS			;
;									;
;***********************************************************************;


DCONTBL word    MSD_init        -CODEbaseqq     ;0 - Init Driver
        word    Media_Check     -CODEbaseqq     ;1 - Return current media code
        word    Get_BPB         -CODEbaseqq     ;2 - Get BIOS parameter block
        word    Cmd_Error       -CODEbaseqq     ;3 - Command error
        word    Disk_Read       -CODEbaseqq     ;4 - Block read
        word    Busy_exit       -CODEbaseqq     ;5 - Returns busy flag
        word    Cmd_Error       -CODEbaseqq     ;6 - Return status,unused
        word    Cmd_Error       -CODEbaseqq     ;7 - Flush input buffer,unused
        word    Disk_write      -CODEbaseqq     ;8 - Block write
        word    Disk_write_ver  -CODEbaseqq     ;9 - Block write with verify
        word    Cmd_Error       -CODEbaseqq     ;10- Return output status
        word    Cmd_Error       -CODEbaseqq     ;11- Flush output buffer
        word    Cmd_Error       -CODEbaseqq     ;12- IO Control,unused

;DUMMY ROUTINE
DEXIT
        movw    es:(DRS_HD_status)[di],#MSE_ok
        ret                                     ;dummy routine


;COMMAND ERROR: EXIT WITH ERROR CODE
Cmd_Error
        movw    es:(DRS_HD_status)[di],#MSE_Bad_Cmd
        ret


;RETURN BUSY FLAG
Busy_exit
        movw    es:(DRS_HD_status)[di],#0200h
        ret
   page
;***********************************************************************;
;**************************    MSD_INIT   ******************************;
;***********************************************************************;
;									;
;       MSD_init        * Called at boot-up to initialize the		;
;                       * Disk Drivers					;
;									;
;------------------------------------------------------------------------

MSD_init


;DETERMINE THE NUMBER OF FLOPPY DISK DRIVES AND POINTER TO LIST OF BPB POINTERS  

	push	ds			 ;save ds

	xor	ax,ax			 ;point to absolute memory space
	mov	ds,ax			 ;

	movb	al,416h			 ;get number of floppy disk drives
	mov	bx,418h			 ;get BPB pointer array offset
	mov	cx,41Ah			 ;get BPB pointer array segment

	pop	ds			 ;restore ds

	mov	dx,CNF_dummy_sec	;get dummy sector size from config tab
	cmp	dx,#0			;
	jz	MSD_init_1		;no entry - skip
	push	ds
	mov	ds,cx			;seg in cx
	mov	si,bx			;offset in si
	mov	si,[si]			;point to first bpb
	mov	[si],dx			;fill in dummy sector size
	movb	0Ah[si],#0FFh		;and dummy media ID
	pop	ds
	
MSD_INIT_1
        movb    es:(DRS_IN_units)[di],al ;store number of drives in DRS
        movw    es:(DRS_IN_bpb)[di],bx   ;store the BPB array offset
        movw    es:(DRS_IN_bpb+2)[di],cx ;store the BPB array segment


;RETURN OK CODE
        movw    es:(DRS_HD_status)[di],#MSE_ok


        ret
   page




;***********************************************************************;
;****************************   MEDIA  CHECK  **************************;
;***********************************************************************;
;									;
; Checks if media has been swapped.					;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
; On Exit:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------

Media_Check



;CALL ROM BIOS TO CHECK IF THE MEDIA HAS BEEN SWAPPED
	mov	bx,#39h			;code for disk handler
	mov	cx,#9			;command for media swap check
	mov	dx,units		;data= drive number to check

        int     #0FCh                   ;call ROM BIOS


;UPDATE SWAPPED STATUS   (ax=change status, 0=no swap, 1=swap, 3=no disk)
        mov     cl,#0                   ;preset media not sure status
        cmp     al,#0                   ;disk swapped ?
        jne     swapped                 ;yes, jump
        mov     cl,#1                   ;code for media not changed
swapped
        movb    es:(DRS_MC_status)[di],cl ;store swapped status


;IF DRIVE NOT READY: RETURN ERROR STATUS (ax=swap status)
	mov	cx,#MSE_ok		;preset ok status
	cmp	al,#2			;drive not ready error ?
	jne	media_present		;no, jump
	mov	cx,#MSE_drv_not_rdy	;return error code
media_present

        mov     es:(DRS_HD_status)[di],cx ;store msdos status


        ret

   page




;***********************************************************************;
;****************************  DISK READ  ******************************;
;***********************************************************************;
;									;
; Setup for a read.							;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
; On Exit:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------




Disk_Read
	movw	c_command,#0		;code for read command
        jmp     Disk_Read_Write





;***********************************************************************;
;***************************  DISK WRITE  ******************************;
;***********************************************************************;
;									;
; Setup for a write operation.						;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
; On Exit:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------



Disk_Write
	movw	c_command,#1		;code for write operation
        jmp     Disk_Read_Write

   page



;***********************************************************************;
;************************  DISK WRITE+VERIFY ***************************;
;***********************************************************************;
;									;
; Setup for a write with verify operation.				;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
; On Exit:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------




Disk_Write_ver
	movw	c_command,#3		;code for write+verify code


;DROP THROUGH TO DISK_READ_WRITE ROUTINE




;***********************************************************************;
;*************************  DISK_READ_WRITE  ***************************;
;***********************************************************************;
;									;
;  Section to handle all reads and writes				;
;									;
;  On Entry:								;
;	c_command = disk operation code					;
;	    es:di = pointer to DRS					;
;									;
; On Exit:								;
;	es:di points to the DRS						;
;									;
;------------------------------------------------------------------------



Disk_Read_Write


;SET UP CALL TABLE FOR ROM BIOS CALL     	(c_command already set up)
	mov	al,es:DRS_RW_count[di]		;set up number of sectors to transfer
	mov	ah,#0				;
	mov	c_num_sec,ax			;

	 
	mov	ax,units			;set up drive unit number
	mov	c_drive,ax			;


	mov	ax,es:DRS_RW_stsec[di]		;set up starting sector
	mov	c_start_sec,ax			;


	mov	ax,es:(DRS_RW_Taddr+0)[di]	;set up memory address, offset
	mov	c_mem_offs,ax	 	   	;


	mov	ax,es:(DRS_RW_Taddr+2)[di] 	;set up memory address, offset
	mov	c_mem_seg,ax		   	;


;SET UP REGISTERS FOR ROM BIOS CALL AND CALL ROM BIOS
	mov	bx,#39h				;disk handler code
	mov	cx,#0Bh				;command code for read/write/verify

	lea	si,CALL_TABLE			;point to CALL TABLE with dx:si
	mov	dx,ds			  	;

	int	#0FCh				;call ROM BIOS


;IF ERROR: SET TRANSFER COUNT TO ZERO   	(ax = disk status)
	cmp	ax,#MSE_ok			;error ?
	je	not_disk_error			;no, jump

	movw	es:DRS_RW_count[di],#0		;set transfer count to zero
not_disk_error
 

;STORE THE RETURNED STATUS IN THE DRS
	mov	es:DRS_HD_status[di],ax		;store in DRS


	ret					;RETURN	
   page
;***********************************************************************;
;**************************  GET_BPB  **********************************;
;***********************************************************************;
;									;
; Routine to get BIOS parameter block pointer				;
;									;
; On Entry:								;
;	es:di points to the DRS						;
;									;
; On Exit:								;
;	es:di points to the DRS						;
;									;
;-----------------------------------------------------------------------;

Get_BPB


;SET UP CALL TABLE FOR A GET BPB CALL   (si = units)
        mov     si,units
	mov	c_bpb_drive,si			;store drive number

	mov	ax,es:DRS_RW_Taddr[di]		;set up memory address
	mov	c_bpb_offs,ax			; ...offset

	mov	ax,es:(DRS_RW_Taddr+2)[di]	;set up memory address
	mov	c_bpb_seg,ax			; ...segment


;SET UP REGISTERS FOR ROM BIOS CALL AND CALL ROM BIOS
	mov	bx,#39h				;code for disk handler
	mov	cx,#0Ah				;command for get BPB pointer

	lea	si,CALL_TABLE			;point to call table with dx:si
	mov	dx,ds				;

	int	#0FCh				;call the ROM BIOS


;STORE THE RETURNED STATUS IN THE DRS
        mov     es:(DRS_HD_status)[di],ax	;store status in DRS


;STORE BPB POINTER IN DRS
	mov	ax,c_bpb_offs			;BPB offset
        mov     es:(DRS_BB_BPBptr)[di],ax	;

	mov	ax,c_bpb_seg			;BPB segment
        mov     es:(DRS_BB_BPBptr+2)[di],ax	;


        ret				  	;RETURN 


        end
$ 