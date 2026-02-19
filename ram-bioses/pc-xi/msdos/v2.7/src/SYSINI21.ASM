  WORD    80*24
                WORD    80*25

                end
$    $ TYPE sysini211.asm
; [bios.generic]sysini211.asm
	title	'[bios.generic]sysini211.asm'
        INCLUDE 'legal.asi'
;****************************************************************************
;*                                                                          *
;*                                                                          *
;*  File name:                      [bios.generic]sysini211.asm             *
;*  File status:                    Assembler language module.              *
;*  Globals prefix:                 SI                                      *
;*  Language:                       Tektronix 8086/88 assembler.            *
;*  Project name:                   Activm Test BIOS.                       *
;*  Revision history:               VAX version 1/5/84 GK                   *
;*				Generic RAM BIOS version 15/6/84 GK	    *
;*                                                                          *
;*                                                                          *
;****************************************************************************

;***************************************************************************
;
; This is the SYSINIT file for MS_DOS 2.11 as supplied by Microsoft in
; November 1983.
; Some of the messages have been changed to allow it to fit into the
; 2K of space reserved for it in the current BIOS.
;       It was created by linking SYSINIT.OBJ SYSIMES.OBJ and DUMYBIOS.OBJ
; on the IBM PC.
; The resulting SYSINIT.EXE file was converted to a binary file using
; EXE2BIN on the PC. This was then converted to an assembler DB's file using
; the BASIC BIN2ASM file on the PC, and transferred to the Tektronix.
; Relavent labels and entry points were then inserted manually.
; How it got onto the VAX is another story.
;
;**************************************************************************
;
; Version 1.00  G.Kurth.        1-Dec-83

;---------------------------------------------------------------------------;
;   Relevant files to the above process may be found on the IBM PC floppy   ;
;   disk labelled 'Tektronix <--> IBM PC (Dave Heatley)'.                   ;
;---------------------------------------------------------------------------;
;
	name	sysinit
;
        Section SYSINIT.MY.ALL, class= SYSIQQ
        
;;;;;;;;;;;;;;;;;;;;
; Exported Globals ;
;;;;;;;;;;;;;;;;;;;;
        
        Global  SI_SysInit                      ;far
        Global  SI_Current_DOS_Location         ;address (segment)
        Global  SI_Final_DOS_Location           ;address (segment)
        Global  SI_Device_List                  ;address (offset)
        Global	SI_dev_lst_seg			;address (segment)
	Global  SI_Memory_Size                  ;word (in paragraphs)
        Global  SI_Default_Drive                ;byte
	Global	SI_call_seg			;word - bios segment for re-init
        ;Global  SI_Buffers                      ;byte
        ;Global  SI_Files                        ;byte

;;;;;;;;;;;;;;;;;;;;
; Imported Globals ;
;;;;;;;;;;;;;;;;;;;;

        
        Global  CODEBaseQQ                      ;BIOS environment.
        Global  MSI_Device_List                 ;Device list header.
        Global  BI_Re_Init                      ;Re_Init entry point in
                                                ;BiosInit module.
	GLOBAL	DOSSEG				;MSDOS SEGMENT

;;;;;;;;;;;;;;;;;;
; The real stuff ;
;;;;;;;;;;;;;;;;;;
;
;
; Offset:  0  (0h).
;
SI_SysInit
        byte    0EBh,063h                       ;jmp short GOINIT
        byte    090h                            ; nop
;
; Configuration data area
;
        word    000h                            ; internal DOSINFO label
        
SI_Current_DOS_Location
        word    DOSSEG				;Dos start segment
        
        word    000h                            ;Dos start offset
        
SI_Final_DOS_Location
        word    DOSSEG				;Dos start segment
        
SI_Device_List
        word    MSI_Device_List-CODEbaseQQ
SI_dev_lst_seg
	word	bits(CODEbaseQQ,4,16)
        
SI_Memory_Size
        word    4000h                           ;Default 256K

SI_Default_Drive
        Byte    000h
        
SI_buffers
        Byte    002h
        
