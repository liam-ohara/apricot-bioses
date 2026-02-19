 t[?3h$ TYPE ansi.asm
;* [bios.apricot.rom]ansi.asm
	TITLE	'[bios.apricot.rom]ansi.asm'

	INCLUDE	'legal.asi'

;* ************************************************************************
;* ** If Escape sequence is ANSI, XANSI is called for every character    **
;* ** until it can act upon a sequence and restore PUT_VEC to its proper **
;* ** state.  Note that if any inconsistencies are found in the input,   **
;* ** the ANSI driver will abort and the rest of the string will be shown**
;* ** on the screen (As with VT100's and the Apricot Screen driver.)     **
;* ************************************************************************

;* ------------------------------------------------------------------------
;*      ansi code space

        Section SCR_ansi.code, align (1), class = instrQQ
        
        Global  CodeBaseQQ, DataBaseQQ
        
        Assume  CS:CodeBaseQQ, DS:DataBaseQQ
        
        GLOBAL  PARS,PAR_1,PAR_2,SCR_DRV_CPOS,XCURESTOR
        GLOBAL  XCURUP,XCURDOWN,XCURLEFT,XCURIGHT
        GLOBAL  COLM_MIN,TOP_LINE,XPOS,YPOS,ORIGIN,XHOME,XRAPROUND,CRLF_FLAG
        GLOBAL  XDISCARD,XNOACTION,XSETHIGH,XSETUND,XENTREV
        GLOBAL  ATTRFLAG,XCURRET,BOT_LINE,PUT_VEC,XERASEOP,PUT_ACTIVE
        GLOBAL  XCURSAVE,XERASEBEP,XCLS,XERASEOL,XERASESOL
        GLOBAL  XERLINE
        
        GLOBAL  XANSI,ANS_REPEAT

XANSI
        ;* * CHAR IS IN AL, OK

        ;* * FIRST CHECK NUMERICS
        CMP     AL,#'0'
        JB      NOT_NUM
        CMP     AL,#'9'
        JBE     ANSI_PAR                ;* WE HAVE A NUMBER

        ;* * NOT A NUMERIC PATERN
NOT_NUM
        CMP     AL,#';'
        JE      ANSI_SEP                ;* GOT A ';* ' SEPARATOR
        CMP     AL,#'?'                 ;* GOT A PRIVATE DEC CODE ?
        JNE     APT1
        RET                             ;* BACK IF A '?'

APT1
        ;* * NOTHING SPECIAL, SO TO ANSI_COM AND PROCESS SOMETHING

        JMP     ANSI_COM

ANSI_SEP
        INCB    PARS
        CMPB    PARS,#2
        JE      ABORT_ANSI1
        RET

ABORT_ANSI1
        JMP     ABORT_ANSI

ANSI_PAR
        SUB     AL,#'0'
        CMPB    PARS,#0                 ;* ON 1st       PARAM ?
        JE      PARAM1                  ;* YES

        
        PAGE
        ;* PUT PARAM 2 INTO VARIABLE

PARAM2
        MOV     BL,AL
        MOVB    AL,PAR_1
        MOV     CL,#10
        MUL     CL
        ADD     AL,BL
        MOVB    PAR_1,AL
        RET



        ;* PUT PARAM 1 INTO VARIABLE
PARAM1
        MOV     BL,AL
        MOV     AL,PAR_2
        MOV     CL,#10
        MUL     CL
        ADD     AL,BL
        MOV     PAR_2,AL
        RET
        

ANSI_COM
        CALL    PROCESS
        CALL    SCR_drv_cpos    ;* ALWAYS POSITION CURSOR
        JMP     ABORT_ANSI

        PAGE
PROCESS
        XOR     BX,BX
        XOR     DX,DX
        MOV     BL,PAR_2
        MOV     DL,PAR_1
        CMP     AL,#'A'         ;* A - CURSOR UP
        JE      ANSI_CUU
        CMP     AL,#'B'         ;* B - CURSOR DOWN
        JE      ANSI_CUD
        CMP     AL,#'C'         ;* C - CURSOR FORWARD
        JE      ANSI_CUF
        CMP     AL,#'D'         ;* D - CURSOR BACK
        JE      ANSI_CUB
        CMP     AL,#'H'         ;* H - CURSOR POSITION
        JE      ANSI_CUP
        CMP     AL,#'J'         ;* J - ERASE IN DISPLAY
        JE      ANSI_6
        CMP     AL,#'K'         ;* K - ERASE IN LINE
        JE      ANSI_7
        CMP     AL,#'f'         ;* f - HOR/VER POSITION
        JE      ANSI_8
        CMP     AL,#'h'         ;* h - SET MODES
        JE      ANSI_9
        CMP     AL,#'l'         ;* l - RESET MODES
        JE      ANSI_A
        CMP     AL,#'m'         ;* m - CHARACTER ATTRIBUTES
        JE      ANSI_B
        CMP     AL,#'n'         ;* n - DEVICE STATUS REPORT
        JE      ANSI_C
        CMP     AL,#'r'         ;* r - SET TOP & BOTTOM MARGINS
        JE      ANSI_D
        CMP     AL,#'s'         ;* s - SAVE CURSOR
        JE      ANSI_E
        CMP     AL,#'u'         ;* u - RESTORE CURSOR
        JE      ANSI_F
        JMP     ABORT_ANSI

ANSI_6  JMP     ANSI_ED
ANSI_7  JMP     ANSI_EL
ANSI_8  JMP     ANSI_CUP
ANSI_9  JMP     ANSI_SM
ANSI_A  JMP     ANSI_RM
ANSI_B  JMP     ANSI_SGR
ANSI_C  JMP     ANSI_DSR
ANSI_D  JMP     ANSI_STBM
ANSI_E  JMP     XCURSAVE
ANSI_F  JMP     XCURESTOR


        ;* *** ANSI CURSOR UP ROUTINE
ANSI_CUU
        MOV     SI,#Xcurup - CodeBaseQQ
        JMP     ANS_REPEAT
        
        ;* *** ANSI CURSOR DOWN ROUTINE
ANSI_CUD
        MOV     SI,#Xcurdown - CodeBaseQQ
        JMP     ANS_REPEAT

        ;* *** ANSI CURSOR LEFT ROUTINE
ANSI_CUB
        MOV     SI,#Xcurleft - CodeBaseQQ
        JMP     ANS_REPEAT

        ;* *** ANSI CURSOR RIGHT ROUTINE
ANSI_CUF
        MOV     SI,#Xcuright - CodeBaseQQ
        JMP     ANS_REPEAT


        PAGE
        ;* *** ANSI CURSOR POSITION ROUTINE
ANSI_CUP
        ;* ** CHECK FOR LEGALITY
        CMP     BL,#0
        JNE     P23
        MOV     BL,#1
P23     CMP     DL,#0
        JNE     P3
        MOV     DL,#1
P3      CMP     BL,#25
        JB      OVY
        MOV     BL,#25
OVY     CMP     DL,#80
        JB      OVX
        MOV     DL,#80
OVX     ;* ** DX=NEW COLUMN
        ;* ** BX=NEW LINE
        DEC     BX
        DEC     DX
        MOV     XPOS,DX
        MOV     YPOS,BX
        RET


        PAGE
        ;* *** ANSI ERASE IN DISPLAY ROUTINE
ANSI_ED
        CMP     BL,#3
        JA      ABORT_ANSI
        PUSH    XPOS
        PUSH    YPOS
        SHL     BX,#1
        CALL    [CS:ANS_ED][BX]
        POP     YPOS
        POP     XPOS
        RET
ANS_ED  WORD    AXer            -CODEBASEQQ
        WORD    Xerasebep       -CODEBASEQQ
        WORD    Xcls            -CODEBASEQQ

AXer
        push    bot_line
        movw    bot_line,#24
        call    Xeraseop
        pop     bot_line
        ret


        PAGE
        ;* *** ANSI ERASE IN LINE ROUTINE
ANSI_EL
        CMP     BL,#3
        JA      ABORT_ANSI
        SHL     BX,#1
        JMP     [CS:ANS_EL][BX]
ANS_EL  WORD    Xeraseol        -CODEBASEQQ
        WORD    Xerasesol       -CODEBASEQQ
        WORD    Xerline         -CODEBASEQQ
        RET


        PAGE
ABORT_ANSI
        ;* * STOP ANYTHING ANSI AND RESET FOR ANOTHER TIME
        MOV     PUT_VEC,#PUT_ACTIVE - CODEBASEQQ
        MOVB    PAR_1,#0
        MOVB    PAR_2,#0
        MOVB    PARS,#0
        RET


        ;* *** ANSI SET MODES ROUTINE
ANSI_SM
        CMP     BL,#20
        JNE     ASM1
        ORB     CRLF_FLAG,#2
        RET
ASM1
        CMP     BL,#6
        JNE     ASM2
        MOVB    ORIGIN,#1
        CALL    Xhome
        RET
ASM2
        CALL    Xrapround
        RET


        ;* *** ANSI RESET MODES ROUTINE
ANSI_RM
        CMP     BL,#20
        JNE     ARM1
        ANDB    CRLF_FLAG,#0FDH
        RET
ARM1
        CMP     BL,#6
        JNE     ARM2
        MOVB    ORIGIN,#0
        CALL    Xhome
        RET
ARM2
        CALL    Xdiscard
        RET

        PAGE
        ;* *** ANSI CHARACTER ATTRIBUTES
ANSI_SGR
        CMP     BL,#8
        JA      ABORT_ANSI
        SHL     BX,#1
        JMP     [CS:AN_SGR][BX]
AN_SGR  WORD    CLRATS          -CODEBASEQQ
        WORD    Xsethigh        -CODEBASEQQ
        WORD    Xnoaction       -CODEBASEQQ
        WORD    Xnoaction       -CODEBASEQQ
        WORD    Xsetund         -CODEBASEQQ
        WORD    Xnoaction       -CODEBASEQQ
        WORD    Xnoaction       -CODEBASEQQ
        WORD    Xentrev         -CODEBASEQQ

CLRATS
        MOVB    ATTRFLAG,#0
        RET


        ;* *** ANSI CPOS REPORT
ANSI_DSR
        CALL    Xcurret
        RET


        ;* *** ANSI TOP & BOTTOM
ANSI_STBM
        ;* ** CHECK FOR LEGALITY

        CMP     BL,#0
        JA      AP23
        MOV     BL,#1
AP23    CMP     DL,#0
        JA      AP3
        MOV     DL,#1
AP3     CMP     BL,#24
        JB      AOVY
        MOV     BL,#24
AOVY    CMP     DL,#79
        JB      AOVX
        MOV     DL,#79

AOVX    ;* ** BX=NEW (MIN) LINE
        ;* ** DX=NEW (MAX) LINE
        dec bx
        dec dx
        MOV     TOP_LINE,BX
        MOV     BOT_LINE,DX
        CALL    Xhome
        RET


        ;* ** SUBSID ROUTINE, CALLS SI BX TIMES
ANS_REPEAT
        CMP     BX,#0
        JNE     DIOT
        MOV     BX,#1
DIOT
        PUSH    BX
        PUSH    SI
        CALL    SI      ;* CALL ROUTINE
        POP     SI
        POP     BX
        DEC     BX
        JNZ     ANS_REPEAT
        RET

        end


$ 