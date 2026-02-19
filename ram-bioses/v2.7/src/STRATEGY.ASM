AL,#FDC_STAT		$ TYPE strategy.asm
;* [bios.apricot.rom]strategy.asm
	TITLE	'[bios.apricot.rom]strategy.asm'

	INCLUDE	'LEGAL.ASI'

;* strategy.asm


;* ***********************************************************************
;* ** Main screen driver module. Needs only the device drivers to print **
;* ** character. Entry is made at SCR_driver with the ASCII code of the **
;* ** character to be printed in AL. No  registers are preserved.          
;* ***********************************************************************

;* -----------------------------------------------------------------------
;*  Screen driver code

        Name    Screen_strat_driver
        
        Section SCR_strategy.code, align (1), class=instrQQ
        
        global  CodeBaseQQ, DataBaseQQ
        
        Assume cs:codebaseqq, ds:databaseqq
        
        GLOBAL  PUT_VEC,LITERAL_FLAG,CONTROL,INSERT_FLAG,INSERT_CHAR
        GLOBAL  GRAPHIC_FLAG,ATTRFLAG,SCR_DRV_WRITE,XPOS,YPOS
        GLOBAL  DISCARD_FLAG,COLM_MAX,SCR_DRV_CPOS,LINEFD,COLM_MIN
        
        Global  PUT_ACTIVE

        PAGE
;* ** PUT_ACTIVE - IF CONTROL IS PASSED TO HERE, WE HANDLE AL AS A RAW
;* **              CHARACTER (WE ARE NOT IN AN ESCAPE SEQUENCE,
;* **              BUT IT COULD BE A CONTROL CODE)


PUT_ACTIVE
        TESTB   LITERAL_FLAG,#1         ;* PRINT LITERALLY
        JNE     PUTC170                 ;* YES
        CMP     AL,#20H                 ;* A CTRL CHAR?
        JNB     PUTC170                 ;* NO
        CALL    CONTROL                 ;* YES
        JMP     PUTC350
PUTC170
        TESTB   INSERT_FLAG,#1          ;* IN INSERT MODE?
        JE      PUTC200                 ;* NO
        PUSH    AX                      ;* INSERT_CHAR DESTROYS AX
        CALL    INSERT_CHAR             ;* MOVE ALL CHARS RIGHT FROM CURSOR
        POP     AX                      ;* RESTORE AX
PUTC200
        TESTB   GRAPHIC_FLAG,#1         ;* IN 'GRAPHIC' MODE?
        JE      PUTC207                 ;* NO
PUTC205
	CMP	AL, #127
	JAE	PUTC207
	CMP	AL, #' '
	JBE	PUTC207
        SUB     AL,#5EH                  ;* CHANGE CHARACTER
PUTC207
        MOV     AH,ATTRFLAG             ;* ATTRIBUTES IN AH
        CALL    SCR_drv_write           ;* WRITE ON THE SCREEN
        MOVB    LITERAL_FLAG,#0         ;* RESET LITERAL
        INCW    XPOS                    ;* NEXT COLUMN
        MOV     AX,XPOS
        CMP     AX,COLM_MAX             ;* AT RIGHT SIDE OF SCREEN?
        JL      PUTC350                 ;* NO
        MOV     AL,DISCARD_FLAG
        OR      AL,AL                   ;* YES, IS DISACRD MODE ON
        JE      PUTC240                 ;* NO
        MOV     AX,COLM_MAX             ;* YES, STAY AT RIGHT COLUMN
        DEC     AX
        MOV     XPOS,AX
PUTC350
        JMP     SCR_drv_cpos            ;* POSITION THE CURSOR

PUTC240
        MOV     AX,COLM_MIN             ;* TO LEFT-HAND SIDE
        MOV     XPOS,AX
        CALL    LINEFD                  ;* DO A LINE-FEED
        JMP     PUTC350

	end
$ 