SI_Files
        Byte    008h

; Command Line (DEfault)
;
        byte    002h,000h
        ascii   'P'
        byte    000h
        byte    000h,000h,000h,000h,000h,000h,000h,000h
        byte    000h,000h,000h,000h,000h,000h,000h,000h
        byte    000h,000h,000h,000h,000h,000h,000h,000h
        byte    000h,000h,000h,000h,000h
; COMEXE
        byte    000h,000h
        byte    014h
        byte    000h,000h,000h,011h,000h,000h,000h,034h
; Offset:  64  (40h).
        byte    000h,000h,000h
; COUNT
        byte    000h,000h,000h,000h,000h
        byte    000h,000h,000h,000h,000h,000h,000h
; PACKET
        byte    016h
        byte    000h,000h,000h,000h,000h,000h,000h,000h
        byte    000h,000h,000h,000h,000h,000h,000h,000h
        byte    000h,000h,000h,000h,000h
;
; GOINIT - start of real code
;
        byte    0FCh,033h,0F6h
        byte    08Bh,0FEh,02Eh,08Bh,00Eh,00Fh,000h,083h
        byte    0F9h,001h,075h,01Dh,0B9h,000h,008h,033h
        byte    0DBh,041h,074h,010h,08Eh,0D9h,08Ah,007h
; Offset:  128  (80h).
        byte    0F6h,0D0h,088h,007h,03Ah,007h,0F6h,0D0h
        byte    088h,007h,074h,0EDh,02Eh,089h,00Eh,00Fh
        byte    000h,08Ch,0C8h,08Eh,0D8h,0B8h,007h,008h
        byte    0D1h,0E8h,0D1h,0E8h,0D1h,0E8h,0D1h,0E8h
        byte    02Bh,0C8h,08Eh,0C1h,0B9h,0F9h,007h,0D1h
        byte    0E9h,0F3h,0A5h,006h,0B8h,0B1h,000h,050h
        byte    0CBh,02Eh,0A1h,005h,000h,08Eh,0D8h,02Eh
        byte    0A1h,009h,000h,08Eh,0C0h,033h,0F6h,08Bh
; Offset:  192  (C0h).
        byte    0FEh,0B9h,000h,028h,0F3h,0A5h,02Eh,0C5h
        byte    036h,00Bh,000h,02Eh,08Bh,016h,00Fh,000h
        byte    0FAh,08Ch,0C8h,08Eh,0D0h,0BCh,0D9h,000h
        byte    0FBh,036h,0FFh,01Eh,007h,000h,036h,08Ch
        byte    006h,005h,000h,036h,089h,03Eh,003h,000h

;*****************************************************************
; Far call to BI_re_Init from here
;
        byte    09Ah                    ; CALLS
        word    BI_re_Init-CODEbaseQQ
SI_call_seg
        word    bits(CODEbaseQQ,4,16)
;******************************************************************

        byte    0FBh,0FCh,08Ch
        byte    0CBh,083h,0EBh,010h,08Eh,0C3h,033h,0F6h
        byte    08Bh,0FEh,0B9h,080h,000h,0F3h,0A5h,0B4h
; Offset:  256  (100h).
        byte    050h,0CDh,021h,01Eh,00Eh,01Fh,0BAh,0EAh
        byte    006h,0B8h,024h,025h,0CDh,021h,01Fh,036h
        byte    08Ah,016h,011h,000h,00Ah,0D2h,074h,006h
        byte    0FEh,0CAh,0B4h,00Eh,0CDh,021h,0E8h,085h
        byte    000h,00Eh,01Fh,0A0h,013h,000h,098h,08Bh
        byte    0C8h,033h,0DBh,0B4h,03Eh,0CDh,021h,0BBh
        byte    002h,000h,0B4h,03Eh,0CDh,021h,043h,0E2h
        byte    0F9h,0BAh,006h,007h,0B0h,002h,0B4h,03Dh
