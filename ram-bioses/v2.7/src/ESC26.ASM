t result
	jne	noscreen		;no - skip SCREEN output
nolcd
	call	[put_vec]		;[?3h$ TYPE esc26.asm
;* [bios.apricot.rom]escapes.asm
	TITLE	'[bios.apricot.rom]escapes.asm'
;******* ESC26.ASM = ESCAPES.ASM WITH LOGO PRINT ****
        INCLUDE	'LEGAL.ASI'
        
;* escapes.asm

;* ************************************************************************
;* **     Xhandler is an internal label which handles all the escape     **
;* **     sequence logic. When the Control Code system sets the entry    **
;* **     vector to Xhandler, we get raw character codes (in AL) as      **
;* **     they are sent to be printed.  The escape handler will RETurn   **
;* **     via a short RET.   Note that nothing is preserved on entry.... **
;* ************************************************************************

        Name    Screen_escapes_drivers
        
        Global  CodeBaseQQ, DataBaseQQ
        
        Assume  CS:CodeBaseQQ, DS:DataBaseQQ
        
        include 'equates.asi'
        
;* ------------------------------------------------------------------------
;*  Escapes code

        
        SECTION SCR_ESCAPES.CODE, ALIGN (1), CLASS = INSTRQQ
        
        
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
        GLOBAL  Xnoaction,Xsize,Xdispatch,Xupdate,SND_ms,ansi_vec
        GLOBAL  Xxmitpage,Xxmitline,Xsetkstr,Xsetvol,Xtonegen,Xmstnd
        Global  Xaltern,Xexaltern,Xentcalc,Xdmsecho,Xscrms,Xexchl
	GLOBAL	LCD_OUT, LCD_ECHO_ON

        PAGE
;* *******************************************************
;* *      Code - Y
;* *           - Hex 59
;* *           - Position cursor
;* *******************************************************
Xcpos
        MOV     AL,CBUFF+2              ;* LINE NUMBER
        XOR     AH,AH                   ;* AH=0
        SUB     AL,#20H
        JB      DCR800                  ;* CAN'T BE ASCII
        MOV     BL,CBUFF+3              ;* COLUMN NUMBER
        XOR     BH,BH                   ;* BH=0
        SUB     BL,#20H
        JB      DCR800                  ;* CAN'T BE ASCII
DCR150
        CMP     AX,#0                   ;* ABOVE TOP LINE?
        JA      DCR200                  ;* NO
        MOV     AX,#0                   ;* YES, SO CLIP TO TOP LINE
        JMP     DCR200
DCR200
        MOV     CX,#23
        CMP     AX,CX                   ;* BELOW OR= TO BOTTOM LINE?
        JBE     DCR300                  ;* YES - OKAY THEN
        INC     CX                      ;* NO - ON BOT+1 LINE ?
        CMP     AX,CX
        JNE     DCR350                  ;* NO - DON'T DO ANYTHING
        TESTB   BOT_FLAG,#1             ;* BOT+1 LINE ENABLED
        JE      DCR350                  ;* NO - DO COLUMN ONLY
DCR300
        MOV     YPOS,AX                 ;* CHANGE LINE POSITION
DCR350
        CMP     BX,#80                  ;* BEYOND MAX COLUMNS ?
        JB      DCR400                  ;* NO - LEAVE OK
        MOV     BX,COLM_MAX             ;* YES - CLIP TO COLM_MAX-1
        DEC     BX
DCR400
        MOV     XPOS,BX
DCR800
        RET


        PAGE
;* *******************************************************
;* *      Code - Z
;* *           - Hex 5A
;* *           - Identify as VT52
;* *******************************************************
Xvt52
        MOV     AL,#1BH
        CALL    KEYS            ;* ESC
        MOV     AL,#'/'
        CALL    KEYS            ;* /
        MOV     AL,#'K'
        JMP     KEYS            ;* K
        

        PAGE
;* *******************************************************
;* *      Code - [
;* *           - Hex 5B
;* *           - ANSI lead-in character
;* *******************************************************
Xanslead

        ;* * START OF ANSI RECOGNISED...
        
        MOVB    PARS,#0                 ;* RESET PARAMETER COUNT
        MOVB    PAR_1,#0                ;* RESET PARAMETER 1
        MOVB    PAR_2,#0                ;* AND PARAMETER 2
        MOVW    PUT_VEC,#XANSI - CODEBASEQQ     ;* SET POINTER
        MOVB    ANSI_ACTIVE,#1          ;* AND FLAG
        RET

        PAGE
;* *******************************************************
;* *      Code - \
;* *           - Hex 5C
;* *           - Function request - KEY IN BUFFER
;* *******************************************************
Xfunc
        MOV     AL,CBUFF+2
        JMP     KEYS
        
        PAGE
;* *******************************************************
;* *      Code - ]
;* *           - Hex 5D
;* *           - Transmit status line
;* *******************************************************
Xxmits
        RET

        PAGE
;* *******************************************************
;* *      Code - 
;* *           - Hex 5E
;* *           - Toggle hold mode
;* *******************************************************
Xholdmode
        RET

        PAGE
;* *******************************************************
;* *      Code - _
;* *           - Hex 5F
;* *           - Reverse function request
;* *******************************************************
Xrevfunc
        MOV     AX,SCR_SEG_WORD
        MOV     ES,AX
        MOV     CX,#2048
        CLD
        MOV     SI,SCR_OFF_WORD
        MOV     DI,SCR_OFF_WORD
FLOOP
        LODW    ES:
        CMPB    ATTRFLAG,#0
        JE      SZER
        OR      AH,ATTRFLAG
STOREIT
        STOW
        LOOP    FLOOP
        RET

SZER
        XOR     AH,AH
        JMP     STOREIT
        
        PAGE
;* *******************************************************
;* *      Code - `
;* *           - Hex 60
;* *           - Save environment
;* *******************************************************
Xenvsave
        MOV     AL,CRTPAR
        MOV     ENV_1,AL
        MOV     AL,BOT_FLAG
        MOV     ENV_2,AL
        MOV     AL,CRLF_FLAG
        MOV     ENV_3,AL
        RET

        PAGE
;* *******************************************************
;* *      Code - a
;* *           - Hex 61
;* *           - Restore environment
;* *******************************************************
Xrestenv
        MOV     AL,ENV_1
        MOV     CRTPAR,AL
        MOV     AL,ENV_2
        MOV     BOT_FLAG,AL
        MOV     AL,ENV_3
        MOV     CRLF_FLAG,AL
        RET

        PAGE
;* *******************************************************
;* *      Code - b
;* *           - Hex 62
;* *           - Erase from beginning of page
;* *******************************************************
Xerasebep
        CALL    Xerasesol            ;* ERASE FROM START OF LINE FIRST
        MOV     SI,TOP_LINE
        MOV     DI,BOT_LINE
        MOV     AX,YPOS
        CMP     AX,SI                   ;* AT TOP LINE?
        JE      EBOP100                 ;* YES - DONE
        DEC     AX                      ;* SIMULATE BOT+1
        CMP     AX,DI                   ;* AT BOT+1
        JE      EBOP100                 ;* YES - DONE
        MOV     DI,AX                   ;* ERASE FROM TOP TO LINE
        CALL    ERASE_LINES
EBOP100
        RET


        PAGE
;* *******************************************************
;* *      Code - c
;* *           - Hex 63
;* *           - Wrap MSCRN on write to 80th pos
;* *******************************************************
Xmswrap
        JMP     SND_MS
        
        PAGE
;* *******************************************************
;* *      Code - d
;* *           - Hex 64
;* *           - Scroll MSCRN on write to 80th pos
;* *******************************************************
Xmsscrl
        JMP     SND_MS

        PAGE
;* *******************************************************
;* *      Code - e
;* *           - Hex 65
;* *           - Enable cursor
;* *******************************************************
Xmscen
;;;;;	JMP	SW_CUR_ON	;NOT YET IMPLEMENTED!!!
	JMP     SND_MS
        
        PAGE
;* *******************************************************
;* *      Code - f
;* *           - Hex 66
;* *           - Disable cursor
;* *******************************************************
Xmscdis
;;;;	JMP	SW_CUR_OFF	;NOT YET IMPLEMENTED!!!
	JMP     SND_MS
        
        PAGE
;* *******************************************************
;* *      Code - g
;* *           - Hex 67
;* *           - Disable Time and Date on MSCRN
;* *******************************************************
Xmstds
        JMP     SND_MS
        
        PAGE
;* *******************************************************
;* *      Code - h
;* *           - Hex 68
;* *           - Reverse tab
;* *******************************************************
Xrevtab
        MOV     AX,XPOS 
        SUB     AX,#8
        AND     AX,#0FFF8H               ;* OFF LEFT SIDE OF SCREEN
        JNS     REVT100                 ;* NO
        MOV     AX,COLM_MIN             ;* STOP AT LEFT SIDE
REVT100
        MOV     XPOS,AX
        RET


        PAGE
;* *******************************************************
;* *      Code - i
;* *           - Hex 69
;* *           - Return BIOS version PRINT LOGO
;* *******************************************************
Xbiosver
        PUSH    ES
        MOV     AX,SCR_SEG_WORD         ;* SCREEN SEG
        MOV     ES,AX

        CMPB    CBUFF+2,#31+22          ;* LINE OUT OF RANGE ?
        JA      NOLOGO
        CMPB    CBUFF+3,#31+85          ;* COLUMN OUT OF RANGE ?
        JA      NOLOGO
        XOR     AH,AH
        MOV     AL,CBUFF+2              ;* LINE
        SUB     AL,#' '                  ;* FIXUP
        MOV     CL,#160                 ;* TIMES 160
        MUL     CL
        MOV     CL,CBUFF+3
        SUB     CL,#' '
        XOR     CH,CH
        ADD     AX,CX
        ADD     AX,CX                   ;* PLUS X TIMES TWO
        ADD     AX,SCR_OFF_WORD
        MOV     BX,AX
        MOV     CX,#21
        MOV     AX,#LOGOBASE
        
        ;* ** PRINT FIRST LINE
LLP1
        MOV     ES:[BX],AX
        INC     BX
        INC     BX
        INC     AX
        LOOP    LLP1

        ADD     BX,#160-(21*2)
        MOV     CX,#21

        ;* ** AND THE SECOND
LLP2
        MOV     ES:[BX],AX
        INC     BX
        INC     BX
        INC     AX
        LOOP    LLP2

        ADD     BX,#160-(21*2)
        MOV     CX,#21

        ;* ** THE LAST LINE
LLP3
        MOVW    ES:[BX],AX
        INC     BX
        INC     BX
        INC     AX
        LOOP    LLP3

NOLOGO
        POP     ES
        RET


        PAGE
;* *******************************************************
;* *      Code - j
;* *           - Hex 6A
;* *           - Save cursor position
;* *******************************************************
Xcursave
        MOV     AX,XPOS
        MOV     XSAV,AX
        MOV     AX,YPOS
        MOV     YSAV,AX
        RET


        PAGE
;* *******************************************************
;* *      Code - k
;* *           - Hex 6B
;* *           - Restore cursor position
;* *******************************************************
Xcurestor
        MOV     AX,XSAV
        MOV     XPOS,AX
        MOV     AX,YSAV
        MOV     YPOS,AX
        RET


        PAGE
;* *******************************************************
;* *      Code - l
;* *           - Hex 6C
;* *           - Erase line
;* *******************************************************
Xerline
        MOV     SI,YPOS
        MOV     DI,SI
        JMP     ERASE_LINES
        

        PAGE
;* *******************************************************
;* *      Code - m
;* *           - Hex 6D
;* *           - View parameters
;* *******************************************************
Xviewp
        RET

        PAGE
;* *******************************************************
;* *      Code - n
;* *           - Hex 6E
;* *           - Return cursor position
;* *******************************************************
Xcurret
        MOV     AL,#1BH                 ;* ESC
        CALL    KEYS
        MOV     AL,#'Y'                 ;* Y
        CALL    KEYS
        MOV     AX,YPOS
        ADD     AL,#20H                 ;* LINE NUMBER
        CALL    KEYS
        MOV     AX,XPOS
        ADD     AL,#20H                 ;* COLUMN NUMBER
        JMP     KEYS
        
        PAGE
;* *******************************************************
;* *      Code - o
;* *           - Hex 6F
;* *           - Erase to start of current line
;* *******************************************************
Xerasesol
        PUSH    XPOS                 ;* SAVE COLUMN POSITION
EBOL100
        CALL    CLEAR_CELL           ;* ERASE
        MOV     AX,COLM_MIN
        CMP     XPOS,AX
        JE      EBOL_X
        DEC     XPOS
        JMP     EBOL100
EBOL_X
        POP     XPOS                 ;* RESTORE COLUMN POS
        RET

        PAGE
;* *******************************************************
;* *      Code - p
;* *           - Hex 70
;* *           - Enter reverse mode
;* *******************************************************
Xentrev
        OR      ATTRFLAG,#REVBIT
        RET

        PAGE
;* *******************************************************
;* *      Code - q
;* *           - Hex 71
;* *           - Exit reverse mode
;* *******************************************************
Xextrev
        MOV     BL,#REVBIT
        NOT     BL
        AND     ATTRFLAG,BL
        RET

        PAGE
;* *******************************************************
;* *      Code - r
;* *           - Hex 72
;* *           - Main MSCRN echo - clear & cursor on
;* *******************************************************
Xmsmaecho
        JMP     SND_MS
        
        PAGE
;* *******************************************************
;* *      Code - s
;* *           - Hex 73
;* *           - Main MSCREEN echo disable
;* *******************************************************
Xmsmadis
        JMP     SND_MS
        
        PAGE
;* *******************************************************
;* *      Code - t
;* *           - Hex 74
;* *           - Enter shift mode
;* *******************************************************
Xentshft
        RET

        PAGE
;* *******************************************************
;* *      Code - u
;* *           - Hex 75
;* *           - Exit shift mode
;* *******************************************************
Xexitshft
        RET

        PAGE
;* *******************************************************
;* *      Code - v
;* *           - Hex 76
;* *           - Wrap around at end of line
;* *******************************************************
Xrapround
        MOVB     DISCARD_FLAG,#0
        RET


        PAGE
;* *******************************************************
;* *      Code - w
;* *           - Hex 77
;* *           - Discard at end of line
;* *******************************************************
Xdiscard
        MOVB     DISCARD_FLAG,#1
        RET

        PAGE
;* *******************************************************
;* *      Code - x
;* *           - Hex 78
;* *           - Set environment flags
;* *******************************************************
Xset
        XOR     BH,BH                   ;* BH=0
        MOV     BL,CBUFF+2              ;* FIND WHAT TO SET
        SUB     BL,#'1'                 ;* BELOW ASCII '0' ?
        JS      SET_DONE                ;* YES, SO EXIT
        CMP     BL,#9                   ;* FROM 0 TO 9?
        JB      SETM500                 ;* YES
        SUB     BL,#7
        CMP     BL,#7                   ;* BELOW ASCII 'A' ?
        JB      SET_DONE                ;* YES - EXIT
        CMP     BL,#12                  ;* A - C ?
        JAE     SET_DONE                ;* NO - EXIT
SETM500
        SHL     BX,#1
        JMP     [CS:SETIT][BX]
        
SET_DONE
        RET

ENABLE_BOT
        ORB             BOT_FLAG,#1             ;* SWITCH ON STATUS LINE
        RET
BLK_CUR
        ANDB    CRTPAR,#0E0H         ;* DO BLOCK
        RET

SW_CUR_OFF
CUR_OFF
        ANDB    CRTPAR,#1FH
        ORB     CRTPAR,#20H
        RET

SET_LF
        ORB      CRLF_FLAG,#1
        RET

SET_CR
        ORB      CRLF_FLAG,#2
        RET


        PAGE
;* *******************************************************
;* *      Code - y
;* *           - Hex 79
;* *           - Reset environment flags
;* *******************************************************
Xresenv
        XOR     BH,BH                   ;* BH=0
        MOV     BL,CBUFF+2              ;* FIND WHAT TO RESET
        SUB     BL,#'1'                 ;* BELOW ASCII '0' ?
        JS      REST_DONE               ;* YES, SO EXIT
        CMP     BL,#9                   ;* FROM 0 TO 9?
        JB      REST500                 ;* YES
        SUB     BL,#7
        CMP     BL,#7                   ;* BELOW ASCII 'A' ?
        JB      REST_DONE               ;* YES - EXIT
        CMP     BL,#12                  ;* A - C ?
        JAE     REST_DONE               ;* NO - EXIT
REST500
        SHL     BX,#1
        JMP     [CS:RESETIT][BX]                ;* DISPATCH
        
REST_DONE
RSET_DONE
        RET

DISABLE_BOT
        ANDB     BOT_FLAG,#0FEH
        RET

UND_CUR
        ANDB    CRTPAR,#0E0H
        ORB     CRTPAR,#00CH
        RET

SW_CUR_ON
CUR_ON
        ANDB     CRTPAR,#1FH
        RET

RSET_LF
        ANDB     CRLF_FLAG,#0FEH
        RET

RSET_CR
        ANDB     CRLF_FLAG,#0FDH
        RET

        PAGE
;* *******************************************************
;* *      Code - z
;* *           - Hex 7A
;* *           - Reset all modes
;* *******************************************************
Xreset

        ;* RESET VARIABLES FOR POWER-UP
        
        MOVW     XPOS            ,#0
        MOVW     YPOS            ,#0
        MOVW     YSAV            ,#0
        MOVW     XSAV            ,#0
        MOVB     ATTRFLAG        ,#0
        MOVW     COLM_MAX        ,#80
        MOVW     COLM_MIN        ,#0
        MOVW     LINE_MAX        ,#24
        MOVW     AWIDTH          ,#80
        MOVW     TOP_LINE        ,#0
        MOVW     BOT_LINE        ,#23
        MOVB     INSERT_FLAG     ,#0
        MOVB     DISCARD_FLAG    ,#0
        MOVB     CRLF_FLAG       ,#0
        MOVB     LITERAL_FLAG    ,#0
        MOVB     GRAPHIC_FLAG    ,#0
        MOVB     BOT_FLAG        ,#0
        MOVB     CRTPAR          ,#0
        MOVB     BUFF_COUNT      ,#0
        MOVW     SWORD           ,#0
        MOVW     CHRBASE         ,#FB1
        MOVB     WINDOW          ,#0
        MOVW     PUT_VEC         ,#PUT_ACTIVE - CODEBASEQQ
        MOVB     AMMODE		 ,#0
        
        ;* ** DO A HARDWARE INIT
        JMP      SCR_drv_hwinit
        
        

        PAGE
;* *******************************************************
;* *      Code - {
;* *           - Hex 7B
;* *           - Spare
;* *******************************************************
Xspr1
XUPDATE
        JMP     SCR_drv_supd
        
        PAGE
;* *******************************************************
;* *      Code - |
;* *           - Hex 7C
;* *           - Enter 132 column mode
;* *******************************************************
Xent132
        RET

        PAGE
;* *******************************************************
;* *      Code - }
;* *           - Hex 7D
;* *           - Spare
;* *******************************************************
Xspare2
        mov     bx,#31h
        mov     cx,#1
        mov     dx,#1
        int     #0fch
        ret
        
;* *******************************************************
;* *      Code - ?
;* *           - Hex ??
;* *           - Do nothing
;* *******************************************************
Xnoaction
        RET


;* ** SUBSID ROUTINE - SENDS ESCAPE BUFFER TO THE MICROSCREEN DRIVER

SND_MS
	CMPB	LCD_ECHO_ON,#1		;* ECHO ALREADY ON?
	JE	SND_MSX			;* YES - DO NOT REPEAT SEQUENCE

        MOV     CL,BUFF_COUNT
        XOR     CH,CH
        MOV     SI,#CBUFF - DATABASEQQ
        CLD
MSLOOP
        LODB                            ;* GET CHAR FROM BUFFER
        PUSH    CX
        PUSH    SI
	PUSH	AX
        CALL    LCD_OUT                   ;* PRINT CHARACTER
        POP     SI
        POP     CX
        LOOP    MSLOOP
SND_MSX
        RET
        
        

RESETIT         WORD    DISABLE_BOT             -CODEBASEQQ                     
                WORD    RSET_DONE               -CODEBASEQQ                     
                WORD    RSET_DONE               -CODEBASEQQ                     
                WORD    UND_CUR                 -CODEBASEQQ                     
                WORD    CUR_ON                  -CODEBASEQQ                     
                WORD    RSET_DONE               -CODEBASEQQ                     
                WORD    RSET_DONE               -CODEBASEQQ                     
                WORD    RSET_LF                 -CODEBASEQQ                     
                WORD    RSET_CR                 -CODEBASEQQ                     
                WORD    RSET_DONE               -CODEBASEQQ                     
                WORD    RSET_DONE               -CODEBASEQQ                     
                WORD    RSET_DONE               -CODEBASEQQ                     


SETIT           WORD    ENABLE_BOT              -CODEBASEQQ
                WORD    SET_DONE                -CODEBASEQQ
                WORD    SET_DONE                -CODEBASEQQ
                WORD    BLK_CUR                 -CODEBASEQQ                             
                WORD    CUR_OFF                 -CODEBASEQQ                             
                WORD    SET_DONE                -CODEBASEQQ                             
                WORD    SET_DONE                -CODEBASEQQ                             
                WORD    SET_LF                  -CODEBASEQQ                             
                WORD    SET_CR                  -CODEBASEQQ                             
                WORD    SET_DONE                -CODEBASEQQ                             
                WORD    SET_DONE                -CODEBASEQQ                             
                WORD    SET_DONE                -CODEBASEQQ                             


        section Xdispatch.data, align (2), class = ConstQQ
        
        PAGE
;* *******************************************************************
;* ** TABLE FOR SIZE OF ESCAPE SEQUENCES THAT HANDLER MUST WAIT FOR **
;* *******************************************************************

XSIZE           BYTE    2       ;*  20H    
                BYTE    2       ;*  21H   !
                BYTE    2       ;*  22H
                BYTE    2       ;*  23H   
                BYTE    2       ;*  24H   $
                BYTE    2       ;*  25H   %
                BYTE    2       ;*  26H   &
                BYTE    2       ;*  27H   '
                BYTE    2       ;*  28H   (
                BYTE    2       ;*  29H   )
                BYTE    3       ;*  2AH   *
                BYTE    2       ;*  2BH   +
                BYTE    6       ;*  2CH   ,
                BYTE    2       ;*  2DH   -
                BYTE    2       ;*  2EH   .
                BYTE    3       ;*  2FH   /
                BYTE    2       ;*  30H   0
                BYTE    2       ;*  31H   1
                BYTE    2       ;*  32H   2
                BYTE    2       ;*  33H   3
                BYTE    5       ;*  34H   4
                BYTE    3       ;*  35H   5
                BYTE    3       ;*  36H   6
                BYTE    3       ;*  37H   7
                BYTE    2       ;*  38H   8
                BYTE    2       ;*  39H   9
                BYTE    2       ;*  3AH   :
                BYTE    2       ;*  3BH   ;* 
                BYTE    2       ;*  3CH   <
                BYTE    2       ;*  3DH   =
                BYTE    2       ;*  3EH   >
                BYTE    2       ;*  3FH   ?
                BYTE    2       ;*  40H   @
                BYTE    2       ;*  41H   A
                BYTE    2       ;*  42H   B
                BYTE    2       ;*  43H   C
                BYTE    2       ;*  44H   D
                BYTE    2       ;*  45H   E
                BYTE    2       ;*  46H   F
                BYTE    2       ;*  47H   G
                BYTE    2       ;*  48H   H
                BYTE    2       ;*  49H   I
                BYTE    2       ;*  4AH   J
                BYTE    2       ;*  4BH   K
                BYTE    2       ;*  4CH   L
                BYTE    2       ;*  4DH   M
                BYTE    2       ;*  4EH   N
                BYTE    2       ;*  4FH   O
                BYTE    2       ;*  50H   P
                BYTE    3       ;*  51H   Q
                BYTE    3       ;*  52H   R
                BYTE    3       ;*  53H   S
                BYTE    3       ;*  54H   T
                BYTE    2       ;*  55H   U
                BYTE    2       ;*  56H   V
                BYTE    2       ;*  57H   W
                BYTE    2       ;*  58H   X
                BYTE    4       ;*  59H   Y
                BYTE    2       ;*  5AH   Z
                BYTE    2       ;*  5BH   [
                BYTE    3       ;*  5CH   
                BYTE    2       ;*  5DH   ]
                BYTE    2       ;*  5EH   
                BYTE    2       ;*  5FH   _ 
                BYTE    2       ;*  60H   `
                BYTE    2       ;*  61H   a
                BYTE    2       ;*  62H   b
                BYTE    2       ;*  63H   c
                BYTE    2       ;*  64H   d
                BYTE    2       ;*  65H   e
                BYTE    2       ;*  66H   f
                BYTE    2       ;*  67H   g
                BYTE    2       ;*  68H   h
                BYTE    4       ;*  69H   i
                BYTE    2       ;*  6AH   j
                BYTE    2       ;*  6BH   k
                BYTE    2       ;*  6CH   l
                BYTE    2       ;*  6DH   m
                BYTE    2       ;*  6EH   n
                BYTE    2       ;*  6FH   o
                BYTE    2       ;*  70H   p
                BYTE    2       ;*  71H   q
                BYTE    2       ;*  72H   r
                BYTE    2       ;*  73H   s
                BYTE    2       ;*  74H   t
                BYTE    2       ;*  75H   u
                BYTE    2       ;*  76H   v
                BYTE    2       ;*  77H   w
                BYTE    3       ;*  78H   x
                BYTE    3       ;*  79H   y
                BYTE    2       ;*  7AH   z
                BYTE    2       ;*  7BH   {
                BYTE    2       ;*  7CH   |
                BYTE    2       ;*  7DH   }


        PAGE
;* *************************************************************
;* ** Dispatch table for escape sequences, one-word entries   **
;* *************************************************************


Xdispatch       WORD    Xnoaction               -CODEBASEQQ          ;*   
                WORD    Xnoaction               -CODEBASEQQ          ;*  !
                WORD    Xnoaction               -CODEBASEQQ          ;*   
                WORD    Xxmitpage               -CODEBASEQQ          ;*   
                WORD    Xprintchr               -CODEBASEQQ          ;*  $
                WORD    Xxmitline               -CODEBASEQQ          ;*  %
                WORD    Xprintpage              -CODEBASEQQ          ;*  &
                WORD    Xprintline              -CODEBASEQQ          ;*  '
                WORD    Xsethigh                -CODEBASEQQ          ;*  (
                WORD    Xsetlow                 -CODEBASEQQ          ;*  )
                WORD    Xselfont                -CODEBASEQQ          ;*  *
                WORD    Xclrfore                -CODEBASEQQ          ;*  +
                WORD    Xsetscr                 -CODEBASEQQ          ;*  ,
                WORD    Xclrback                -CODEBASEQQ          ;*  -
                WORD    Xresetsz                -CODEBASEQQ          ;*  .
                WORD    Xsetleds                -CODEBASEQQ          ;*  /
                WORD    Xsetund                 -CODEBASEQQ          ;*  0
                WORD    Xresetund               -CODEBASEQQ          ;*  1
                WORD    Xblinkon                -CODEBASEQQ          ;*  2
                WORD    X3                      -CODEBASEQQ          ;*  3
                WORD    Xsetkey                 -CODEBASEQQ          ;*  4
                WORD    Xsetkstr                -CODEBASEQQ          ;*  5
                WORD    Xsetvol                 -CODEBASEQQ          ;*  6
                WORD    Xtonegen                -CODEBASEQQ          ;*  7
                WORD    Xtest                   -CODEBASEQQ          ;*  8
                WORD    Xstrikeon               -CODEBASEQQ          ;*  9
                WORD    Xstrikeof               -CODEBASEQQ          ;*  :
                WORD    Xsline                  -CODEBASEQQ          ;*  ;* 
LCTM            WORD    Xmstnd                  -CODEBASEQQ          ;*  <
                WORD    Xaltern                 -CODEBASEQQ          ;*  =
                WORD    Xexaltern               -CODEBASEQQ          ;*  >
                WORD    Xentcalc                -CODEBASEQQ          ;*  ?
                WORD    Xentins                 -CODEBASEQQ          ;*  @
                WORD    Xcurup                  -CODEBASEQQ          ;*  A
                WORD    Xcurdown                -CODEBASEQQ          ;*  B
                WORD    Xcuright                -CODEBASEQQ          ;*  C
                WORD    Xcurleft                -CODEBASEQQ          ;*  D
                WORD    Xcls                    -CODEBASEQQ          ;*  E
                WORD    Xgrafik                 -CODEBASEQQ          ;*  F
                WORD    Xegrafik                -CODEBASEQQ          ;*  G
                WORD    Xhome                   -CODEBASEQQ          ;*  H
                WORD    Xrevindx                -CODEBASEQQ          ;*  I
                WORD    Xeraseop                -CODEBASEQQ          ;*  J
                WORD    Xeraseol                -CODEBASEQQ          ;*  K
                WORD    Xinsline                -CODEBASEQQ          ;*  L
ANSI_VEC        WORD    Xdeline                 -CODEBASEQQ          ;*  M
                WORD    Xdelchar                -CODEBASEQQ          ;*  N
                WORD    Xextins                 -CODEBASEQQ          ;*  O
                WORD    Xinsing                 -CODEBASEQQ          ;*  P
                WORD    Xscrleft                -CODEBASEQQ          ;*  Q
                WORD    Xscrright               -CODEBASEQQ          ;*  R
                WORD    Xscrup                  -CODEBASEQQ          ;*  S
                WORD    Xscrdown                -CODEBASEQQ          ;*  T
                WORD    Xmsecho                 -CODEBASEQQ          ;*  U
                WORD    Xdmsecho                -CODEBASEQQ          ;*  V
                WORD    Xscrms                  -CODEBASEQQ          ;*  W
                WORD    Xexchl                  -CODEBASEQQ          ;*  X
                WORD    Xcpos                   -CODEBASEQQ          ;*  Y
                WORD    Xvt52                   -CODEBASEQQ          ;*  Z
                WORD    Xanslead                -CODEBASEQQ          ;*  [
                WORD    Xfunc                   -CODEBASEQQ          ;*  
                WORD    Xxmits                  -CODEBASEQQ          ;*  ]
                WORD    Xholdmode               -CODEBASEQQ          ;*  
                WORD    Xrevfunc                -CODEBASEQQ          ;*  _
                WORD    Xenvsave                -CODEBASEQQ          ;*  `
                WORD    Xrestenv                -CODEBASEQQ          ;*  a
                WORD    Xerasebep               -CODEBASEQQ          ;*  b
                WORD    Xmswrap                 -CODEBASEQQ          ;*  c
                WORD    Xmsscrl                 -CODEBASEQQ          ;*  d
                WORD    Xmscen                  -CODEBASEQQ          ;*  e
                WORD    Xmscdis                 -CODEBASEQQ          ;*  f
                WORD    Xmstds                  -CODEBASEQQ          ;*  g
                WORD    Xrevtab                 -CODEBASEQQ          ;*  h
                WORD    Xbiosver                -CODEBASEQQ          ;*  i
                WORD    Xcursave                -CODEBASEQQ          ;*  j
                WORD    Xcurestor               -CODEBASEQQ          ;*  k
                WORD    Xerline                 -CODEBASEQQ          ;*  l
                WORD    Xviewp                  -CODEBASEQQ          ;*  m
                WORD    XcurRET                 -CODEBASEQQ          ;*  n
                WORD    Xerasesol               -CODEBASEQQ          ;*  o
                WORD    Xentrev                 -CODEBASEQQ          ;*  p
                WORD    Xextrev                 -CODEBASEQQ          ;*  q
                WORD    Xmsmaecho               -CODEBASEQQ          ;*  r
                WORD    Xmsmadis                -CODEBASEQQ          ;*  s
                WORD    Xentshft                -CODEBASEQQ          ;*  t
                WORD    Xexitshft               -CODEBASEQQ          ;*  u
                WORD    Xrapround               -CODEBASEQQ          ;*  v
                WORD    Xdiscard                -CODEBASEQQ          ;*  w
                WORD    Xset                    -CODEBASEQQ          ;*  x
                WORD    Xresenv                 -CODEBASEQQ          ;*  y
                WORD    Xreset                  -CODEBASEQQ          ;*  z
                WORD    Xspr1                   -CODEBASEQQ          ;*  {
                WORD    Xent132                 -CODEBASEQQ          ;*  |
                WORD    Xspare2                 -CODEBASEQQ          ;*  {

$ 