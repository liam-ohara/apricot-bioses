vt100 < pcram
01       [?3h$ TYPE diskc26.asm
; [bios.apricot.rom]diskc26.asm
        title   '[bios.apricot.rom]diskc26.asm'

        INCLUDE 'legal.asi'						


;***********************************************************************;
;									;
;		            D I S K C O N 	(entry: FDC_CONFIG)	;
;									;
;	      ROM BIOS interface to the disk system.			;
;									;
; MODULE:       [bios.apricot.rom]diskc26.asm				;
; PROGRAMMER:   G. Kurth						;
; STATUS:       Test Version						;
; IMPLEMENTED:  3-feb-84						;
;									;
; MODIFICATIONS:      * Function 8 bug corrected 22-feb-84		;
;                     * CACTUS version 12-mar-84 G.K.			;
;		      * VAX version 2/5/84 GK				;
;		      * apricot version, with test for buffer on 64k	;
;			  boundary when formatting (DMA limitation)	;
;			  3/5/84 RJW.					;
;		      * Extensions to provide a comprehensive interface ;
;			  to the ROM BIOS. 7/6/84, RJW.			;
;		      * Apricot version from activm 14/8/84 GK		;
;		      * BIOS 2.4 COMPATIBLE VERSION OF DISKCON		;
;			  19/10/84 GK					;
;		      * Undocumented call to read track 19/11/84 RJW	;
;		* TENTATIVE FOREIGN DISK SUPPORT 13/3/85 GK		;
;		* read track call removed 19/3/85 GK			;
;									;
;***********************************************************************;
   page

        INCLUDE 'ioregs.asi'
	INCLUDE 'mserror.asi'

        Global  CodebaseQQ, DatabaseQQ
        
        Assume CS:CodebaseQQ, DS:DatabaseQQ, SS:DatabaseQQ
        
        INCLUDE 'FSstat.asi'
        


        Section Diskcon.data, Align(2), Class=DataQQ
;
        Global  FMT_dataseg, FMT_offset
        Global  B_FLP_TYP
	Global	DSK_type0, DSK_type1
	Global	DSK_secs0, DSK_secs1
        Global  FMT_DRIVE
	Global  diskio			;read/write/verify sectors subroutine
	Global  BPB_default		;set up default BPB
	Global  MSD_BPB0		;BPB address, drive 0
	Global  MSD_BPB1		;BPB address, drive 1
	Global	Flpy_init_drvr		;overwrite BPB if disk type invalid
	Global	FR_q_swapped		;media swap check
	Global	B_FLP_NUM		;number of floppy drives available (1,2)
	GLOBAL	B_WIN_NUM		;NUMBER OF WINCHESTER DRIVES
	GLOBAL	WID_CHANGED1,WID_CHANGED2
	GLOBAL	WID_TYPE1,WID_TYPE2
;
BPB_drive	BLOCK 2		;drive number
table_ptr	BLOCK 4		;pointer to table
buffer_ptr	BLOCK 4		;pointer to the 512 buffer
   page
;***********************************************************************;
;                    SUBROUTINE   FDC_CONFIG				;
;***********************************************************************;
;									;
;  This subroutine decodes and carries out the calls to the ROM BIOS	;
;  disk handler.							;
;									;
;  On Entry:								;
;		ax = preloaded fail (0FFFFh)				;
;        	cx = command						;
;    	 	dx = data 						;
;        or  dx:si = points to table of data				;
;									;
;  On Exit:								;
;    		ax = returned data or status				;
;		all other registers preserved				;
;									;
;***********************************************************************;

        Section diskcon.code, Align(1), Class=InstrQQ

        Global  TRKINIT
        Global  FDC_CONFIG
        Global  DO_select_drive, DO_wait_FDC, DO_FDC_clr

max_func        equ     0Ch       	;maximum legal number of function calls
        
;
FDC_CONFIG

;PRESET AX WITH FAIL STATUS (AGAIN)
	mov	ax,#0FFFFh


;IF CONTROL COMMAND IS INVALID: RETURN ERROR CODE
        cmp     cx,#max_func            ;in valid command ?
        ja      fdc_config_x		;yes, jump
        shl     cx,#1                   ;convert to word index
	mov	bx,cx			;
        jmp     [CS:FDC_CTAB][bx]       ;call routine

FDC_CONFIG_OK
        xorw    ax,ax                   ;say OK


FDC_CONFIG_X
        ret     			;RETURN  --- status in ax
  page
;***********************************************************************;
;									;
;    	       	    JUMP TABLE FOR DISK CONTROL CALLS			;
;									;
;***********************************************************************;



FDC_CTAB
        WORD    FDC_FUNC0-CodebaseQQ    ;function 0 - return status
        WORD    FDC_FUNC1-CodebaseQQ    ;function 1 - set format Drive
        WORD    FDC_FUNC2-CodebaseQQ    ;function 2 - set format segment
        WORD    FDC_FUNC3-CodebaseQQ    ;function 3 - set format offset
        WORD    FDC_FUNC4-CodebaseQQ    ;function 4 - format Disk
        WORD    FDC_FUNC5-CodebaseQQ    ;function 5 - check disk status (AP)
        WORD    FDC_FUNC6-CodebaseQQ    ;function 6 - set disk swapped
        WORD    FDC_FUNC7-CodebaseQQ    ;function 7 - return disk type
        WORD    FDC_FUNC8-CodebaseQQ    ;function 8 - return drive type
        WORD    FDC_FUNC9-CodebaseQQ    ;function 9 - check if media swapped
        WORD    FDC_FUNCA-CodebaseQQ    ;function A - get BPB pointer
        WORD    FDC_FUNCB-CodebaseQQ    ;function B - read/write/verify sectors
        WORD    FDC_FUNCC-CodebaseQQ    ;function C - check disk status
  page
;***********************************************************************;
;********************  FUNC 0:   RETURN STATUS  ************************;
;***********************************************************************;



;RETURN STATUS: SAY PRESENT AND ON-LINE
FDC_FUNC0                               ;RETURN STATUS
        jmpsh   FDC_CONFIG_OK           ;just say OK for present




;***********************************************************************;
;********************  FUNC 1: SET FORMAT DRIVE NUMBER  ****************;
;***********************************************************************;


FDC_FUNC1                               ;set format drive
;
; **** BIOS 2.4 COMPATIBILITY MODS ******
;
;ADJUST FOR NUMBER OF WINCHESTERS
	mov	dh,#0			
	MOV	BX,DX			;SAVE DRIVE NUMBER FOR RETURN
	SUB	DL,B_WIN_NUM		;SUBTRACT NUMBER OF WINIS

;IF DRIVE NOT PRESENT: SET FORMAT DRIVE TO FFFF AND RETURN ERROR
        cmpb    dl,B_FLP_NUM		;drive present ?
        jb      format_num_ok           ;yes, jump

        movw    FMT_DRIVE,ax            ;fill drive number with FFFF
	jmpsh   FDC_CONFIG_X            ;and abort with error
format_num_ok


;UPDATE FORMAT DRIVE WITH VALID DRIVE NUMBER
        movw    FMT_DRIVE,dx            ;set drive number
        MOV	AX,BX			;RETURN REQUESTED DRIVE NUMBER
	jmpsh   FDC_CONFIG_OK           ;return OK
  page
;***********************************************************************;
;********************  FUNC 2:  SET FORMAT SEGMENT  ********************;
;***********************************************************************;


;SET BUFFER SEGMENT
FDC_FUNC2                               ;set FORMAT data segment
        movw    FMT_dataseg,dx          ;set up
        jmpsh   FDC_CONFIG_OK           ;say ok




;***********************************************************************;
;********************  FUNC 3: SET FORMAT OFFSET  **********************;
;***********************************************************************;


;SET BUFFER OFFSET
FDC_FUNC3                               ;set FORMAT data offset
        movw    FMT_offset,dx           ;set up
        jmpsh   FDC_CONFIG_OK           ;say ok
  page
;***********************************************************************;
;********************  FUNC 4:  FORMAT THE DISK  ***********************;
;***********************************************************************;




;FORMAT THE DISK
FDC_FUNC4                               ;FORMAT disk

        cmpw    dx,#2                   ;valid type?
        jbe     FDC_F4_1                ;yes skip
        xor     dx,dx                   ;set type 0
FDC_F4_1
        push    dx                      ;send drive type
        call    TRKINIT                 ;format disk
        jmpsh   FDC_CONFIG_X            ;return error in AX
  page
;***********************************************************************;
;********************  FUNC 5:   RETURN DISK STATUS  *******************;
;***********************************************************************;


;RETURN DISK STATUS
FDC_FUNC5                               ;return disk status
;ADJUST FOR WINCHESTERS
	mov	dh,#0
	cmp	dl,B_WIN_NUM		;winchester request?
	jb	wini_stat
	sub	dl,B_WIN_NUM		;adjust for floppy request
        cmpb    dl,B_FLP_NUM		;drive present ?
	jb	drive_err_5		;yes - go for it
	jmp	FDC_CONFIG_X		;else return FFFF
wini_stat
	mov	ax,#0022h		;return dummy OK for winchester
	jmp	FDC_CONFIG_X

;***********************************************************************;
;********************  FUNC C:   RETURN DISK STATUS  *******************;
;***********************************************************************;


;RETURN DISK STATUS
FDC_FUNCC                               ;return disk status


;IF DRIVE NOT PRESENT:  RETURN ERROR
	mov	dh,#0			
        cmpb    dl,B_FLP_NUM		;drive present ?
        jb      drive_err_5             ;yes, jump

	mov	ax,#MSE_bad_unit	;return error code
        jmp     FDC_CONFIG_X            ;and abort with error
drive_err_5


;GET STATUS
        cmpb    FS_active,#1            ;file system active?
        jne	not_active		;no, jump
	jmp     FDC_CONFIG_X            ;yes - quit with error
not_active
        movb    FS_active,#1            ;make sure we are alone
        push    dx                      ;send drive
        call    DO_select_drive         ;and select it
        andw    ax,ax                   ;error code = 0?
        jz      FDC_F5_3                ;yes - continue
        movb    FS_active,#0            ;inactive again
        movw    ax,#0FFFFh              ;say fail
        jmp     FDC_CONFIG_X            ;and exit
FDC_F5_3
        call    DO_FDC_clr              ;clear down the FDC
        xorw    ax,ax                   ;clear ah
        in      al,#FDC_STAT            ;get status
        movb    FS_active,#0            ;inactive again
        jmp     FDC_CONFIG_X            ;and return it

  page
;***********************************************************************;
;********************  FUNC 6:   SET DRIVE SWAPPED STATUS  *************;
;***********************************************************************;



FDC_FUNC6                               ;set drive swapped
;
; ***** BIOS 2.4 COMPATABILITY MODS *****
;
; ADJUST FOR WINIS IF PRESENT
	mov	dh,#0			
	CMP	DL,B_WIN_NUM		;WINCHESTER REQUEST?
	JB	FDC_FUNC6_W		;YES - DO IT
	SUB	DL,B_WIN_NUM

;IF DRIVE NOT PRESENT:  RETURN ERROR
        cmpb    dl,B_FLP_NUM		;drive present ?
        jb      drive_err_6             ;yes, jump

        jmp     FDC_CONFIG_X            ;and abort with error
drive_err_6

;GET DRIVE SWAPPED STATUS
        mov     bx,#FS_stat-DatabaseQQ  ;point at status array
	cmpb	dl,#1
        jne     FDC_F6_3                ;skip if not 1
        add     bx,#D_length            ;adjust for drive 1
FDC_F6_3
        movb    D_swapped[bx],#1        ;say swapped
        jmp     FDC_CONFIG_OK           ;say OK

FDC_FUNC6_W
	CMP	DL,#0			;WINI 0?
	JNE	FDC_FUNC6_1W		;NO - DO 2
	MOVB	WID_CHANGED1,#01	;SET CHANGED
	JMP	FDC_CONFIG_OK
FDC_FUNC6_1W
	MOVB	WID_CHANGED2,#01
	JMP	FDC_CONFIG_OK

  page
;***********************************************************************;
;********************  FUNC 7:   GET DISK TYPE  ************************;
;***********************************************************************;



FDC_FUNC7                               ;get disk type
;
; ***** BIOS 2.4 COMPATABILITY MODS *****
;
; ADJUST FOR WINIS IF PRESENT
	mov	dh,#0			
	CMP	DL,B_WIN_NUM		;WINI REQUEST?
	JB	FDC_FUNC7_W		;YES
	SUB	DL,B_WIN_NUM

;IF DRIVE NOT PRESENT:  RETURN ERROR
        cmpb    dl,B_FLP_NUM		;drive present ?
        jb      drive_err_7             ;yes, jump

        jmp     FDC_CONFIG_X            ;and abort with error
drive_err_7


;GET DISK TYPE
        movb    al,DSK_type0            ;preload disk type 0
	cmp	dl,#1			;drive 1?
        jne     FDC_F7_3                ;no - skip
        movb    al,DSK_type1            ;load disk type 1
FDC_F7_3
        xorb    ah,ah                   ;zero out AH
	jmp	FDC_CONFIG_X

FDC_FUNC7_W
	CMP	DL,#0			;WINI 0?
	JNE	FDC_FUNC7_1W		;NO - 2
	MOV	AL,WID_TYPE1		;GET DRIVE 0 TYPE
	JMPSH	FDC_F7_3		;AND RETURN
FDC_FUNC7_1W
	MOV	AL,WID_TYPE2		;GET DRIVE 1 TYPE
	JMPSH	FDC_F7_3

  page
;***********************************************************************;
;********************  FUNC 8:  GET DRIVE TYPE  ************************;
;***********************************************************************;




;GET DRIVE TYPE

FDC_FUNC8                               ;get drive type
;ADJUST FOR WINIS IF PRESENT
	XOR	DH,DH
	CMP	DL,B_WIN_NUM		;WINI?
	JB	FDC_FUNC7_W		;YES - DO ABOVE
	SUB	DL,B_WIN_NUM
	CMP	DL,B_FLP_NUM
	JAE	FDC_FUNC8_X		;ABORT FOR INVALID DRIVE

; ignore the drive number as there is only one drive type record
        xorw    ax,ax                   ;clear ah
        movb    al,B_FLP_TYP            ;preload floppy type
FDC_FUNC8_X
        jmp     FDC_CONFIG_X            ;return type
  page
;***********************************************************************;
;*********************  FUNC 9: MEDIA SWAP CHECK  **********************;
;***********************************************************************;
;									;
;  On Entry:								;
;	          dx = drive number, 0 or 1.				;
;									;
;  On Exit:								;
;		   ax = 0 if disk not swapped				;
;	   	      = 1 if disk swapped				;
;          	      = 2 error drive not ready  			;
;									;
;									;
;***********************************************************************;


FDC_FUNC9


;IF DRIVE NOT PRESENT:  RETURN ERROR
	mov	dh,#0			
        cmpb    dl,B_FLP_NUM		;drive present ?
        jb      drive_err_9             ;yes, jump

	mov	ax,#MSE_bad_unit	;return error code
        jmp     FDC_CONFIG_X            ;and abort with error
drive_err_9


;TEST IF MEDIA CHANGED
	mov	al,dl			;get drive number in al
        call    FR_q_swapped            ;returns result in al, as stated above


;RETURN RESULT
        xor	ah,ah	             	;return result as ax

        jmp     FDC_CONFIG_X            ;return swap status in ax

   page
;***********************************************************************;
;**********************  FUNC A: GET BPB POINTER  **********************;
;***********************************************************************;
;									;
;  On Entry:								;
;	The registers dx and si form the segment and offset of a	;
;	pointer to a table containing the drive number and a double	;
;       word pointer to a 512 byte buffer. On return, this double	;
;	word pointer is overwritten with the pointer to the BPB.	;
;									; 
;	This is summarised as:						;
;									;
;	  [dx:si + 0] = drive number, 0 or 1  - WORD			;
;	  [dx:si + 2] = pointer to 512 scratch buffer   -DWORD		;
;									;
;  On Exit:								;
;	           ax = disk status					;
;       DWORD pointer = pointer to the BPB  - DWORD			;
;									;
;***********************************************************************;





FDC_FUNCA

;SAVE POINTER TO INPUT TABLE
	mov	table_ptr,si		;save table offset
	mov	table_ptr+2,dx		;save table segment


;SAVE DRIVE NUMBER AND DWORD POINTER TO BUFFER (dx:si points to input table)
	push	es			;save es
	mov	es,dx			;point to input table with es:si

	mov	ax,es:[si]		;get drive number in ax, and save it
	mov	BPB_drive,ax		;

	les	dx,es:2[si]		;get pointer to 512 buffer in es:dx
	mov	buffer_ptr,dx		;store buffer offset
	mov	buffer_ptr+2,es		;store offset

	pop	es			;restore es


;IF DRIVE NUMBER IS INVALID: EXIT WITH ERROR CODE
	cmp	al,B_FLP_NUM		;valid drive number ?
	jb	BPB_drive_ok		;yes, jump

	mov	ax,#MSE_bad_unit	;return error code
	jmp	FDC_CONFIG_X		;
BPB_drive_ok


;SET UP BPB OF SPECIFIED UNIT TO DEFAULT VALUES  (al= drive unit)
	CBW
	PUSH	AX			; SEND DRIVE NUMBER
        call    BPB_default             ;call routine in DISKIO


;READ THE LABEL SECTOR USING DEFAULT BPB 
	mov	al,BPB_drive		;get drive number

	mov	di,buffer_ptr		;get offset
	mov	dx,buffer_ptr+2		;get segment

        mov     ah,#0                   ;command for read sectors
        mov     si,#0                   ;starting sector
	mov	cx,#1			;number of sectors to read
        call    diskio	                ;read the label sector


;IF ERROR IN BPB: RETURN ERROR STATUS AND POINTER TO THE DEFAULT BPB
        cmp     ax,#MSE_ok              ;error ?
    	jne	return_bpb		;yes, jump


;BPB READ CORRECTLY: OVERWRITE DEFAULT BPB WITH BPB READ FROM DISK
        movw    di,#MSD_BPB1-DataBaseQQ ;default to offset for BPB 1
        cmpw    BPB_drive,#1            ;unit 1 ?
        je      BPB_move                ;yes, jump
        movw    di,#MSD_BPB0-DataBaseQQ ;offset for BPB 0
BPB_move
;FIRST ATTEMPT AT SUPPORTING FOREIGN DISKS
;STEP ONE - CHECK FIRST BYTE IN LABEL SECTOR FOR E9 OR EB

	CLD				;SET UP DIRECTION FOR MOVES
	PUSH	DS
	LDS	SI,BUFFER_PTR		;POINT AT LOADED HEADER
	CMPB	DS:[SI],#0EBH		;AN EBH?
	JE	FOREIGN			;YES
	CMPB	DS:[SI],#0E9H		;OR AN E9H?
	JE	FOREIGN			;YES

;ONE OF OURS - LOAD UP AS USUAL
        add     si,#50H                 ;add BPB offset in the scratch pad
        mov     cx,#8                   ;8 words long
   rep  movw                            ;move ds:si to es:di
	JMPSH	INITBPB

FOREIGN
;A FOREIGN ONE FOUND - SEE IF WE CAN HANDLE IT
	CMPW	DS:0BH[SI],#512		;SECTOR SIZE OF 512?
	JNE	BADFOREIGN		;NO - ABORT
	CMPW	DS:18H[SI],#09		;AND NINE SECTORS/TRACK?
	JNE	BADFOREIGN
	MOVW	AX,DS:1AH[SI]		;LOAD UP HEAD COUNT FOR LATER
	ADD	SI,#0BH			;POINT AT FOREIGN BPB
	MOV	CX,#13			;13 BYTES TO MOVE
   REP	MOVB
	CMP	AX,#2			;TWO HEADS?
	JE	FOREIGN2		;YES - SKIP
	XOR	AX,AX			;NOT TWO - SET TYPE 0
FOREIGN2
	STOB				;FILL IN TYPE BYTE - 0 OR 2
	XOR	AX,AX
	STOW				;FILL IN VOLUME START - 0
	JMPSH	INITBPB
;
BADFOREIGN
;A BAD FOREIGN ONE - FORCE A DEFAULT BPB
	MOVB	ES:0DH[DI],#0FFH		;FILL IN TYPE BYTE WITH INVALID DATA

INITBPB
	POP	DS			;RESTORE DS AFTER ABOVE

;IF DISK TYPE IS INVALID: OVERWRITE BPB WITH DEFAULT VALUES, AGAIN
        mov     ax,BPB_drive            ;get drive unit
        push    ax                      ;stack unit code for next routine
        call    FLPY_init_drvr          ;if disk type bad: overwrite BPB
					;...returns status in ax

;STORE POINTER TO DRIVE'S BPB IN DWORD IN INPUT TABLE & RETURN STATUS IN AX
return_bpb
        mov     cx,#MSD_BPB1-DataBaseQQ	;default to offset for BPB 1
        cmpw    BPB_drive,#1            ;unit 1 ?
        je      BPB_done                ;yes, jump
        mov     cx,#MSD_BPB0-DataBaseQQ ;no, get offset for BPB 0
BPB_done

	push	es			;save our es

	les	bx,table_ptr		;point to input table
	mov	es:2[bx],cx		;store BPB offset
	mov	es:4[bx],ds		;store BPB segemnt	

	pop	es			;restore es



        jmp     FDC_CONFIG_X            ;return swap status in ax

   page
;***********************************************************************;
;****************  FUNC B: READ/WRITE/VERIFY SECTORS  ******************;
;***********************************************************************;
;									;
;  On Entry:								;
;	  [dx:si + 0] = WORD  - drive number, 0 or 1 			;
;	  [dx:si + 2] = WORD  - command:				;
;			        0 = read 				;
;			        1 = write				;
;			        2 = verify				;
;			        3 = write + verify			;
;	  [dx:si + 4] = WORD  - starting physical sector		;
;	  [dx:si + 6] = WORD  - number of sectors			;
;	  [dx:si + 8] = DWORD - memory pointer				;
;									;
;  On Exit:								;
;	           ax = disk status					;
;	The number of sectors field is overwritten with the actual	;
;	number of sectors transferred.					;
;									;
;***********************************************************************;


FDC_FUNCB


;SAVE THE INPUT TABLE POINTER
	mov	table_ptr,si		;store offset
	mov	table_ptr+2,dx		;store segment


;SET UP REGISTERS FOR SUBROUTINE DISKIO
	push	es			;save our es
	
	mov	es,dx			;point to input table with es:si

	movb	al,es:[si]		;get drive number
	movb	ah,es:2[si]		;get command
	mov	cx,es:6[si]		;number of sectors to access
	mov	di,es:8[si]		;memory offset (if not verify)
	mov	dx,es:10[si]		;memory segment (if not verify)
	mov	si,es:4[si]		;get starting sector (overwrite si)

	pop	es			;restore our es


;IF DRIVE NOT PRESENT:  RETURN ERROR
        cmpb    al,B_FLP_NUM		;drive present ?
        jb      drive_rwv_ok            ;yes, jump

	mov	ax,#MSE_bad_unit	;return error code
        jmp     FDC_CONFIG_X            ;and abort with error
drive_rwv_ok


;DO THE TRANSFER BY CALLING DISKIO; RETURNS STATUS IN AX
	call	diskio			;do transfer


;IF ERROR: OVERWRITE NUMBER OF SECTORS TRANSFERRED (save ax = status)
	cmp	ax,#MSE_ok		;error ?
	je	no_rwv_error		;no, jump

	push	es			;save our es

	les	bx,table_ptr		;get pointer to input table in es:bx
	movw	es:6[bx],#0000h		;say 0 sectors transferred

	pop	es			;restore our es
no_rwv_error


;RETURN WITH DISK STATUS IN AX
        jmp     FDC_CONFIG_X            ;return disk status in ax


        end

$ 