; Offset:  320  (140h).
        byte    0F9h,0CDh,021h,073h,005h,0E8h,024h,005h
        byte    0EBh,013h,050h,0BBh,001h,000h,0B4h,03Eh
        byte    0CDh,021h,058h,08Bh,0D8h,0B4h,045h,0CDh
        byte    021h,0B4h,045h,0CDh,021h,0BAh,00Fh,007h
        byte    0B0h,002h,0E8h,062h,005h,0BAh,018h,007h
        byte    0B0h,001h,0E8h,05Ah,005h,0BEh,015h,000h
        byte    01Eh,007h,08Bh,0FEh,0B1h,0FFh,0FEh,0C1h
        byte    0ACh,0AAh,00Ah,0C0h,075h,0F8h,04Fh,0B0h
; Offset:  384  (180h).
        byte    00Dh,0AAh,088h,00Eh,014h,000h,00Eh,007h
        byte    0BAh,02Dh,007h,0BBh,035h,000h,08Ch,04Fh
        byte    004h,08Ch,04Fh,008h,08Ch,04Fh,00Ch,033h
        byte    0C0h,0B4h,04Bh,0F9h,0CDh,021h,0BAh,0E4h
        byte    007h,0E8h,0C8h,004h,0EBh,0FEh,00Eh,01Fh
        byte    0BBh,0FFh,0FFh,0B4h,048h,0CDh,021h,0B4h
        byte    048h,0CDh,021h,0A3h,04Dh,000h,0A3h,049h
        byte    000h,0B8h,000h,037h,0CDh,021h,088h,016h
; Offset:  448  (1C0h).
        byte    015h,000h,0BAh,021h,007h,0B8h,000h,03Dh
        byte    0F9h,0CDh,021h,072h,003h,0E9h,0A9h,000h
        byte    00Eh,01Fh,0E8h,01Ah,004h,0A0h,013h,000h
        byte    02Ch,005h,076h,03Bh,098h,08Bh,01Eh,047h
        byte    000h,08Bh,016h,049h,000h,0C5h,03Eh,003h
        byte    000h,0C5h,07Dh,004h,089h,01Dh,089h,055h
        byte    002h,00Eh,01Fh,0C4h,03Eh,047h,000h,026h
        byte    0C7h,005h,0FFh,0FFh,026h,089h,045h,004h
; Offset:  512  (200h).
        byte    0B3h,028h,0F6h,0E3h,08Bh,0C8h,001h,006h
        byte    047h,000h,0B8h,006h,000h,001h,006h,047h
        byte    000h,003h,0F8h,033h,0C0h,0F3h,0AAh,0E8h
        byte    0D5h,003h,0FEh,00Eh,012h,000h,074h,02Fh
        byte    01Eh,0C4h,03Eh,047h,000h,0C5h,01Eh,003h
        byte    000h,08Bh,047h,013h,026h,089h,005h,08Bh
        byte    047h,015h,026h,089h,045h,002h,089h,07Fh
        byte    013h,08Ch,047h,015h,026h,0C7h,045h,004h
; Offset:  576  (240h).
        byte    0FFh,000h,08Bh,05Fh,011h,01Fh,083h,0C3h
        byte    010h,001h,01Eh,047h,000h,0EBh,0C8h,0E8h
        byte    09Dh,003h,08Bh,01Eh,049h,000h,0A1h,04Dh
        byte    000h,08Eh,0C0h,02Bh,0D8h,0B4h,04Ah,0CDh
        byte    021h,006h,08Ch,0C0h,048h,08Eh,0C0h,026h
        byte    0C7h,006h,001h,000h,008h,000h,007h,0C3h
        byte    0BAh,0C6h,007h,0E8h,016h,004h,0E9h,08Dh
        byte    000h,08Bh,0D8h,033h,0C9h,033h,0D2h,0B8h
