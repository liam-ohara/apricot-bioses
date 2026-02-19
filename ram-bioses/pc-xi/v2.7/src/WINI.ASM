00H		;set busy
PRN_configA_s1
	jmp	PRN_con_x		;return status
;
	page
;----[?3h$ TYPE wini.asm
; [bios.generic.rom]wini.asm	TITLE	'[bios.generic.rom]wini.asm'
	INCLUDE 'legal.asi'
;***************************************************************************
;
;	FILENAME:	[bios.generic.rom]wini2.asm
;	PROGRAMMER:	G.Kurth
;	STATUS:		Test version
;	MODIFICATIONS:	First Activm Testbios version 31-may-84 GK
;			ROM bios version 7-june-84 GK
;			Support for single drive on new board 4-jul-84
;
;	GENERIC VERSION FOR APRICOT, ACTIVM & CACTUS ROM BIOS'S
;	WITH CONDITIONAL ASSEMBLY FOR EACH.
;	SUPPORTS BOTH OLD AND NEW CONTROLLERS AND UP TO TWO DRIVES.
;	G.K. 30 AUGUST 1984
;	Grotty Winchester board mods 9-nov-84 GK
;	Test version for retry on write 9-nov-84 GK
;	V8 timing. 13/11/84 RJW.
;	Retry on read/write ID not found only 19/11/84 GK
;	Multi-type support - stage 1, 512b/s 2,4,8 head only
;	Stage 2 :- generic for rom/ram bios's	8/1/85 GK
;	Stage 3 :- Use of parking cylinder number 15/1/85 GK
;	Modified for 1 - 8 head drives 26/2/85 IGC
;	Modified for 1 - 16 head drives using rev 10 controller
;		at standard address 27/2/85 IGC
;	Modified to allow MS-DOS sector > 512k 27/2/85 IGC
;	Modified to allow > 2 drives in total 28/2/85 IGC
;	Modified for indirect load of port addresses 1/3/85 IGC
;	Modified INIT code to detect which board is present 4/3/85 IGC
;	Modified parking to park all drives in sequence
;	Modified to use default BPB for a get BPB call 29/4/85 IGC
;	Modified to ignore B_REBOOT flag 29/4/85 IGC
;
;**************************************************************************
;
	INCLUDE	'Genequ.asi'
        INCLUDE 'mserror.asi'
	INCLUDE	'ioregs.asi'
	INCLUDE	'copyregs.asi'
;
;-------------------------------------------------------------------------
;	CONDITIONAL ASSEMBLY FLAGS
;
APRICOT	EQU	TRUE	;APRICOT PC & XI
ACTIVM	EQU	FALSE	;APRICOT PORTABLE
CACTUS	EQU	FALSE	;APRICOT F1
;
	page
;-------------------------------------------------------------------------
; Winchester Board Port addresses
;
;**WIP_errf        equ     0E2h    ;WD1010 error flags (R/O)
;**WIP_wpre        equ     0E2h    ;WD1010 write precomp cylinder (W/O)
;**WIP_seccnt      equ     0E4h    ;WD1010 sector count (R/W)
;**WIP_secnum      equ     0E6h    ;WD1010 sector number (R/W)
;**WIP_cyllo       equ     0E8h    ;WD1010 cylinder number low (R/W)
;**WIP_cylhi       equ     0EAh    ;WD1010 cylinder number high (R/W)
;**WIP_sdh         equ     0ECh    ;WD1010 sector size/drive/head byte (R/W)
;**WIP_stat        equ     0EEh    ;WD1010 status register (R/O)
;**WIP_cmd         equ     0EEh    ;WD1010 command register (R/W)
;**WIP_l_hds0      equ     1E0h    ;latch head select bit 0 (W/O)
;**WIP_l_hds1      equ     1E2h    ;latch head select bit 1 (W/O)
;**WIP_l_hds2      equ     1E4h    ;latch head select bit 2 (W/O)
;**WIP_l_ds1       equ     1E6h    ;latch Drive select 1 (W/O)
;**WIP_l_dtrn      equ     1E8h    ;latch data transferred bit (W/O)
;**WIP_l_prst      equ     1EAh    ;latch byte & sector pointer reset (W/O)
;**WIP_l_bmst      equ     1ECh    ;latch buffer master (W/O)
;**WIP_l_ds2       equ     1EEh    ;latch Drive select 2 (W/O)
;**WIP_ram         equ     1F0h    ;buffer RAM (R/W)
;
;               WD1010 status register bit definitions
WIS_busy        equ     10000000b       ;busy bit
WIS_ready       equ     01000000b       ;ready bit
WIS_writef      equ     00100000b       ;write fault
WIS_seekc       equ     00010000b       ;seek complete
WIS_drq         equ     00001000b       ;data request
WIS_cip         equ     00000010b       ;command in progress
WIS_err         equ     00000001b       ;error flag
;
;               WD1010 error flag bit definitions
WIER_bad_blk    equ     10000000b       ;bad block
WIER_crc_datf   equ     01000000b       ;CRC data field
WIER_id_notf    equ     00010000b       ;ID not found
WIER_abortc     equ     00000100b       ;aborted command
WIER_trk0_er    equ     00000010b       ;track 0000 error
WIER_dam_nf     equ     00000001b       ;data address mark not found
;
;               WD1010 commands
WICM_restore    equ     00010000b       ;restore (rate = 35uS)
WICM_seek       equ     01110000b       ;seek (rate = 35uS)
WICM_reads      equ     00101000b       ;read sector (single, int at EOC)
WICM_writes     equ     00110000b       ;write sector (single)
WICM_readm      equ     00101100b       ;read sector (multiple, int at EOC)
WICM_writem     equ     00110100b       ;write sector (multiple)

WICM_scan_id    equ     01000000b       ;scan ID
WICM_writef     equ     01010000b       ;write format

WICM_notry	equ	00000001b	;retry disable bit

;---------------------------------------------------------------------------
; Equates
;
;
BPB_offset      equ     050h            ;offset of BPB in header
DTAB_offset	equ	00Ch		;offset of drive table in header
WIf_offset      equ     00Dh            ;offset of winchester flag in header
;
	PAGE
;
;---------------------------------------------------------------------------
;
        Global CodebaseQQ, DatabaseQQ
;
        Assume CS:CodebaseQQ, DS:DatabaseQQ, SS:DatabaseQQ, ES:DatabaseQQ
;
;	GLOBAL DECLARATIONS
;	-------------------
;---------------------------------------------------------------------------
;
;	INTERNAL ROUTINES
        Global	WINI_Int		;Interrupt handler
	Global	WINI_Init		;Initialisation code
	Global	WINI_config		;Control Device Handler
        Global  WI_park_hd1		;head park for drive 1
	GLOBAL	WI_PARK_HD2		;head park for drive 2

;	EXTERNAL ROUTINES
        Global  SH_wake_me_up		;sheduler
        Global	WINIT_table		;INIT BPB POINTER TABLE

;	INTERNAL & EXTERNAL DATA
        Global	PRN_queue		;SCRATCH SPACE FOR INIT HEADER SECTORS
	Global	CNF_diagflag		;retry disable flag
	Global	CNF_wini_park		;park disable flag
	GLOBAL	WINI_BPB1, WINI_BPB2	;BPB'S FOR BOTH DRIVES
	GLOBAL	WID_TYPE1, WID_TYPE2	;TYPE FLAGS FOR BOTH DRIVES
	GLOBAL	WID_MAXSEC1,WID_MAXSEC2	;NUMBER OF SECTORS
	GLOBAL	WID_SECSIZ1,WID_SECSIZ2	;SIZE OF SECTORS
	GLOBAL	WID_TRKSID1,WID_TRKSID2	;TRACKS/SIDE
	GLOBAL	WID_CHANGED1,WID_CHANGED2	;CHANGED FLAGS
	Global	B_WIN_NUM, B_WIN_TYP	;BOOT TIME TYPE & NUMBER FLAGS
	Global	B_WIN0_NUM, B_WIN1_NUM	;**
;** NOTE This is total number of winchesters on both cards
	Global	WID_BOARD		;WINCHESTER BOARD TYPE (0=SINGLE, 1=DUAL)
	GLOBAL	WID_WPRE		;WRITE PRECOMP CYL

;--------------------------------------------------------------------------
	IF	APRICOT = TRUE		;APRICOT 8089 EXTERNALS
;--------------------------------------------------------------------------
	Global	WI_RW_PB, WI_RD_TB, WI_WRT_TB
	Global	WI_RW_OFFSET, WI_RW_SEGMENT, WI_RW_BYTE_COUNT
	Global	DRW_WAIT_89
	Global	WI_RW_PORT		;**
;--------------------------------------------------------------------------
	ENDIF
;--------------------------------------------------------------------------

	PAGE
;
        SECTION Wini.const, Align(1), CLASS=ConstQQ
;
;
winit_table		Word    WINI_BPB1-DatabaseQQ
			WORD	WINI_BPB2-DATABASEQQ
			word	wini_BPB3-databaseQQ
			word	wini_BPB4-databaseQQ
;
;
; Default BPB for Rodime 352 10 meg wini
;
WI_default_BPB          Word    512             ;sector size
                        byte    8               ;cluster size
                        Word    16              ;reserved sectors
                        byte    2               ;number of FAT's
                        Word    512             ;directory entries
                        Word    (306*4*16)      ;number of sectors
                        byte    0FBh            ;media ID - non-used
                        Word    8               ;sectors per FAT
                        byte    4               ;disk type
                        Word    0               ;logical offset
WI_default_DTAB		Byte	0		;not multi regioned
			Byte	1		;media type = wini
			Word	306		;parking cylinder
			Word	16		;sectors per track
			Word	306		;tracks per side (cyls)
			Word	0		;precomp cyl (none)
			Byte	4		;Number of heads
			Byte	0		;interleave factor
			Word	0		;Skew factor
;
;-------------------------------------------------------------------------
; Winchester Board 0 Port addresses
;
WIP_board0			;**
WIP0_errf        WORD     0E2h    ;** WD1010 error flags (R/O)
WIP0_wpre        WORD     0E2h    ;** WD1010 write precomp cylinder (W/O)
WIP0_seccnt      WORD     0E4h    ;** WD1010 sector count (R/W)
WIP0_secnum      WORD     0E6h    ;** WD1010 sector number (R/W)
WIP0_cyllo       WORD     0E8h    ;** WD1010 cylinder number low (R/W)
WIP0_cylhi       WORD     0EAh    ;** WD1010 cylinder number high (R/W)
WIP0_sdh         WORD     0ECh    ;** WD1010 sector size/drive/head byte (R/W)
WIP0_stat        WORD     0EEh    ;** WD1010 status register (R/O)
WIP0_cmd         WORD     0EEh    ;** WD1010 command register (R/W)
WIP0_l_hds0      WORD     1E0h    ;** latch head select bit 0 (W/O)
WIP0_l_hds1      WORD     1E2h    ;** latch head select bit 1 (W/O)
WIP0_l_hds2      WORD     1E4h    ;** latch head select bit 2 (W/O)
WIP0_l_ds1       WORD     1E6h    ;** latch Drive select 1 (W/O)
WIP0_l_dtrn      WORD     1E8h    ;** latch data transferred bit (W/O)
WIP0_l_prst      WORD     1EAh    ;** latch byte & sector pointer reset (W/O)
WIP0_l_bmst      WORD     1ECh    ;** latch buffer master (W/O)
WIP0_l_ds2       WORD     1EEh    ;** latch Drive select 2 (W/O)
WIP0_ram         WORD     1F0h    ;** buffer RAM (R/W)

;-------------------------------------------------------------------------
; Winchester Board 1 Port addresses
;
WIP_board1
WIP1_errf        WORD     0D2h    ;** WD1010 error flags (R/O)
WIP1_wpre        WORD     0D2h    ;** WD1010 write precomp cylinder (W/O)
WIP1_seccnt      WORD     0D4h    ;** WD1010 sector count (R/W)
WIP1_secnum      WORD     0D6h    ;** WD1010 sector number (R/W)
WIP1_cyllo       WORD     0D8h    ;** WD1010 cylinder number low (R/W)
WIP1_cylhi       WORD     0DAh    ;** WD1010 cylinder number high (R/W)
WIP1_sdh         WORD     0DCh    ;** WD1010 sector size/drive/head byte (R/W)
WIP1_stat        WORD     0DEh    ;** WD1010 status register (R/O)
WIP1_cmd         WORD     0DEh    ;** WD1010 command register (R/W)
WIP1_l_hds0      WORD     160h    ;** latch head select bit 0 (W/O)
WIP1_l_hds1      WORD     162h    ;** latch head select bit 1 (W/O)
WIP1_l_hds2      WORD     164h    ;** latch head select bit 2 (W/O)
WIP1_l_ds1       WORD     166h    ;** latch Drive select 1 (W/O)
WIP1_l_dtrn      WORD     168h    ;** latch data transferred bit (W/O)
WIP1_l_prst      WORD     16Ah    ;** latch byte & sector pointer reset (W/O)
WIP1_l_bmst      WORD     16Ch    ;** latch buffer master (W/O)
WIP1_l_ds2       WORD     16Eh    ;** latch Drive select 2 (W/O)
WIP1_ram         WORD     170h    ;** buffer RAM (R/W)

;---------------------------------------------------------------------------
;
        SECTION winiio.data, Align(2), CLASS=DataQQ
;
; Winchester drive structures
;	Drive 1
WINI_BPB1	;From offset 50h in label sector
WID_SECSIZ1		BLOCK	2	;00h	;sector size
WID_CLUSIZ1             BLOCK	1	;02h	;cluster size
WID_RSVDSC1             BLOCK	2	;03h	;reserved sectors
WID_NFAT1		BLOCK	1	;05h	;number of FAT's
WID_NDIR1		BLOCK	2	;06h	;directory entries
WID_MAXSEC1             BLOCK	2	;08h	;number of sectors
WID_MID1		BLOCK	1	;0Ah	;media ID - non-used
WID_FATSEC1		BLOCK	2	;0Bh	;sectors per FAT
WID_TYPE1               BLOCK	1	;0Dh	;disk type
WID_LOGOF1		BLOCK	2	;0Eh	;logical offset
WINI_DTAB1	;From offset 0Ch in label sector
WID_REGN1		BLOCK	1	;10h	;regions on disk
WID_MTYPE1		BLOCK	1	;11h	;media type
WID_PRKCYL1		BLOCK	2	;12h	;parking cylinder
WID_SECTRK1		BLOCK	2	;14h	;sectors per track
WID_TRKSID1		BLOCK	2	;16h	;Tracks per side
WID_WRPRE1		BLOCK	2	;18h	;Write precomp cylinder
WID_HEADS1		BLOCK	1	;1Ah	;number of heads
WID_ILVE1		BLOCK	1	;1Bh	;interleave factor
WID_SKEW1		BLOCK	2	;1Ch	;skew factor
;internals
;*	WIDhd_mask1		BLOCK	2	;1Eh	;head mask for logical translate
;*	WIDhd_shift1    	BLOCK	1	;20h	;head shift for logical translate
;**WID_CHANGED1    	BLOCK	1	;21h	;changed flag (boolean)
;**WID_PARK1		BLOCK	1	;22h	;parking active
WID_CHANGED1		BLOCK	1	;1Eh	;**changed flag (boolean)
WID_PARK1		BLOCK	1	;1Fh	;**parking active
						; 0  Idle
						; 1  Parking
						; -1 Parked
;	Drive 2
WINI_BPB2	;From offset 50h in label sector
WID_SECSIZ2		BLOCK	2	;00h	;sector size
WID_CLUSIZ2             BLOCK	1	;02h	;cluster size
WID_RSVDSC2             BLOCK	2	;03h	;reserved sectors
WID_NFAT2		BLOCK	1	;05h	;number of FAT's
WID_NDIR2		BLOCK	2	;06h	;directory entries
WID_MAXSEC2             BLOCK	2	;08h	;number of sectors
WID_MID2		BLOCK	1	;0Ah	;media ID - non-used
WID_FATSEC2		BLOCK	2	;0Bh	;sectors per FAT
WID_TYPE2               BLOCK	1	;0Dh	;disk type
WID_LOGOF2		BLOCK	2	;0Eh	;logical offset
WINI_DTAB2	;From offset 0Ch in label sector
WID_REGN2		BLOCK	1	;10h	;regions on disk
WID_MTYPE2		BLOCK	1	;11h	;media type
WID_PRKCYL2		BLOCK	2	;12h	;parking cylinder
WID_SECTRK2		BLOCK	2	;14h	;sectors per track
WID_TRKSID2		BLOCK	2	;16h	;Tracks per side
WID_WRPRE2		BLOCK	2	;18h	;Write precomp cylinder
WID_HEADS2		BLOCK	1	;1Ah	;number of heads
WID_ILVE2		BLOCK	1	;1Bh	;interleave factor
WID_SKEW2		BLOCK	2	;1Ch	;skew factor
;internals
;*	WIDhd_mask2		BLOCK	2	;1Eh	;head mask for logical translate
;*	WIDhd_shift2    	BLOCK	1	;20h	;head shift for logical translate
;**WID_CHANGED2    	BLOCK	1	;21h	;changed flag (boolean)
;**WID_PARK2		BLOCK	1	;22h	;parking active
WID_CHANGED2		BLOCK	1	;1Eh	;**changed flag (boolean)
WID_PARK2		BLOCK	1	;1Fh	;**parking active
;	Drive 3
WINI_BPB3	;From offset 50h in label sector
WID_SECSIZ3		BLOCK	2	;00h	;sector size
WID_CLUSIZ3             BLOCK	1	;02h	;cluster size
WID_RSVDSC3             BLOCK	2	;03h	;reserved sectors
WID_NFAT3		BLOCK	1	;05h	;number of FAT's
WID_NDIR3		BLOCK	2	;06h	;directory entries
WID_MAXSEC3             BLOCK	2	;08h	;number of sectors
WID_MID3		BLOCK	1	;0Ah	;media ID - non-used
WID_FATSEC3		BLOCK	2	;0Bh	;sectors per FAT
WID_TYPE3               BLOCK	1	;0Dh	;disk type
WID_LOGOF3		BLOCK	2	;0Eh	;logical offset
WINI_DTAB3	;From offset 0Ch in label sector
WID_REGN3		BLOCK	1	;10h	;regions on disk
WID_MTYPE3		BLOCK	1	;11h	;media type
WID_PRKCYL3		BLOCK	2	;12h	;parking cylinder
WID_SECTRK3		BLOCK	2	;14h	;sectors per track
WID_TRKSID3		BLOCK	2	;16h	;Tracks per side
WID_WRPRE3		BLOCK	2	;18h	;Write precomp cylinder
WID_HEADS3		BLOCK	1	;1Ah	;number of heads
WID_ILVE3		BLOCK	1	;1Bh	;interleave factor
WID_SKEW3		BLOCK	2	;1Ch	;skew factor
;internals
;*	WIDhd_mask3		BLOCK	2	;1Eh	;head mask for logical translate
;*	WIDhd_shift3    	BLOCK	1	;20h	;head shift for logical translate
;**WID_CHANGED3    	BLOCK	1	;21h	;changed flag (boolean)
;**WID_PARK3		BLOCK	1	;22h	;parking active
WID_CHANGED3		BLOCK	1	;1Eh	;**changed flag (boolean)
WID_PARK3		BLOCK	1	;1Fh	;**parking active
;	Drive 4
WINI_BPB4	;From offset 50h in label sector
WID_SECSIZ4		BLOCK	2	;00h	;sector size
WID_CLUSIZ4             BLOCK	1	;02h	;cluster size
WID_RSVDSC4             BLOCK	2	;03h	;reserved sectors
WID_NFAT4		BLOCK	1	;05h	;number of FAT's
WID_NDIR4		BLOCK	2	;06h	;directory entries
WID_MAXSEC4             BLOCK	2	;08h	;number of sectors
WID_MID4		BLOCK	1	;0Ah	;media ID - non-used
WID_FATSEC4		BLOCK	2	;0Bh	;sectors per FAT
WID_TYPE4               BLOCK	1	;0Dh	;disk type
WID_LOGOF4		BLOCK	2	;0Eh	;logical offset
WINI_DTAB4	;From offset 0Ch in label sector
WID_REGN4		BLOCK	1	;10h	;regions on disk
WID_MTYPE4		BLOCK	1	;11h	;media type
WID_PRKCYL4		BLOCK	2	;12h	;parking cylinder
WID_SECTRK4		BLOCK	2	;14h	;sectors per track
WID_TRKSID4		BLOCK	2	;16h	;Tracks per side
WID_WRPRE4		BLOCK	2	;18h	;Write precomp cylinder
WID_HEADS4		BLOCK	1	;1Ah	;number of heads
WID_ILVE4		BLOCK	1	;1Bh	;interleave factor
WID_SKEW4		BLOCK	2	;1Ch	;skew factor
;internals
;*	WIDhd_mask4		BLOCK	2	;1Eh	;head mask for logical translate
;*	WIDhd_shift4    	BLOCK	1	;20h	;head shift for logical translate
;**WID_CHANGED4    	BLOCK	1	;21h	;changed flag (boolean)
;**WID_PARK4		BLOCK	1	;22h	;parking active
WID_CHANGED4		BLOCK	1	;1Eh	;**changed flag (boolean)
WID_PARK4		BLOCK	1	;1Fh	;**parking active
;
;
;-------------------------------------------------------------------------
; Active Winchester Board Port addresses
;
WIP_active			;**
WIP_errf        BLOCK	2	;** WD1010 error flags (R/O)
WIP_wpre        BLOCK	2	;** WD1010 write precomp cylinder (W/O)
WIP_seccnt      BLOCK	2	;** WD1010 sector count (R/W)
WIP_secnum      BLOCK	2	;** WD1010 sector number (R/W)
WIP_cyllo       BLOCK	2	;** WD1010 cylinder number low (R/W)
WIP_cylhi       BLOCK	2	;** WD1010 cylinder number high (R/W)
WIP_sdh         BLOCK	2	;** WD1010 sector size/drive/head byte (R/W)
WIP_stat        BLOCK	2	;** WD1010 status register (R/O)
WIP_cmd         BLOCK	2	;** WD1010 command register (R/W)
WIP_l_hds0      BLOCK	2	;** latch head select bit 0 (W/O)
WIP_l_hds1      BLOCK	2	;** latch head select bit 1 (W/O)
WIP_l_hds2      BLOCK	2	;** latch head select bit 2 (W/O)
WIP_l_ds1       BLOCK	2	;** latch Drive select 1 (W/O)
WIP_l_dtrn      BLOCK	2	;** latch data transferred bit (W/O)
WIP_l_prst      BLOCK	2	;** latch byte & sector pointer reset (W/O)
WIP_l_bmst      BLOCK	2	;** latch buffer master (W/O)
WIP_l_ds2       BLOCK	2	;** latch Drive select 2 (W/O)
WIP_ram         BLOCK	2	;** buffer RAM (R/W)
;
;
; Logical units on drive
;
WID_lunits      BLOCK 2         ;logical units supported
;
; WD1010 Interrupt routine status return
;
WID_Int_Stat    BLOCK 2
;
; function request data store
;
WID_unit        BLOCK 2         ;unit number
WID_command     BLOCK 2         ;command
WID_st_sec      BLOCK 2         ;start sector
WID_sec_cnt     BLOCK 2         ;sector count
WID_mem_off     BLOCK 2         ;memory offset
WID_mem_seg     BLOCK 2         ;memory segment
WID_error	BLOCK 2		;error store

WID_drive	BLOCK 2		;** Unit is converted to drive

WID_pl_st_sec	BLOCK 2		;* physical start sector (low)
WID_ph_st_sec	BLOCK 2		;* physical start sector (high)
WID_p_sec_cnt	BLOCK 2		;* physical sector count
;
;* WID_SELECTED	BLOCK	2	;CURRENTLY SELECTED DRIVE
;
;
; WD1010 Task File data
;
WID_wpre        BLOCK 1         ;write precomp cylinder
WID_seccnt      BLOCK 1         ;sector count
WID_secnum      BLOCK 1         ;sector number
WID_cyllo       BLOCK 1         ;cylinder number (low) - these treated as
WID_cylhi       BLOCK 1         ;cylinder number (high)  a WORD by software
WID_sdh         BLOCK 1         ;size/drive/head byte
WID_cmd         BLOCK 1         ;command
WID_head        BLOCK 1         ;head for latch
;
;
WID_timeout     BLOCK 2         ;Winchester timeout count
WID_buffsize    BLOCK 2         ;buffer size (in sectors)
WID_active      BLOCK 1         ;winchester active flag (for timeout)
;
WID_try		BLOCK 1		;retry count for write
;
WID0_buffsize	BLOCK	2	;** Winchester board 0 buffer size
WID1_buffsize	BLOCK	2	;** Winchester board 1 buffer size

        PAGE
;---------------------------------------------------------------------------
;
        SECTION winiio.code, Align(1), CLASS=InstrQQ
;
;****************************************************************************
;
;
; WINI_int - interrupt handler (winchester controller)
;
; Reads status out of WD1010 to clear interrupt, and places it in
; WID_Int_Stat for polling routine.
; Sends non-specific EOI to interrupt controller or 'RETI' to CTC.
;
;
WINI_int
        push    ax                      ;save working registers
	push	dx
        push    ds
        movw    ax,#bits(DatabaseQQ,4,16)
        movw    ds,ax                   ;set up DS for variables
        xorw    ax,ax                   ;clear AH

;NEW BIT FOR BOARDS WITH INTERRUPT STATUS BIT

	CMP	WID1_buffsize,#0	;Board 1 present
	JE	WINI_INT2

	MOV	DX,WIP1_L_HDS0		;POINT AT STATUS LATCH (board 1)
	IN	AL,DX
	TEST	AL,#1			;WAS IT THE WINI?
	JZ	WINI_INT2		;NOPE

	mov	dx,WIP1_stat		;get WD1010 status (board 1)
	in	al,dx
        movw    WID_Int_Stat,ax         ;put in polling area
WINI_INT2

	CMP	WID0_buffsize,#0	;Board 0 present
	JE	WINI_INT1

	CMPB	WID_BOARD,#1		;DUAL CONTROLLER BOARD?
	JNE	WINI_INT0		;NO - SKIP

	MOV	DX,WIP0_L_HDS0		;POINT AT STATUS LATCH
	IN	AL,DX
	TEST	AL,#1			;WAS IT THE WINI?
	JZ	WINI_INT1		;NOPE
WINI_INT0
	mov	dx,WIP0_stat		;get WD1010 status (board 0)
	in	al,dx
        movw    WID_Int_Stat,ax         ;put in polling area
WINI_INT1
;---------------------------------------------------------------------------
	IF	CACTUS = TRUE		;CACTUS SPECIFIC
;---------------------------------------------------------------------------
	mov	ax,#4DEDh		;send RETI to CTC
	out	#Z80_RETI,al		;first 'ED'
	xchg	al,ah
	out	#Z80_RETI,al		;then '4D'
;---------------------------------------------------------------------------
	ELSE				;APRICOT OR ACTIVM
;---------------------------------------------------------------------------
        movb    al,#20h                 ;non-specific EOI
        out     #PIC_IW0,al             ;to PIC
;---------------------------------------------------------------------------
	ENDIF
;---------------------------------------------------------------------------
        pop     ds
	pop	dx
        pop     ax
        iret
;
        PAGE
;****************************************************************************
;
;	WINI_config	-	Main IO handler for the winchester system
;			Called from INT 0FCh with data in registers:
;			AX = 0FFFFh (preloaded fail)
;			CX = command
;			DX = data
;			or DX:SI is pointer to table.
;			Returns status in AX.
;
;
WINI_config
		mov	bx,cx			;zap command into bx
		cmp	bx,#0005h		;valid?
		ja	WINI_con_x		;no - abort
		cmpb	B_WIN_NUM,#1		;do we have a winchester?
		jb	WINI_con_x		;no - abort
		shl	bx,#1			;create word offset
		jmp	[cs:WINI_CTAB][bx]	;and go to handler
;
WINI_con_ok	xor	ax,ax			;return ok status
;
WINI_con_x	ret				;return status in ax
;
WINI_CTAB	WORD	WINI_con_ok-CodebaseQQ	;0 - init
		WORD	WINI_c_swap-CodebaseQQ	;1 - set disk to swapped
		WORD	WINI_c_type-CodebaseQQ	;2 - return disk type
		WORD	WINI_c_qswp-CodebaseQQ	;3 - Check swap status
		WORD	WINI_c_gbpb-CodebaseQQ	;4 - Get BPB
		WORD	WINI_c_rwv-CodebaseQQ	;5 - Read/Write/Verify disk
;
;****************************************************************************
;
WINI_con_bu	;Return bad unit status

		mov	ax,#MSE_bad_unit
		jmpsh	WINI_con_x

;****************************************************************************
;
WINI_c_swap	;Set disk status to swapped

		CMP	DL,B_WIN_NUM		;VALID DRIVE (0 OR 1)
		JAE	WINI_CON_BU		;ABORT WITH ERROR
;**		CMP	DL,#01H			;SECOND DRIVE?
;**		JNE	WINI_C_SW1		;NO - SWAP FIRST
;**		MOVB	WID_CHANGED2,#1		;SECOND DRIVE SWAPPED
;**		JMPSH	WINI_CON_OK
;**WINI_C_SW1
;**		MOVB	WID_CHANGED1,#1		;FIRST DRIVE SWAPPED
		MOVB	BL,DL			;**
		XORB	BH,BH			;**
		SHLW	BX,#1			;**
		MOVW	BX,WINIT_TABLE[BX]	;**
		MOVB	01EH[BX],#1		;**
		jmpsh	WINI_con_ok		;and return with OK status

;****************************************************************************
;
WINI_c_type	;Check Winchester disk type

		CMP	DL,B_WIN_NUM		;VALID DRIVE (0 OR 1)
		JAE	WINI_CON_BU
;**		MOVB	AL,WID_TYPE1		;GET TYPE FOR FIRST
;**		CMP	DL,#0			;IS IT?
;**		JE	WINI_C_TYPE1		;AND SKIP IF FIRST
;**		MOVB	AL,WID_TYPE2		;GET TYPE FOR SECOND DRIVE
;**WINI_C_TYPE1
		MOVB	BL,DL			;**
		XORB	BH,BH			;**
		SHLW	BX,#1			;**
		MOVW	BX,WINIT_TABLE[BX]	;**
		MOVB	AL,0DH[BX]		;**
		cbw
		jmpsh	WINI_con_x		;and return type
;
;****************************************************************************
;
WINI_c_qswp	;Check for winchester swapped

		CMP	DL,B_WIN_NUM		;VALID DRIVE (0 OR 1)
		JAE	WINI_CON_BU		;ABORT IF INVALID
		XOR	AX,AX
;**		CMP	DL,#0			;IS IT THE FIRST?
;**		JE	WINI_C_QS1		;YES - SKIP
;**		XCHG	AL,WID_CHANGED2		;GET/RESET FLAG FOR SECOND
;**		JMPSH	WINI_C_QS2
;**WINI_C_QS1
;**		XCHG	AL,WID_CHANGED1		;GET/RESET FLAG FOR FIRST
;**WINI_C_QS2
		MOVB	BL,DL			;**
		XORB	BH,BH			;**
		SHLW	BX,#1			;**
		MOVW	BX,WINIT_TABLE[BX]	;**
		XCHG	AL,1EH[BX]		;**

		cbw
		jmpsh	WINI_con_x		;and return it

;****************************************************************************
;
WINI_c_gbpb	;Get BPB
;		enters with DX:SI -> table
;			WORD	drive number
;			DWORD	pointer to 512 byte scratch space

		push	es			;save current es
		mov	es,dx			;and point at table
		mov	ax,es:2[si]		;get buffer offset
		mov	WID_mem_off,ax		;and put in table
		mov	ax,es:4[si]		;get buffer segment
		mov	WID_mem_seg,ax		;and put in table
;**		MOV	ES:2[SI],#(WINI_BPB1-DATABASEQQ)	;GET FIRST
		mov	es:4[si],ds		;set up BPB address for return	
		MOV	AX,ES:[SI]		;GET DRIVE

		PUSH	BX			;** Index into BPB table
		MOV	BX,AX			;**
		SHL	BX,#1			;**
		MOV	BX,WINIT_TABLE[BX]	;** Get BPB pointer
		MOV	ES:2[SI],BX		;** Set BPB addr for return
		POP	BX			;**

;**		CMP	AL,#01H			;SECOND DRIVE (1)
;**		JNE	WINI_C_G1		;SKIP IF NOT SECOND DRIVE
;**		MOV	ES:2[SI],#(WINI_BPB2-DATABASEQQ)	;GET SECOND
WINI_C_G1
		pop	es			;restore es
		CMP	AL,B_WIN_NUM		;VALID DRIVE?
		JAE	WINI_CON_BU		;NOT VALID - ABORT
		MOV	WID_UNIT,AX		;SET DRIVE SELECT

		CALL	WI_BPB_default		;default BPB
		CALL	WI_init_drvr

		xor	ax,ax
		mov	WID_command,ax		;set up command 0 - read
		mov	WID_st_sec,ax		;sector 0 (header)
		inc	ax
		mov	WID_sec_cnt,ax		;and 1 sector
		call	WINI_IO			;and read it in
		cmpw	WID_error,#0		;all well?
		je	WINI_c_g2		;yes - load BPB
		call	WI_BPB_default		;no - load default
		jmpsh	WINI_c_g3		;and finish off
WINI_c_g2	call	WI_get_BPB		;move in loaded bpb
WINI_c_g3	call	WI_init_drvr		;set up variables from BPB
		mov	ax,WID_error		;get error back
		jmp	WINI_con_x		;and return it
;
;****************************************************************************
;
WINI_c_rwv	;read/write/verify sectors
;		Enter with DX:SI -> table
;		WORD	drive
;		WORD	command
;		WORD	Start sector
;		WORD	Number of sectors
;		DWORD	Transfer address
;	Commands are: 0 - read, 1 - write, 2 - verify, 3 - write with verify
;
		cld				;set up for copy
		push	dx			;save segment for later
		push	si			;save offset for later
		lea	di,WID_unit		;point at internal table
		push	ds
		mov	ds,dx			;point at source with ds:si
		mov	cx,#6			;6 words to move
		rep	movw			;movem!
		pop	ds
		movw	WID_error,#MSE_bad_unit	;set up bad unit
		MOVW	AX,WID_UNIT		;CHECK UNIT NUMBER
		CMPB	AL,B_WIN_NUM		;VALID DRIVE (0 OR 1)
		JAE	WINI_C_RWVX		;NO - ABORT WITH BAD UNIT
		movw	WID_error,#MSE_bad_cmd	;set up bad command
		cmpw	WID_command,#3		;valid command (0-3)
		ja	WINI_c_rwvx		;abort
		call	WINI_IO			;do the transfer
WINI_c_rwvx
		pop	di			;get back offset
		pop	dx			;and segment
		cmpw	WID_error,#0		;no errors?
		je	WINI_c_rwvy		;no - skip
		push	es
		mov	es,dx			;seg in es
		movw	es:6[di],#0		;say no sectors transferred
		pop	es
WINI_c_rwvy
		mov	ax,WID_error		;get error status	
		jmp	WINI_con_x		;and return the status

;
;
;****************************************************************************
;
; Wini_IO - main entry point for winchester read/write from control device
;		Called with the following set up:
;		WID_UNIT	0 = FIRST DRIVE
;				1 = SECOND DRIVE
;		WID_command	0 = read
;				1 = write
;				2 = verify
;				3 = write with verify
;		WID_st_sec	starting logical sector
;		WID_sec_cnt	number of sectors
;		WID_mem_off	transfer address offset
;		WID_mem_seg	transfer address segment
;
;		Returns status in WID_error
;
;
Wini_IO
        movb    WID_active,#1           ;say wini active
        call    WI_validate             ;validate request
        cmpw    ax,#MSE_OK              ;OK?
        jne     Wini_IO_exit            ;no - abort
	CALL	SEL_BOARD		;** Convert unit to board and drive

	CALL	WINI_SELECT		;SELECT THE DRIVE
	cmpw	ax,#MSE_OK
	jne	Wini_IO_exit
        call    Wini_IO_loop            ;yes - go into loop
Wini_IO_exit
        movw	WID_error,ax            ;save error
;**	CMPB	WID_SELECTED,#1		;WAS IT DRIVE 2?
;**	JNE	WINI_IO_EX1		;NO - DRIVE 1
;**	MOVB	WID_PARK2,#0		;RESET PARKING ACTIVE FLAG
;**	MOVW	AX,#WIN2_SLEEPER	;LOAD UP DRIVE 2 ID
;**	JMPSH	WINI_IO_EXX
;**WINI_IO_EX1
;**	MOVB	WID_PARK1,#0		;RESET PARKING ACTIVE FLAG
;**	MOVW	AX,#WIN1_SLEEPER	;LOAD UP DRIVE 1 ID
;**WINI_IO_EXX

;**	MOVB	WID_PARK1,#0		;** RESET PARKING ACTIVE FLAG

	MOV	BX,WID_UNIT		;** RESET PARKING ACTIVE FLAG
	SHL	BX,#1			;**
	MOV	BX,winit_table[BX]	;**
	MOVB	1FH [BX],#0		;**

	movw	ax,#win1_sleeper	;**Park all drives in 5 seconds
        push    ax
        mov     ax,#250                 ;250 * 20ms = 5 seconds
        push    ax
        call    SH_wake_me_up           ;set off sheduler for 2 minute timeout
        movb    WID_active,#0           ;set wini inactive
        ret
;
;-----------------------------------------------------------------------
;
;       main read/write loop
;
Wini_IO_loop
;*	movw    ax,WID_st_sec           ;get sector
	MOVW	AX,WID_pl_st_sec	;* get physical sector
	MOVW	DX,WID_ph_st_sec	;*
        call    WI_translate            ;translate to physical
        movb    WID_secnum,al           ;set up sector number
        movw    WID_cyllo,cx            ;and cylinder number
	andb    WID_sdh,#0F8h           ;mask out old WD head bits
;*	orb     WID_sdh,bl              ;add in new head bits
        movb    WID_head,bl             ;set up head for latch
	AND	BL,#7			;* mask to heads 0 - 7
	ORB	WID_sdh,BL		;* add in new head bits
        movw    bx,#16                  ;find sectors to end of track
        sub     bx,ax                   ;subtract sector number
        cmp     bx,WID_buffsize         ;check against our buffer size
        jbe     Wini_IO_ch1             ;OK - skip
        mov     bx,WID_buffsize         ;chop down to multiple transfer capability
Wini_IO_ch1
;*	cmp     bx,WID_sec_cnt          ;more than requested?
	CMP	BX,WID_p_sec_cnt	;* more than requested ?
        jbe     Wini_IO_ch2             ;no - do all
;*	movw    bx,WID_sec_cnt          ;only do requested
	MOVW	BX,WID_p_sec_cnt	;* only do requested
Wini_IO_ch2
        movb    WID_seccnt,bl           ;set up sector count for multi-sec
	testb	WID_command,#1		;read or verify command? (bit 0 = 0)
;**	jz	WI_readsec		;yes - do read/verify
	jnz	Wini_IO_ch20		;** yes - do read/verify
	jmp	WI_readsec		;**
Wini_IO_ch20				;**
	
;  Write multipe sectors within one track
;
	movb	WID_try,#3
WI_wrt_try
        xorw    ax,ax                   ;
;**	movw    dx,#WIP_l_dtrn          ;set up 'transferred' address
	movw	dx,WIP_l_dtrn		;** set up 'transferred' address
        out     dx,al                   ;set 'transferred' to 0
        call    WI_set_mas              ;set master to user & pulse pinters
        movb    WID_cmd,#WICM_writem    ;set up write command
	cmpb	CNF_diagflag,#1		;retry disabled?
	jne	WI_wrt_rt		;no - skip
	movb	WID_try,#1		;disable soft retry
	orb	WID_cmd,#WICM_notry	;set retry disabled bit
WI_wrt_rt
        call    WI_WD1010_go            ;set off the WD1010
        jnz     WI_wrt_x                ;nz = timeout error
        xorw    cx,cx                   ;set up count of bytes
        movb    ch,WID_seccnt           ;= sector count * 512
        shlw    cx,#1
        movw    si,WID_mem_off          ;offset in si
;**	movw    dx,#WIP_ram             ;buffer RAM port
	movw	dx,WIP_ram		;** buffer RAM port
;--------------------------------------------------------------------------
	IF	APRICOT = TRUE		;APRICOT SPECIFIC - 80
;--------------------------------------------------------------------------
	movw	WI_rw_offset,SI				;set up offset
	movw	WI_rw_PB,#(WI_wrt_TB-DataBaseQQ)	;set up write
	call	WI_rw_8089				;do the transfer
;--------------------------------------------------------------------------
	ELSE				;ACTIVM OR CACTUS - NO 8089
;--------------------------------------------------------------------------
        cld
        push    ds
        movw    ds,WID_mem_seg          ;segment in DS
WI_wrt_lp
        lodb                            ;get data from ds:si
        out     dx,al                   ;send to buffer RAM
        loop    WI_wrt_lp               ;do the lot
        pop     ds
;--------------------------------------------------------------------------
	ENDIF
;--------------------------------------------------------------------------
WI_wrt_1
;**	in      al,#WIP_stat            ;get WD1010 status
	PUSH	DX			;**
	mov	dx,WIP_stat		;** get WD1010 status
	in	al,dx			;**
	POP	DX			;**
        testb   al,#WIS_drq             ;data request?
        jz      WI_wrt_1                ;no - wait
                                        ;should have a timeout here?
        movb    al,#1                   ;set master = disk (1)
        call    WI_set_mas              ;and pulse pointer reset
        movb    al,#1                   ;set 'transferred' to 1
;**	movw    dx,#WIP_l_dtrn
	movw	dx,WIP_l_dtrn		;**
        out     dx,al
        call    WI_wait_WD              ;wait for WD1010
        call    WI_err_decode           ;get error status
        push    ax                      ;save status
;**	movw    dx,#WIP_l_dtrn
	movw	dx,WIP_l_dtrn		;**
        xorw    ax,ax
        out     dx,al                   ;reset transferred
        pop     ax                      ;restore status
        cmpw    ax,#MSE_OK              ;all well?
        je      WI_wrt_2                ;yes - continue
;
WI_wrt_x
	DECB	WID_TRY
	JNZ	WI_WRT_TRY
	ret				;abort - error in AX
;
;
WI_wrt_2                                ;check for verify
        cmpb    WID_command,#3          ;write with verify?
	je	WI_readsec		;yes - do read
        jmp     Wini_IO_lp1             ;no - done write
        		              ;else READ data just written

;
;  Read multiple sectors within track
;
WI_readsec
	movb	WID_try,#3		;set up retry count
WI_rd_try
        movb    al,#1                   ;set buffer master to disk (1)
        call    WI_set_mas              ;and pulse pointer reset
;**	movw    dx,#WIP_l_dtrn          ;set up 'transferred' address
	movw	dx,WIP_l_dtrn		;** set up 'transferred' address
        movb    al,#1
        out     dx,al                   ;set 'transferred' to 1
        movb    WID_cmd,#WICM_readm     ;set up read command
	cmpb	CNF_diagflag,#1		;retry disabled?
	jne	WI_rd_rt		;no - skip
	movb	WID_try,#1		;disable soft retry
	orb	WID_cmd,#WICM_notry	;disable retry
WI_rd_rt
        call    WI_WD1010_go            ;set off the WD1010
        jnz     WI_rd_0                 ;nz = timeout error
        call    WI_wait_WD              ;wait for data available
        call    WI_err_decode           ;decode error status
WI_rd_0                                 ;skip for timeout error
        push    ax                      ;and save it
;**	movw    dx,#WIP_l_dtrn          ;reset transferred
	movw	dx,WIP_l_dtrn		;** reset transferred
        xorw    ax,ax
        out     dx,al
        call    WI_set_mas              ;set master to user & pulse pointer
        pop     ax                      ;get status back
        cmpw    ax,#MSE_OK              ;all well?
        jnz     WI_rd_x			;no - abort
        xorw    cx,cx                   ;set up count of bytes
        movb    ch,WID_seccnt           ;= sector count * 512
        shlw    cx,#1
        movw    di,WID_mem_off          ;offset in di
;**	movw    dx,#WIP_ram             ;buffer RAM port
	movw	dx,WIP_ram		;** buffer RAM port
        cld
        testb    WID_command,#2		;is the verify bit set in the command?
        jnz      WI_vfy_lp		;yes - do verify
;---------------------------------------------------------------------------
	IF	APRICOT = TRUE		;APRICOT 8089 TRANSFER
;---------------------------------------------------------------------------
	movw	WI_rw_offset,di			;set up offset
	movw	WI_rw_PB,#(WI_rd_TB-DatabaseQQ)	;set up read
	call	WI_rw_8089			;and go
;---------------------------------------------------------------------------
	ELSE				;ACTIVM & CACTUS MANUAL TRANSFER
;---------------------------------------------------------------------------
        push    es
        movw    es,WID_mem_seg          ;segment in ES
WI_rd_lp
        in      al,dx                   ;get data
        stob                            ;put in memory
        loop    WI_rd_lp                ;do the lot
        pop     es
;---------------------------------------------------------------------------
	ENDIF
;---------------------------------------------------------------------------
        jmpsh   Wini_IO_lp1             ;transferred - do next lot
;
WI_vfy_lp                               ;verify data
        push    es
        movw    es,WID_mem_seg          ;segment in ES
        decw    di                      ;adjust address
WI_vfy_lp1                              ;VERIFY loop
        incw    di
        in      al,dx                   ;get data
        cmpb    al,es:[di]              ;check it
        loope   WI_vfy_lp1              ;loop if same and note done all
        pop     es                      ;restore es
        je      Wini_IO_lp1             ;all well - do next
        movw    ax,#MSE_bad_wrt         ;say bad write
        ret				;exit with error
;
;	error on read - retry or abort
WI_rd_x
	decb	WID_try
	jnz	WI_rd_try		;retry read
	ret				;return error in ax
;
;       Tail end of loop - adjust to get next track
;
Wini_IO_lp1
        xorw    ax,ax
        movb    al,WID_seccnt           ;get count of sectors done last
;*	subw    WID_sec_cnt,ax          ;count down sectors
	SUBW	WID_p_sec_cnt,ax	;* count down sectors
        jz      Wini_done
;*	addw    WID_st_sec,ax           ;bump sector
	ADDW	WID_pl_st_sec,ax	;* bump sector
	ADCW	WID_ph_st_sec,#0	;*
        movb    cl,#5                   ;multiply count by 20H to get segment adjust
        shlw    ax,cl
        addw    WID_mem_seg,ax          ;and update memory address
        jmp     Wini_IO_loop            ;more sectors to do
Wini_done
        movw    ax,#MSE_OK              ;say all done OK
        ret                             ;error status in AX

        PAGE
;---------------------------------------------------------------------------
	IF	APRICOT = TRUE
;---------------------------------------------------------------------------
;
;	WI_RW_8089	- APRICOT 8089 TRANSFER
;
WI_RW_8089
	mov	WI_rw_byte_count,cx	;set up count
	mov	ax,WIP_ram		;** set 8089 DMA port address
	mov	WI_RW_PORT,ax		;**
	mov	ax,WID_mem_seg		;get seg
	mov	WI_rw_segment,ax	;into table
	call	DRW_wait_89		;wait for 8089 not busy
	mov	dx,ds			;save ds
	xor	ax,ax			;point at 8089 CCB
	mov	ds,ax
	mov	bx,#500h		;which is at 500h
	mov	4[bx],dx		;database in seg
	mov	2[bx],#(WI_rw_pb-DatabaseQQ)
	mov	[bx],#0EE03h		;set up busy
	mov	ds,dx			;restore ds
	out	#IOP_CH1,al		;kick 8089
	call	DRW_wait_89		;and wait for completion
	ret

	page
;-------------------------------------------------------------------------
	ENDIF
;-------------------------------------------------------------------------
;
;*************************************************************************
;
; Wini_init - first time initialisation of winchester
;
; Sizes winchester buffer RAM
; If there is no RAM available assumes winchester not present,
; otherwise sets up INT vector to point at winchester interrupt
; handler and unmasks the pic, this
; Enables winchester controller interrupts,
; Performs a scan ID, followed by a seek to cylinder 0, restore if error.
; loads label sector into currently spare memory (printer buffer)
; and sets up BPB in winchester drivers.
; returns error status in AX
;
;*************************************************************************

;
;
Wini_init

;	1)	Set up default driver status, Test buffer ram for size
;		Assume no winchester if buffer ram test fails.

