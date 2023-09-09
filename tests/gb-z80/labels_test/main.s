
; testing label value calculation in wla-gb (the assembler, not the linker)

.MEMORYMAP
DEFAULTSLOT 1
SLOT 0 $0000 $2000
SLOT 1 STArT $2000 sIzE $2000
SLOT 2 START $8000 SIZE $2000
.ENDME

.ROMBANKMAP
BANKSTOTAL 3
BANKSIZE $2000
BANKS 3
.ENDRO

.EMPTYFILL $ff
        
.BANK 1 SLOT 1
.ORG 0

; @BT linked.gb

start:  nop
        or a,a
        pop af
        ld sp,startend

        .define POSTPONED_TO_LINKER = startend+1
        .define POSTPONED_TO_LINKER2 = FORCE_start+1
        .define POSTPONED_TO_LINKER3 = POSTPONED_TO_LINKER2+$2000
        
startend:
        
        .db "00>"                ; @BT TEST-00 00 START
        .dw POSTPONED_TO_LINKER  ; @BT 07 20
        .db :POSTPONED_TO_LINKER ; @BT 01
        .db bank(POSTPONED_TO_LINKER) ; @BT 01
        .db "<00"                ; @BT END
        
        .db "01>"               ; @BT TEST-01 01 START
        .db :startend + 1       ; @BT 02
        .db "<01"               ; @BT END

        .assert startend == $2006
        .assert startend - 1 == $2005
        .assert startend - start == 6
        .assert startend - 1 - start == 5

        .section "FORCE" force slot 2 org $101
FORCE_start:
        .db "02>"               ; @BT TEST-02 02 START
        .db :POSTPONED_TO_LINKER2 ; @BT 01
        .db :POSTPONED_TO_LINKER3 ; @BT 02
        .db POSTPONED_TO_LINKER2 & 0 ; @BT 00
        .db POSTPONED_TO_LINKER3 & 0 ; @BT 00
        .db "<02"                 ; @BT END
        .ends

        .assert FORCE_start == $8101

        .section "OVERWRITE" overwrite slot 1 org $200
OVERWRITE_start:
        .db 1
        .ends

        .assert OVERWRITE_start == $2200
        