; Offset:  640  (280h).
        byte    002h,042h,0CDh,021h,0A3h,043h,000h,033h
        byte    0D2h,0B8h,000h,042h,0CDh,021h,08Ch,0CAh
        byte    0A1h,043h,000h,005h,00Fh,000h,0B1h,004h
        byte    0D3h,0E8h,02Bh,0D0h,083h,0EAh,011h,08Eh
        byte    0DAh,08Eh,0C2h,033h,0D2h,036h,08Bh,00Eh
        byte    043h,000h,0B4h,03Fh,0F9h,0CDh,021h,09Ch
        byte    00Eh,01Fh,050h,0B4h,03Eh,0CDh,021h,058h
        byte    09Dh,072h,004h,03Bh,0C8h,074h,009h,0BAh
; Offset:  704  (2C0h).
        byte    021h,007h,0E8h,0A7h,003h,0E9h,008h,0FFh
        byte    0E8h,067h,002h,0E8h,04Bh,002h,072h,0F5h
        byte    08Ah,0E0h,0E8h,044h,002h,080h,0FCh,042h
        byte    075h,00Fh,0E8h,060h,003h,074h,027h,03Dh
        byte    064h,000h,073h,08Ch,0A2h,012h,000h,0EBh
        byte    01Dh,080h,0FCh,043h,074h,003h,0EBh,01Dh
        byte    090h,03Ch,04Fh,075h,011h,0E8h,021h,002h
        byte    072h,0CBh,03Ch,04Eh,075h,008h,0B4h,033h
; Offset:  768  (300h).
        byte    0B0h,001h,08Ah,0D0h,0CDh,021h,00Eh,01Fh
        byte    0E8h,0BCh,002h,0EBh,0C1h,080h,0FCh,044h
        byte    074h,003h,0E9h,085h,001h,08Ch,0CBh,08Eh
        byte    0DBh,089h,036h,061h,000h,08Ch,006h,063h
        byte    000h,0E8h,0CBh,002h,033h,0C0h,0A3h,007h
        byte    000h,0A1h,049h,000h,0A3h,009h,000h,0A3h
        byte    04Bh,000h,006h,01Fh,08Bh,0D6h,08Eh,0C3h
        byte    0BBh,049h,000h,0B0h,003h,0B4h,04Bh,0F9h
; Offset:  832  (340h).
        byte    0CDh,021h,01Eh,007h,00Eh,01Fh,073h,005h
        byte    0E8h,025h,003h,0EBh,0B9h,006h,056h,00Eh
        byte    007h,0BBh,006h,000h,0E8h,0B3h,002h,0BBh
        byte    008h,000h,0E8h,0ADh,002h,00Eh,01Fh,0A1h
        byte    05Fh,000h,03Bh,006h,00Fh,000h,072h,004h
        byte    05Eh,007h,0EBh,0DCh,0A3h,049h,000h,0A1h
        byte    05Dh,000h,0A3h,047h,000h,0C5h,016h,007h
        byte    000h,08Bh,0F2h,083h,0C6h,004h,02Eh,0C4h
; Offset:  896  (380h).
        byte    03Eh,003h,000h,08Bh,004h,0A9h,000h,080h
        byte    074h,01Dh,0A9h,001h,000h,074h,008h,026h
        byte    089h,055h,00Ch,026h,08Ch,05Dh,00Eh,0A9h
        byte    008h,000h,074h,008h,026h,089h,055h,008h
        byte    026h,08Ch,05Dh,00Ah,0E9h,0A4h,000h,02Eh
        byte    0A0h,05Ch,000h,00Ah,0C0h,075h,00Dh,02Eh
        byte    0C7h,006h,047h,000h,000h,000h,0B8h,0FFh
        byte    0FFh,0E9h,0B4h,000h,098h,08Bh,0C8h,08Ah
; Offset:  960  (3C0h).
        byte    0F4h,026h,08Ah,055h,010h,026h,000h,045h
        byte    010h,02Eh,0C5h,01Eh,061h,000h,02Eh,0C4h
        byte    02Eh,003h,000h,026h,0C4h,06Eh,000h,026h
        byte    083h,07Eh,018h,0FFh,074h,006h,026h,0C4h
        byte    06Eh,018h,0EBh,0F3h,02Eh,0A1h,047h,000h
        byte    026h,089h,046h,018h,02Eh,0A1h,049h,000h
        byte    026h,089h,046h,01Ah,02Eh,0C4h,02Eh,047h
        byte    000h,02Eh,083h,006h,047h,000h,05Eh,026h
