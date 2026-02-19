and for fdc
;tbc0
;tx0
	hlt9

       $ TYPE drivers.asm
; [bios.apricot.rom]drivers.asm
	Title	'[bios.apricot.rom]drivers.asm'

	include	'legal.asi'

;* **********************************************************************
;* ** Main configurable hardware driver, for scrolls, reads and writes **
;* **********************************************************************

        PAGE

;* ----------------------------------------------------------------------
;*  drivers code

        Name    Low_level_drivers
        
        Section SCR_drivers.code, align (1), class=InstrQQ
        
        Include 'equates.asi'
	Include	'ioregs.asi'
        
        Global  CodeBaseQQ, DataBaseQQ
        GLOBAL  IMG_SEG_WORD,SCR_SEG_WORD,TIMEOUT,YPOS,XPOS,CURSOR
        GLOBAL  LINES,CHRBASE,CRTPAR,UPDATE,XRESET,PUT_VEC,PUT_ACTIVE
        GLOBAL  TOP_LINE,BOT_LINE,ERASE_LINES,WINDOW
        
        GLOBAL  ENQUIRE,KEYS,PRNOUT,SCR_DRV_SUPD,SCR_OFF_WORD,MC6845
        GLOBAL  SCR_DRV_WRITE,SCR_DRV_READ,SCR_DRV_CPOS
        GLOBAL  SCR_DRV_BELL,SCR_DRV_GRAPHICS,SCR_DRV_HWINIT
        GLOBAL  TMR_CURSOR,SCR_DRV_SETSTART,CRT_start
        
        Assume CS:CodebaseQQ, DS:DatabaseQQ


ENQUIRE
        PUSH    AX
        MOV     BX,#35H
        MOV     CX,#1
        INT     #0FCH
        POP     BX
        CMP     AX,BX           ;* NEW WITH OLD
        JGE     OKTS
        MOV     AL,#0
        RET                     ;* NO, YOU CAN'T
OKTS
        MOV     AL,#1
        RET                     ;* YES, YOU CAN

        PAGE

KEYS
        MOV     DX,AX
        XOR     DH,DH
        MOV     BX,#32H
        MOV     CX,#8
        INT     #0FCH
        RET


        PAGE
PRNOUT
        MOV     DX,AX
        XOR     DH,DH
        MOV     BX,#35H
        MOV     CX,#7
        INT     #0FCH
        RET


        PAGE
SCR_drv_supd
        RET
        
;***********************************************
        ;CMPB   UPDATE,#1
        ;JE     UPD_END
        ;PUSH    DS                             ;* SAVE FOR LATER
        ;XOR     SI,SI                          ;* START AT 0
        ;XOR    DI,DI
        ;MOV     ES,SCR_SEG_WORD
        ;MOV     DS,IMG_SEG_WORD
        ;MOV     CX,#2048                       ;* MOVE 2K WORDS
        ;CLD
  ;REP   MOVW                                   ;* DO THE MOVE
        ;POP     DS                             ;* RESTORE DS
;UPD_END
        ;RET
;************************************************

        PAGE
SCR_drv_setstart
        ;* ** RESETS THE START ADDRESS, BUT PRESERVES THE 25TH LINE.
        CMPB    WINDOW,#1
        JE      SST100
        CMPW    SCR_OFF_WORD,#0         ;* ALREADY RESET ?
        JE      SST100
REST4
        ;* FIRST, RESET THE CRTC
        PUSHF
        CLI
        MOV     AL,#13                  ;* START REGISTER
        OUT     #CRTC_ADDR,AL           ;* SELECT IT
        MOV     AL,#0
        OUT     #CRTC_DATA,AL           ;* MOVE START ADDR TO ZERO
        MOV     AL,#12                  ;* LOW START REGISTER
        OUT     #CRTC_ADDR,AL           ;* SELECT
        MOV     AL,#0                   ;* RESET AL
        OUT     #CRTC_DATA,AL
        POPF
        ;* SECOND, MOVE THE 25TH LINE FROM THE IMAGE TO THE REAL SCREEN & IMAGE
        MOV     SI,SCR_OFF_WORD         ;* TAKE OFFSET WORD
        ADD     SI,#(24*80)*2           ;* ADJUST
        MOV     DI,#(24*80)*2           ;* OFFSET WILL BE ZERO
        MOV     CX,#80                  ;* 80 WORDS IN A LINE
        PUSH    DS                      ;* SAVE DS FOR LATER
        MOV     AX,SCR_SEG_WORD         ;* SAVE IMAGE SEGMENT
        MOV     DS,AX                   ;* PUT INTO DS
        MOV     ES,AX                   ;* AND ES
        PUSH    SI                      ;* SAVE OUR SOURCE FOR LINE DELETE LATER
        CLD

        REP     MOVW

;****************************************
;MOV25TH2
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
        ;LOOP   MOV25TH2                ;* LOOP UNTIL DONE
;****************************************
        
        POP     DI                      ;* RESTORE POINTER TO 24TH LINE
        POP     DS                      ;* RESTORE DATA SEGMENT
        MOV     CX,#80+96               ;* 80 WORDS TO DELETE
        MOV     AX,#VSPACE              ;* SPACE CHARACTER
        ;PUSH   DI

        REP     STOW

;****************************************
;D252
        ;AND    DI,#1000H-1             ;* AND WITH SCREEN MASK
        ;STOW
        ;LOOP   D252

        ;POP    DI
        ;MOV    CX,#80+96               ;* 80 WORDS AGAIN
        ;MOV    ES,SCR_SEG_WORD
;E252
        ;AND    DI,#1000H-1
        ;STOW
        ;LOOP   E252
;*****************************************
        
        MOVW    SCR_OFF_WORD,#0         ;* RESET OFFSET TO ZERO
        MOVW    MC6845,#0
