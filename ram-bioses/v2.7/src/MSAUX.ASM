0       ;* CURSOR ON?
        JE      S3h$ TYPE msaux.asm
; [bios.apricot.ram]msaux.asm
	title 	'[bios.apricot.ram]MSAUX.asm'

        include 'legal.asi'




;************************************************************************
;*                                                                      *
;*                            M S A U X                                 *
;*                                                                      *
;*      MSDOS interface to ROM based serial communications driver.      *
;*                                                                      *
;*                                                                      *
;*      FILENAME:       [BIOS.APRICOT.RAM]msaux.asm                   	*
;*      AUTHOR:         Ray Woolcock                                    *
;*      WRITTEN:        12-JUN-84                                       *
;*                                                                      *
;*      REVISION HISTORY:                                               *
;*			Generic RAM BIOS 15/6/84 GK			*
;*                      Apricot RAM BIOS 3/9/84 GK	                *
;*                                                                      *
;*                                                                      *
;************************************************************************
    page    

        name    MSAUX
        
        global  CODEBASEQQ, DATABASEQQ
        
        assume  cs:CODEBASEQQ, ds:DATABASEQQ
        

        
        

;************************************************************************
;*************************  DATA SECTION  *******************************
;************************************************************************



        SECTION MSAUX.data, ALIGN(2), CLASS = DATAQQ


;INCLUDE EQUATE FILES
        INCLUDE 'DRSoffs.asi'
        INCLUDE 'Genequ.asi'

	GLOBAL	AUX_RXQ_COUNT

;INTERNAL VARIABLES
ES_save BLOCK   2                       ;Temporary save location;
DRS_ptr	BLOCK   4			;dword pointer to DRS


;CALL TABLE FOR TRANSMIT/RECEIVE STRING CALLS 
CALL_TABLE
c_count	BLOCK   2			;number of characters to transfer
c_ptr	BLOCK   4			;DWORD pointer to string
        page
;************************************************************************
;*************************  PROGRAM SECTION  ****************************
;************************************************************************



        SECTION MSAUX.code, ALIGN(1), CLASS = INSTRQQ


;ENTRY ADDRESS 
        Global  MSAUX_driver		;entered from MSINTER


;EXTERNAL ROUTINES
;	none


   page
;************************************************************************
;************************  SUBROUTINE  MSAUX  ***************************
;************************************************************************
;*                                                                      *
;*                                                                      *
;*      This subroutine is called by MSINTER to handle all  calls       *
;*      to the AUX device.  This module is RAM resident and makes       *
;*      calls to the ROM bios by  using software interrupts.            *
;*                                                                      *
;*                                                                      *
;*	Note that throughout this program: 				*
;*	    *  ES:DI points to the transfer buffer supplied by MSDOS	*
;*	    *  CX    contains the number of characters to transfer	*
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



MSAUX_driver            ;Entry point from MSINTER


;GET POINTER TO DRS FROM STACK INTO ES:BX AND SAVE
        mov     bp,sp
        movw    ES_save,es                      ;save current es
        les     bx,2[bp]                        ;set ES:BX to DRS


	mov	DRS_ptr,bx			;store ES:BX
	mov	DRS_ptr+2,es			;

        
;GET BYTE COUNT FROM DRS, INTO CX
        mov     cx,es:(DRS_RW_count)[bx]        ;CX=byte/sector count


;GET COMMAND FROM DRS, INTO AX        (whilst es:bx still points to DRS)
        mov     al,es:(DRS_HD_command)[bx]      ;AL=command code
        cbw                                     ;


;GET TRANSFER ADDRESS FROM DRS, INTO ES:DI
        mov     di,es:(DRS_RW_taddr)[bx]        ;transfer address into ES:DI
        mov     es,es:(DRS_RW_taddr+2)[bx]


;IF COMMAND INVALID: FORCE COMMAND 3   (command_error routine)
	cmp	ax,#12				;valid command ?
	jbe	no_cmd_error			;no, jump


	mov	ax,#3				;force command 3
no_cmd_error


;CALCULATE ADDRESS OF ROUTINE
	shl	ax,#1				;adjust for words
	mov	si,ax				;
	xor	ax,ax				;preload ok
	jmp	[cs:aux_control_table][si]	;JUMP to routine



