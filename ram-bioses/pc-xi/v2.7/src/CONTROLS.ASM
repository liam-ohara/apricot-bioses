
        movw    4[bx],dx
        movw    2[bx],#(vfy_PB-DataBaseQQ)
   $ TYPE controls.asm
;* [bios.apricot.rom]controls.asm
	TITLE	'[bios.apricot.rom]controls.asm'

	INCLUDE	'LEGAL.ASI'

;* controls.asm


;* ********************************************************************
;* **     CONTROL CODE HANDLER FOR CHARACTERS SENT TO THE SCREEN     **
;* **                     WHICH ARE LESS THAN 20H                    **
;* ********************************************************************


;* --------------------------------------------------------------------
;*  Control handlers code

        Name    Screen_controls_driver
        
        Section SCR_controls.code, align (1), Class = InstrQQ

        Global  CodeBaseQQ, DataBaseQQ
        
        Assume  CS:CodeBaseQQ, DS:DataBaseQQ
        
        INCLUDE 'equates.asi'
        
        GLOBAL  SCR_DRV_BELL,XPOS,YPOS,COLM_MIN,COLM_MAX
        GLOBAL  TOP_LINE,BOT_LINE,SCROLL_UP,CRLF_FLAG,CHRBASE
        GLOBAL  CBUFF,PUT_VEC,BUFF_COUNT,DISCARD_FLAG,XHANDLER
        GLOBAL  CONTROL,LINEFD
        
        GLOBAL  CONTROLS
        
CONTROL
        ;* * VALUE OF CONTROL CHAR IS IN AL

        MOV     BL,AL
        XOR     BH,BH

        SHL     BX,#1   ;* COS WE ARE IN A WORD TABLE
        JMP     [cs:CONTROL_TAB][BX]


CONTROL_TAB     WORD    NULL    -CodeBaseQQ             ;* NUL  - 00H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* SOH  - 01H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* STX  - 02H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* ETX  - 03H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* EOT  - 04H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* ENQ  - 05H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* ACK  - 06H - NO ACTION
                WORD    BELL    -CodeBaseQQ             ;* BEL  - 07H - RING BELL
                WORD    BS      -CodeBaseQQ             ;* BS   - 08H - BACK SPACE
                WORD    TAB     -CodeBaseQQ             ;* TAB  - 09H - HORIZONTAL TAB
                WORD    LINEFD  -CodeBaseQQ             ;* LF   - 0AH - LINE FEED
                WORD    LINEFD  -CodeBaseQQ             ;* VT   - 0BH - DO A LINE FEED
                WORD    LINEFD  -CodeBaseQQ             ;* FF   - 0CH - DO A LINE FEED
                WORD    CARRET  -CodeBaseQQ             ;* CR   - 0DH - CARRIAGE RETURN
                WORD    SHOUT   -CodeBaseQQ             ;* SO   - 0EH - SHIFT OUT
                WORD    SHIN    -CodeBaseQQ             ;* SI   - 0FH - SHIFT IN
                WORD    NULL    -CodeBaseQQ             ;* DLE  - 10H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* DC1  - 11H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* DC2  - 12H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* DC3  - 13H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* DC4  - 14H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* NAK  - 15H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* SYN  - 16H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* ETB  - 17H - NO ACTION
                WORD    ABORT   -CodeBaseQQ             ;* CAN  - 18H - STOP ESC SEQ
                WORD    NULL    -CodeBaseQQ             ;* EM   - 19H - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* SUB  - 1AH - NO ACTION
                WORD    XSEQ -CodeBaseQQ                ;* ESC  - 1BH - START ESC SEQ
                WORD    NULL    -CodeBaseQQ             ;* FS   - 1CH - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* GS   - 1DH - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* RS   - 1EH - NO ACTION
                WORD    NULL    -CodeBaseQQ             ;* US   - 1FH - NO ACTION
                

        PAGE
;* *******************************************************
;* *      NULL HANDLER FOR UNUSED CONTROL CODES -
;* *      DOES ABSOLUTLEY NOTHING THE WHATSOEVER
;* *******************************************************
NULL
        RET

        PAGE
;* *******************************************************
;* *      BELL ROUTINE - SOUNDS THE INTERNAL BELL
;* *      
;* *******************************************************
BELL
        CALL    SCR_drv_bell            ;* USE LOW-LEVEL
        RET

        PAGE