;**	CALL	SEL_BOARD_1		;** SELECT FIRST BOARD

;***	MOVW	WID_SELECTED,#0002H	;SAY DUMMY DRIVE SELECTED
;*	MOVW	WID_SELECTED,#0FFFFH	;*** SAY DUMMY DRIVE SELECTED
	XOR	AX,AX
	MOVB	WID_PARK1,AL		;** Say winchester needs parking
	MOVB	WID_PARK2,AL
	MOVB	WID_PARK3,AL		;**
	MOVB	WID_PARK4,AL		;**
	MOVB	WID_BOARD,AL		;SAY SINGLE CONTROLLER BOARD
	movb	B_WIN_NUM,AL		;say no winchester
        movb    WID_active,#1           ;set active on
;**	movw    WID_buffsize,#16        ;set up for 8K buffer

	CALL	SEL_BOARD_0		;** Test board 0
	CALL	WINI_TEST		;**
	movw	WID0_buffsize,ax	;** set up buffer size
	CALL	SEL_BOARD_1		;** Test board 1
	CALL	WINI_TEST		;**
	MOVW	WID1_buffsize,ax	;** set up buffer size

	or	ax,WID0_buffsize	;** Any board present ?
	jnz	wini_init_c		;**
	jmp	wini_init_x		;**

	IF 0	;*************************************************************
        xor     ax,ax
        call    WI_set_mas              ;set master to user & pulse pointer
        mov     cx,#2048                ;transfer 2048 bytes