;************************************************************************
;									;
; 	           LOOK UP TABLE OF MSAUX FUNCTIONS			;
;									;
;***********************************************************************;



aux_control_table        
        word    AUX_init        -codebaseqq	;0 - Initialise driver
        word    command_error   -codebaseqq	;1 - N/A  (return media code)
        word    command_error   -codebaseqq	;2 - N/A  (get BPB)
        word    command_error   -codebaseqq	;3 - io control input
        word    AUX_read        -codebaseqq	;4 - Read characters
        word    AUX_look_ahead  -codebaseqq	;5 - Non-destructive read
        word    AUX_in_stat     -codebaseqq	;6 - return input status
        word    AUX_flush_input -codebaseqq	;7 - Flush input buffer
        word    AUX_write	-codebaseqq	;8 - Write characters
        word    AUX_write       -codebaseqq	;9 - Write characters
        word    dexit           -codebaseqq	;10- N/A  (return O/P status)
        word    AUX_flush_output-codebaseqq	;11- Flush output buffer
        word    command_error   -codebaseqq	;12- N/A  (IO Control)
  page
;***********************************************************************;
;**********************  MSAUX  EXIT PROCEDURES  ***********************;
;***********************************************************************;


;DUMMY FUNCTION CALL
dexit	xor	al,al


;CALL SUCCESSFUL: SET 'done' BIT AND EXIT (al=error code)
exit    orb     ah,#00000001h
        jmp     err1


;DEVICE BUSY: SET 'done' AND 'busy' BIT AND EXIT
busy_exit
        mov     ah,#00000011b   		;busy code
	mov	al,#0				;no error
        jmp     err1


;COMMAND ERROR: RETURN CODE FOR 'Unkown Command Error' AND EXIT
command_error
        mov     al,#3            		;error code for unknown command
        mov     ah,#10000001b   		;set ERROR and COMPLETE bits


;STORE STATUS (ax) IN DRS AND RETURN TO MSINTER        
err1
        les     bx,DRS_ptr                      ;set ES:BX -> DRS
        movw    es:(DRS_HD_status)[BX],ax       ;ops are complete
        mov     es,ES_save                      ;restore es
        ret     #4                              ;RETURN --- pop DRS pointer

   page




;***********************************************************************;
;****************************  AUX  INIT  ******************************;
;***********************************************************************;
;									;
;                       Initialise AUX device.				;
;									;
; The ROM BIOS is called to initialse the AUX device. This will		;
; flush the input and output buffers and then set up the SIO		;
; according to the data in the configuration table loaded from the	;
; disk's header sector.							;
;									;
;									;
;------------------------------------------------------------------------


        
AUX_init

        
;CALL ROM BIOS TO INITIALISE THE AUX DEVICE
	mov	cx,#0000h		;command for initialisation
	mov	bx,#0034h		;device number
	int	#0FCh			;call ROM BIOS


;RETURN WITH CODE FOR NO ERROR
        xor     ax,ax			;code for no error
        jmp     exit                    ;go to exit procedure
   page




;***********************************************************************;
;****************************  AUX_IN_STAT  ****************************;
;***********************************************************************;
;									;
;                       Return input status.				;
;			Set busy bit if no input character available	;
;									;
;									;
;------------------------------------------------------------------------


        
AUX_in_stat

	xor	ax,ax
	cmp	AUX_rxq_count,ax	;input empty?
	jz	busy_exit		;yes - set busy        
	jmp     dexit                   ;go to exit procedure
   page




;***********************************************************************;
;****************************  AUX  READ  ******************************;
;***********************************************************************;
;									;
; Read character(s) from the aux device.				;
;									;
;  On Entry:								;
;	es:di = tranfer buffer						;
;	   cx = number of characters to transfer			;
;									;
;------------------------------------------------------------------------


AUX_read


;SET UP CALL TABLE FOR READ STRING
	mov	c_count,cx		;store count
	mov	c_ptr,di		;store memory offset
	mov	c_ptr+2,es		;store segment


;CALL ROM BIOS TO READ THE STRING AND EXIT
	lea	si,CALL_TABLE		;point to the table
	mov	dx,ds			   ;

	mov	cx,#0020h		;command for read string
	mov	bx,#0034h		;device number
	int	#0FCh			;call ROM BIOS

        xor     ax,ax			;code for no error
        jmp     exit                    ;go to exit procedure
   page




