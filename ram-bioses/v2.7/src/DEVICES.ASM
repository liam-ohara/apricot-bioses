NG DISKIO; RETURNS STATUS IN AX
	call	diskio			;do transfer


;IF ERROR: OVERWRITE NUMB$ TYPE devices.asm
;* [bios.apricot.rom]devices.asm
	TITLE	'[bios.apricot.rom]devices.asm'

	INCLUDE	'LEGAL.ASI'

;* **************************************************************************
;* ** This is a device interpreter for accesses to the screen. Some device **
;* ** specific handlers are contained in here.                             **
;* **************************************************************************


;* -----------------------------------------------------------
;*  Devices section

        Name    Screen_device_handler
        
        Section SCR_devices.code, align (1), class=InstrQQ
        
        Include 'equates.asi'
        
        Global  CodebaseQQ, DatabaseQQ
        
        GLOBAL  SCR_DRV_CPOS,SCR_DRV_SUPD,XPOS,YPOS,COLM_MAX
        GLOBAL  SCR_DRV_WRITE,AWIDTH,COLM_MIN,SWORD,LINES,SCR_OFF_WORD
        GLOBAL  MC6845,TOP_LINE,BOT_LINE,WINDOW
        GLOBAL  CHRBASE,SCR_DRV_READ,IMG_SEG_WORD,SCR_SEG_WORD
        
        GLOBAL  POS_CURSOR,ERASE_LINES,INSERT_CHAR,CLEAR_CELL
        GLOBAL  SCROLL_DOWN,SCROLL_UP,PUT_CELL,GET_CELL
        
        Assume  CS:Codebaseqq, DS:DatabaseQQ


        PAGE
;* *******************************************************
;* *      POS_CURSOR  - POSITION CURSOR AT XPOS,YPOS
;* *
;* *******************************************************

POS_CURSOR
        JMP     SCR_drv_cpos
        
        PAGE
;* *******************************************************
;* *      ERASE_LINES - SI = TOP LINE NUMBER
;* *                    DI = BOTTOM LINE NUMBER
;* *******************************************************

ERASE_LINES
        PUSH    DS
        
        CLD                             ;* MAKE SURE
        MOV     BX,AWIDTH               ;* WIDTH OF THE ACTIVE SCREEN (WORDS) IN BX
        MOV     DX,COLM_MIN             ;* MINIMUM COLUMN OF ACTIVE SCREEN (OR WINDOW)
        MOV     ES,SCR_SEG_WORD         ;* IMAGE SEGMENT IN ES
        
        MOV     CX,DI                   ;* GET BOTTOM LINE
        SUB     CX,SI                   ;* EXTRACT NO OF LINES
        INC     CX                      ;* ADD ONE FOR LUCK
        JCXZ    NOCLRT                  ;* NOT 38 MINS

CLRLOOP
        PUSH    CX                      ;* SAVE LOOP COUINTER
        MOV     CX,BX                   ;* MAKE NEW COUNTER := NUMBER OF WORDS IN LINE
        PUSH    BX                      ;* SAVE WORDS CONSTANT
        MOV     BX,SI                   ;* BX:=SI:=OFFSET INTO THE SCREEN
        SHL     BX,#1                   ;* *2
        MOV     DI,CS:LINES[BX]         ;* EXTRACT FROM CONSTANTS TABLE
        ADD     DI,DX                   ;* ADD IN COLUMN NUMBER TO START FROM
        SHL     DI,#1                   ;* MULTIPLY BY 2
        ADD     DI,SCR_OFF_WORD         ;* ADD IN THE SEGMENT OFFSET
        POP     BX                      ;* RESTORE WORD COUNT
        MOV     AX,#VSPACE              ;* AS WE ARE CLEARING, PUT IN A SPACE
        
        REP     STOW

;****************************************
;KW1
        ;AND    DI,#1000H-1             ;* AND DESTINATION WITH THE SCREEN MASK
        ;STOW                           ;* PUT WORD ON THE SCREEN
        ;LOOP   KW1                     ;* LOOP BACK FOR ANOTHER
;****************************************

        POP     CX                      ;* RESTORE MAIN LOOP COUNTER
        INC     SI                      ;* DOWN ONE LINE
        LOOP    CLRLOOP                 ;* LOOP FOR ANOTHER

NOCLRT
        POP     DS
        ;CALL    SCR_drv_supd           ;* UPDATE REAL SCREEN
        RET


        PAGE
;* *******************************************************
;* *      INSERT_CHAR - XPOS AND YPOS, SCROLLS ALL CHARS
;* *                    TO THE RIGHT RIGHT ONE PLACE
;* *******************************************************

INSERT_CHAR
        MOV     AX,XPOS
        PUSH    AX
        MOV     AX,COLM_MAX
        DEC     AX
        MOV     XPOS,AX