;**	mov     dx,#WIP_ram             ;to buffer
	mov	dx,WIP_ram		;** to buffer
        mov     al,#55h
Wini_init_tl
        out     dx,al
        loop    Wini_init_tl
        not     al
        out     dx,al                   ;write inverse to location 2049
        xor     ax,ax
        call    WI_set_mas              ;set master to user & pulse pointer reset
;**	mov     dx,#WIP_ram
	mov	dx,WIP_ram		;**
        mov     ah,#0AAh
	not	ah
        in      al,dx                   ;get first location
        cmpb    al,ah                   ;is it a 55h - i.e. have we looped round?
        je      Wini_init_c             ;yes - must be 8K buffer
        movw    WID_buffsize,#4         ;no - say 2K buffer
        not     ah
        cmpb    al,ah                   ;
        je      Wini_init_c             ;it was a loop round
        movw    ax,#MSE_failure         ;load fail
        jmp     Wini_init_x             ;and fail - do not set up wini ints
	ENDIF	;*************************************************************

;	2)	Set up interrupt vector and enable interrupt
 
Wini_init_c
        
	pushf
        cli				;now we shall set up the interrupt
	push	es
	xor	ax,ax			;vector in low ram
	mov	es,ax			;point at low ram
;----------------------------------------------------------------------------
	IF	APRICOT = TRUE
