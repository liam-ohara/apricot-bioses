DAT  $ TYPE msinter.asm
; [bios.apricot.ram]msinter.asm
	title	'[bios.apricot.ram]msinter.asm'
	INCLUDE	'legal.asi'
;************************************************************************
;*                                                                      *
;*			M S I N T E R					*
;*									*
;*	Filename:	[bios.apricot.ram]msinter.asm			*
;*	Programmer:	G. Kurth					*
;*	Created:	25-may-84					*
;*	Modified:	Generic RAM BIOS version 15/6/84 GK		*
;*			MSCREEN support 16/8/84 GK			*
;*			Apricot RAM BIOS version 5/9/84			*
;*									*
;************************************************************************

;************************************************************************
;*									*
;*	This module provides the interface between MS-DOS and the	*
;*	RAM BIOS.							*
;*	It contains the MS-DOS device list (MSI_device_list) and the	*
;*	entry points to the device drivers.				*
;*									*
;************************************************************************

	page

	name	msinter

; Equate file includes
;=====================

        INCLUDE 'Genequ.asi'
        INCLUDE 'DRSoffs.asi'

; Things needed to communicate with SYSINIT
; =========================================
 
 Global MSI_Device_List ;far
 Global CLKDEV, WINMAX, MSDDEV, DRVMAX  ;for re-configuration by Biosinit
 Global CONSEG,AUXSEG,PRNSEG,CLKSEG,WINSEG,LCDSEG
 
; Device Driver Procedures.
; ========================

 Global MSCON_Driver             ; procedure MSCON_Driver(drs_addr:address)
 Global MSCLK_Driver             ; procedure MSCLK_Driver(drs_addr:address)
 Global MSD_Driver               ; procedure MSD_Driver(drs_addr:address)
 Global MSPRN_Driver             ; procedure MSPRN_Driver(drs_addr:address)
 Global MSAUX_Driver             ; procedure MSAUX_Driver(drs_addr:address)
 Global MSWINI_Driver            ; procedure MSWINI_Driver(drs_addr:address)
 Global MSLCD_Driver             ; procedure MSLCD_Driver(drs_addr:address)
 
; Things needed to communicate with BIOS system.
; ==============================================

 Global   codebaseqq
 Global   databaseqq
 Global   STKBASEQQ
 
;  Device Driver Tables.
;  ====================

;-----------------------------------------------+
;     DWORD pointer to next device              | 1 word offset.
;         (-1,-1 if last device)                | 1 word segement.
;-----------------------------------------------+
;     Device attribute WORD                     ; 1 word.
;       Bit 15 = 1 for chacter devices.         ;
;                0 for Block devices.           ;
;                                               ;
;       Charcter devices. (Bit 15=1)            ;
;         Bit 0 = 1  current sti device.        ;
;         Bit 1 = 1  current sto device.        ;
;         Bit 2 = 1  current NUL device.        ;
;         Bit 3 = 1  current Clock device.      ;
;         Bit 4 = 1  current SPECIAL device.    ;
;                                               ;
;         Bit 13 = 1 for non IBM machines.      ;
;                  0 for IBM machines only.     ;
;         Bit 14 = 1 IOCTL control bit.         ;
;-----------------------------------------------+
;     Device strategy pointer.                  ; 1 word offset.
;-----------------------------------------------+
;     Device interrupt pointer.                 ; 1 word offset.
;-----------------------------------------------+
;     Device name field.                        ; 8 bytes.
;       Character devices are any valid name    ;
;         left justified, in a space filled     ;
;         field.                                ;
;       Block devices contain # of units in     ;
;         the first byte.                       ;
;-----------------------------------------------+
 
 Section MSINTER.TABLES,align(2),class=INSTRQQ
 
 Assume CS:codebaseqq
 
MSI_Device_List
CONDEV					;Header for device CON
        Word	AUXDEV-codebaseqq
CONSEG	WORD	bits(codebaseqq,4,16)	;Link to next device
        Word	8013H			;Attributes: console input,spec-output device
        Word	STRATEGY-codebaseqq	;Srategy entry point
        Word	CON_Ientry-codebaseqq	;Interrupt entry point
        ASCII	'CON     '		;Device name
 
AUXDEV					;Header for device AUX
        Word	PRNDEV-codebaseqq	;
AUXSEG	WORD	bits(codebaseqq,4,16)
        Word	8000H
        Word	STRATEGY-codebaseqq
        Word	AUX_Ientry-codebaseqq
        ASCII	'AUX     '
 
PRNDEV					;Header for device PRN
        Word	CLKDEV-codebaseqq	;
PRNSEG	WORD	bits(codebaseqq,4,16)
        Word	8000H
        Word	STRATEGY-codebaseqq
        Word	PRN_Ientry-codebaseqq
        ASCII	'PRN     '
;
; Default layout - first block device is single wini
; 
CLKDEV					;Header for device CLOCK
        Word	WINIDEV-codebaseqq
CLKSEG	Word	bits(codebaseqq,4,16)
        Word	8008H
        Word	STRATEGY-codebaseqq
        Word	CLK_Ientry-codebaseqq
        ASCII	'CLOCK   '
 
;
; Default layout - second block device is single floppy
;
WINIDEV					;Header for Winchester disk
        Word	MSDDEV-codebaseqq