IRC1
        POP     AX
        CMP     AX,XPOS
        JE      CLEAR_CELL
        PUSH    AX
        DEC     XPOS
        CALL    GET_CELL
        INC     XPOS
        CALL    PUT_CELL
        DEC     XPOS
        JMP     IRC1

        PAGE
;* *******************************************************
;* *      CLEAR_CELL  - CLEARS THE CHARACTER CELL AT
;* *                    XPOS, YPOS
;* *******************************************************

CLEAR_CELL
        MOV     AL,#20h
        MOV     AH,#BLNKAT
        JMP     SCR_drv_write
        
        PAGE
;* *******************************************************
;* *      SCROLL_DOWN - SI = TOP LINE NUMBER INCLUSIVE
;* *                    DI = BOTTOM LINE NUMBER INCLUSIVE
;* *******************************************************

SCROLL_DOWN
        ;* * ALL SCROLLING IS DONE USING THE VIRTUAL SCREEN

        PUSH    DS              ;* DON'T DESTROY DS
        PUSH    SI              ;* SAVE SI FOR LINE DELETE LATER
        CLD                     ;* MAKE SURE
        CMP     DI,SI           ;* BOTH DE SAME ?
        JE      NO_BUT_ERA      ;* YEAH
        MOV     BX,AWIDTH       ;* WIDTH (WORDS)
        MOV     DX,COLM_MIN     ;* MINIMUM COLUMN
        MOV     ES,SCR_SEG_WORD ;* IMAGE SEGMENT
        
        MOV     CX,DI           ;* CX=TOP LINE TO MOVE
        SUB     CX,SI           ;* NOW NO. OF LINES
        MOV     SI,DI           ;* GUESS WHAT!
        DEC     SI
MOVLOOP
        PUSH    DS
        PUSH    CX              ;* SAVE LOOP COUNTER
        PUSH    SI
        PUSH    BX
        MOV     BX,SI
        SHL     BX,#1
        MOV     SI,CS:LINES[BX] ;* FORMULA IS (Y*160) + (X*2)
        ADD     SI,DX
        SHL     SI,#1
        ADD     SI,SCR_OFF_WORD
        MOV     DS,ScR_SEG_WORD ;*  INTO DS &
        POP     BX
        MOV     DI,SI           ;* SI=LINE TO MOVE FROM
        ADD     DI,#160         ;* DI=LINE TO MOVE TO
        MOV     CX,BX           ;* BX=AWIDTH

        REP     MOVW

;***********************************************
;KW2
        ;AND    SI,#1000H-1
        ;LODW
        ;AND    DI,#1000H-1
        ;STOW
        ;LOOP   KW2
;***********************************************
        
        POP     SI
        POP     CX
        DEC     SI              ;* UP ONE
        POP     DS
        LOOP    MOVLOOP

NO_BUT_ERA
        POP     SI              ;* YES, SO DELETE LINE SI
        MOV     DI,SI
        POP     DS
        CALL    ERASE_LINES
        RET

SCR_CO1
        JMP     SCR_CO

        PAGE
;* *******************************************************
;* *      SCROLL_UP   - SI = TOP LINE NUMBER INCLUSIVE
;* *                    DI = BOTTOM LINE NUMBER INCLUSIVE
;* *                    ACTIVE FROM COLM_MIN & COLM_MAX
;* *******************************************************

SCROLL_UP
        CMP     SI,#0
        JNE     SCR_CO1
        CMP     DI,#23
        JNE     SCR_CO1
        CMPB    WINDOW,#1
        JE      SCR_CO1
        
        MOV     AX,SCR_OFF_WORD         ;* TAKE OLD OFFSET WORD
        ADD     AX,#160                 ;* ADD ON 160
        AND     AX,#1000H-1             ;* AND WITH SCREEN MASK
        MOV     SCR_OFF_WORD,AX         ;* UPDATE OFFSET
        SHR     AX,#1                   ;* DIVIDE BY 2 FOR CURSOR
        MOV     MC6845,AX               ;* UPDATE CURSOR OFFSET VALUE
        PUSHF                           ;* DON'T GET INTERRUPTED
        CLI
        MOV     DX,AX                   ;* AX IS USED FOR OUT VALUES
        MOV     AL,#13                  ;* LOW START ADDR
        OUT     #68H,AL                 ;* SELECT LOW REGISTER
        MOV     AL,DL                   ;* SELECT LOW HALF
        OUT     #6AH,AL                 ;* MOVE THE SCREEN
        MOV     AL,#12                  ;* SELECT HIGH REGISTER
        OUT     #68H,AL                 ;* TO CRTC
        MOV     AL,DH                   ;* HIGH HALF
        OUT     #6AH,AL                 ;* MOVE THE REST OF THE SCREEN
        POPF                            ;* RESTORE INTERRUPT STATUS
        MOV     SI,SCR_OFF_WORD         ;* TAKE OFFSET WORD
        ADD     SI,#(23*80)*2           ;* ADJUST
        MOV     DI,SI                   ;* INTO DESTINATION
        ADD     DI,#80*2                ;* GO DOWN ONE LINW
        MOV     CX,#80                  ;* 80 WORDS IN A LINE
        PUSH    DS                      ;* SAVE DS FOR LATER
        MOV     AX,ScR_SEG_WORD         ;* SAVE IMAGE SEGMENT
        MOV     DS,AX                   ;* PUT INTO DS
        MOV     ES,AX                   ;* AND ES
        PUSH    SI                      ;* SAVE OUR SOURCE FOR LINE DELETE LATER
        CLD

        REP     MOVW