;----------------------------------------------------------------------------
	mov	es:(82*4),#WINI_Int-CodebaseQQ
	mov	es:((82*4)+2),cs	;and set up the vector
	pop	es
        in      al,#PIC_IMR		;select PIC interrupt mask register
        and     al,#0FBh                ;AND mask for INT2
        out     #PIC_IMR,al
;----------------------------------------------------------------------------
	ELSEIF	ACTIVM = TRUE
;----------------------------------------------------------------------------
	mov	es:(83*4),#WINI_Int-CodebaseQQ
	mov	es:((83*4)+2),cs	;and set up the vector
	pop	es
        in      al,#PIC_IMR		;select PIC interrupt mask register
        and     al,#0F7h                ;AND mask for INT3
        out     #PIC_IMR,al
;----------------------------------------------------------------------------
	ELSE				;OTHERWISE - CACTUS
;----------------------------------------------------------------------------
	mov	es:(96*4),#WINI_Int-CodebaseQQ
	mov	es:((96*4)+2),cs	;and set up the vector
	pop	es
	mov	al,#11010111b		;CTC channel 0 - External Int
					;counter mode, INT enabled
					;active high, reset, load TC
	out	#CTC_CH0,al

	mov	cx,#4			;small delay
wini_w1	loop	wini_w1			;delay aprox 10us

	mov	al,#1			;count for interrupt
	out	#CTC_CH0,al
