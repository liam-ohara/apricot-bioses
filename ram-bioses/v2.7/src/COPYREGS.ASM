
;*********************************************************************$ TYPE copyregs.asm
; [bios.apricot.rom]copyregs.asm
        title '[bios.apricot.rom]copyregs.asm'

        Include 'legal.asi'

;***************************************************************************
;*                                                                         *
;*                         C O P Y__R E G S                                *
;*                                                                         *
;*      This file allocates the memory locations used as copies of         *
;*      the more important write-only I/O registers.                       *
;*                                                                         *
;*                                                                         *
;*      FILENAME:       [bios.apricot.rom]copyregs.asm                      *
;*      PROGRAMMER:     R. J. WOOLCOCK.                                    *
;*      IMPLEMENTED:    28-MAR-84                                          *
;*      MODIFIED:       VAX version 2/5/84 GK                              *
;*                                                                         *
;***************************************************************************
  page





;***************************************************************************
;*                                                                         *
;*      FILE  COPY_REGS.ASM                                                *
;*      ====================                                               *
;*                                                                         *
;*      Certain I/O registers within the system are write only. This       *
;*      causes problems when more than one program wishes to  update       *
;*      individual bits within a register.  To overcome this problem       *
;*      a  copy is kept  of all the  important I/O register contents;      * 
;*      it is  these  registers  that  are  defined in  this  module.      *
;*                                                                         *
;*      The  module  `copy_regs.asmi'  contains  all  the  necessary       * 
;*      global statements.                                                 *
;*                                                                         *
;*      To update an I/O register, for which there is a copy, first        *
;*      update the copy then output the copy to the I/O.                   *
;*                                                                         *
;*                                                                         *
;*                                                                         *
;***************************************************************************
  page
        name copy_regs


        Global  CodeBaseQQ,DataBaseQQ           ;set during link

        Assume  ds:DataBaseQQ, cs:CodeBaseQQ
        section write_regs.data,align(2),class=dataQQ

        include 'copyregs.asi'

	Global	COPY_BASE

;***************************************************************************
;************************   COPY OF SIO REGISTERS  *************************
;***************************************************************************

;Base of copy table - given by low RAM pointer at 722h
;
COPY_BASE

; SIDE A

COPY_SIO_W1A    BLOCK   1       ;copy of SIO write register 1
COPY_SIO_W3A    BLOCK   1       ;copy of SIO write register 3
COPY_SIO_W4A    BLOCK   1       ;copy of SIO write register 4
COPY_SIO_W5A    BLOCK   1       ;copy of SIO write register 5

; SIDE B

COPY_SIO_W1B    BLOCK   1       ;copy of SIO write register 1
COPY_SIO_W3B    BLOCK   1       ;copy of SIO write register 3
COPY_SIO_W4B    BLOCK   1       ;copy of SIO write register 4
COPY_SIO_W5B    BLOCK   1       ;copy of SIO write register 5

                End

$ 