;***********************************************************************;
;*************************  AUX LOOK AHEAD  ****************************;
;***********************************************************************;
;									;
; Non-destructive read							;
;									;
; On Entry:								;
;	DRS_ptr points to DRS						;
;									;
; On Exit:								;
;     if character is available	it is stored in DRS_ND_data		;
;     else a device busy code is returned.				;
;									;
;------------------------------------------------------------------------





AUX_look_ahead


;CALL ROM BIOS TO READ NEXT CHARACTER
	mov	cx,#001Bh		;non-destructive read command
	mov	bx,#0034h		;device number
	int	#0FCh			;call ROM BIOS


;IF NO CHARACTER AVAILABLE RETURN BUSY CODE
	cmp	ax,#0FFFFh		;character returned in al ?
	jne	char_returned		;yes, jump

	jmp	busy_exit		;return busy code
char_returned


;STORE LOOK AHEAD CHARACTER (al) IN DRS
        les     bx,DRS_ptr              ;set ES:BX -> DRS
        mov     es:(DRS_ND_data)[bx],al ;store the character


;RETURN CODE FOR NO ERROR
        xor     ax,ax                   ;clear ax
        jmp     exit                    ;and back
   page




;***********************************************************************;
;************************  AUX FLUSH INPUT  ****************************;
;***********************************************************************;
;									;
;   Flush input buffer 							;
;   (ie, throw away charcters received but not read)			;
;									;
;   On Entry:								;
;	es:di = tranfer buffer						;
;	   cx = number of characters to transfer			;
;									;
;------------------------------------------------------------------------



AUX_flush_input


;CALL ROM BIOS TO FLUSH THE INPUT BUFFER
	mov	cx,#001Dh		;command for flush input buffer
	mov	bx,#0034h		;device number
	int	#0FCh			;call ROM BIOS


;RETURN CODE FOR NO ERROR
        xor     ax,ax                   ;retrun no error code
        jmp     exit                    ;
   page




;***********************************************************************;
;*************************  AUX FLUSH OUTPUT  **************************;
;***********************************************************************;
;									;
;   Flush output buffer 						;
;   (ie, throw away characters waiting to be transmitted)		;
;									;
;   On Entry:								;
;	es:di = tranfer buffer						;
;	   cx = number of characters to transfer			;
;									;
;------------------------------------------------------------------------


AUX_flush_output


;CALL ROM BIOS TO FLUSH THE OUTPUT BUFFER
	mov	cx,#001Ch		;command for flush output buffer
	mov	bx,#0034h		;device number
	int	#0FCh			;


;RETURN CODE FOR NO ERROR
        xor     ax,ax                   ;zap ax
        jmp     exit                    ;and back again
   page




;***********************************************************************;
;****************************  AUX  WRITE  *****************************;
;***********************************************************************;
;									;
;   Output characters to the AUX device.				;
;									;
;   On Entry:								;
;	DRS_ptr points to DRS						;
;	es:di = tranfer buffer						;
;	   cx = number of characters to transfer			;
;									;
;------------------------------------------------------------------------


AUX_write


;SET UP CALL TABLE FOR TRANSMIT STRING
	mov	c_count,cx		;store count
	mov	c_ptr,di		;store string offset
	mov	c_ptr+2,es		;store string segment


;CALL ROM BIOS TO TRANSMIT THE STRING AND EXIT
	lea	si,CALL_TABLE		;point to the table
	mov	dx,ds			   ;

	mov	cx,#001Fh		;command for transmit string
	mov	bx,#0034h		;device number
	int	#0FCh			;call ROM BIOS


;IF NOT ALL CHARACTERS OUTPUT: UPDATE COUNT IN DRS
	cmp	ax,#0			;error ?
	je	all_transmitted		;no, jump

	mov	cx,c_count		;get returned count
	les	bx,DRS_ptr		;point to DRS

	mov	es:DRS_RW_count[bx],cx	;return the actual number transmitted

	jmp	busy_exit		;
all_transmitted


;ALL TRANSMITTED: RETURN OK CODE 
        xor     ax,ax			;code for no error
        jmp     exit                    ;go to exit procedure




        END



$ 