SST100
        MOV     SI,TOP_LINE
        MOV     DI,BOT_LINE
        JMP     ERASE_LINES
        
        
        PAGE
SCR_drv_write
        ;* * WRITE THE ASCII CHARACTER IN AL TO THE SCREEN
        ;* * ATTRIBUTES MUST BE IN AH

        ADD     AX,CHRBASE      ;* ADD ON CHARACTER BASE
        MOV     BX,YPOS
        SHL     BX,#1
        MOV     DI,CS:LINES[BX]
        ADD     DI,XPOS
        SHL     DI,#1
        ADD     DI,SCR_OFF_WORD
        
        ;* * WRITE TO REAL SCREEN
        MOV     ES,SCR_SEG_WORD
        STOW
        
;******************************************
        ;SUB    DI,#2
        ;AND    DI,#1000H-1
        ;* * WRITE TO VIRTUAL, TOO
        ;MOV     ES,IMG_SEG_WORD
        ;STOW
;******************************************

        RET


        PAGE
SCR_drv_read
        ;* * READS A WORD FROM THE SCREEN AND PUTS IT IN AX
        MOV     BX,YPOS
        SHL     BX,#1
        MOV     SI,CS:LINES[BX]
        ADD     SI,XPOS
        SHL     SI,#1
        ADD     SI,SCR_OFF_WORD
        AND     SI,#1000H-1
        ;* * READ FROM SCREEN
        MOV     ES,SCR_SEG_WORD
        LODW    es:
        RET


        PAGE
SCR_drv_cpos

        ;* * POSITION THE CURSOR AT XPOS,YPOS IN HARDWARE & DO TIMEOUT

        MOV     BX,YPOS
        SHL     BX,#1
        MOV     AX,CS:LINES[BX]
        ADD     AX,XPOS
        ADD     AX,MC6845

        ;* * AX HAS FINITE POSITION
        ;* * SO POSITION CURSOR
	PUSHF
	CLI
        MOV     CX,AX
        MOV     AL,#0EH
        OUT     #CRTC_ADDR,AL
        MOV     AL,CH
        OUT     #CRTC_DATA,AL
        MOV     AL,#0FH
        OUT     #CRTC_ADDR,AL
        MOV     AL,CL
        OUT     #CRTC_DATA,AL
        ;* * NOW SWITCH IT OFF
        MOV     AL,#10          ;*  CURSOR REGISTER
        OUT     #CRTC_ADDR,AL
        MOV     AL,#OFFV        ;*  OFF VALUE
        OUT     #CRTC_DATA,AL
        MOVB    CURSOR,#0       ;*  SET CLOCK FLAG TO OFF
        MOVB    TIMEOUT,#TMRD   ;*  SET TIMER TICKS
	POPF
        RET

        PAGE
SCR_drv_bell
        MOV     BX,#32H
        MOV     CX,#9
        INT     #0FCH
        RET                     ;* SOUNDS THE BLEEPER

        PAGE
SCR_drv_graphics
        MOV     SI,#CRT_ingraf - CodeBaseQQ
        JMP     INITCR

        PAGE
SCR_drv_hwinit
        ;* ** PROGRAM CRT FOR TEXT MODE:
        
        MOVW    SCR_SEG_WORD,#SCR_SEG
        ;MOVW   IMG_SEG_WORD,#IMG_SEG
        MOVW    SCR_OFF_WORD,#0
        MOVW    MC6845,#0
        MOV     ES,SCR_seg_WORD
        MOV     CX,#2048
        MOV     AX,#VSPACE
        XOR     DI,DI
        
        REP     STOW
        
        MOVW    PUT_VEC,#PUT_ACTIVE - CODEBASEQQ
        MOV     SI,#CRT_intxt - CodeBaseQQ      ;* LOAD SETUP TABLE
        CALL    INITCR

        ;* CHANGE PARALLEL BIT FOR TEXT
	pushf
	cli
	in	al,#PIO_PORB
	or	al,#010h			;set text output/screen on
	and	al,#0F7h
	out	#PIO_PORB,al
	popf

        RET

INITCR
	pushf
	cli
        XOR     BX,BX
INIT_CRLOOP
        MOV     AX,BX
        OUT     #CRTC_ADDR,AL
        MOV     AL,CS:[BX][SI]
        OUT     #CRTC_DATA,AL
        INC     BX
        CMP     BL,#16
        JB      INIT_CRLOOP
        popf
	RET

        ;* * REGISTER TABLES FOR CRTC

CRT_intxt  BYTE   94,80,79,12,25,10,25,25,03,14,00,15,00,00,00,000  ;* text

CRT_ingraf BYTE   59,50,51,07,25,10,25,25,03,14,00,15,00,00,00,00   ;* graphics

CRT_istart BYTE   045h,04eh,044h,020h,04fh,046h,020h,043h,04fh,044h ;* to
           BYTE   045h,02dh,04eh,069h,063h,06bh,020h,057h,069h,06ch ;* reset
           
        PAGE

;* **   CALLED EVERY 20MS BY CLOCK INTERRUPT
TMR_cursor
        CMPB    CURSOR,#0       ;* CURSOR ON?
        JE      SW_ON           ;* NO
TMR_GO
        RET                     ;* GET BACK

SW_ON
        DECB    TIMEOUT         ;* DECREMENT COUNTER
        JNZ     TMR_GO
	PUSHF
	CLI
        MOV     AL,#10          ;* CURSOR REGISTER
        OUT     #CRTC_ADDR,AL
        MOV     AL,CRTPAR       ;* ON VALUE
        OUT     #CRTC_DATA,AL
        NOTB    CURSOR          ;* SET FLAG TO ON
	POPF
        JMP     TMR_GO

        end
$ 