WINSEG	Word	bits(codebaseqq,4,16)
        Word	2000H			;Is a block device
        Word	STRATEGY-codebaseqq
        Word	WINI_Ientry-codebaseqq
WINMAX  Byte	1			;Test BIOS. Drive A: only.
        Byte	0BAH,0BAH,0BAH,0BAH,0BAH,0BAH,0BAH ;filler
 
MSDDEV					;Header for disk devices
        Word	LCDDEV-codebaseqq
LCDSEG	Word	bits(codebaseqq,4,16)
        Word	2000H			;Is a block device
        Word	STRATEGY-codebaseqq
        Word	MSD_Ientry-codebaseqq
DRVMAX  Byte	2			;Interim BIOS. Drive A: & B: only.
        Byte	0BAH,0BAH,0BAH,0BAH,0BAH,0BAH,0BAH ;filler
;
; If PROM information indicates that there is no wini present, the above
; layout is changed by BIOSINIT to remove the winchester block device from
; the list, and adjust the floppy block device to 2 drives.
;
LCDDEV					;Header for MSCREEN device
	Word	-1,-1			;end of list
	Word	8000H
	Word	STRATEGY-codebaseqq
	Word	LCD_Ientry-codebaseqq
	Ascii	'MSCREEN '

;------------------------------------------------------------------------------;
;   MSINTER data area.                                                         ;
;------------------------------------------------------------------------------;

        Section MSINTER.DATA,align(2),class=DATAQQ


Save_ss     word 0
Save_sp     word 0                 ;Save old stack segment.

PTRSAV_bx   word 0                 ;Strategy pointer save.
PTRSAV_es   word 0

;-----------------------------------------------------------------------------;
;   MSINTER code.                                                             ;
;-----------------------------------------------------------------------------;

        Section MSINTER.CODE,align(2),class=INSTRQQ
        Assume ds:databaseqq,CS:codebaseqq,ss:databaseqq
;
;
; Simplistic Strategy routine for non-multi-Tasking system.
;
;   Currently just saves I/O packet pointers in PTRSAV for
;   later processing by the individual interrupt routines.
;
 

STRATEGY
	PUSH	AX
        PUSH    DS              ;SAVE MSDOS'S DATA SEGMENT
        MOV     AX,#bits(databaseqq,4,16) ;GET BIOS DATA SEGMENT
        MOV     DS,AX
        MOV     PTRSAV_bx,BX
        MOV     PTRSAV_es,ES
        POP     DS              ;RESTORE MSDOS'S DATA SEGMENT
        POP	AX
	RETS
 

;
; Common program for handling the simplistic I/O packet
;   processing scheme in MSDOS 2.0
;
 
ENTRY   PUSH    AX              ;Save all necessary registers.
        PUSH    CX
        PUSH    DX
        PUSH    DI
        PUSH    BP
        PUSH    DS
        PUSH    ES
        PUSH    BX
        
                                ;Set up BIOS environment.
        mov     ax,#bits(databaseqq,4,16)
        mov     ds,ax
        mov     es,ax
        
        cli                     ;disable interrupts for stack switch.
        mov     Save_ss,ss
        mov     Save_sp,sp
        mov     ss,ax
        mov     sp,#(stkbaseqq-databaseqq)

; !!! Assumption: BIOS is always called with interrupts enabled !!!

        sti                     ;stack switch complete.
        
        
        push    PTRSAV_es       ;seg
        push    PTRSAV_bx       ;offset
        
        call    si              ;call BIOS Device Driver.
        
        ;cli                    ;not required, 8086 does not see interrupt
        mov     ss,Save_ss
        mov     sp,Save_sp
        ;sti                    ;ditto, stack switch complete.
        
        POP     BX              ;Restore registers.
        POP     ES
        POP     DS
        POP     BP
        POP     DI
        POP     DX
        POP     CX
        POP     AX
        POP     SI
        RETS                    ;RESTORE REGS AND RETURN


;
; Console interrupt routine for processing I/O packets.
;
 
CON_Ientry
        PUSH    SI
        MOV	SI,#MSCON_Driver-CODEBASEQQ
        JMP     ENTRY
;
; AUX device interrupt routine for processing I/O packets.
;
 
AUX_Ientry
        PUSH    SI
        MOV	SI,#MSAUX_Driver-CODEBASEQQ
        JMP     ENTRY
 
;
; PRN device interrupt routine for processing I/O packets.
;
 
PRN_Ientry
        PUSH    SI
        MOV	SI,#MSPRN_Driver-CODEBASEQQ
        JMP     ENTRY
 
;
; Clock interrupt routine for processing I/O packets.
;
 
CLK_Ientry
        PUSH    SI
        MOV	SI,#MSCLK_Driver-CODEBASEQQ
        JMP     ENTRY

;
; Disk interrupt routine for processing I/O packets.
;
 
MSD_Ientry
        PUSH    SI
        MOV	SI,#MSD_Driver-CODEBASEQQ
        jmp     entry
        
;
; Winchester interrupt routine for processing I/O packets
;
WINI_Ientry
        PUSH    SI
        MOV	SI,#MSWINI_Driver-CODEBASEQQ
        jmp     entry

;
; MicroScreen interrupt routine for processing I/O packets
;
LCD_Ientry
        PUSH    SI
        MOV	SI,#MSLCD_Driver-CODEBASEQQ
        jmp     entry


        end

$ 