;----------------------------------------------------------------------------
	ENDIF
;----------------------------------------------------------------------------
        popf
        
;	3)	Set up internal variables in command table
;		and restore the disk.

	IF 0				;****
        movb    WID_wpre,#255           ;write precomp on cyl 1020
        movb    WID_seccnt,#1           ;sector count of 1
        movb    WID_secnum,#0           ;sector 0
        movw    WID_cyllo,#0            ;seek to cyliner 0
                                        ;( cyllo & cylhi bytes as a word )
        movb    WID_sdh,#00100000b      ;512 byte sectors, drive 0, head 0
        movb    WID_head,#0             ;set up head for latch
	ENDIF				;****
;
;	4)	DO THE INIT FOR BOTH DRIVES
;
;**	movb	B_WIN_NUM,#1		;say we have a winchester
	movb	B_WIN0_NUM,#0		;* No drives on board 0 yet
	movb	B_WIN1_NUM,#0		;* No drives on board 1 yet
	movb    WID_changed1,#0		;reset flags
	MOVB	WID_CHANGED2,#0
	MOVB	WID_CHANGED3,#0		;**
	MOVB	WID_CHANGED4,#0		;**

	CMPW	WID0_BUFFSIZE,#0	;* Have we got board 0 ?
	JE	WINI_INIT_2		;* No then don't test drives

	CALL	SEL_BOARD_0		;** Select board 0
;**	MOVW	WID_UNIT,#0000H		;START ON WINI 1
	movw	wid_drive,#0		;** Start on Wini 1
	CALL	WINI_SEL0		;GO SELECT THE DRIVE
	movw	WID_timeout,#1000	;20 second timeout for ready 1
	movb	al,B_WIN_NUM		;** Current unit number
	xor	ah,ah			;**
	mov	WID_unit,ax		;**
	CALL	WINI_GINIT		;AND GO FOR IT
;?	AND	AX,AX
;**	JNZ	WINI_INIT_X		;ABORT IF DRIVE 1 DEAD
;?	JNZ	WINI_INIT_2		;**
	CMP	AX,#MSE_drv_not_rdy	;? Give up with board if drive not ready
	JE	WINI_INIT_2		;?
	INCB	B_WIN0_NUM		;*
	INCB	B_WIN_NUM		;****
;**	MOV	DX,#WIP_L_DS1		;DESELECT BOTH DRIVES
	MOV	DX,WIP_L_DS1		;** DESELECT BOTH DRIVES
	MOV	AL,#0
	OUT	DX,AL

	mov	cx,#80			;delay approx 200 us
wini_w2	loop	wini_w2			;

;**	IN	AL,#WIP_STAT		;GET 1010 STATUS
	push	dx			;**
	MOV	DX,WIP_STAT		;** GET 1010 STATUS
	IN	AL,DX			;**
	pop	dx			;**
	TEST	AL,#WIS_READY		;STILL READY?
;**	JNZ	WINI_INIT_X		;YES - SINGLE BOARD
	JNZ	WINI_INIT_2		;**
	MOVB	WID_BOARD,#1		;OK - DUAL CONTROLLER BOARD
;**	INCB	B_WIN_NUM		;SAY TWO WINCHESTERS
;**	MOVW	WID_UNIT,#0001H		;THEN WINI 2
	movw	WID_drive,#1		;** Then Wini 2
	CALL	WINI_SEL0		;GO SELECT THE DRIVE
	movw	WID_timeout,#100	;2 second timeout for ready 2
	movb	al,B_WIN_NUM		;** Current unit number
	xor	ah,ah			;**
	mov	WID_unit,ax		;**
	CALL	WINI_GINIT
;?	AND	AX,AX
;?	JNZ	WINI_INIT_2
	CMP	AX,#MSE_drv_not_rdy	;? Give up with board if drive not ready
	JE	WINI_INIT_2		;?
	INCB	B_WIN0_NUM		;*
	INCB	B_WIN_NUM		;****
WINI_INIT_2				;**
	CMPW	WID1_BUFFSIZE,#0	;* Have we got board 0 ?
	JE	WINI_INIT_X		;* No then don't test drives

	CALL	SEL_BOARD_1		;** Select board 1
;**	MOVW	WID_UNIT,#0000H		;**START ON WINI 1
	movw	WID_drive,#0		;** Start on Wini 1
	CALL	WINI_SEL0		;**GO SELECT THE DRIVE
	movw	WID_timeout,#1000	;**20 second timeout for ready 1
	movb	al,B_WIN_NUM		;** Current unit number
	xor	ah,ah			;**
	mov	WID_unit,ax		;**
	CALL	WINI_GINIT		;**AND GO FOR IT
;?	AND	AX,AX
;?	JNZ	WINI_INIT_X		;**ABORT IF DRIVE 1 DEAD
	CMP	AX,#MSE_drv_not_rdy	;? Give up with board if drive not ready
	JE	WINI_INIT_X		;?
	INCB	B_WIN1_NUM		;*
	INCB	B_WIN_NUM		;****
;**	MOV	DX,#WIP_L_DS1		;**DESELECT BOTH DRIVES
	MOV	DX,WIP_L_DS1		;** DESELECT BOTH DRIVES
	MOV	AL,#0
	OUT	DX,AL

	mov	cx,#80			;**delay approx 200 us
wini_w3	loop	wini_w3			;**

;**	IN	AL,#WIP_STAT		;**GET 1010 STATUS
	push	dx			;**
	MOV	DX,WIP_STAT		;** GET 1010 STATUS
	IN	AL,DX			;**
	pop	dx			;**
	TEST	AL,#WIS_READY		;**STILL READY?
	JNZ	WINI_INIT_X		;**YES - SINGLE BOARD
;**	MOVB	WID_BOARD,#1		;**OK - DUAL CONTROLLER BOARD
;**	INCB	B_WIN_NUM		;**SAY TWO WINCHESTERS
;**	MOVW	WID_UNIT,#0001H		;**THEN WINI 2
	movw	WID_drive,#1		;** Then Wini 2
	CALL	WINI_SEL0		;**GO SELECT THE DRIVE
	movw	WID_timeout,#100	;**2 second timeout for ready 2
	movb	al,B_WIN_NUM		;** Current unit number
	xor	ah,ah			;**
	mov	WID_unit,ax		;**
	CALL	WINI_GINIT		;**
