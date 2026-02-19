	;and put in 8089 array[?3h$ TYPE vars.asm
;* [bios.apricot.rom]vars.asm
	TITLE	'[bios.apricot.rom]vars.asm'

	INCLUDE	'LEGAL.ASI'

;* VARS.ASM

  GLOBAL XPOS,YPOS,XSAV,YSAV,SCR_SEG_WORD,PUT_VEC
  GLOBAL COLM_MAX,COLM_MIN,LINE_MAX,TOP_LINE,BOT_LINE,AWIDTH
  GLOBAL SWORD,SAVDS,CHRBASE,ATTRFLAG,INSERT_FLAG,DISCARD_FLAG
  GLOBAL ANSI_ACTIVE,CURSOR_FLAG,CRLF_FLAG,LITERAL_FLAG,GRAPHIC_FLAG
  GLOBAL BOT_FLAG,BUFF_COUNT,CBUFF,CURSOR,CRTPAR,TIMEOUT,ORIGIN,UPDATE
  GLOBAL ENV_1,ENV_2,ENV_3,ENV_4,LINES,PAR_1,PAR_2,PARS,SCR_OFF_WORD
  GLOBAL MC6845,WINDOW,AMMODE
        
        PAGE

;* --------------------------------------------------------------------
;*  Screen driver data segment

        Name    Screen_data_asm
        
        Global  CodeBaseQQ, DataBaseQQ
        
        Section SCR_data.data, align (2), class=DataQQ

        Assume  CS:CodeBaseQQ,DS:DataBaseQQ

XPOS            WORD    0       ;* CURSOR X POSITION, ABS
YPOS            WORD    0       ;* CURSOR Y POSITION, ABS
XSAV            WORD    0       ;* X SAVE POSITION
YSAV            WORD    0       ;* Y SAVE POSITION
SCR_SEG_WORD    WORD    0       ;* SCREEN SEGMENT
SCR_OFF_WORD    WORD    0       ;* SCREEN OFFSET
PUT_VEC         WORD    0       ;* JMP VECTOR FOR CHARACTER PUT
COLM_MAX        WORD    0       ;* MAXIMUM COLUMN AT THE MOMENT
COLM_MIN        WORD    0       ;* MINIMUM COLUMN ATM
LINE_MAX        WORD    0       ;* MAXIMUM LINE AT THE MOMENT
TOP_LINE        WORD    0       ;* TOP LINE OF THE SCREEN
BOT_LINE        WORD    0       ;* BOTTOM LINE ON THE SCREEN
AWIDTH          WORD    0       ;* ACTUAL WIDTH OF SCREEN IN CHR POSITIONS
SWORD           WORD    0       ;* SCREEN WORD
SAVDS           WORD    0       ;* SAVE DS
CHRBASE         WORD    0       ;* DEFAULT CHARACTER BASE
MC6845          WORD    0       ;* 6845 START ADDRESS COUNT
ATTRFLAG        BYTE    0       ;* ATTRIBUTE FLAG (XXXXrsui)
INSERT_FLAG     BYTE    0       ;* INSERT MODE (ON OR OFF)
DISCARD_FLAG    BYTE    0       ;* DISCARD MODE (ON OR OFF)
ANSI_ACTIVE     BYTE    0       ;* I HATE ANSI
CURSOR_FLAG     BYTE    0       ;* CURSOR STATE (ON OR OFF)
CRLF_FLAG       BYTE    0       ;* AUTO LF ON CR (ON OR OFF)
LITERAL_FLAG    BYTE    0       ;* LITERAL MODE (ON OR OFF)
WINDOW          BYTE    0       ;* WINDOW ACTIVE FLAG
GRAPHIC_FLAG    BYTE    0       ;* GRAPHIC VT52 MODE (ON OR OFF)
BOT_FLAG        BYTE    0       ;* BOTTOM LINE (ON OR OFF)
BUFF_COUNT      BYTE    0       ;* COUNT OF BUFFER CHARS
CBUFF           BLOCK   5       ;* BUFFER FOR ESCAPE CHARACTERS
CURSOR          BYTE    0       ;* CURSOR ON
CRTPAR          BYTE    0       ;* PARAMS FOR CURSOR ON
TIMEOUT         BYTE    0       ;* TIMER VARIABLE
ORIGIN          BYTE    0       ;* ANSI ORIGIN FLAG
UPDATE          BYTE    0       ;* SCREEN UPDATE FLAG
PAR_1           BYTE    0       ;* ANSI PARAMETER 1
PAR_2           BYTE    0       ;* ANSI PARAMETER 2
PARS            BYTE    0       ;* PARAMETER COUNT FOR ANSI
AMMODE		BYTE	0	;* ANSI MARK-OUT MODE FLAG
ENV_1           BYTE    0
ENV_2           BYTE    0
ENV_3           BYTE    0
ENV_4           BYTE    0

;* ---------------------------------------------------------------------
;*  CONSTANTS

        SECTION SCREEN_constants.code, align (2), Class = InstrQQ

LINES           WORD    80*0
                WORD    80*1
                WORD    80*2
                WORD    80*3
                WORD    80*4
                WORD    80*5
                WORD    80*6
                WORD    80*7
                WORD    80*8
                WORD    80*9
                WORD    80*10
                WORD    80*11
                WORD    80*12
                WORD    80*13
                WORD    80*14
                WORD    80*15
                WORD    80*16
                WORD    80*17
                WORD    80*18
                WORD    80*19
                WORD    80*20
                WORD    80*21
                WORD    80*22
                WORD    80*23
                WORD    80*24
                WORD    80*25

                end
$ 