; Offset:  1024  (400h).
        byte    0C7h,046h,018h,0FFh,0FFh,026h,0C6h,046h
        byte    017h,0FFh,08Bh,037h,043h,043h,026h,089h
        byte    056h,000h,0B4h,053h,0CDh,021h,026h,08Bh
        byte    046h,002h,006h,02Eh,0C4h,03Eh,003h,000h
        byte    026h,03Bh,045h,011h,007h,076h,00Eh,05Eh
        byte    007h,0BAh,07Eh,007h,0BBh,0E1h,007h,0E8h
        byte    044h,002h,0E9h,0D1h,0FEh,01Eh,052h,02Eh
        byte    0C5h,016h,007h,000h,026h,089h,056h,012h
; Offset:  1088  (440h).
        byte    026h,08Ch,05Eh,014h,05Ah,01Fh,042h,0FEh
        byte    0C6h,0E2h,083h,02Eh,0C4h,03Eh,003h,000h
        byte    026h,08Bh,04Dh,017h,026h,08Bh,055h,019h
        byte    02Eh,0C5h,036h,007h,000h,026h,089h,075h
        byte    017h,026h,08Ch,05Dh,019h,08Bh,004h,02Eh
        byte    0A3h,007h,000h,089h,00Ch,089h,054h,002h
        byte    05Eh,007h,040h,074h,003h,0E9h,0D5h,0FEh
        byte    0E9h,08Bh,0FEh,080h,0FCh,051h,075h,02Eh
; Offset:  1152  (480h).
        byte    0E8h,0BAh,001h,074h,0F3h,00Ah,0E4h,075h
        byte    0EFh,0B4h,038h,0BAh,0FFh,0FFh,0CDh,021h
        byte    073h,0E6h,0BAh,0ABh,007h,0E8h,0F4h,001h
        byte    0EBh,0DEh,080h,0FCh,046h,075h,0DCh,0E8h
        byte    09Bh,001h,074h,0D4h,03Dh,064h,000h,073h
        byte    05Bh,0A2h,013h,000h,0EBh,0CAh,080h,0FCh
        byte    057h,075h,00Eh,08Ah,0D0h,0B8h,001h,037h
        byte    088h,016h,015h,000h,0CDh,021h,0E9h,045h
; Offset:  1216  (4C0h).
        byte    0FEh,080h,0FCh,041h,075h,00Eh,03Ch,046h
        byte    075h,007h,0B8h,003h,037h,032h,0D2h,0CDh
        byte    021h,0E9h,032h,0FEh,080h,0FCh,053h,075h
        byte    02Bh,0C6h,006h,015h,000h,000h,0BFh,02Eh
        byte    007h,088h,045h,0FFh,0E8h,032h,000h,00Ah
        byte    0C0h,074h,01Ch,03Ch,020h,072h,005h,088h
        byte    005h,047h,0EBh,0F0h,0C6h,005h,000h,0E8h
        byte    01Fh,000h,03Ch,00Ah,075h,003h,0E8h,018h
; Offset:  1280  (500h).
        byte    000h,0E9h,0CAh,0FDh,0E9h,069h,0FDh,0C6h
        byte    005h,000h,0BFh,015h,000h,0E8h,009h,000h
        byte    03Ch,020h,072h,0E0h,088h,005h,047h,0EBh
        byte    0F4h,08Bh,00Eh,043h,000h,0E3h,011h,08Bh
        byte    036h,045h,000h,026h,08Ah,004h,0FFh,00Eh
        byte    043h,000h,0FFh,006h,045h,000h,0F8h,0C3h
        byte    0F9h,0C3h,08Bh,00Eh,043h,000h,0E3h,0F8h
        byte    0E8h,099h,000h,033h,0F6h,08Bh,0FEh,0E8h