;?	AND	AX,AX			;**
;?	JNZ	WINI_INIT_X		;**
	CMP	AX,#MSE_drv_not_rdy	;? Give up with board if drive not ready
	JE	WINI_INIT_X		;?
	INCB	B_WIN1_NUM		;*
	INCB	B_WIN_NUM		;****

WINI_INIT_X
	push	ax
	call	SEL_BOARD_0		;*
	call	WI_PARK_DES		;deselect both drives
	call	SEL_BOARD_1		;*
	call	WI_PARK_DES		;*
	pop	ax
	MOVB	WID_ACTIVE,#0
        ret                             ;error code in ax
;

	IF 1	;*************************************************************
; Have a look at the controller card to see how big the buffer is.
; Return	AX - 4  2k buffer
;		     16 8k buffer
;		     0  no board present
wini_test
        xor     ax,ax
        call    WI_set_mas              ;set master to user & pulse pointer
        mov     cx,#2048                ;transfer 2048 bytes
	mov	dx,WIP_ram		; to buffer
        mov     al,#55h
Wini_init_tl
        out     dx,al
        loop    Wini_init_tl
        not     al
        out     dx,al                   ;write inverse to location 2049
        xor     ax,ax
        call    WI_set_mas              ;set master to user & pulse pointer reset
	mov	dx,WIP_ram
        mov     ah,#0AAh
	not	ah
        in      al,dx                   ;get first location
        cmpb    al,ah                   ;is it a 55h - i.e. have we looped round?
        je      Wini_test_8k		;** yes - must be 8K buffer
        not     ah
        cmpb    al,ah                   ;
        je      Wini_test_2k		;it was a loop round
        xor	ax,ax			;load fail
        ret
wini_test_8k
	mov	ax,#16
	ret
wini_test_2k
	mov	ax,#4
	ret
	ENDIF	;**************************************************************

;----------------------------------------------------------------------
; WINI_GINIT - SUBROUTINE TO GO CHECK THE WINCHESTER
;
WINI_GINIT
;**	in	al,#WIP_stat		;get status
	PUSH	DX			;**
	MOV	DX,WIP_stat		;** get status
	IN	AL,DX			;**
	POP	DX			;**
	test	al,#WIS_ready		;is the drive ready?
	jnz	WINI_Ginit_2		;yes - go
	cmpw	WID_Timeout,#0		;timed - out
	jnz	WINI_GINIT		;no - wait
;**	DECB	B_WIN_NUM		;AND REDUCE NUMBER OF WINIS
	mov	ax,#MSE_drv_not_rdy	;say drive unwell
	ret

;
;	Do two scan ID's and go load, Restore if error.
;
WINI_Ginit_2
	IF 1				;****
        movb    WID_wpre,#255           ;write precomp on cyl 1020
        movb    WID_seccnt,#1           ;sector count of 1
        movb    WID_secnum,#0           ;sector 0
        movw    WID_cyllo,#0            ;seek to cyliner 0
                                        ;( cyllo & cylhi bytes as a word )
        movb    WID_sdh,#00100000b      ;512 byte sectors, drive 0, head 0
        movb    WID_head,#0             ;set up head for latch
	ENDIF				;****

        call    WI_BPB_default          ;set up default BPB
        call    WI_init_drvr            ;init driver variables (from BPB)

	movb	WID_cmd,#WICM_scan_id	;do a scan ID
	call	WINI_go			;do it
	jnz	WINI_GINIT_RST		;failed - do a restore
;**	in	al,#WIP_cylhi		;get hi byte of cylinder
	PUSH	DX			;**
	MOV	DX,WIP_cylhi		;** get hi byte of cylinder
	IN	AL,DX			;**
	mov	ah,al
;**	in	al,#WIP_cyllo		;and low
	MOV	DX,WIP_cyllo		;** and low
	IN	AL,DX			;**
	POP	DX			;**
	cmp	ax,#0			;on cylinder 0?
	jz	WINI_GINIT_C1		;ok - do seek up
	dec	ax			;seek to next door cylinder
	jmpsh	WINI_GINIT_C2
WINI_GINIT_C1
	inc	ax			;seek to next door cylinder
WINI_GINIT_C2
	movw	WID_cyllo,ax		;set up cylinder
	movb	WID_cmd,#WICM_seek	;set up seek
	call	WINI_go
	jnz	WINI_GINIT_RST		;failed - do a restore
	movb	WID_cmd,#WICM_scan_id	;do a scan ID
	call	WINI_go			;do it
	jnz	WINI_GINIT_RST		;failed - do a restore
;**	in	al,#WIP_cylhi		;get hi byte of cylinder
	PUSH	DX			;**
	MOV	DX,WIP_cylhi		;** get hi byte of cylinder
	IN	AL,DX			;**
	mov	ah,al
;**	in	al,#WIP_cyllo		;and low
	MOV	DX,WIP_cyllo		;** and low
	IN	AL,DX			;**
	POP	DX			;**
	cmp	ax,WID_cyllo		;is it where it should be?
	je	WINI_GINIT_LD		;yes - do a load

WINI_GINIT_RST
	movw	WID_Cyllo,#0		;going for cylinder 0
        movb    WID_cmd,#WICM_restore   ;do a restore
	call	WI_WD1010_go		;kick off
        jnz     WINI_GINIT_X             ;exit on error
	movw	WID_timeout,#750	;long wait for restore
	call	WI_wait_1		;wait for it
	call	WI_err_decode
	cmp	ax,#MSE_OK		;all well?
	jne	WINI_GINIT_X		;no - abort
;
;	4)	load header sector into unused printer buffer
;
WINI_GINIT_LD
        xorw    ax,ax
        movw    WID_command,ax          ;set comm = 0 (read)
;*	movw    WID_st_sec,ax           ;start sector 0
	movw	WID_pl_st_sec,ax	;* start sector 0
	movw	WID_ph_st_sec,ax	;*
        incw    ax
;*	movw    WID_sec_cnt,ax          ;one sector
	movw	WID_p_sec_cnt,ax	;* one sector
        movw    WID_mem_off,#(PRN_queue-DatabaseQQ)
                                        ;mem offset
        movw    WID_mem_seg,ds          ;mem seg = current ds
        call    Wini_IO_loop		;read header
        cmpw    ax,#MSE_OK              ;all well?
        jne     Wini_Ginit_OK           ;abort with default
	lea	bx,PRN_queue            ;set up offset of buffer
        cmpb    WIf_offset[bx],#1       ;test winchester flag
        jne     Wini_Ginit_ok           ;abort but OK
        call	WI_get_bpb		;get the BPB from the header
        call    WI_init_drvr            ;init driver from BPB
WINI_GINIT_OK
	movw	WID_Cyllo,#305		;park drive on cylinder 305
	movb	WID_cmd,#WICM_seek
	call	Wini_go
	MOV	AX,#MSE_OK		;SAY ALL IS WELL WITH THE WORLD
WINI_GINIT_X
	RET
;
; WINI_go	;subroutine to perform command, returns nz on error
;
WINI_go
	call	WI_WD1010_go		;kick off
	jnz	WINI_go1		;failed
	call	WI_wait_WD		;wait for wini
	call	WI_err_decode		;decode any error
	cmp	ax,#MSE_OK		;all well?
WINI_go1
	ret

        PAGE
;
;************************************************************************
;
; Subroutines
;
;************************************************************************

;*WI_PARK_HD1	;HEAD PARKING FOR DRIVE 1
;*	MOV	DX,#0			;SET UP 0
;*	JMPSH	WI_PARK_HD

WI_PARK_HD2	;HEAD PARKING FOR DRIVE 2
;*	MOV	DX,#1			;SET UP 1

WI_PARK_HD1	;* HEAD PARKING FOR ALL DRIVES
;
; WI_park_hd    - COMMON HEAD PARKING ROUTINE - PARKS & DESELECTS DRIVE
;               IF NO ACCESS FOR FIVE SECONDS.
;* WI_park_hd
;*	cmpb	B_WIN_NUM,DL		;do we even have THE winchester?
;*	jae	WI_park_0
;*	jmp	WI_park_XX		;no - forget it
;*WI_park_0

        cmpb    WID_active,#0           ;Winchester inactive?
        jne     WI_ex_park              ;no - exit
	cmpb	CNF_wini_park,#0	;allowed to park?
;*	jne     WI_park_ex              ;no - someone else must be messing
	jne	WI_ex_park		;*

;*	LEA	BX,WID_PARK1		;POINT AT DRIVE 1 PARKING FLAG
;*	LEA	SI,WID_PARK2		;POINT AT DRIVE 2 PARKING FLAG
;*	CMP	DL,#1			;DRIVE TWO?
;*	JNE	WI_PARK_1		;NO - SKIP
;*	XCHG	BX,SI			;OTHER ONE IN [SI]
;*WI_PARK_1
;*	XOR	AX,AX
;*	CMP	[SI],AL			;OTHER DRIVE PARKING?
;*	JNZ	WI_PARK_EX		;YES - WAIT FOR NEXT CHANCE

;* See if anyone needs parking or deselecting

	XOR	DX,DX			;* Look at drive 1 ? 
	LEA	BX,WINI_BPB1		;*
	CMPB	1FH[BX],#-1		;*
	JNE	WI_PARK_0		;*
	INC	DX			;* Look at drive 2 ? 
	LEA	BX,WINI_BPB2		;*
	CMPB	1FH[BX],#-1		;*
	JNE	WI_PARK_0		;*
	INC	DX			;* Look at drive 3 ? 
	LEA	BX,WINI_BPB3		;*
	CMPB	1FH[BX],#-1		;*
	JNE	WI_PARK_0		;*
	INC	DX			;* Look at drive 4 ? 
	LEA	BX,WINI_BPB4		;*
	CMPB	1FH[BX],#-1		;*
	JNE	WI_PARK_0		;*

	JMP	WI_park_XX		;*

WI_ex_park
	JMP	WI_park_ex		;*

WI_PARK_0				;*
	CMP	DL,B_WIN_NUM		;* Do we have THE winchester
	jae	WI_ex_park		;*

;**	in      al,#WIP_stat            ;get 1010 status
	push	dx			;** get 1010 status
	mov	dx,WIP_stat		;**
	in	al,dx			;**
	pop	dx			;**
        testb   al,#WIS_busy ! WIS_cip  ;busy or command in progress?
;*	jnz     WI_park_ex              ;yes - abort
	jnz	WI_ex_park		;*

;*	XOR	AX,AX
;*	XCHG	AL,[BX]			;GET OLD FLAG & RESET IT
;*	CMP	AL,AH			;ARE WE AT IT?

	CMPB	1FH[BX],#0		;* PARK OR DESELECT
;*	JNE	WI_PARK_DES		;YES - NOW DESELECT THE DRIVE
	JNE	WI_DES_PARK		;*

	MOVB	WID_ACTIVE,#1
;*	MOVB	[BX],#1			;SAY DESELECT NEXT TIME
	MOVB	1FH[BX],#1		;* SAY DESELECT NEXT TIME
	MOV	WID_UNIT,DX		;SELECT DRIVE
;*	PUSH	DX			;SAVE ID
	CALL	SEL_BOARD		;*
	CALL	WINI_SEL0
;*	POP	DX
;*	PUSH	DX
        movb    WID_seccnt,#1           ;sector count of 1
        movb    WID_secnum,#0           ;sector 0
;*	MOV	AX,WID_PRKCYL1		;GET PARKING CYLINDER FOR DRIVE 1
;*	CMP	DL,#1			;DRIVE 2?
;*	JNE	WI_PARK_2
;*	MOV	AX,WID_PRKCYL2		;GET PARKING CYLINDER FOR DRIVE 2
;*WI_PARK_2
	MOV	AX,12H[BX]		;*
	DEC	AX			;ADJUST CYLINDER NUMBER
	movw    WID_cyllo,AX		;seek to cyliner
                                        ;( cyllo & cylhi bytes as a word )
        andb    WID_sdh,#11111000b      ;head 0
        movb    WID_head,#0             ;set up head for latch
        movb    WID_cmd,#WICM_seek      ;do a seek
        call    WI_WD1010_go            ;set off the 1010
        MOVB	WID_ACTIVE,#0