;*****************************************
;MOV25TH
        ;AND    SI,#1000H-1             ;* ADJUST FOR POINTER INTO IMAGE
        ;AND    DI,#1000H-1             ;* SAME HERE
        ;LODW                           ;* READ WORD FROM IMAGE
        ;MOV    DX,#SCR_SEG             ;* SCREEN SEGMENT
        ;MOV    ES,DX
        ;STOW                           ;* PUT WORD ON REAL SCREEN
        ;MOV    DX,#IMG_SEG             ;* IMAGE SEGMENT
        ;MOV    ES,DX
        ;SUB    DI,#2                   ;* ADJUST DESTINATION
        ;STOW                           ;* STORE IN IMAGE
        ;LOOP   MOV25TH                 ;* LOOP UNTIL DONE
;*****************************************
        
        POP     DI                      ;* RESTORE POINTER TO 24TH LINE
        POP     DS                      ;* RESTORE DATA SEGMENT
        MOV     CX,#80                  ;* 80 WORDS TO DELETE
        MOV     AX,#VSPACE              ;* SPACE CHARACTER
        ;PUSH   DI

        REP     STOW

;*****************************************
;D25
        ;AND    DI,#1000H-1             ;* AND WITH SCREEN MASK
        ;STOW
        ;LOOP   D25

        ;POP    DI
        ;MOV    CX,#80                  ;* 80 WORDS AGAIN
        ;MOV    ES,SCR_SEG_WORD
;E25
        ;AND    DI,#1000H-1
        ;STOW
        ;LOOP   E25
;*****************************************

        RET                             ;* RETURN TO STRATEGY


SCR_CO
        PUSH    DI
        PUSH    DS
        CLD                     ;* MAKE SURE
        MOV     BX,AWIDTH
        MOV     DX,COLM_MIN
        MOV     ES,SCR_SEG_WORD
        MOV     CX,DI           ;* GET BOTTOM LINE
        INC     CX
        INC     SI              ;* FIXUP

SCROL1
        PUSH    DS
        PUSH    CX
        MOV     CX,BX           ;* PUT NO OF WORDS IN

        ;* * MOVE ROW NUMBER SI UP ONE, OVERWRITING THE
        ;* * ROW ABOVE IT.
        
        ;* CX=WIDTH (WORDS)
        ;* SI=START LINE
        ;* DX=LEFT COLUMN
        
        PUSH    SI
        PUSH    BX
        MOV     BX,SI
        SHL     BX,#1
        MOV     SI,CS:LINES[BX]
        ADD     SI,DX
        SHL     SI,#1
        ADD     SI,SCR_OFF_WORD
        POP     BX
        MOV     DS,SCR_SEG_WORD
        
        ;* SI IS THE FIRST POINT TO MOVE FROM
        
        MOV     DI,SI            ;* TO DESTINATION
        SUB     DI,#160          ;* UP A LINE
        
        ;* WE NOW MOVE FROM DS:SI TO ES:DI

        REP     MOVW

;************************************
;KW3
        ;AND    SI,#1000H-1
        ;LODW
        ;AND    DI,#1000H-1
        ;STOW
        ;LOOP   KW3
;************************************

        POP     SI
        POP     CX
        
        POP     DS
        INC     SI
        CMP     SI,CX
        JL      SCROL1
        
        POP     DS
        POP     DI
        MOV     SI,DI
        
        ;* NOW CLEAR THE BOTTOM LINE ON THE WINDOW:

        CALL    ERASE_LINES
        
        RET


        PAGE
;* *******************************************************
;* *      PUT_CELL    - PUTS SWORD ONTO SCREEN AT 
;* *                    XPOS, YPOS
;* *******************************************************

PUT_CELL
        MOV     AX,SWORD
        SUB     AX,CHRBASE
        JMP     SCR_drv_write
        

        PAGE
;* *******************************************************
;* *      GET_CELL    - GET XPOS YPOS CELL AND PUTS IT
;* *                    INTO SWORD (SCREEN WORD BUFFER)
;* *******************************************************

GET_CELL
        CALL    SCR_drv_read
        MOV     SWORD,AX
        RET
$ 