;* *******************************************************
;* *      BS HANDLER - MOVES THE CURSOR BACK BY ONE
;* *      COLUMN. IF AT THE LEFT-HAND SIDE, MOVE UP A
;* *      ROW, TO THE RIGHT-HAND SIDE.
;* *******************************************************
BS
        MOV     AX,XPOS                 ;* BACKSPACE
        DEC     AX                      ;* BACKWARD ONE CHAR COLUMN
        CMP     AX,COLM_MIN             ;* CHECH IF OVERLAP
        JNB     BS500                   ;* IF NOT AT LEFT SIDE OF SCREEN
        TESTB   DISCARD_FLAG,#1         ;* IN DISCARD MODE?
        JNE     BS600                   ;* YES - NO WRAP
        MOV     AX,COLM_MAX             ;* ELSE WRAP AROUND
        DEC     AX
        MOV     BX,YPOS
        CMP     BX,TOP_LINE             ;* AT TOP LINE?
        JE      BS500
        DEC     BX                      ;* SIMULATE BOT+1
        CMP     BX,BOT_LINE             ;* AT BOT+1?
        JE      BS500                   ;* YES - SO STAY THERE
        MOV     YPOS,BX                 ;* ELSE WRAP UP ONE LINE
BS500
        MOV     XPOS,AX
BS600
        RET

        PAGE
;* *******************************************************
;* *      TAB - MOVES THE CURSOR RIGHT IN MODULOS OF 8
;* *      STICKS AT RIGHT-HAND SIDE IF TOO MANY TABS
;* *******************************************************
TAB
        MOV     AX,XPOS                 ;* HORIZONTAL TAB
        ADD     AX,#8                   ;* ADD ON TAB STOP VALUE
        AND     AX,#0FFF8H              ;* AND OUT REMAINDER
        CMP     AX,COLM_MAX             ;* OFF END?
        JL      HT550                   ;* NO
        MOV     AX,COLM_MAX             ;* ELSE - STAY AT LAST COLUMN
        DEC     AX
HT550
        MOV     XPOS,AX
        RET

        PAGE
;* *******************************************************
;* *      LINE FEED - MOVES THE CURSOR DOWN ONE LINE, IF
;* *      AT BOTTOM OF SCREEN, A SCROLL UP IS PERFORMED
;* *******************************************************
LINEFD
        CALL    LINE_FD                 ;* LINE FEED
        TESTB   CRLF_FLAG,#2            ;* AN AUTO CR ON LF
        JE      LF100                   ;* NO
        MOV     AX,COLM_MIN
        MOV     XPOS,AX                 ;* YES - DO A RETURN
LF100
        RET
LINE_FD
        MOV     AX,YPOS
        MOV     BX,BOT_LINE
        CMP     AX,BX
        JE      LF300
        INC     BX                      ;* CHECK BOTTOM+1
        CMP     AX,BX
        JE      LF200                   ;* IF BOT+1 DO NOTHING
        INC     AX
        MOV     YPOS,AX
LF200
        RET
LF300
        MOV     SI,TOP_LINE             ;* SCROLL FROM TOP TO BOTTOM LINE
        MOV     DI,BOT_LINE             ;* PRINT ON BOTTOM LINE
        MOV     YPOS,DI                 ;* STAY ON BOTTOM LINE - 1
        CALL    SCROLL_UP               ;* CALL SCROLL DRIVER
        RET

        PAGE
;* *******************************************************
;* *      CARRIAGE RETURN - MOVES THE CURSOR TO THE LEFT
;* *      HAND SIDE OF THE SCREEN
;* *******************************************************
CARRET
        MOV     AX,COLM_MIN
        MOV     XPOS,AX                 ;* DO PHYSICAL RETURN
        TESTB   CRLF_FLAG,#1            ;* AUTO LF?
        JE      CR100                   ;* NO
        CALL    LINE_FD                 ;* YES
CR100
        RET

        PAGE
;* *******************************************************
;* *      SHIFT OUT - SELECTS THE SECOND CHARACTER FONT
;* *      
;* *******************************************************
SHOUT
        MOVW    CHRBASE,#FB2                    ;* CHRBASE #1
        RET

        PAGE
;* *******************************************************
;* *      SHIFT IN - SELECTS THE PRIMARY CHARACTER FONT
;* *      
;* *******************************************************
SHIN
        MOVW    CHRBASE,#FB1                  ;* CHRBASE #2
        RET

        PAGE
;* *******************************************************
;* *      ABORT - CONTROL X HANDLER TO STOP ANY ESCAPE
;* *      SEQUENCE THAT MAY BE PENDING
;* *******************************************************
ABORT
        RET

        PAGE
;* *******************************************************
;* *      ESCAPE - START ESCAPE SEQUENCE BY SETTING
;* *      FLAG AND ALTERING THE PUT VECTOR
;* *******************************************************
XSEQ
        MOVB     CBUFF,AL                      ;* INSERT INTO BUFFER
        MOVW     PUT_VEC,#XHANDLER-CodeBaseQQ  ;* SET VECTOR TO ESCAPE HANDLER
        MOVB     BUFF_COUNT,#1                 ;* RESET BUFFER COUNT
        RET

	end
$ 