;*	POP	DX                      ;GET BACK ID
WI_PARK_EX
	MOV	AX,#WIN1_SLEEPER	;SET UP FOR DRIVE 1
;*	CMP	DL,#1			;ASKED FOR DRIVE 2?
;*	JNE	WI_PARK_EX1		;NO - SKIP
;*	MOV	AX,#WIN2_SLEEPER	;SET UP FOR DRIVE 2
;*WI_PARK_EX1
	PUSH	AX			;SEND ID
	MOV	AX,#50			;WAIT 1 SECOND
	PUSH	AX
	CALL	SH_WAKE_ME_UP		;TELL SHEDULER
WI_park_XX
        ret                             ;ignore errors

WI_DES_PARK				;*
	MOVB	1FH [BX],#-1		;*
	MOV	WID_unit,dx		;*
	CALL	SEL_BOARD		;*
	CALL	WI_PARK_DES		;*
;*	JMP	WI_PARK_EX		;*
	JMP	WI_PARK_HD1		;* Now try to park a drive
;
;	DESELECT BOTH DRIVES - ALSO CALLED BY INIT
;
WI_PARK_DES
;***	MOVW	WID_SELECTED,#2		;SAY DUMMY SELECTED
;*	MOVW	WID_SELECTED,#0FFFFH	;*** SAY DUMMY SELECTED
	XOR	AX,AX
;**	MOV	DX,#WIP_L_DS1		;SET UP FOR DRIVE 1
	mov	dx,WIP_l_ds1		;** set up for drive 1
	OUT	DX,AL			;DESELECT DRIVE
;**	MOV	DX,#WIP_L_DS2		;DO DRIVE 2
	mov	dx,WIP_l_ds2		;** do drive 2
	OUT	DX,AL			;DESELECT DRIVE
;*	JMPSH	WI_PARK_XX		;DONE
	RET				;*
;
;************************************************************************
;
; WI_validate - validates call for read/write
;               sets up WI_error with appropriate error status
;
WI_validate
	MOVW	AX,WID_UNIT		;CHECK FOR VALID UNIT
	CMP	AL,B_WIN_NUM
	JAE	WI_VAL0			;INVALID - ABORT
;*	MOVW	BX,WID_MAXSEC1		;GET MAX SECTORS FOR FIRST DRIVE
;*	movw	cx,WID_SECSIZ1		;* Sector size for first drive
;*	CMPB	AL,#0			;FIRST DRIVE?
;*	JE	WI_VALZ			;YES - SKIP
;*	MOVW	BX,WID_MAXSEC2		;GET MAX SECTORS FOR SECOND DRIVE
;*	movw	cx,WID_SECSIZ2		;* Sector size for second drive
	MOV	BX,WID_unit		;* Get BPB pointer
	SHL	BX,#1			;*
	MOV	BX,WINIT_table[BX]	;*
	MOV	CX,0h[BX]		;* Sector size
	MOV	BX,8h[BX]		;* Max sector
;*WI_VALZ
        movw    ax,WID_sec_cnt          ;get count requested
        andw    ax,ax                   ;asking for no sectors?
        jnz	WI_val1			;no - carry on
WI_VAL0
        movw    ax,#MSE_failure         ;say no way
        jmpsh   WI_val_x
WI_val1
        addw    ax,WID_st_sec           ;get count + start
	CMPW	AX,BX			;INVALID LOGICAL SECTOR?
        jbe     WI_val2                 ;no -continue
        movw    ax,#MSE_no_sctr         ;say no sectors there
        jmpsh   WI_val_x
WI_val2
	mov	cl,ch			;* Sector size / 512
	shrb	cl,#1			;*
	xorb	ch,ch			;*
	mov	ax,WID_st_sec		;*
	mul	cx			;* Calculate physical start
	mov	WID_pl_st_sec,ax	;* save low byte
	mov	WID_ph_st_sec,dx	;* save high byte
	movb	al,WID_sec_cnt		;* Calculate sector count
	mulb	cl			;*
	mov	WID_p_sec_cnt,ax	;* and save it

        movw    ax,#MSE_OK              ;say all well
WI_val_x
        ret
;
        PAGE
;
;--------------------------------------------------------------------------
;
; WI_translate - translates logical sector number in AX, to physical
; sector in AX, head number in BX, cylinder number in CX.
;*	NOTE - THIS IS ONLY VALID FOR 2,4 OR 8 HEADS
;	NOTE - NOW VALID FOR ANY NUMBER OF HEADS	;*
;	ON ENTRY DX:AX IS THE SECTOR NUMBER

WI_translate
;*	MOV	CH,WIDHD_SHIFT1		;SET UP FOR DRIVE 1
;*	MOV	DX,WIDHD_MASK1
;****	MOV	CH,WID_HEADS1		;*
;****	CMPW	WID_SELECTED,#1		;DRIVE 2?
;****	JNE	WI_TRANS1		;NO - SKIP
;*	MOV	CH,WIDHD_SHIFT2		;SET UP FOR DRIVE 2
;*	MOV	DX,WIDHD_MASK2
;****	MOV	CH,WID_HEADS2		;*
;****WI_TRANS1

	MOV	BX,WID_unit		;**** Get BPB pointer for drive
	SHL	BX,#1			;****
	MOV	BX,WINIT_TABLE[BX]	;****
	MOVB	CH,1AH[BX]		;****

	push    ax                      ;save number
;*	mov     cl,#4                   ;shift down to get head bits
;*    	shrw    ax,cl
	shrw	dx,#1			;*
	rcrw	ax,#1			;*
	shrw	dx,#1			;*
	rcrw	ax,#1			;*
	shrw	dx,#1			;*
	rcrw	ax,#1			;*
	shrw	dx,#1			;*
	rcrw	ax,#1			;*
;*	movw    bx,ax                   ;head in bx
;*	andw    bx,DX			;mask down to n bits
;*	mov     cl,CH
;*	shrw    ax,cl                   ;get cylinder number
;*	movw    cx,ax                   ;in cx
	mov	cl,ch			;* number of heads to CX
	xorb	ch,ch			;*
;*	xorw	dx,dx			;* calculate head, cylinder
	divw	cx			;* DX is head, AX is cylinder
	mov	bx,dx			;* put where we want them
	mov	cx,ax			;*
        pop     ax
        andw    ax,#000Fh               ;valid sector = 0-15
        ret
;
;-------------------------------------------------------------------------
;
; WI_WD1010_go - sets up the task file and kicks off the WD1010
; returns fail (timeout) status in ax (nz)
; Longer timeouts can be obtained by setting up WID_timeout, and calling
; WI_WD1010_1.
;
WI_WD1010_go
        movw    WID_timeout,#25         ;500mS timeout
WI_WD1010_1
;**	in      al,#WIP_stat            ;get WD1010 status
	push	dx			;**
	mov	dx,WIP_stat		;** get WD1010 status
	in	al,dx			;**
	pop	dx			;**
        testb   al,#WIS_busy ! WIS_cip  ;busy or command in progress?
        jz      WI_WD1010_3             ;no
WI_WD1010_2
        cmpw    WID_timeout,#0          ;timed-out?
        jnz     WI_WD1010_1             ;no -loop
        mov     ax,#0FFFFh              ;set up interrupt flag
        movw    WID_Int_Stat,ax
        mov     al,#WICM_scan_id        ;do a scan id
;**	out     #WIP_cmd,al             ;send command
	push	dx			;**
	mov	dx,WIP_cmd		;** send command
	out	dx,al			;**
	pop	dx			;**
        call    WI_wait_WD              ;wait for result
        call    WI_err_decode           ;decode error
        cmpw    ax,#MSE_OK              ;all well?
        je      WI_WD1010_4             ;yes - carry on
        jmpsh   WI_WD1010_x             ;abort
WI_WD1010_3
        testb   al,#WIS_ready           ;drive ready?
        jz      WI_WD1010_2             ;no - wait
        testb   al,#WIS_seekc           ;seek complete?
        jz      WI_WD1010_2             ;no wait
;
WI_WD1010_4
        movw    ax,#0FFFFh              ;set up interrupt flag
        movw    WID_Int_Stat,ax
        movw    cx,#3                   ;set up head bits in latches
;**	movw    dx,#WIP_l_hds0
	movw	dx,WIP_l_hds0		;**
        movb    al,WID_head
WI_WD1010_5
        out     dx,al                   ;set up bit
        shrb    al,#1                   ;get next
        incw    dx
        incw    dx                      ;next head port
        loop    WI_WD1010_5
	cmp	WID_drive,#1		;* Second drive can't have > 8 heads
	je	WI_WD1010_7		;*
	ANDB	AL,#1			;* head select bit 3
;**	MOV	DX,#WIP_l_ds2		;* output to drive select 2
	mov	dx,WIP_l_ds2		;**
	OUT	DX,AL			;*
WI_WD1010_7
	cld
        movw    cx,#7                   ;set up seven registers in task file
;**	movw    dx,#WIP_wpre            ;start at write precomp port
	movw	dx,WIP_wpre		;** start at write precomp port
        lea	si,WID_wpre		;point to table
WI_WD1010_6
        lodb                            ;get data from ES:SI
        out     dx,al                   ;send to port
        incw    dx
        incw    dx
        loop    WI_WD1010_6
        xorw    ax,ax                   ;say OK
WI_WD1010_x
        andw    ax,ax                   ;set nz flag on err
        ret
;
;-------------------------------------------------------------------------
; WI_wait_WD - waits for WD1010 to complete operation by polling
;               interrupt flag status.
;               Returns WD1010 status in AL.
;               OR AX=0FFFFh for timeout
;	Longer timeouts can be obtained by setting up WID_timeout and calling
;	WI_wait_1.
;
WI_wait_WD
        movw    WID_timeout,#25         ;500mS timeout
WI_wait_1
        hlt                             ;reduce bus clutter
        cmpw    WID_Int_stat,#0FFFFh    ;flag changed?
        jne     WI_wait_2               ;yes - return
        cmpw    WID_timeout,#0          ;timed-out?
        jne     WI_wait_1               ;no - keep going
WI_wait_2
        movw    ax,WID_Int_Stat         ;get status
        ret                             ;and return
;
        PAGE
;
;-------------------------------------------------------------------------
; 
; WI_err_decode - decodes WD1010 error status from status register in al
;               and WD1010 error flag register
;               Returns MS-DOS error flag in AX
;
WI_err_decode
        cmpw    ax,#0FFFFh              ;timeout error?
        je      WI_err_dec0             ;yes - set failure
        testb   al,#(WIS_busy ! WIS_writef ! WIS_cip)
                        ; busy, write fault or command in progress?
        jz      WI_err_dec1             ;no - continue
WI_err_dec0
        movw    ax,#MSE_failure         ;say failed
        jmpsh   WI_err_dec_x
WI_err_dec1
        testb   al,#WIS_err             ;error bit set?
        jz      WI_err_dec8             ;no -skip
;**	in      al,#WIP_errf            ;get errror flags
	push	dx			;**
	mov	dx,WIP_errf		;** get error flags
	in	al,dx			;**
	pop	dx			;**
        testb   al,#WIER_bad_blk        ;bad block?
        jz      WI_err_dec2             ;no -skip
        movw    ax,#MSE_bad_media       ;say bad media
        jmpsh   WI_err_dec_x
WI_err_dec2
        testb   al,#WIER_crc_datf       ;CRC data field?
        jz      WI_err_dec3             ;no-skip
        movw    ax,#MSE_CRC_err         ;say CRC error
        jmpsh   WI_err_dec_x
WI_err_dec3
        testb   al,#(WIER_id_notf ! WIER_dam_nf)
                        ; ID not found, or Data address not found?
        jz      WI_err_dec4
        movw    ax,#MSE_no_sctr         ;say no sector
        jmpsh   WI_err_dec_x