; Offset:  1344  (540h).
        byte    059h,000h,03Ch,020h,072h,0F9h,051h,056h
        byte    057h,08Bh,0EEh,04Dh,0BEh,03Ah,007h,0B5h
        byte    000h,08Bh,0FDh,08Ah,00Ch,046h,0E3h,00Eh
        byte    0F3h,0A6h,09Fh,003h,0F1h,09Eh,0ACh,075h
        byte    0F0h,05Fh,05Eh,059h,0EBh,005h,05Fh,05Eh
        byte    059h,0B0h,05Ah,0AAh,0E8h,024h,000h,0E8h
        byte    036h,000h,075h,0F8h,0E8h,024h,000h,0AAh
        byte    0E8h,018h,000h,0AAh,03Ch,020h,077h,0F8h
; Offset:  1408  (580h).
        byte    03Ch,00Ah,074h,0BBh,026h,0C6h,045h,0FFh
        byte    000h,0E8h,007h,000h,0AAh,03Ch,00Ah,075h
        byte    0F8h,0EBh,0ACh,0E3h,026h,026h,08Ah,004h
        byte    046h,049h,0C3h,0E3h,01Eh,026h,08Ah,004h
        byte    046h,049h,0E8h,003h,000h,074h,0F4h,0C3h
        byte    03Ch,020h,074h,0FBh,03Ch,009h,074h,0F7h
        byte    03Ch,03Dh,074h,0F3h,03Ch,02Ch,074h,0EFh
        byte    03Ch,03Bh,0C3h,059h,089h,03Eh,043h,000h
; Offset:  1472  (5C0h).
        byte    033h,0F6h,089h,036h,045h,000h,0C3h,0E8h
        byte    04Fh,0FFh,072h,007h,03Ch,00Ah,075h,0F7h
        byte    0E8h,046h,0FFh,0C3h,051h,056h,01Eh,006h
        byte    01Fh,033h,0F6h,0ACh,03Ch,061h,072h,009h
        byte    03Ch,07Ah,077h,005h,02Ch,020h,088h,044h
        byte    0FFh,0E2h,0F0h,01Fh,05Eh,059h,0C3h,036h
        byte    0A1h,047h,000h,005h,00Fh,000h,0D1h,0E8h
        byte    0D1h,0E8h,0D1h,0E8h,0D1h,0E8h,036h,001h
; Offset:  1536  (600h).
        byte    006h,049h,000h,033h,0C0h,036h,0A3h,047h
        byte    000h,0C3h,02Eh,08Eh,01Eh,009h,000h,02Eh
        byte    003h,01Eh,007h,000h,08Bh,007h,02Eh,0FFh
        byte    036h,007h,000h,02Eh,0A3h,007h,000h,0BBh
        byte    04Fh,000h,036h,0FFh,01Eh,007h,000h,02Eh
        byte    08Fh,006h,007h,000h,0C3h,058h,0E9h,03Fh
        byte    0FCh,02Ch,030h,072h,006h,03Ch,009h,077h
        byte    002h,0F8h,0C3h,0F9h,0C3h,033h,0DBh,0E8h
; Offset:  1600  (640h).
        byte    0EFh,0FFh,072h,0E9h,093h,053h,0BBh,00Ah
        byte    000h,0F7h,0E3h,05Bh,002h,0C3h,080h,0D4h
        byte    000h,072h,0DAh,093h,0E8h,0C2h,0FEh,072h
        byte    00Eh,00Ah,0C0h,075h,0E2h,036h,0FFh,006h
        byte    043h,000h,036h,0FFh,00Eh,045h,000h,08Bh
        byte    0C3h,00Bh,0C0h,0C3h,00Eh,007h,08Bh,0F2h
        byte    0BAh,099h,007h,0BBh,0E1h,007h,00Eh,01Fh
        byte    0B4h,009h,0CDh,021h,026h,08Ah,014h,00Ah
