nput count
;
screen_active	BLOCK	1	;temporary
;
KD_datatop			;dummy label at top of data area
;
KD_downbuff	B$ TYPE escapes1.asm
;* [bios.apricot.rom]escapes1.asm
	TITLE	'[bios.apricot.rom]escapes1.asm'

        INCLUDE	'LEGAL.ASI'
        
;* escapes.asm

;* ************************************************************************
;* **     Xhandler is an internal label which handles all the escape     **
;* **     sequence logic. When the Control Code system sets the entry    **
;* **     vector to Xhandler, we get raw character codes (in AL) as      **
;* **     they are sent to be printed.  The escape handler will RETurn   **
;* **     via a short RET.   Note that nothing is preserved on entry.... **
;* ************************************************************************

        Name    Screen_escapes_drivers2
        
        Global  CodeBaseQQ, DataBaseQQ
        
        Assume  CS:CodeBaseQQ, DS:DataBaseQQ
        
        include 'equates.asi'
        


;* ------------------------------------------------------------------------
;*  Escapes code

        
        SECTION SCR_ESCAPES2.CODE, ALIGN (1), CLASS  = INSTRQQ
        
        
        GLOBAL  XHANDLER,BUFF_COUNT,CBUFF,ANSI_ACTIVE,PUT_ACTIVE,AMMODE
        GLOBAL  CHRBASE,TOP_LINE,LITERAL_FLAG,INSERT_FLAG,BOT_LINE
        GLOBAL  GRAPHIC_FLAG,UPDATE,BOT_FLAG,ENV_1,ENV_2,ENV_3,ATTRFLAG
        GLOBAL  XPOS,YPOS,AWIDTH,CLEAR_CELL,COLM_MAX,COLM_MIN,CRLF_FLAG
        GLOBAL  CRTPAR,DISCARD_FLAG,ENQUIRE,ERASE_LINES,XANSI,ANS_REPEAT
        GLOBAL  GET_CELL,INSERT_CHAR,INBIT,KEYS,LINE_MAX,MSC,LCTM
        GLOBAL  SCR_DRV_CPOS,PRNOUT,PUT_CELL,PUT_VEC,SCROLL_DOWN,SCROLL_UP
        GLOBAL  SCR_DRV_GRAPHICS,SCR_DRV_HWINIT,SCR_DRV_SUPD,SWORD,XSAV,YSAV
        GLOBAL  SCR_DRV_SETSTART,SCR_SEG_WORD,PARS,PAR_1,PAR_2,CALC_INPUT

        Global  SCR_OFF_WORD,WINDOW,Xprintchr,Xprintpage,Xprintline                          ;*  '
        Global  Xsethigh,Xsetlow,Xselfont,Xclrfore,Xsetscr,Xclrback                                  ;*  -
        Global  Xresetsz,Xsetleds,Xsetund,Xresetund,Xblinkon,X3                                      ;*  3
        Global  Xsetkey,Xtest,Xstrikeon,Xstrikeof,Xsline,Xentins                             ;*  @
        Global  Xcurup,Xcurdown,Xcuright,Xcurleft,Xcls,Xgrafik,Xegrafik                              ;*  G
        Global  Xhome,Xrevindx,Xeraseop,Xeraseol,Xinsline,Xdeline                            ;*  M
        Global  Xdelchar,Xextins,Xinsing,Xscrleft,Xscrright,Xscrup                                   ;*  S
        Global  Xscrdown,Xmsecho,Xcpos,Xvt52,Xanslead,Xenvsave,Xrestenv                              ;*  a
        Global  Xerasebep,Xrevtab,Xbiosver,Xcursave,Xcurestor,Xerline                                ;*  l
        Global  Xviewp,XcurRET,Xerasesol,Xentrev,Xextrev,Xmsmaecho,Xmsmadis                                  ;*  s
        Global  Xrapround,Xdiscard,Xset,Xresenv,Xreset,Xspr1,Xspare2                                 ;*  {
        GLOBAL  Xnoaction,Xsize,Xdispatch,Xupdate,SND_ms,ANSI_VEC
        Global  Xxmitpage,Xxmitline,Xsetkstr,Xsetvol,Xtonegen
        Global  Xmstnd,Xaltern,Xexaltern,Xentcalc,Xdmsecho,Xscrms,Xexchl
	GLOBAL	KD_STATUS

Xhandler
        MOV     CL,AL                   ;* STORE AWAY
        MOV     BL,BUFF_COUNT           ;* GET COUNT
        XOR     BH,BH
        MOV     CBUFF[BX],CL            ;* PUT IN CHARACTER
        INC     BL                      ;* NEXT ONE
        MOV     BUFF_COUNT,BL           ;* UPDATE COUNT
        MOV     DL,CBUFF+1              ;* GET FIRST CHARACTER
        XCHG    DL,BL                   ;* DL=LENGTH, BL=CHAR
        SUB     BL,#' '
        JS      ABORT_ESC               ;* OUT OF RANGE
        CMPB    DL,XSIZE[BX]            ;* GOT ALL CHARACTERS YET ?
        JB      CONT_SEQ
        XOR     BH,BH                   ;* BX COULD BE ANYTHING ON EARTH
        SHL     BX,#1
        CALL    [XDISPATCH][BX]      ;* DISPATCH SEQUENCE
        CALL    SCR_drv_cpos            ;* ALWAYS POSITION CURSOR


ABORT_ESC
        CMPB    ANSI_ACTIVE,#1          ;* IS ANSI ON ?
        JE      JUSRET                  ;* YEAH, SO JUST RETURN
        MOVW    PUT_VEC,#PUT_ACTIVE  - CODEBASEQQ ;* NO, SO RESET PRINT VECTOR

JUSRET
        MOVB    ANSI_ACTIVE,#0          ;* FOOL THE STRATEGY FOR NEXT TIME
        RET

CONT_SEQ
        MOVW    PUT_VEC,#XHANDLER - CODEBASEQQ ;* SET VECTOR FOR CONTINUE
        RET



        PAGE
;* ***************************************************************************
;* **                                                                     **
;* **   INDIVIDUAL ESCAPE SEQUENCE ROUTINES - SHOULD NEVER NEED TO BE     **
;* **                   CHANGED FOR NEW DISPLAY HARDWARE                  **
;* **                                                                     **
;* ***************************************************************************


        PAGE
;* *******************************************************
;* *      Code - #
;* *           - Hex 23
;* *           - Transmit Page
;* *******************************************************
Xxmitpage
        RET

        PAGE
;* *******************************************************
;* *      Code - $
;* *           - Hex 24
;* *           - Print Character
;* *******************************************************
Xprintchr
        CALL    GET_CELL                ;* GET CHAR IN AL
        SUB     AX,CHRBASE              ;* FIXUP
        JMP     KEYS                    ;* XMIT TO BUFFER

        PAGE
;* *******************************************************
;* *      Code - %
;* *           - Hex 25
;* *           - Transmit Line
;* *******************************************************
Xxmitline
        RET

        PAGE
;* *******************************************************
;* *      Code - &
;* *           - Hex 26
;* *           - Print Page
;* *******************************************************
Xprintpage
        ;* * DUMPS ENTIRE SCREEN TO A CONNECTED LINE PRINTER
        MOV     AX,#800H                 ;* NUMBER OF BYTES TO PRINT
        CALL    ENQUIRE
        CMP     AL,#0                   ;* CAN WE DUMP?
        JE      NODUMP                  ;* NO
        PUSH    YPOS
        MOV     AL,#12                  ;* DO A FORM FEED
        CALL    PRNOUT
        XOR     CX,CX

        ;* * THIS LOOP PLAYS WITH YPOS AND CALLS THE PRINT LINE ROUTINE
        ;* * SO AS TO MAKE THINGS REALLY FAST .....

        MOV     YPOS,CX
        MOV     CX,#24
LOO77
        PUSH    CX
        CALL    Xprintline
        INC     YPOS
        POP     CX
        LOOP    LOO77
        POP     YPOS
NODUMP
        RET

        PAGE
;* *******************************************************
;* *      Code - '
;* *           - Hex 27
;* *           - Print Line
;* *******************************************************
Xprintline
        ;* * PRINT YPOS LINE ON THE PRINTER
        PUSH    XPOS
        MOV     XPOS,#-1
        MOV     CX,#80                  ;* 80 CHARS
X_LOOP33
        INC     XPOS
        CALL    GET_CELL
        ;* * XPOS YPOS CELL NOW IN AX
        AND     AX,#0000111111111111B
        SUB     AX,CHRBASE              ;* GET RID OF OFFSETS
        JS      SPACE_PR                ;* IF <0 THEN DO SPACE
        AND     AL,#7FH                 ;* GET RID OF THE TOP-BIT
STP
        PUSH    CX
        CALL    PRNOUT                  ;* PRINT CHARACTER
        POP     CX
        LOOP    X_LOOP33                        ;* NEXT ONE

        POP     XPOS                    ;* RESTORE X POSITION
        MOV     AL,#13                  ;* CR
        CALL    PRNOUT
        MOV     AL,#10                  ;* LF
        CALL    PRNOUT
        RET

SPACE_PR
        MOV     AL,#' '                 ;* SUBSTITUTE WITH SPACE
        JMP     STP


        PAGE
;* *******************************************************
;* *      Code - (
;* *           - Hex 28
;* *           - Set High Intensity
;* *******************************************************
Xsethigh
        OR      ATTRFLAG,#INTBIT
        RET

        PAGE
;* *******************************************************
;* *      Code - )
;* *           - Hex 29
;* *           - Set Low Intensity
;* *******************************************************
Xsetlow
        MOV     BL,#INTBIT
        NOT     BL
        AND     ATTRFLAG,BL
        RET

        PAGE
;* *******************************************************
;* *      Code - *
;* *           - Hex 2A
;* *           - Select character font
;* *******************************************************
Xselfont
        MOV     AL,CBUFF+2      ;* CHARACTER SET NUMBER IN AL
        CMP     AL,#'3'         ;* TOO MANY?
        JA      NOSEL
        CMP     AL,#'0'
        JE      SEL_DEF
        CMP     AL,#'1'
        JE      SEL_SEC
        MOVW    CHRBASE,#FB3    ;* THIRD CHARACTER FONT BASE
        RET
SEL_DEF
        MOVW    CHRBASE,#FB1    ;* DEFAULT CHARACTER FONT BASE
        RET
SEL_SEC
        MOVW    CHRBASE,#FB2    ;* SECONT FONT-BASE
NOSEL
        RET

        PAGE
;* *******************************************************
;* *      Code - +
;* *           - Hex 2B
;* *           - Clear Foreground (high intensity) chars
;* *******************************************************
Xclrfore
        MOV     AL,#INTBIT      ;* HIGH ATTRIBUTE
        JMP     CLRIT           ;* TO NEXT HANDLER (-)

        PAGE
;* *******************************************************
;* *      Code - ,
;* *           - Hex 2C
;* *           - Set screen size
;* *******************************************************
Xsetscr
        MOVB    WINDOW,#1
        MOV     AL,CBUFF+2               ;* GET TOP LINE NUMBER
        CMP     AL,#20H                  ;* > 20H?
        JA      S100                    ;* NO
        MOV     AL,#20H                  ;* ROUND DOWN TO 20H
S100
        CMP     AL,#38H                  ;* > 38H?
        JB      S200                    ;* NO
        MOV     AL,#38H                  ;* ROUND UP
S200
        ;* * NOW AL IS THE NEW TOP LINE
        
        XOR     AH,AH
        SUB     AX,#20H                 ;* TAKE BASE AWAY
        MOV     TOP_LINE,AX            ;* PUT INTO TOP LINE
        
        MOV     AL,CBUFF+3
        CMP     AL,#20H
        JA      S1001
        MOV     AL,#20H
S1001
        CMP     AL,#38H
        JB      S2001
        MOV     AL,#38H
S2001
        ;* * NOW AL IS THE NEW BOTTOM LINE
        
        XOR     AH,AH
        SUB     AX,#20H
        MOV     BOT_LINE,AX
        
        MOV     AL,CBUFF+4
        CMP     AL,#20H
        JA      S1002
        MOV     AL,#20H
S1002
        CMP     AL,#9FH
        JB      S2002
        MOV     AL,#9FH
S2002   
        ;* * NOW AL IS THE NEW LEFT COLUMN
        
        XOR     AH,AH
        SUB     AX,#20H
        MOV     COLM_MIN,AX
        
        MOV     AL,CBUFF+5
        CMP     AL,#20H
        JA      S1003
        MOV     AL,#20H
S1003   
        CMP     AL,#9FH
        JB      S2003
        MOV     AL,#9FH
S2003   
        ;* * NOW AL IS THE NEW RIGHT COLUMN
        
        XOR     AH,AH
        SUB     AX,#20H
	INC	AX
        MOV     COLM_MAX,AX
        MOV     BX,COLM_MIN        
        SUB     AX,BX                   ;* WORD WIDTH = 
        MOV     AWIDTH,AX               ;* MAX COLUMN - MIN COLUMN
        
        JMP     Xhome
        
        
        PAGE
;* *******************************************************
;* *      Code - -
;* *           - Hex 2D
;* *           - Clear background (low intensity) chars
;* *******************************************************
Xclrback
        MOV     AL,#0                   ;* FLAG TO SAY 'BACKGROUND'
CLRIT
        ;* * CLEARS ALL CHARACTERS ON THE SCREEN WITH ATTRIBUTE AL

        PUSH    DS
        MOV     ES,SCR_SEG_WORD
        MOV     DS,SCR_SEG_WORD         ;* SET UP SEGMENTS FOR IMAGE
        MOV     BL,AL                   ;* SAVE FOR LATER
        MOV     CX,#2000                ;* 2000 WORDS
        XOR     SI,SI                   ;* START AT WORD 0
        CLD                             ;* MAKE SURE
DPLOOP
        LODW                            ;* GET WORD INTO AX
        CMP     BL,#0                   ;* ON BACKGROUND ?
        JE      TBACK                   ;* YES
        TEST    AH,BL                   ;* CHECK BIT
        JNZ     FOUNDONE                ;* IS IT SET ? - YES
MASK_DONE
        LOOP    DPLOOP                  ;* NO
        POP     DS                      ;* FINISH
        JMP     Xupdate                 ;* UPDATE SCREEN
        
TBACK                                   ;* TEST FOR BACKGROUND MODE
        CMP     AH,BL
        JE      FOUNDONE
        JMP     MASK_DONE

FOUNDONE
        MOV     DI,SI                   ;* PUT WORD
        SUB     DI,#2                   ;* INTO DI
        MOV     AX,#VSPACE
        STOW                            ;* PUT ON SCREEN
        JMP     MASK_DONE               ;* BACK AGAIN

        PAGE
;* *******************************************************
;* *      Code - .
;* *           - Hex 2E
;* *           - Reset screen size
;* *******************************************************
Xresetsz
        MOVW    AWIDTH  ,#80
        MOVW    TOP_LINE,#00
        MOVW    LINE_MAX,#24
        MOVW    BOT_LINE,#23
        MOVW    COLM_MIN,#00
        MOVW    COLM_MAX,#80
        MOVB    WINDOW  ,#00
        JMP     Xhome
        
        PAGE
;* *******************************************************
;* *      Code - /
;* *           - Hex 2F
;* *           - Set membrane key LED's
;* *******************************************************
Xsetleds
        JMP     SND_MS                  ;* SEND BUFFER TO MICROSCREEN
        
        PAGE
;* *******************************************************
;* *      Code - 0
;* *           - Hex 30
;* *           - Set underline mode
;* *******************************************************
Xsetund
        OR      ATTRFLAG,#UNDBIT
        RET

        PAGE
;* *******************************************************
;* *      Code - 1
;* *           - Hex 31
;* *           - Reset underline mode
;* *******************************************************
Xresetund
        MOV     BL,#UNDBIT
        NOT     BL
        AND     ATTRFLAG,BL
        RET

        PAGE
;* *******************************************************
;* *      Code - 2
;* *           - Hex 32
;* *           - Switch on cursor blink
;* *******************************************************
Xblinkon
        OR      CRTPAR,#BLINKBIT
        RET

        PAGE
;* *******************************************************
;* *      Code - 3
;* *           - Hex 33
;* *           - Switch cursor blink off
;* *******************************************************
X3
        MOV     BL,#BLINKBIT
        NOT     BL
        AND     CRTPAR,BL
        RET

        PAGE
;* *******************************************************
;* *      Code - 4
;* *           - Hex 34
;* *           - Set a key value
;* *******************************************************
Xsetkey
        PUSHF
        CLI                     ;* COVER MYSELF UP
        MOV     CX,#0
        MOV     ES,CX
        MOV     DI,#712H
        PUSH    ES:[DI]
        MOV     ES,ES:2[DI]
        POP     DI
        XOR     AX,AX
        XOR     CX,CX
        XOR     DX,DX
        MOV     DL,CBUFF+2      ;* KEY MODE
        MOV     CL,CBUFF+3      ;* KEY NUMBER
        MOV     AL,CBUFF+4      ;* NEW CHARACTER
        MOV     BX,CX
        SHL     BX,#1           ;* ADJUST FOR WORDS (IGN ATTR)

        CMP     DL,#'3'         ;* IN ALT MODE ?
        JE      CH_ALT

        CMP     DL,#'2'         ;* SHIFT MODE ?
        JE      CH_SHIFT

        CMP     DL,#'1'         ;* NORMAL MODE ?
        JE      CH_NORM
        JMP     CH_COMPLETE
        
CH_NORM
        ;* DL='1', SO CHANGE NORMAL MODE KEY

        MOV     ES:[BX][DI],AL                  ;* CHANGE THE KEY
        INC     DI                              ;* INC FOR ATTR
        MOVB    ES:[BX][DI],#10100000B  ;* REPEAT
        JMP     CH_COMPLETE

CH_SHIFT
        MOVB    ES:208[BX][DI],AL               ;* CHANGE SHIFT VALUE
        INC     DI                              ;* ALTER FOR VALUE
        MOVB    ES:208[BX][DI],#10100000B       ;* REPEAT
        JMP     CH_COMPLETE


CH_ALT
        MOVB    ES:416[BX][DI],AL               ;* AND ALT VALUE
        INC     DI
        MOVB    ES:416[BX][DI],#10100000B       ;* REPEAT

CH_COMPLETE
        POPF
        RET

        PAGE
;* *******************************************************
;* *      Code - 5
;* *           - Hex 35
;* *           - Set a key string
;* *******************************************************
Xsetkstr
        RET

        PAGE
;* *******************************************************
;* *      Code - 6
;* *           - Hex 36
;* *           - Set sound volume level
;* *******************************************************
Xsetvol
        RET

        PAGE
;* *******************************************************
;* *      Code - 7
;* *           - Hex 37
;* *           - Generate a tone
;* *******************************************************
Xtonegen
        RET

        PAGE
;* *******************************************************
;* *      Code - 8
;* *           - Hex 38
;* *           - Set literal/test mode on
;* *******************************************************
Xtest
        MOVB     LITERAL_FLAG,#1         ;* INITIATE LITERAL MODE
        RET

        PAGE
;* *******************************************************
;* *      Code - 9
;* *           - Hex 39
;* *           - Set strikeout on
;* *******************************************************
Xstrikeon
        ORB      ATTRFLAG,#STKBIT
        RET

        PAGE
;* *******************************************************
;* *      Code - :
;* *           - Hex 3A
;* *           - Set strikeout off
;* *******************************************************
Xstrikeof
        MOV     BL,#STKBIT
        NOT     BL
        AND     ATTRFLAG,BL
        RET

        PAGE
;* *******************************************************
;* *      Code - *
;* *           - Hex 3B
;* *           - Move cursor to status line
;* *******************************************************
Xsline
        MOV     AX,BOT_LINE
        INC     AX
        MOV     YPOS,AX
        MOV     XPOS,#0
        RET

        PAGE
;* *******************************************************
;* *      Code - <
;* *           - Hex 3C
;* *           - Display time and date on MSCRN
;* *******************************************************
Xmstnd
        JMP     SND_MS
        
        PAGE
;* *******************************************************
;* *      Code - =
;* *           - Hex 3D
;* *           - Enter alternate mode on keypad
;* *******************************************************
Xaltern
        MOVW    ANSI_VEC,#XREVINDX - CODEBASEQQ
        MOVB    XSIZE+8,#3
        MOVB    XSIZE+9,#3
        CALL    XDISCARD
        RET

        PAGE
;* *******************************************************
;* *      Code - >
;* *           - Hex 3E
;* *           - Exit alternate mode on keypad
;* *******************************************************
Xexaltern
        MOVW    ANSI_VEC,#XDELINE - CODEBASEQQ
        MOVB    XSIZE+8,#2
        MOVB    XSIZE+9,#2
        CALL    XRAPROUND
        RET

        PAGE
;* *******************************************************
;* *      Code - ?
;* *           - Hex 3F
;* *           - Enter CALC mode
;* *******************************************************
Xentcalc
	ORB	KD_STATUS,#04		;SET CALC STATUS ON
        MOV     AX,#4
        PUSH    AX
        CALL    CALC_INPUT
        RET
        
        PAGE
;* *******************************************************
;* *      Code - @
;* *           - Hex 40
;* *           - Enter insert mode
;* *******************************************************
Xentins
        MOVB     INSERT_FLAG,#1
        RET

        PAGE
;* *******************************************************
;* *      Code - A
;* *           - Hex 41
;* *           - Cursor up
;* *******************************************************
Xcurup
        MOV     AX,YPOS
        CMP     AX,TOP_LINE             ;* AT TOP OF SCREEN?
        JE      CUP100                  ;* YES - STAY THERE
        DEC     AX                      ;* SIMULATE BOT+1
        CMP     AX,BOT_LINE             ;* YES - ON BOTTOM LINE
        JE      CUP100                  ;* YES - STAY THERE
        MOV     YPOS,AX
CUP100
        RET


        PAGE
;* *******************************************************
;* *      Code - B
;* *           - Hex 42
;* *           - Cursor down
;* *******************************************************
Xcurdown
        MOV     AX,YPOS
        MOV     BX,BOT_LINE
        CMP     AX,BX                   ;* ON BOTTOM LINE
        JE      CDN100                  ;* YES - STAY THERE
        INC     BX                      ;* ON BOT+1?
        CMP     AX,BX
        JE      CDN100                  ;* YES - STAY THERE
        INC     AX                      ;* ELSE MOVE DOWN A LINE
        MOV     YPOS,AX
CDN100
        RET


        PAGE
;* *******************************************************
;* *      Code - C
;* *           - Hex 43
;* *           - Cursor right
;* *******************************************************
Xcuright
        MOV     AX,XPOS
        INC     AX                      ;* MOVE FORWARD ONE CHAR COLUMN
        CMP     AX,COLM_MAX             ;* AT RIGHT SIDE OF SCREEN?
        JB      CRT100                  ;* NO
        MOV     AX,COLM_MAX             ;* YES - STAY THERE
        DEC     AX
CRT100
        MOV     XPOS,AX
        RET
        

        PAGE
;* *******************************************************
;* *      Code - D
;* *           - Hex 44
;* *           - Cursor left
;* *******************************************************
Xcurleft
        MOV     AX,XPOS
        CMP     AX,COLM_MIN
        JE      CLF100
        DEC     AX                      ;* BACK ONEOM.
CLF100
        MOV     XPOS,AX
        RET


        PAGE
;* *******************************************************
;* *      Code - E
;* *           - Hex 45
;* *           - Clear screen
;* *******************************************************
Xcls
        MOV     SI,TOP_LINE
        MOV     DI,BOT_LINE
        MOV     AX,YPOS
        CMP     AX,DI                   ;* BEYOND BOTTOM LINE?
        JBE     CLEAR100                ;* NO
        INC     DI                      ;* DI = BOT+1
        MOV     SI,DI                   ;* JUST DELETE 1 LINE
        CALL    ERASE_LINES             ;* ERASE BOT LINE + 1
        MOV     XPOS,#0
        RET
CLEAR100
        CALL    Xhome
        JMP     SCR_drv_setstart        ;* RESET THE START ADDRESS 
        

        PAGE
;* *******************************************************
;* *      Code - F
;* *           - Hex 46
;* *           - Enter graphic mode
;* *******************************************************
Xgrafik
        MOVB    GRAPHIC_FLAG,#1
        RET


        PAGE
;* *******************************************************
;* *      Code - G
;* *           - Hex 47
;* *           - Exit graphic mode
;* *******************************************************
Xegrafik
        MOVB    GRAPHIC_FLAG,#0
        RET


        PAGE
;* *******************************************************
;* *      Code - H
;* *           - Hex 48
;* *           - Home cursor
;* *******************************************************
Xhome
        MOV     AX,COLM_MIN             ;* LEFT COLUMN
        MOV     XPOS,AX
        MOV     AX,TOP_LINE             ;* TOP LINE
        MOV     YPOS,AX
        RET


        PAGE
;* *******************************************************
;* *      Code - I
;* *           - Hex 49
;* *           - Reverse index
;* *******************************************************
Xrevindx
        MOV     SI,TOP_LINE
        MOV     DI,BOT_LINE
        MOV     AX,YPOS
        CMP     AX,SI                   ;* AT TOP OF SCREEN
        JE      RVLF100                 ;* YES - SCROLL
        DEC     AX                      ;* SIMULATE BOT+1
        CMP     AX,DI
        JE      RVLF200                 ;* DON'T SCROLL IF ON BOT+1
        DECW     YPOS                    ;* ELSE MOVE UP A LINE
RVLF200
        RET
RVLF100
        JMP    SCROLL_DOWN
        

        PAGE
;* *******************************************************
;* *      Code - J
;* *           - Hex 4A
;* *           - Erase to end of page
;* *******************************************************
Xeraseop
        CALL    Xeraseol             ;* FIRST ERASE TO END OF LINE
        MOV     AX,YPOS
        MOV     SI,AX
        INC     SI
        MOV     DI,BOT_LINE
        CMP     AX,DI                   ;* IF AT BOTTOM THEN DONE
        JE      EEOP200
        DEC     AX                      ;* SIMULATE BOT+1
        CMP     AX,DI                   ;* AT BOT+1?
        JE      EEOP200                 ;* YES (AS ABOVE) DONE
        CALL    ERASE_LINES
EEOP200
        RET


        PAGE
;* *******************************************************
;* *      Code - K
;* *           - Hex 4B
;* *           - Erase to end of line
;* *******************************************************
Xeraseol
        MOV     AX,XPOS
        PUSH    AX                      ;* SAVE COLUMN POSITION
EOL100
        CALL    CLEAR_CELL              ;* BLANK FOR ERASE
        INC     XPOS
        MOV     AX,XPOS
        CMP     AX,COLM_MAX             ;* ERASE TO EOL?
        JB      EOL100                  ;* NO
        POP     AX                      ;* YES - RESTORE POSITION
        MOV     XPOS,AX
        RET


        PAGE
;* *******************************************************
;* *      Code - L
;* *           - Hex 4C
;* *           - Insert line
;* *******************************************************
Xinsline
        MOV     SI,YPOS                 ;* SCROLL FROM THIS LINE
        MOV     DI,BOT_LINE             ;* TO THE BOTTOM LINE
        MOV     AX,SI
        DEC     AX                      ;* SIMULATE BOT+1
        CMP     AX,DI                   ;* DON'T INSERT AT BOT+1
        JE      INST100
        CALL    SCROLL_DOWN             ;* DOWN ONE LINE
        MOV     AX,COLM_MIN
        MOV     XPOS,AX                 ;* POSITION TO START OF LINE
INST100
        RET

        PAGE
;* *******************************************************
;* *      Code - M
;* *           - Hex 4D
;* *           - Delete line
;* *******************************************************
Xdeline
        MOV     SI,YPOS                 ;* SCROLL FROM THIS LINE
        MOV     DI,BOT_LINE             ;* TO THE BOTTOM LINE
        MOV     AX,SI
        DEC     AX                      ;* SIMULATE BOT+1
        CMP     AX,DI                   ;* DON'T DELETE AT BOT+1
        JE      DELET100
        CALL    SCROLL_UP               ;* DOWN ONE LINE
        MOV     AX,COLM_MIN
        MOV     XPOS,AX                 ;* POSITION TO START OF LINE
DELET100
        RET


        PAGE
;* *******************************************************
;* *      Code - N
;* *           - Hex 4E
;* *           - Delete character
;* *******************************************************
Xdelchar
        MOV     AX,XPOS                 ;* SAVE CHAR COLUMN POS
        PUSH    AX
DLC100
        INC     XPOS
        MOV     AX,XPOS
        CMP     AX,COLM_MAX             ;* MOVED ALL CHARS RIGHT?
        JE      DLC200                  ;* YES
        CALL    GET_CELL                ;* PUT STUFF INTO BUFFER
        DEC     XPOS                    ;* BACK ONE
        CALL    PUT_CELL                ;* PUT ON TOP OF HERE
        INC     XPOS
        JMP     DLC100
DLC200
        DEC     XPOS
        CALL    CLEAR_CELL              ;* CLEAR RIGHT-MOST CHAR
        POP     AX                      ;* RESTORE XPOS
        MOV     XPOS,AX
        JMP     SCR_DRV_SUPD
        

        PAGE
;* *******************************************************
;* *      Code - O
;* *           - Hex 4F
;* *           - Exit insert mode
;* *******************************************************
Xextins
        MOVB     INSERT_FLAG,#0
        RET


        PAGE
;* *******************************************************
;* *      Code - P
;* *           - Hex 50
;* *           - Insert single character
;* *******************************************************
Xinsing
        JMP    INSERT_CHAR             ;* USE SUBSID ROUTINE
        
        PAGE
;* *******************************************************
;* *      Code - Q
;* *           - Hex 51
;* *           - Scroll left n characters
;* *******************************************************
Xscrleft
        MOVB    UPDATE,#1
        PUSH    YPOS
        PUSH    XPOS
        MOV     CL,CBUFF+2
        XOR     CH,CH
        SUB     CL,#20H
        JCXZ    SCEND
        CMP     CL,#79
        JA      SCEND
PLOOPW
        PUSH    CX
        MOV     AX,COLM_MIN
        MOV     XPOS,AX
        MOV     AX,TOP_LINE
        MOV     YPOS,AX
CSCROLE
        CALL    Xdelchar
        INC     YPOS
        MOV     AX,YPOS
        CMP     AX,BOT_LINE
        JBE     CSCROLE
        POP     CX
        LOOP    PLOOPW
SCEND
        POP     XPOS
        POP     YPOS
        MOVB    UPDATE,#0
        JMP     XUPDATE
        
        PAGE
;* *******************************************************
;* *      Code - R
;* *           - Hex 52
;* *           - Scroll right n characters
;* *******************************************************
Xscrright
        MOVB    UPDATE,#1
        PUSH    YPOS
        PUSH    XPOS
        MOV     CL,CBUFF+2
        XOR     CH,CH
        SUB     CL,#20H
        JCXZ    SCENDR
        CMP     CL,#79
        JA      SCENDR
PLOOPR
        PUSH    CX
        
        MOV     AX,COLM_MIN
        MOV     XPOS,AX
        MOV     AX,TOP_LINE
        MOV     YPOS,AX
CSCROL
        CALL    Xinsing
        INC     YPOS
        MOV     AX,YPOS
        CMP     AX,BOT_LINE
        JBE     CSCROL
        POP     CX
        LOOP    PLOOPR
SCENDR
        POP     XPOS
        POP     YPOS
        MOVB    UPDATE,#0
        JMP     XUPDATE
        

        PAGE
;* *******************************************************
;* *      Code - S
;* *           - Hex 53
;* *           - Scroll up n lines
;* *******************************************************
Xscrup
        MOVB    UPDATE,#1
        PUSH    XPOS
        PUSH    YPOS
        MOV     CL,CBUFF+2
        XOR     CH,CH
        SUB     CL,#20H
        JCXZ    PM23
        CMP     CL,#24
        JA      PM23
        MOV     BX,CX
        MOVW    YPOS,#0
        MOV     SI,#Xdeline - CODEBASEQQ
        CALL    ANS_REPEAT

PM23
        POP     YPOS
        POP     XPOS
        MOVB    UPDATE,#0
        JMP     XUPDATE
       
        PAGE
;* *******************************************************
;* *      Code - T
;* *           - Hex 54
;* *           - Scroll down n lines
;* *******************************************************
Xscrdown
        MOV     UPDATE,#1
        PUSH    XPOS
        PUSH    YPOS
        MOV     CL,CBUFF+2
        XOR     CH,CH
        SUB     CL,#20H
        JCXZ    WE234
        CMP     CL,#24
        JA      WE234

        MOV     BX,CX
	MOV	YPOS, #0
        MOV     SI,#Xinsline - CODEBASEQQ
        CALL    ANS_REPEAT

WE234
        POP     YPOS
        POP     XPOS
        MOVB    UPDATE,#0
        JMP     XUPDATE
        

        PAGE
;* *******************************************************
;* *      Code - U
;* *           - Hex 55
;* *           - Enable MSCRN echo
;* *******************************************************
Xmsecho
        JMP     SND_MS
        

        PAGE
;* *******************************************************
;* *      Code - V
;* *           - Hex 56
;* *           - Disable MSCRN echo
;* *******************************************************
Xdmsecho
        JMP     SND_MS
        
        PAGE
;* *******************************************************
;* *      Code - W
;* *           - Hex 57
;* *           - Screen output to MSCRN only
;* *******************************************************
Xscrms
        JMP     SND_MS
        
        PAGE
;* *******************************************************
;* *      Code - X
;* *           - Hex 58
;* *           - Exchange line
;* *******************************************************
Xexchl
        RET

        end

$ 