WI_err_dec4
        testb   al,#WIER_abortc         ;aborted command?
        jz      WI_err_dec5             ;no - skip
        movw    ax,#MSE_failure
        jmpsh   WI_err_dec_x
WI_err_dec5
        testb   al,#WIER_trk0_er        ;track 000 error
        jz      WI_err_dec8
        movw    ax,#MSE_seek_err        ;say seek error
        jmpsh   WI_err_dec_x
        
WI_err_dec8
        movw    ax,#MSE_OK              ;say OK
WI_err_dec_x
        ret
;
        PAGE
;
;-----------------------------------------------------------------------
; WI_tick - countdown for timeouts
;
        Global WI_tick
;
WI_tick
        cmpw    WID_timeout,#0          ;already 0?
        je      WI_tick_x               ;yes -skip
        decw    WID_timeout
WI_tick_x
        ret
;
;
;------------------------------------------------------------------------
; WI_init_drvr  - 
;       Initialises driver variables from BPB in WINI_BPB
;
;
WI_init_drvr
;**	xor	ax,ax
;**	LEA	BX,WINI_BPB1		;POINT AT FIRST DRIVE TABLE
;**	CMPB	AH,WID_UNIT		;CHECK IF ON ZERO
;**	JE	WI_INIT_DR0		;YES - SKIP
;**	LEA	BX,WINI_BPB2		;POINT AT SECOND DRIVE TABLE

	MOV	BX,WID_UNIT		;** GET UNIT NUMBER
	SHL	BX,#1			;** INDEX INTO TABLE
	MOV	BX,winit_table[BX]	;**

;
WI_INIT_DR0
	MOV	AL,0DH[BX]		;GET DRIVE TYPE FIELD
;*	cmpb    al,#3                   ;check valid
;*	jb      WI_init_dr1             ;no- load default
;*	cmpb    al,#5                   ;
;*	jbe     WI_init_dr2             ;ok - continue
	CMPB	AL,#3			;* 2 - HEAD DRIVE ?
	JNE	WI_init_dr10		;*
	MOVB	01AH[BX],#2		;*
	JMP	WI_init_dr2		;*
WI_init_dr10				;*
	CMPB	AL,#4			;* 4 - HEAD DRIVE ?
	JNE	WI_init_dr11		;*
	MOVB	01AH[BX],#4		;*
	JMP	WI_init_dr2		;*
WI_init_dr11				;*
	CMPB	AL,#5			;* 8 - HEAD DRIVE ?
	JNE	WI_init_dr12		;*
	MOVB	01AH[BX],#8		;*
	JMP	WI_init_dr2		;*
WI_init_dr12				;*
	CMPB	AL,#80H			;* OTHER VALID DRIVE ?
;*	MOV	AX,#4			;* LIE A LITTLE BIT !!
	JE	WI_init_dr2		;*

WI_init_dr1
	PUSH	BX
	call    WI_BPB_default          ;set up default BPB
        POP	BX
	movw    ax,#4                   ;with default size
WI_init_dr2
	CMPW	16H[BX],#0		;CYLINDERS FIELD EMPTY?
	JNE	WI_INIT_DR3		;NO - OK
	MOVW	16H[BX],#306		;SET UP DEFAULT
WI_INIT_DR3
	CMPW	12H[BX],#0		;PARK CYLINDER FIELD EMPTY?
	JE	WI_INIT_DR4		;YES
	CMPW	12H[BX],#512		;OR OLD SECTOR SIZE FIELD?
	JNE	WI_INIT_DR5		;NO - OK
WI_INIT_DR4
	MOVW	12H[BX],#306		;SET UP DEFAULT FOR RODIME DRIVES
WI_INIT_DR5
	cmpw	0h[BX],#1000h		;MAX 4k sector size
	jbe	WI_INIT_DR6
	movw	0h[BX],#1000h
WI_INIT_DR6
        movb    B_WIN_TYP,al		;set up drive type
;*	decw    ax
;*	decw    ax                      ;convert to shift factor
;*	movb    20H[BX],al		;SET UP HEAD SHIFT FIELD
;*	movw    cx,ax
;*	xorw    ax,ax
;*	decw    ax                      ;ax = 0FFFFh
;*	shlw    ax,cl
;*	notw    ax                      ;mask now in ax
;*	movw    1EH[BX],ax		;SET UP HEAD MASK FIELD
        ret
;
;-----------------------------------------------------------------------
; WI_BPB_default - 
;       Set up default BPB in WINI_BPB
;       Default type is Rodime 10 meg single volume
;
;
WI_BPB_default
;**	LEA	DI,WINI_BPB1		;POINT AT BPB FOR FIRST DRIVE
;**	CMPB	WID_UNIT,#01H		;SECOND DRIVE?
;**	JNE	WI_BPB_DEF1		;NOPE - SKIP
;**	LEA	DI,WINI_BPB2		;POINT AT SECOND DRIVE'S BPB

	MOV	DI,WID_UNIT		;** GET UNIT NUMBER
	SHL	DI,#1			;** INDEX INTO TABLE
	MOV	DI,winit_table[DI]	;**

WI_BPB_DEF1
        lea	si,WI_default_BPB
        cld
        movw    cx,#15                  ;15 words to move
        rep     movw                    ;copy
        ret
;
;----------------------------------------------------------------------
; WI_get_BPB	- Loads WINI_BPB from a header sector whose address
;		is given by WID_mem_seg:WID_mem_off ( these addresses should
;		be valid since the driver does not change addresses if
;		only one sector has been loaded)
;

WI_get_BPB
;*	LEA	DI,WINI_BPB1		;POINT AT BPB FOR FIRST DRIVE
;*	CMPB	WID_UNIT,#01H		;SECOND DRIVE?
;*	JNE	WI_GET_BPB1		;NO - SKIP
;*	LEA	DI,WINI_BPB2		;POINT AT BPB FOR SECOND DRIVE

	MOV	DI,WID_UNIT		;** GET UNIT NUMBER
	SHL	DI,#1			;** INDEX INTO TABLE
	MOV	DI,winit_table[DI]	;**

WI_GET_BPB1
	push	ds			;save ds
	lds	si,WID_mem_off		;get seg:off of header in ds:si 
	add	si,#BPB_offset		;point to BPB within header
	mov	cx,#8			;8 words (16 bytes)
	cld
	rep	movw			;copy
	SUB	SI,#(BPB_offset+16-DTAB_offset)	;point at new data area
	mov	cx,#7			;7 words (14 bytes)
	rep	movw			;copy
	pop	ds
	ret
;
;----------------------------------------------------------------------
; WI_set_mas - sets buffer master latch to 'al', & pulses pointer reset
;
WI_set_mas
;**	movw    DX,#WIP_l_bmst          ;point at master port
	movw	dx,WIP_l_bmst		;** point at master port
        out     dx,al                   ;send al to it
        decw    dx
        decw    dx                      ;point at buffer reset port
        movb    al,#1
        out     dx,al                   ;pulse 1 -> 0
        movb    al,#0
        out     dx,al
        ret
;
;----------------------------------------------------------------------
;** WINI_SELECT - SELECTS DRIVE GIVEN BY WID_UNIT
;   WINI_SELECT - SELECTS DRIVE GIVEN BY WID_DRIVE
;	SETS UP DRIVE SELECT IN WID_SDH AND CHANGES SELECT LATCHES
;
WINI_SELECT
	movw	WID_timeout,#25
WINI_SEL_LP
;**	IN	AL,#WIP_STAT		;GET WD1010 STATUS
	push	dx			;**
	mov	dx,WIP_STAT		;** GET WD1010 status
	in	al,dx			;**
	pop	dx			;**
	TEST	AL,#(WIS_BUSY ! WIS_CIP)	;BUSY OR COMMAND IN PROGRESS?
	JZ	WINI_SEL0		;no
	cmpw	WID_timeout,#0
	jnz	WINI_SEL_LP
	mov	ax,#MSE_failure
	ret

WINI_SEL0
;**	MOV	AX,WID_UNIT		;GET REQUESTED UNIT
	MOV	AX,WID_DRIVE		;** GET REQUESTED DRIVE
;****	MOV	AX,WID_UNIT		;** GET REQUESTED DRIVE
;****	CMPW	AX,WID_SELECTED		;ALREADY SELECTED?
;****	JE	WINI_SEL_X		;YES - DONE
;****	MOV	WID_SELECTED,AX		;SAY NEW DRIVE ON THE WAY
	ANDB	WID_SDH,#11100111B	;SET SELECT TO DRIVE 1
	CMPB	AL,#1			;DRIVE 2 REQUESTED?
	JE	WINI_SEL1		;YES - SELECT IT
;**	MOV	DX,#WIP_L_DS2		;POINT AT DRIVE 2 SELECT
	mov	dx,WIP_L_DS2		;** POINT AT DRIVE 2 SELECT
	XOR	AX,AX
	OUT	DX,AL			;DESELECT DRIVE 2
	INC	AX
;**	MOV	DX,#WIP_L_DS1		;AND SELECT DRIVE 1
	mov	dx,WIP_L_DS1		;** AND SELECT DRIVE 1
	OUT	DX,AL
;*	mov	ax,WID_WRPRE1		;get write precomp cyl for drive 1
	jmpsh	WINI_SELW		;set up write precomp value
;
WINI_SEL1
	ORB	WID_SDH,#00001000B	;SELECT DRIVE 2
;**	MOV	DX,#WIP_L_DS1		;POINT AT DRIVE 1 SELECT
	MOV	DX,WIP_L_DS1		;** POINT AT DRIVE 1 SELECT
	XOR	AX,AX
	OUT	DX,AL			;DESELECT DRIVE 1
	INC	AX
;**	MOV	DX,#WIP_L_DS2		;AND SELECT DRIVE 2
	MOV	DX,WIP_L_DS2		;** AND SELECT DRIVE 2
	OUT	DX,AL
;*	mov	ax,WID_WRPRE2		;get write precomp cylinder for drive
WINI_SELW
	MOV	BX,WID_UNIT		;* Get BPB pointer
	SHL	BX,#1			;*
	MOV	BX,WINIT_table [BX]	;*
	MOV	AX,18H[BX]		;*

	CMPW	AX,#0			;NO PRECOMP?
	JNE	WINI_SELW0		;YES THERE IS
	NOT	AX			;SET AX TO 0FFFFH
	JMPSH	WINI_SELW1		;AND SKIP
WINI_SELW0
	DEC	AX			;ADJUST FOR BASE 1
	shr	ax,#1			;/2
	shr	ax,#1			;/4
WINI_SELW1
	movb	WID_wpre,al		;set up write precomp for drive	
WINI_SEL_X
	xor	ax,ax
	RET
	;

;***********************************************************************

SEL_BOARD
	MOV	AX,WID_unit		;** Unit 0,1,2 etc
	CMP	AL,B_WIN0_NUM		;** On board 0 ?
	MOV	WID_drive,ax		;**
	JB	SEL_BOARD_0		;**
	SUB	AL,B_WIN0_NUM		;** drive on board 2
	MOV	WID_drive,AX		;**
	JMP	SEL_BOARD_1		;**

SEL_BOARD_0				;**
	PUSH	SI			;**
	MOVW	SI,WID0_buffsize	;**
	MOVW	WID_buffsize,SI		;**
	LEA	SI,WIP_board0		;** copy port address
	JMP	BOARD_SEL		;**
SEL_BOARD_1				;**
	PUSH	SI			;**
	MOVW	SI,WID1_buffsize	;**
	MOVW	WID_buffsize,SI		;**
	LEA	SI,WIP_board1		;**

BOARD_SEL
	PUSH	DI
	PUSH	CX
	LEA	DI,WIP_active		;**
	MOV	CX,#18			;**
	CLD				;**
	rep	movw			;**
	POP	CX			;**
	POP	DI			;**
	POP	SI			;**
	RET				;**

        end
 
$ 