; Offset:  1664  (680h).
        byte    0D2h,074h,007h,0B4h,002h,0CDh,021h,046h
        byte    0EBh,0F2h,08Bh,0D3h,0B4h,009h,0CDh,021h
        byte    0C3h,050h,053h,051h,052h,056h,01Eh,053h
        byte    033h,0C0h,0B4h,03Dh,0F9h,0CDh,021h,05Ah
        byte    072h,01Eh,006h,01Fh,08Bh,0D8h,0B9h,000h
        byte    0FFh,0B4h,03Fh,0F9h,0CDh,021h,072h,010h
        byte    08Bh,0F2h,081h,03Ch,04Dh,05Ah,075h,003h
        byte    0F9h,0EBh,005h,0B4h,03Eh,0F9h,0CDh,021h
; Offset:  1728  (6C0h).
        byte    01Fh,05Eh,05Ah,059h,05Bh,058h,0C3h,0E8h
        byte    01Ah,000h,073h,007h,0BAh,0FDh,006h,0E8h
        byte    012h,000h,0C3h,033h,0C0h,0B4h,044h,0CDh
        byte    021h,0F6h,0C2h,080h,075h,0F4h,0B4h,03Eh
        byte    0CDh,021h,0EBh,0E8h,0B4h,03Dh,0F9h,0CDh
        byte    021h,0C3h,083h,0C4h,006h,058h,05Bh,059h
        byte    05Ah,05Eh,05Fh,05Dh,01Fh,007h,050h,0B4h
        byte    019h,0CDh,021h,058h,0CFh,05Ch,044h,045h
; Offset:  1792  (700h).
        byte    056h,05Ch,04Eh,055h,04Ch,000h,05Ch,044h
        byte    045h,056h,05Ch,043h,04Fh,04Eh,000h,05Ch
        byte    044h,045h,056h,05Ch,041h,055h,058h,000h
        byte    05Ch,044h,045h,056h,05Ch,050h,052h,04Eh
        byte    000h,05Ch,043h,04Fh,04Eh,046h,049h,047h
        byte    02Eh,053h,059h,053h,000h,05Ch,043h,04Fh
        byte    04Dh,04Dh,041h,04Eh,044h,02Eh,043h,04Fh
        byte    04Dh,000h,007h,042h,055h,046h,046h,045h
; Offset:  1856  (740h).
        byte    052h,053h,042h,005h,042h,052h,045h,041h
        byte    04Bh,043h,005h,053h,048h,045h,04Ch,04Ch
        byte    053h,006h,044h,045h,056h,049h,043h,045h
        byte    044h,005h,046h,049h,04Ch,045h,053h,046h
        byte    008h,053h,057h,049h,054h,043h,048h,041h
        byte    052h,057h,008h,041h,056h,041h,049h,04Ch
        byte    044h,045h,056h,041h,007h,043h,04Fh,055h
        byte    04Eh,054h,052h,059h,051h,000h,00Dh,00Ah
; Offset:  1920  (780h).
        byte    042h,061h,064h,020h,073h,065h,063h,074h
        byte    06Fh,072h,020h,073h,069h,07Ah,065h,020h
        byte    069h,06Eh,020h,066h,069h,06Ch,065h,020h
        byte    024h,00Dh,00Ah,042h,061h,064h,020h,06Fh
        byte    072h,020h,04Dh,069h,073h,073h,069h,06Eh
        byte    067h,020h,024h,00Dh,00Ah,042h,061h,064h
        byte    020h,043h,06Fh,075h,06Eh,074h,072h,079h
        byte    020h,049h,06Eh,066h,06Fh,072h,06Dh,061h
; Offset:  1984  (7C0h).
        byte    074h,069h,06Fh,06Eh,020h,024h,00Dh,00Ah
        byte    042h,061h,064h,020h,063h,06Fh,06Dh,06Dh
        byte    061h,06Eh,064h,020h,069h,06Eh,020h,043h
        byte    04Fh,04Eh,046h,049h,047h,02Eh,053h,059h
        byte    053h,00Dh,00Ah,024h,043h,06Fh,06Dh,06Dh
        byte    061h,06Eh,064h,020h,049h,06Eh,074h,065h
        byte    072h,070h,072h,065h,074h,065h,072h,000h

; ***** End of file *****

        end

$ 