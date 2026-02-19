
        byte    104,105,106,107,108,109,1[?3h$ TYPE calc.asm
; [bios.apricot.ram]calc.asm
        TITLE   'Apricot Calculator'

	INCLUDE	'LEGAL.ASI'
;
;
;       This program provides a calculator facility for the
;       Apricot before a disk has been booted up. The usual
;       four functions are available in addition to %,%change,
;       and four memory functions. (Store,recall,add and subtract)
;       The soft keys 2-6 are used to access the memory functons.
;       Soft key 1 is used to exit from the calculator to allow
;       a disk to be booted.
;
;       Modified by Nick Wilson, July 83 for inclusion into the BIOS,
;       this entails utilising the SEND key to send the MScreen contents
;       to the MSDOS input queue as specified in CIB.DOC, 15th March 1983
;
;	Modified for use in VAX RAM BIOS 3-sep-84 GK
;
        GLOBAL  CALC_INPUT
	GLOBAL  KBD_q_out              ;part of mod for SEND
        GLOBAL  LCD_calc_out
        GLOBAL  DATABASEQQ;FAR
        GLOBAL  CODEBASEQQ;FAR
        GLOBAL  STKBASEQQ;FAR
        GLOBAL  ABBASE,POPN,LCHOP,KEYLEG,BUFPTR
;
ND      EQU 7           ;No. of C-digits in fp mantissa
NDI     EQU 10          ;No. of digits in display for FINP,FOUT
;
        section calc.data,align(1),class=dataQQ
        ASSUME DS:DATABASEQQ,   CS:CODEBASEQQ,  SS:DATABASEQQ
;
;
ABBASE  BLOCK   20              ;Base of ASCII display buffer
;
MBASE   BLOCK   34              ;Base of memory buffer (>20 for MEMKEY)
;
BUFPTR  BLOCK   2               ;Pointer into buffer
;
;
FAC                             ;fp accumulator
FS      BLOCK   1               ;sign
FC                              ;mantissa base
FE      BLOCK   1               ;Exponent
FC1     BLOCK   1               ;MS mantissa C-digit
FC2     BLOCK   1               ;2nd mant C-digit
        BLOCK   5               ;Rest of mantissa
;
        PAGE
;
FVAC                            ;Primary floating variable
FVS     BLOCK   1
FVC
FVE     BLOCK   1
FVC1    BLOCK   1
FVC2    BLOCK   6       ;=ND-1
;
FPV1    BLOCK   9               ;Sign 0 = +ve 80h = -ve
                                ;Exponent 100**(Exp - 80H)
                                ;Mantissa C-digits 0-99
;
FPV2    BLOCK   ND+2            ;2nd fp variable
FPV3    BLOCK   ND+2
;
RC      BLOCK   1
RC1     BLOCK   7               ;Remainder bytes during division
MG      BLOCK   3
REG     BLOCK   1               ;Register to be stored in WC1
;
;
;
WC                              ;Workspace C-digits
WC0     BLOCK   1
WC1     BLOCK   1
WC2     BLOCK   1
WC3     BLOCK   10
WCE     BLOCK   3
;
MESG
LCHOP   BLOCK   1
LCHCL   BLOCK   1
LCHNO   BLOCK   1
LCHPC   BLOCK   1
POPN    BLOCK   1
TPOPN   BLOCK   1
DPFLAG  BLOCK   1
ERRFLG  BLOCK   1
;
;
        PAGE
;
;
S_P     EQU     0               ;Stack base [BP]
LINK    EQU     2               ;Return link to calling program
PARM1   EQU     4               ;1st parameter on stack
PARM2   EQU     6               ;2nd parameter on stack
;
;
SFLAGS  EQU     0               ;Flags
SDI     EQU     2               ;DI
SSI     EQU     4               ;SI
SBX     EQU     6               ;BX
SCX     EQU     8               ;CX
SDX     EQU     10              ;DX
SBP     EQU     12              ;BP
SLINK   EQU     14              ;Link for return from subroutine
;
FPS     EQU     0               ;fp sign
FPE     EQU     1               ;Exponent
FPC1    EQU     2               ;Mantissa
;
FPC     EQU     1               ;Base for mantissa
;
;
        SECTION TCALC.CONST,ALIGN(1),CLASS=CONSTQQ

KEYLEG  ASCII   ' Off   Send   Mem+   Mem-  Store  Recall' ;
        BYTE 0E9h            ;terminator for error routine

	        ;1234567890123456789012345678901234567890
        PAGE
;
        SECTION TCALC.CODE, ALIGN(1),CLASS=INSTRQQ
        ASSUME DS:DATABASEQQ,   CS:CODEBASEQQ,  SS:DATABASEQQ
;
SAVE                            ;Save regs on subroutine entry
        POP     AX              ;Link to save
        PUSH    BP
        MOVW    BP,SP           ;Set stack base for sr to address params on stack
        PUSH    DX
        PUSH    CX
        PUSH    BX              ;Stack other regs
        PUSH    SI
        PUSH    DI
        PUSHF                   ;...and flags
;
        CLD                     ;Auto-decrement
;
        MOVW    SI,LINK[BP]     ;Return link for in-line parameters
        JMP     AX              ;Go to sr
;
;
ERROR                           ;Arithmetic overflow arrives here
        MOVB    ERRFLG,#1       ;Fall through to REST
;
REST                            ;Restores registers saved by SAVE
                                ;Return from sr by JMP REST
;
;
        POPF                    ;Restore flags
RESTNF  POP     DI              ;...and registers
        POP     SI
        POP     BX
        POP     CX
        POP     DX
        POP     BP
        RET
;
;
;
;
        PAGE
;
;
FADSUB                          ;Floating point addition routine
                                ;Multiplies FAC by FVAC and puts
                                ; result into FAC
;
FADD    CALL    SAVE            ;Save registers and address stack
        MOVB    DH,#0           ;Set flag to Add
        JMP     FAS1
;
FSUB    CALL    SAVE            ;Save regs
        MOVB    DH,#80H         ;Set flag to Subtract
;
FAS1    LEA     AX,FVAC         ;Get byte parameter as fp no.to
                                ;add or sutract to or from FAC
;
        MOVW    BX,AX           ;Pointer to PN
        LEA     BP,FAC          ;Pointer to FAC
;
        CMPB    FPE[BX],#0      ;PE is exponent of PN
        JE      REST            ;If zero then FAC is unchanged by sum
        XORB    DH,FPS[BX]      ;If the signs of PN and FAC are not
        XORB    DH,FS           ;..the same, reverse Add/Subtract flag
;
FAS2
        MOVB    AL,FPE[BX]      ;Parameter exponent
        ADDB    AL,#80H
        CBW
        MOVW    CX,AX           ;Corrected
        MOVB    AL,FE           ;FAC exponent
        ADDB    AL,#80H
        CBW
        SUBW    AX,CX           ;Difference between exponents
        JNS     FAS3            ;FAC exp >= PN exp.
        XCHG    BX,BP           ;BP points to larger value
        SUBB    FE,AL           ;FE,FS set for larger value
        XORB    FS,DH
        NEGW    AX              ;+ve exponent difference
;
FAS3
        MOVW    CX,#ND          ;No. of C-digits in mantissa
        LEA     SI,FPC1[BP]
        LEA     DI,WC1          ;Copy mantissa of larger value
   REP  MOVB                    ;...into workspace WC1
;
        CMPW    AX,#ND+1        ;Exponent diff greater than
        JGE     FAS10L          ;..mantissa length, no change
                                ;..to larger value
;
        MOVW    CX,#ND          ;Count no. of C-digits
        MOVB    DL,#100
;
        MOVW    SI,CX           ;For LS C-digit of mantissa
        MOVW    DI,CX
        ADDW    DI,AX           ;For corresp C-digit in workspace
;
FAS4
        CMPW    DI,#ND+2
        JG      FAS7            ;This C-digit not signif to result
        MOVB    AH,FPC[BX][SI]  ;Smaller value's C-digit
        MOVB    AL,WC[DI]       ;Larger's C-digit in workspace
        CMPB    DH,#0
        JNE     FAS5            ;Real subtraction
;
        ADDB    AL,AH
        CMPB    AL,DL           ;Addition ovflow to next C-digit
        JB      FAS6            ;No..
        SUBB    AL,DL           ;Yes, reduce C-digit
        INCB    WC-1[DI]        ;..and do carry
        JMP     FAS6
;
FAS5
        SUBB    AL,AH
        JNS     FAS6            ;No borrow in subtraction
        ADDB    AL,DL           ;Restore to 0-99 range
        DECB    WC-1[DI]        ;..and do borrow
;
FAS6
        MOVB    WC[DI],AL       ;Result C-digit stored
;
FAS7
        DECW    SI              ;Step pointers for next C-digit
        DECW    DI
        LOOP    FAS4
;
FAS7C
        CMPB    WC[DI],DL
        JL      FAS7D           ;0-99 or -ve
        SUBB    WC[DI],DL       ;Reduce to range 0-99
        DECW    DI
        INCB    WC[DI]          ;and report carry
        JMP     FAS7C           ;as far as necessary
;
FAS7D
        CMPB    WC0,#0          ;Borrow from MS end ..
        JL      FAS7B           ;..so reverse digits and sign
;
        CMPB    WC[DI],#0
        JGE     FAS10           ;No more borrow
FAS7A
        ADDB    WC[DI],DL
        DECW    DI
        DECB    WC[DI]          ;Carry borrow forward
        JS      FAS7A
FAS10L
        JMP     FAS10
FAS7B
        MOVW    CX,#ND          ;Subtract underflow
        LEA     DI,WC+7         ;Reverse digits and sign
        MOVW    SI,DI
        STD
;
FAS8
        LODB
        NEGB    AL              ;Subtract all C-digits from 100
        JNS     FAS9            ;Must be a trailing zero
        ADDB    AL,DL
        INCB    [SI]            ;Carry
FAS9
        STOB
        LOOP    FAS8
        XORB    FS,#80H         ;Reverse sign of result in FAC
FAS10
        JMP     FNORM           ;Normalise, round and exit
;
FPMAXL  JMP     FPMAX
FP0L    JMP     FP0             ;..long jumps..
RESTL   JMP     REST
;
        PAGE
;
;
FMUL
;       Multiply FAC by FVAC, result to FAC.
;       If result too large set FAC to max val and take error exit.
;
        CALL    SAVE
        LEA     SI,FVAC         ;Get parameter
        MOVW    AX,SI
;
        CMPB    FE,#0           ;Exp of 0 = fp value of 0
        JE      FP0L            ;FAC = 0 so result = 0
        LODB                    ;Sign of parameter
        XORB    FS,AL           ;Store sign of result
;
        LODB                    ;Exponent of parameter
        MOVB    AH,#80H         ;Exponent offset
        ADDB    AL,AH
        ADDB    FE,AH           ;Remove offset from both exponents
        ADDB    FE,AL           ;Exponent of result (maybe +1)
        JO      FM6             ;Exponent over or underflow
        INCB    FE
        JO      FM6
        ADDB    FE,AH           ;Restore exponent offset
;
        MOVW    BP,SI           ;Points to 1st C-digit of parameter
        DECW    BP              ;Now PC base
        MOVB    DH,#100
        MOVW    BX,#7           ;To address LS C-digit of FAC
;
FM1
        MOVW    CX,#9
        SUBW    CX,BX           ;Count of relevant multiplications
        MOVB    DL,FC[BX]       ;..for the current FAC digit
;
FM2
        MOVW    SI,CX
        MOVB    AL,[BP][SI]     ;Parameter C-digit
        MULB    DL              ;.. x current FAC C-digit
        DIVB    DH
        ADDW    AX,WC-1[BX][SI] ;Added to the wkspace C-digits
        CMPB    AH,DH
        JB      FM3             ;No carry from LS C-digit
        SUBB    AH,DH
        INCB    AL              ;Carry into MS
;
FM3
        CMPB    AL,DH
        JB      FM4             ;No carry from MS C-digit of pair
        SUBB    AL,DH
        INCB    WC-2[BX][SI]    ;Report carry into next MS C-digit
;
FM4
        MOVW    WC-1[BX][SI],AX ;Write C-digit pair into wkspce
        LOOP    FM2             ;Repeat for all the relevant C-digits of
;                               ;..the parameter value
;
        DECW    BX              ;For next MS FAC C-digit
        JG      FM1             ;Not yet all done
;
FM5
        JMP     FNORM           ;Answer is now in the wkspace C-digits,
                                ;with possible leading zero round it
                                ;normalise it, and store it into the
                                ;FAC, then clear workspace and exit
FM6
        JC      FP0L            ;Exponent underflow, val < 100**-128
                                ;set FAC to 0, clear wkspace and exit
;
        JMP     FPMAXL          ;Exponent overflow, set FAC to maximum
                                ;value and take error exit
;
;
        PAGE
;
;
FDIV
;               Divides fp no. in FAC by fp no. at address given by 
;               the parameter.  Division by zero or other exponent
;               overflow causes the FAC to be set to the maximum fp
;               value.
;
;
        CALL    SAVE
        LEA     SI,FVAC
        MOVW    AX,SI
        CMPB    FE,#0
        JNE     FDA
        JMP     REST            ;Value=0 (Exp=-128) so result=0
FDA
        LODB                    ;Parameter fp no. sign
        XORB    FS,AL           ;Sign of result to FAC
;
        MOVB    AH,#80H         ;Exponent offset
        LODB                    ;Parameter fp no. exponent
        CMPB    AL,#0
        JNE     FDB
        JMP     FPMAX           ;Div by zero is error
;
FDB     ADDB    AL,AH
        ADDB    FE,AH           ;Remove offset from both exponents
        SUBB    FE,AL           ;Exp of result (or +1)
        JO      FD13L           ;Exp overflow or underflow
;
        ADDB    FE,AH           ;Restore offset to result exp in FAC
        MOVW    BP,SI           ;Form base for parameter = divisor
        DECW    BP              ; C-digits
;
        LODB                    ;MS C-digit of divisor
        MOVB    BL,#100
        MULB    BL
        MOVW    BX,AX           ;Provisional divisor (binary) =
        LODB                    ; PC1*100 + PC2 + 1
        CBW
        ADDW    BX,AX
        INCW    BX
;
        MOVB    AL,#100
        MULB    FC1             ;Provisional remainder (binary)=
        ADDB    AL,FC2          ; FC1*100 + FC2
        JNC     FD1
        INCB    AH
;
FD1     LEA     SI,FC1
        LEA     DI,RC1          ;Copy FAC C-digits into
        MOVW    CX,#ND          ; remainder field RC(N)
  REP   MOVB
;
        MOVW    SI,#1           ;For WC1,FC1,RC1, etc.
        MOVW    DX,#0           ;MS of mul result in case not used
FD2
        CMPW    AX,#200
        JB      FD2A            ;Probably 1 remainder * 100
        CMPW    AX,BX
        JA      FD5             ;Remainder > divisor, quotient > 0
FD2A
        INCW    SI              ;Step to next quotient C-digit
FD3
        CMPW    SI,#ND+3
        JGE     FD12L           ;Enough quotient digits done
;
        MOVW    DX,#100
        MULW    DX
        ADDB    AL,RC+1[SI]     ;Include another C-digit in the
        JNC     FD4             ; binary remainder
        INCB    AH
        JNZ     FD4
        INCW    DX
FD4
        CMPW    DX,#0
        JNE     FD5             ;DXAX must be > BX
        JMP     FD2             ;Include further digits until
                                ; remainder>divisor, or quotient
                                ; has enough C-digits
FD12L
        JMP     FD12            ;Staging post
FD13L   JMP     FD13
;
FD5
        DIVW    BX              ;Quotient digit 0 - 199
        ADDB    WC[SI],AL       ; stored in workspace
        MOVW    DI,SI
        MOVB    DH,#100
FD6     CMPB    WC[DI],DH       ;Report any carry into MS C-digits
        JB      FD7
        SUBB    WC[DI],DH
        DECW    DI
        INCB    WC[DI]          ;As far as necessary
        JMP     FD6
FD7
        PUSH    SI              ;Save quotient digit no.
        MOVB    DL,AL           ;Quotient digit as single digit
        MOVW    CX,#ND          ;Multiplicand
        MOVW    DI,CX
        ADDW    DI,SI           ;Result scaling
FD8
        DECW    DI
        CMPW    DI,#ND+4
        JG      FD10            ;Result insignificant so don't bother
        MOVW    SI,CX
        MOVB    AL,[BP][SI]     ;Divisor C-digit
        MULB    DL              ; * quotient C-digit (1 - 199)
        DIVB    DH              ;Split into 2 C-digits to be
        SUBB    RC[DI],AH       ; subtracted from the remainder
        JNS     FD9             ; with
        INCB    AL              ; allowance for carries
        ADDB    RC[DI],DH
FD9     SUBB    RC-1[DI],AL
        JNC     FD9B
FD9A    DECB    RC-2[DI]        ;Excess carry will be picked up
        ADDB    RC-1[DI],DH     ; in handling the next digit pair
FD9B    JS      FD9A
FD10                            ;Loop until the divisor C-digits have
        LOOP    FD8             ;all been multiplied by this quotient
                                ;C-digit, and the result has been 
                                ;subtracted from the remainder
        POP     SI              ;Restore quotient C-digit no.
        MOVB    AL,RC-1[SI]     ;May be 1 but not more
        MULB    DH
        ADDB    AL,RC[SI]       ;1st digits of new remainder
        JNC     FD11            ; as new binary remainder
        INCB    AH
FD11
        MOVW    DX,#0
        JMP     FD3             ;Loop for next quotient C-digit
FD12                            ;Enough quotient C-digits are now in
        JMP     FNORM           ;workspace so round and normalise them
                                ;store result in FAC,clear workspace
                                ;and exit.
FD13
        JC      FD14
        JMP     FP0             ;Exponent underflow, set FAC = 0
FD14                            ;Exponent overflow, set FAC to max
        JMP     FPMAX           ; value and take error exit
;
;
;
        PAGE
;
FGET                            ;Get fp value from FVAC and
                                ; store it in the FAC
        CALL    SAVE
        LEA     SI,FVAC         ;Parameter fp. no.address
        MOVW    AX,SI
        LEA     DI,FAC
        JMP     FPA1            ;Copy param fp no. into FAC
;
;
;
FPUT                            ;Put fp no. from FAC into position whose 
                                ;address is given by 1st paraneter
        CALL    SAVE
        LEA     DI,FVAC
FPA
        MOVW    AX,DI
        LEA     SI,FAC
FPA1
        MOVW    CX,#ND+2        ;Copy fp no. from FAC into
  REP   MOVB                    ; the parameter position
;
        JMP     REST            ;Restore registers and exit
;
;
        PAGE
;
SWAP                            ;Swaps contents of FAC and FVAC
;
        CLD
        LEA     SI,FAC
        LEA     DI,FAC
        LODW
        XCHG    FVAC,AX
        STOW
        LODW
        XCHG    FVAC+2,AX
        STOW
        LODW
        XCHG    FVAC+4,AX
        STOW
        LODW
        XCHG    FVAC+6,AX
        STOW
        LODB                    ;Get ninth byte
        XCHG    FVAC+8,AL
        STOB
;
        RET
;
;
        PAGE
;
;
FINP                            ;Converts the chars in workspace C-digits
                                ;into a fp value in the FAC register
                                ; WC1 = Exponent (no. of dec places)
                                ; WC2 = Sign (0 for +ve otherwise -ve)
                                ; WC3-12 = BCD digits 0-9 (MS to LS)
;
        CALL    SAVE
        MOVB    AL,WC2          ;Sign
        CMPB    AL,#0
        JE      FIN1            ;Positive
        MOVB    AL,#80H         ;fp -ve sign value
FIN1
        MOVB    FS,AL           ;Store sign into FAC register
;
        MOVB    AL,WC1          ;Set provisional exponent
        CMPB    AL,#0FH
        JNE     FIN1A
        XORB    AL,AL           ;1st dot not set so use 0
        MOVB    WC1,AL
FIN1A
        SHRB    AL,#1           ;Exp = 4 - (WC1)/2
        NEGB    AL
        ADDB    AL,#84H         ;True value if MS C-digit not zero
        MOVB    FE,AL
;
        LEA     SI,WC3          ;Start at WC3 for 5 C-digits
        MOVW    CX,#NDI
        MOVW    DI,SI           ;Replace leading 'F's with '0's
        XORB    AL,AL
FIN1B
        CMPB    [DI],#0FH
        JNE     FIN1C
        STOB
        LOOP    FIN1B
;
FIN1C
        MOVW    CX,#NDI/2       ;Start at WC3 for 5 C-digits if
        TESTB   WC1,#1          ; exponent WC1 is even
        JE      FIN2            ;Exp even
        INCW    CX              ;Start at WC2 for 6 C-digits
        DECW    SI              ; if exp WC1 is odd
        MOVB    WC2,#0
        MOVB    WC3+NDI,#0      ;Clear lead and tail digits
FIN2
        LEA     DI,WC1          ;To store C-digits in WC1,WC2..
FIN3
        LODW                    ;form WC(n) * 10 + WC(N+1)
        XCHG    AL,AH
        AAD
        STOB                    ;and store as a C-digit in workspace
        LOOP    FIN3            ;For 5 or 6 C-digits
;
        MOVB    AL,#0
        MOVW    CX,#ND          ;Clear less significant C-digits
  REP   STOB
;
        JMP     FNORM           ;Normalise link into FAC register
;
;
        PAGE
;
FOUT                            ;Convert fp value in FAC into bcd character 
                                ;string in workspace,
                                ; WC1 = exponent (no.of dec places)
                                ; WC2 = sign (0 = +ve, 8 = -ve)
                                ; WC3-12 = bcd mantissa digits 0-9
;
        CALL    SAVE
;
        MOVB    WC1,#20         ;Set float
        MOVB    AL,FS
        MOVB    RC,AL           ;Save sign of FAC for later
        MOVB    BH,#0           ;No.of leading '0's for fraction value
        MOVB    DL,#1           ;Offset for MS BCD digit if 1st C-digit
        CMPB    FC1,#10         ; is a single BCD digit
        JL      FOT1
        INCB    DL              ;Else 2 BCD digit offset
;
FOT1
        MOVB    AL,FE
        ADDB    AL,#80H         ;Corrected exponent
        CMPB    AL,#NDI
        JGE     FOTML           ;Too big to go in reg
        CMPB    AL,#-NDI
        JG      FOT1A           ;Not too many leading zeroes
;
        MOVB    AL,#-NDI
FOT1A   SHLB    AL,#1           ;No.of BCD digits in the integer part
        ADDB    AL,DL
        CMPB    AL,#0
        JG      FOT2            ;fp value has an integer part
;
        NEGB    AL
        MOVB    BH,WC1          ;No of dp + 10 to float
        CMPB    BH,#10
        JL      FOT1C
        SUBB    BH,#10          ;Remove float flag, leave dec places
FOT1C
        CMPB    AL,BH
        JLE     FOT1B           ;Less leading '0's than dp's
        MOVB    RC,#0           ;Force +ve sign if more
FOT1B
        INCB    AL
        MOVB    BH,AL           ;Count of leading '0's, = -D
        MOVB    AL,#1           ;D = 1 for 0.00FFF
FOT2
        CMPB    AL,#NDI         ;Check if too many digits in the int.
        JG      FOTML           ;part of value for it to be contained
                                ;in the display field
        MOVB    DH,AL           ;Save the no. of integer digits
        LEA     SI,FC1
        MOVB    AL,DL           ;MS digit posn. as WC(n)
        ADDB    AL,BH           ;N =1 or 2 + no.of leading '0's + 1
        INCB    AL
        CBW
        MOVW    DI,AX           ;DI = N at this stage
;
        MOVW    CX,#NDI+4       ;Right hand end of display field + 1
        SUBW    CX,DI
        INCW    CX
        SARW    CX,#1
        JLE     FOT4            ;No real digits assigned to display
        PUSH    BX              ;field, must be a fraction to be 
        LEA     BX,WC           ;displayed as 0.000... to n dec places
        ADDW    DI,BX           ;Now DI is destination pointer
        POP     BX              ;Bodge for Tektronix
;
FOT3
        LODB                    ;Get C-digit from FAC
        AAM                     ; split it into 2 BCD digits
        XCHG    AL,AH
        STOW                    ; and store them into workspace
        LOOP    FOT3            ;Loop until at least 1 more digit than
                                ;is to be displayed has been stored
;
FOT4
        MOVB    DL,#0           ;Reset 'float' flag
        CMPB    WC1,#10         ;Floating dec places?
        JB      FOT5            ;No
        SUBB    WC1,#10         ;Set no of digits
        MOVB    DL,#1           ;Set 'float' flag
        JMP     FOT5
;
FOTML   JMP     FOTM
;
FOT5
        LEA     SI,WC3
        MOVB    AL,DH           ;Find LS digit to be displayed, + 1
        ADDB    AL,WC1
        CBW
        ADDW    SI,AX           ; and set source pointer to it
        CMPW    SI,#WCE-DATABASEQQ ;This rubbish gets offset of WC3+NDI!!
        JLE     FOT6            ;The req'd display is O.K.
        MOVB    WC1,#NDI        ;Reduce the no.of dec places to keep
        SUBB    WC1,DH          ; answer in the display
;
        LEA     SI,WC3+NDI
;
FOT6
        STD                     ;(set direction flag)
        ADDB    [SI],#5         ;Round from 1st digit off the
        MOVB    BL,#10          ; LS end of the display
        CMPB    [SI],BL
        JL      FOT7            ;No round-up needed
        INCB    -1[SI]          ;Report rounding carry
;
FOT7
        LEA     DI,WC2+NDI      ;LS digit of display field
        MOVW    CX,SI           ;Count no.of digits to display
        SUBW    CX,#WC3-DATABASEQQ ;Rubbish to get offset
        MOVB    WC2,#0
;
        MOVB    BH,WC1          ;No.of dec places (=display's exp)
;
        LODB                    ;Step left from rounded digit
FOT8
        LODB                    ;Get next digit
        CMPB    AL,BL           ;100
        JB      FOT9            ;No rounding carry
        SUBB    AL,BL
        INCB    [SI]            ;Report carry
;
FOT9
        CMPB    DL,#0
        JE      FOT12           ;Not 'floating' dec places
        CMPB    AL,#0
        JNE     FOT10           ;Digit not zero (stops floating)
        CMPB    BH,#0
        JNE     FOT11           ;Still some dec places to float
FOT10
        MOVB    DL,#0           ;Reset 'float' flag (non-zero dec digit
        JMP     FOT12           ; or integer started)
FOT11
        DECB    BH              ;Reduce count of floating dec places
        JMP     FOT13           ; and display's exponent
FOT12
        STOB                    ;Store digit into display field
FOT13
        LOOP    FOT8            ;Repeat for next digit
;
        CMPB    [SI],#0
        JE      FOT15           ;No overflow due to rounding
;
        CMPW    DI,#WC2-DATABASEQQ ;Rubbish to get offset
        JA      FOT14           ;Extra display digit available
        CMPB    BH,#0
        JLE     FOTM            ;No dec places, integer 9999999999
                                ;became 10000000000  overflow
        MOVB    WC3,#1          ;Set MS digit to 1 for 1000...
        DECB    BH              ; and lose 1 dec place
        JMP     FOT15
FOT14
        MOVB    AL,#1           ;Use extra digit for overflow
        STOB
FOT15
        CMPB    BH,#0
        JNE     FOT15A          ;Not integer
        MOVB    BH,#0FH         ;Remove '.' from rh position
FOT15A  MOVB    WC1,BH
        MOVW    CX,DI           ;Set count for no.of display
        SUBW    CX,#WC2-DATABASEQQ ;Rubbish to get offset
        JLE     FOT16           ;No unused digits
        MOVB    AL,#0FH         ;BCD blank char    ********
  REP   STOB
;
FOT16
        MOVB    AL,RC           ;Copy sign of fp no. from FAC
        CMPB    AL,#0           ; to display field
        JE      FOT17
        MOVB    AL,#8
FOT17   MOVB    WC2,AL
;
        JMP     REST            ;Exit normally
;
FOTM
        MOVB    AL,#9           ;fp no. too large for display
        MOVW    CX,#NDI
        LEA     DI,WC3          ;Set integer 9999999999
  REP   STOB
;
        MOVB    WC1,#0FH        ;Exp 0, no dec places
        MOVB    AL,RC           ;Get sign right
        CMPB    AL,#0
        JE      FOT19
        MOVB    AL,#8
FOT19   MOVB    WC2,AL
;
        JMP     ERROR           ;Arithmetic overflow error report
;
;
;
        PAGE
;
;
FP0             ;Set FAC = 0 and exit normally (exp underflow)
;
        CLD
        MOVB    AL,#0
        MOVW    CX,#ND+2        ;Total length of fp no.
        LEA     DI,FAC
  REP   STOB                    ;Set FAC to +0.00000 E -128
;
        JMP     CLWC            ;Clear workspace and exit
;
;
FPMAX                           ;Set FAC to max value and take error
                                ; exit  (exponent overflow etc.)
        CLD
        MOVB    AL,#99
        MOVW    CX,#ND
        LEA     DI,FC1          ;Set FAC to 99.9999999999 E 127
  REP   STOB                    ; leaving the sign unchanged
        MOVB    FE,#0FFH
        MOVB    ERRFLG,#1
        JMP     CLWC            ;Clear up workspace and exit
;
;
FCLW            ;Clear out workspace
;
        CALL    SAVE
        JMP     CLWC            ;Clear C-digits, restore regs and exit
;
CLWC            ;Clear workspace C-digits
;
        CLD                     ;Auto decrement
        MOVB    AL,#0
        LEA     DI,RC
        MOVW    CX,#ND+NDI+11   ;Clear RC and WC workspaces
  REP   STOB
;
        JMP     REST            ;Restore regs and exit
;
        PAGE
;
FNORM                   ;Round, normalise and store the mantissa in the
                        ; workspace C-digits WC(n) into FAC
;
        MOVW    SI,#0
        ADDB    FE,#80H         ;Remove exponent offset
        CMPB    WC0,#0
        JE      FN1             ;No overflow from real addition
;
        INCB    FE              ;Step exponent for overflow
        JO      FPMAX           ;Exponent oflo - max value + error
        JMP     FN4             ;WC0-6 is mantissa C-digits
;
FN1
        MOVW    CX,#ND          ;No.of digits in mantissa
FN2
        INCW    SI              ;Points to WC1
        CMPB    WC[SI],#0
        JNE     FN3             ;1st non-zero C-digit found
        LOOP    FN2
;
        JMP     FP0             ;No non-zero digit so 0 to FAC
;
FN3
        DECW    SI              ;Adjust exp for no.of leading zeroes
        MOVW    AX,SI
        SUBB    FE,AL           ;LS byte of SI
        JO      FP0             ;Exp underflow so 0 to FAC
        INCW    SI
;
FN4
        MOVW    CX,#ND
        LEA     DI,FC+ND        ;Last C-digit of FAC mantissa
        STD
        ADDW    SI,CX           ;1st digit beyond mantissa
        MOVB    DH,#100
        MOVB    AL,#50
        ADDB    AL,WC[SI]       ;Round from 1st digit beyond
        CMPB    AL,DH
        JB      FN5             ;No carry from rounding
        INCB    WC-1[SI]        ;Note carry
FN5
        DECW    SI
        MOVB    AL,WC[SI]       ;Get C-digit
        CMPB    AL,DH
        JB      FN6             ;Nocarry
        SUBB    AL,DH
        INCB    WC-1[SI]        ;Propagate carry
FN6
        STOB
        LOOP    FN5             ;Store C-digit into FAC
;
        CMPB    WC-1[SI],#0
        JE      FN8             ;No overflow from rounding
        INCB    FE              ;Step exponent
        JNO     FN7
        JMP     FPMAX           ;Exp overflow = max val + error
FN7
        INCB    1[DI]           ;FC1 = 1, rest of mantissa is 0
;
FN8
        ADDB    FE,#80H         ;Restore exponent offset
;
        JMP     CLWC            ;Clear workspace and exit
;
;
        PAGE
;
LABBCD                  ;Convert ASCII data from display register
                        ; to BCD data formatted for FINP
;
        CALL    FCLW            ;Clear BCD register
        CALL    SAVE
        MOVW    CX,#13
        CMPB    ABBASE,#'-'     ;Is 1st char a minus sign?
        JNE     LABB2           ;No, jump
        MOVB    WC2,AL          ;Yes, set -ve flag for FINP
        DECW    CX              ;Reduce char count
LABB2
        MOVB    AH,#0           ;Keep count of no.of dec.places
        LEA     SI,ABBASE+12    ;Start from end of ASCII buffer
        LEA     DI,WC3+9        ;..and from end of BCD buffer...
        STD                     ; ..and work back
LABB4
        LODB                    ;Fetch ASCII char
        CMPB    AL,#20H         ;Space?
        JNE     LABB6
        LOOP    LABB4           ;Skip spaces
LABB6
        CMPB    AL,#'.'         ;D.P.?
        JNE     LABB8
        MOVB    WC1,AH          ;Set no.of dec.places for FINP
        LOOP    LABB4
        JMP     LABBE           ;All done
LABB8
        INCB    AH              ;Count dec.places
        ANDB    AL,#0FH         ;Convert ASCII to BCD
        STOB                    ;Put into wkspace
        LOOP    LABB4           ;Do next char
LABBE   JMP     REST            ;Exit
;
;
        PAGE
;
CLRAB                           ;Clear the ASCII display register to 0.
;
        MOVW    AX,#2E30H
        LEA     DI,ABBASE
        CLD
        STOW
        MOVW    AX,#2020H
        MOVW    CX,#8
  REP   STOW
        MOVB    BUFPTR,#0
        RET
;
;
CLRMEM                          ;Clear memory
;
        MOVW    AX,#2020H
        LEA     DI,MBASE
        MOVW    CX,#10
        CLD
  REP   STOW
        RET
;
;
;
;
        PAGE
;
LBCDAB                          ;Convert BCD value in wkspace to
                                ; ASCII characters in display register
;
        CALL    SAVE
        CALL    CLRAB
        MOVB    AL,ERRFLG       ;Check error flag
        CMPB    AL,#0
        JE      LBC1            ;Jump if O.K
        MOVB    ABBASE,#45H
        MOVB    ABBASE+1,#72H
        MOVB    ABBASE+2,#72H
        MOVB    ABBASE+3,#6FH
        MOVB    ABBASE+4,#72H   ;Output Error
        JMP     LBC12
LBC1
        MOVW    CX,#10
        MOVB    AH,#10
        MOVB    AL,WC1          ;WC1 has no.of dec.places
        CMPB    AL,#10
        JG      LBC2            ;Assume > 10 means 0  (i.e.0F)
        SUBB    AH,AL
LBC2
        CLD
        LEA     SI,WC2
        LEA     DI,ABBASE
        LODB                    ;Get sign
        CMPB    AL,#0
        JZ      LBC4
        MOVB    AL,#'-'
        STOB                    ;Store sign to ASCII
LBC4
        CMPB    AH,#0
        JNZ     LBC6
        MOVB    AL,#'.'
        STOB                    ;Start with d.p. if necessary
LBC6
        LODB
        CMPB    AL,#0FH         ;Blank?
        JE      LBC8
        ORB     AL,#30H         ;Convert BCD to ASCII
        STOB
LBC8
        DECB    AH
        JNZ     LBC10
        MOVB    AL,#'.'
        STOB
LBC10
        LOOP    LBC6
;
LBC12
        JMP     REST            ;Exit
;
;
;
        PAGE
;
CLRALL                          ;Clears everything in sight
;
        CALL    CLRMEM
        MOVB    ABBASE+18,#20H  ;Get rid of M=
        MOVB    ABBASE+19,#20H
        CALL    CLRAB
        CALL    FCLW
        LEA     DI,FAC
        MOVW    AX,#0
        MOVW    CX,#ND+2
        CLD
  REP   STOW
;
        MOVB    LCHOP,#0
        MOVB    LCHCL,#0
        MOVB    LCHPC,#0
        MOVB    LCHNO,#0
        MOVB    POPN,#0
        MOVW    BUFPTR,#0
        MOVB    TPOPN,#0
        MOVB    DPFLAG,#0
        MOVB    ERRFLG,#0
;
        RET
;
;
;
        PAGE
;
DISP                    ;Display routine to output the ASCII buffer
                        ; to the microscreen, using the interface program
                        ; in the bios, called LCD_calc_out, which takes
                        ; a character argument and displays it on the MScreen.
;
        MOVW    AX,#80H
        PUSH    AX
        CALL LCD_calc_out
        
        LEA     SI,ABBASE
        MOVW    CX,#32          ;Nothing clever for now...
DISP2   CLD
        LODB
        CMPB    LCHOP,#0        ;Check to see if an operator
        JE      DISP8           ; should be displayed and if
        CMPB    AL,#20H         ; so display it instead of
        JNE     DISP6           ; the first space.
        CMPB    POPN,#1
        JNE     DISP3
        MOVB    AL,#2BH
        JMP     DISP8
DISP3   CMPB    POPN,#2
        JNE     DISP4
        MOVB    AL,#2DH
        JMP     DISP8
DISP4   CMPB    POPN,#3
        JNE     DISP5
        MOVB    AL,#78H
        JMP     DISP8
DISP5   CMPB    POPN,#4
        JNE     DISP8
        MOVB    AL,#10H
        JMP     DISP8
DISP6   PUSH    SI              ;Save regs from Pascal
        PUSH    CX
        PUSH    AX              ;Parameter for LCD_calc_out
        CALL    LCD_calc_out
        POP     CX
        POP     SI
        LOOP    DISP2
        RET
DISP7
        CLD
        LODB
DISP8   PUSH    SI
        PUSH    CX
        PUSH    AX
        CALL    LCD_calc_out
        POP     CX
        POP     SI
        LOOP    DISP7
        RET
;
        PAGE
;
BOTLIN                  ;This routine displays legends for soft keys
;
        MOVW    AX,#0A8H        ;Cursor address for bottom line LCD
        PUSH    AX              ;Parameter for LCD_calc_out
        CALL    LCD_calc_out
        LEA     SI,KEYLEG       ;Address of legends in RAM
        MOVW    CX,#40          ;40 character line
BOT2	CLD
        LODB
        PUSH    SI
        PUSH    CX
        PUSH    AX
        CALL    LCD_calc_out
        POP     CX
        POP     SI
        LOOP    BOT2
        RET
;
LEDON                   ;Turns on LED's for relevent soft keys
;
        MOVW    AX,#00H         ;Turns on SK1,SK2,SK3,SK4,SK5,SK6
        PUSH    AX              ;All other LED's turned **OFF**
        CALL    LCD_calc_out
        RET
;
;
        PAGE
;
GETCHR                  ;This routine is used to translate keycodes to ASCII
;
        MOVB    AH,AL           ;It returns C clear, P for MEM+
        MOVB    AL,#'S'         ;S for STORE, R for RECALL, M for MEM-
        CMPB    AH,#0DH         ;or E for SEND
        JE      GRET
        MOVB    AL,#'R'
        CMPB    AH,#0EH
        JE      GRET
	MOVB    AL,#'E'         ;Mod for SEND
        CMPB    AH,#0AH
        JE      GRET            ;END MOD FOR SEND
        MOVB    AL,#'%'
        CMPB    AH,#1DH
        JE      GRET
        MOVB    AL,#'X'
        CMPB    AH,#1EH
        JE      GRET
        MOVB    AL,#0F6H        ;Divide
        CMPB    AH,#1FH
        JE      GRET
        MOVB    AL,#'-'
        CMPB    AH,#20H
        JE      GRET
        MOVB    AL,#'+'
        CMPB    AH,#21H
        JNE     G2
GRET    RET
G2      MOVB    AL,#'C'
        CMPB    AH,#30H
        JE      GRET
        MOVB    AL,#'7'
        CMPB    AH,#31H
        JE      GRET
        MOVB    AL,#'8'
        CMPB    AH,#32H
        JE      GRET
        MOVB    AL,#'9'
        CMPB    AH,#33H
        JE      GRET
        MOVB    AL,#'4'
        CMPB    AH,#43H
        JE      GRET
        MOVB    AL,#'5'
        CMPB    AH,#44H
        JE      GRET2
        MOVB    AL,#'6'
        CMPB    AH,#45H
        JE      GRET2
        MOVB    AL,#'1'
        CMPB    AH,#54H
        JE      GRET2
        MOVB    AL,#'2'
        CMPB    AH,#55H
        JE      GRET2
        MOVB    AL,#'3'
        CMPB    AH,#56H
        JNE     G4
GRET2   RET
G4      MOVB    AL,#'0'
        CMPB    AH,#5EH
        JE      GRET2
        MOVB    AL,#'.'
        CMPB    AH,#5FH
        JE      GRET2
        MOVB    AL,#'='
        CMPB    AH,#60H
        JE      GRET2
        MOVB    AL,#'P'
        CMPB    AH,#0BH
        JE      GRET2
        MOVB    AL,#'M'
        CMPB    AH,#0CH
        JE      GRET2
        MOVB    AL,#0
        RET
;
;
;
        PAGE
;
STOR                            ;Store ASCII register to memory
;
        LEA     SI,ABBASE
        LEA     DI,MBASE
        MOVW    CX,#9
        CLD
  REP   MOVW
        MOVB    ABBASE+18,#'M'
        MOVB    ABBASE+19,#'='
        MOVB    LCHNO,#0                ;Prevent continued number entry
        RET
;
;
;
RECAL                           ;Recall memory to ASCII register
;
        LEA     SI,MBASE
        LEA     DI,ABBASE
        MOVW    CX,#9
        CLD
  REP   MOVW
        MOVB    AL,ABBASE
        CMPB    AL,#20H         ;Have we just moved blanks?
        JNE     RECAL2
        CALL    CLRAB
RECAL2
        MOVB    LCHOP,#0
        MOVB    LCHCL,#0
        MOVB    LCHNO,#0
        MOVB    LCHPC,#0
;
        RET
;
;
;
;
        PAGE
;
;
GOTOP                           ;Prog comes here when char entered is operator
;
        CMPB    LCHOP,#0        ;Was last char an operator?
        JZ      GOTOP2          ;No, jump
        MOVB    POPN,AH         ;Yes, just update pending opn.
        JMP     GOTOPE
GOTOP2
        MOVB    TPOPN,AH        ;Temp. save for pending opn.
        CALL    LABBCD
        CALL    FINP
        CMPB    POPN,#0
        JE      GOTOP8
GOTOP3
        CMPB    POPN,#1
        JNE     GOTOP4
        CALL    FADD            ;Do +
        JMP     GOTOP8
GOTOP4
        CMPB    POPN,#2
        JNE     GOTOP5
        CALL    SWAP
        CALL    FSUB            ;Do -
        JMP     GOTOP8
GOTOP5
        CMPB    POPN,#3
        JNE     GOTOP6
        CALL    FMUL            ;Do X
        JMP     GOTOP8
GOTOP6
        CALL    SWAP
        CALL    FDIV            ;Do /
GOTOP8
        MOVB    AH,TPOPN        ;Recover popn.
        MOVB    POPN,AH
        CALL    FOUT
        MOVB    AH,ERRFLG       ;Check error status
        CMPB    AH,#0
        JNZ     GOTOP9          ;If error, avoid corrupting FVAC
        CALL    FPUT            ;Leave result in FVAC to allow chaining
GOTOP9
        CALL    LBCDAB
GOTOPE
        MOVB    LCHOP,#1
        MOVB    LCHCL,#0
        MOVB    LCHNO,#0
        MOVB    LCHPC,#0
        JMP     MAIN6
;

;
;
        PAGE
;
START
MAIN
;
CALC_INPUT                      ;This is main CALC entry point
;
        MOVW    BX,SP           ;The char to be processed is on the stack.
        MOVW    AX,2[BX]
        PUSH    BP              ;Save BP for return
        CMPB    AL,#4           ;Is it CALC keycode?
        JNE     MAIN1
        MOVW    AX,#0
        PUSH    AX
        CALL    LCD_calc_out
        CALL    BOTLIN          ;Display soft key legends
        JMP     GOTCLC          ;Set up registers and display 0.
MAIN1
        CMPB    AL,#9           ;Is it EXIT keycode?
        JNE     MAIN1A
        MOVW    AX,#0ffffh
        PUSH    AX
        CALL    LCD_calc_out
        JMP     MAIN8
MAIN1A
        CALL    GETCHR          ;For the present, get char to AL ****
        CMPB    AL,#0
        JNZ     MAIN2
        JMP     MAIN8           ;GETCHR din't recognise char, so throw it away
MAIN2
        MOVB    AH,ERRFLG       ;Get error status
        CMPB    AH,#0
        JZ      MAIN2A          ;Jump if no error
        CMPB    AL,#'C'         ;If error, only allow CLR
        JNE     MAIN8
        JMP     CLRERR
MAIN2A
        MOVB    AH,#0
        CMPB    AL,#'='
        JE      GOTOPL
        INCB    AH
        CMPB    AL,#'+'
        JE      GOTOPL
        INCB    AH
        CMPB    AL,#'-'
        JE      GOTOPL
        INCB    AH
        CMPB    AL,#'X'
        JE      GOTOPL
        INCB    AH
        CMPB    AL,#0F6H                ;Code for divide
        JE      GOTOPL
        INCB    AH
        CMPB    AL,#'%'
        JE      PERCYL
        CMPB    AL,#'C'                 ;CLR
        JE      GOTCLR
        CMPB    AL,#'.'
        JE      GOTNUM
        CMPB    AL,#'E'                 ;Another mod for SEND
        JE      SENDLCD1                ;if we want to send, jump to SENDLCD
        CMPB    AL,#'0'
        JB      MAIN8
        CMPB    AL,#'9'
        JBE     GOTNUM
        CMPB    AL,#'S'
        JNE     MAIN3
        CALL    STOR
        JMP     MAIN6
MAIN3   CMPB    AL,#'R'
        JNE     MAIN3A
        CALL    RECAL
        JMP     MAIN6
MAIN3A  CMPB    AL,#'P'                 ;MEM+
        JNE     MAIN3B
        CALL    MEMKEY
        JMP     MAIN6
MAIN3B  CMPB    AL,#'M'
        JNE     MAIN6
        CALL    MEMKEY
MAIN6
        CALL    DISP
MAIN8
        POP     BP              ;restore bp
        RET     #2              ;  ******  RET TO BIOS ******
;
;
;
;
GOTOPL  JMP     GOTOP           ;Staging post
PERCYL  JMP     PERCY
;
;
        PAGE
;
GOTCLR
        CMPB    LCHCL,#0        ;Was last char. also a CLR?
        JE      GOTCL2          ;No, jump
GOTCLC                          ;Come here if CALC is pressed
        CALL    CLRALL          ;Yes, clear everything
GOTCL2
        CALL    CLRAB           ;Clear ASCII
        MOVB    LCHOP,#0
        MOVB    LCHCL,#1
        MOVB    LCHNO,#0
        MOVB    LCHPC,#0
        JMP     MAIN6
;
CLRERR
        MOVB    ERRFLG,#0       ;Clear error flag
        CALL    FGET            ;Restore last result to FAC
        CALL    FCLW
        CALL    FOUT
        CALL    LBCDAB
        MOVB    POPN,#0
        JMP     MAIN6

SENDLCD1        JMP     SENDLCD ;intermediate jump for lcd

;
        PAGE
;
;
GOTNUM
        PUSH    AX              ;Save char
        CMPB    LCHNO,#0        ;Was last char a number?
        JNE     GOTN2           ;Yes, jump
        CALL    CLRAB           ;No, clear buffer
        MOVB    DPFLAG,#0       ;Zero dec. point flag
GOTN2
        MOVW    BX,BUFPTR       ;Get current buffer position
        POP     AX              ;Recover char
        CMPB    AL,#'.'
        JNE     GOTN4
        CMPB    DPFLAG,#0
        JNZ     MAIN8           ;Only allow one dec. point!!!
        MOVB    DPFLAG,#1
        CMPW    BX,#0           ;Insert zero before leading d.point
        JNZ     GOTN5
        INCW    BX
        INCB    BUFPTR
GOTN4
        CMPW    BX,#0
        JNZ     GOTN5
        CMPB    AL,#'0'
        JE      GOTN6
GOTN5
        CMPW    BX,#9
        JG      GOTN8           ;Buffer full, go away
        MOVB    ABBASE[BX],AL   ;Update buffer
        INCB    BUFPTR          ;Update buffer position
        CMPB    DPFLAG,#0
        JNZ     GOTN6
        MOVB    ABBASE+1[BX],#'.' ;Put point after no. unless entered
GOTN6
        MOVB    LCHOP,#0
        MOVB    LCHCL,#0
        MOVB    LCHNO,#1
        MOVB    LCHPC,#0
GOTN8
        JMP     MAIN6
;
        PAGE
;
PERCY
        CMPB    LCHPC,#0        ;Two %'s consecutively?
        JZ      PERCY2          ;No, continue
        JMP     MAIN8
PERCY2
        CMPB    POPN,#1         ;Pending opn. must be add...
        JZ      PERCY4
        CMPB    POPN,#2         ;..or subtract
        JZ      PERCY4
        CMPB    POPN,#0         ;..or equals
        JZ      PERCY4
        JMP     MAIN8           ;Otherwise go away
PERCY4
        CALL    LABBCD
        CALL    FINP
        DECB    FE              ;Do percent
        CALL    FMUL
        CALL    FOUT
        CALL    LBCDAB
        MOVB    LCHOP,#0
        MOVB    LCHCL,#0
        MOVB    LCHNO,#0
        MOVB    LCHPC,#1        ;Set percent flag
        JMP     MAIN6
;
        PAGE
;
MEMKEY                          ;Comes here to process MEM+ and MEM-
;
        PUSH    AX              ;Save op
        LEA     SI,MBASE
        LEA     DI,MBASE+20
        MOVW    CX,#6
  REP   MOVW                    ;Save mem in case of error later
        CALL    TEMPS           ;Save FAC and FVAC
        CALL    LABBCD
        CALL    FINP
        CALL    FPUT
        CALL    SWASC           ;Swaps ASCII registers
        CMPB    ABBASE,#20H     ;Was there anything in memory?
        JNE     MEMK3           ;Yes, carry on
        MOVW    ABBASE,#2E30H   ;No, put in 0.
MEMK3
        CALL    LABBCD
        CALL    FINP
        POP     AX              ;Get op
        CMPB    AL,#'P'
        JNE     MEMK2
        CALL    FADD
        JMP     MEMK4
MEMK2   CALL    FSUB
MEMK4
        CALL    FOUT
        CALL    LBCDAB
        CMPB    ABBASE,#'E'     ;Check for Error
        JE      MEMK6           ;Don't put Error into memory or lose FVAC!
        CALL    SWASC           ;Swap back
        CALL    TEMPR           ;Restore FAC and FVAC
        MOVB    ABBASE+18,#'M'  ;Put up M= just in case this is first
        MOVB    ABBASE+19,#'='  ; use of memory keys
        JMP     MEMK8
MEMK6
        LEA     SI,MBASE+20     ;Restore memory
        LEA     DI,MBASE
        MOVW    CX,#6
        CLD
  REP   MOVW
MEMK8
        MOVB    LCHNO,#0        ;Don't allow continued number entry
        RET;
        PAGE
;
TEMPS                   ;Do temporary store of FAC and FVAC
;
        LEA     SI,FAC
        LEA     DI,FPV1
        MOVW    CX,#9
        CLD
  REP   MOVW
        RET
;
TEMPR                   ;Restore from TEMP
;
        LEA     SI,FPV1
        LEA     DI,FAC
        MOVW    CX,#9
        CLD
  REP   MOVW
        RET
;
        PAGE
;
SWASC                   ;Swap main ASCII disp reg. with memory reg
;
        CLD
        LEA     SI,ABBASE
        LEA     DI,ABBASE
        LODW
        XCHG    MBASE,AX
        STOW
        LODW
        XCHG    MBASE+2,AX
        STOW
        LODW
        XCHG    MBASE+4,AX
        STOW
        LODW
        XCHG    MBASE+6,AX
        STOW
        LODW
        XCHG    MBASE+8,AX
        STOW
        LODW
        XCHG    MBASE+10,AX
        STOW
;
        RET


SENDLCD                         ;Nick Wilson -- Thu 28/07/83 - 10:45:38
                                ;Routine to send LCD contents to MSDOS
                                ;input queue. Acts on MB2, Returns to
                                ;bios via MAIN8.
        
;
        LEA     SI,ABBASE
        MOVW    CX,#12          ;Max of ten characters
SLCD1   CLD
        LODB
        CMPW    CX,#12
        JE      SLCD2           ;IF AT FIRST POS - LEAVE (NJW 5.9.83)
        CMPB    AL,#2Eh         ;point ok
        JZ      SLCD4           ;but test for end of line
        CMPB    AL,#30h         ;BELOW 0 NOT OK
        JB      SLCD3
        CMPB    AL,#39h         ;ABOVE 9 NOT OK
        JA      SLCD3
SLCD2   MOVB    AH,#01          ;say length of 1
        PUSH    SI
        PUSH    CX
        PUSH    AX
        CALL    KBD_q_out
        POP     CX
        POP     SI
        LOOP    SLCD1
SLCD3   JMP     MAIN8           ;done - tidy & return
;
SLCD4                           ; test next char
        CMPB    [SI],#30H       ; next char below 0 not ok
        JB      SLCD3
        CMPB    [SI],#39H       ;above 9 not ok
        JA      SLCD3
        JMP     SLCD2           ;otherwise ok
;
        end

$ 