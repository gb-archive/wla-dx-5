
;������������������������������������������������������������������������������
; a small test for wla-68000
;������������������������������������������������������������������������������

        .MEMORYMAP
          DEFAULTSLOT 0
          ; ROM area
          SLOTSIZE    $400000
          SLOT        0       $000000
          ; RAM area
          SLOTSIZE    $10000
          SLOT        1       $FF0000
        .ENDME

        .ROMBANKMAP
          BANKSTOTAL 1
          BANKSIZE $400000
          BANKS 1
        .ENDRO

        .EMPTYFILL $AA

        .SMDHEADER
          SYSTEMTYPE "SEGA MEGA DRIVE "    ; 16 bytes
          COPYRIGHT  "                "    ; 16 bytes
          TITLEDOMESTIC "             "    ; 48 bytes (all spaces)
          TITLEOVERSEAS "             "    ; 48 bytes (all spaces)
          SERIALNUMBER  "             "    ; 14 bytes (all spaces)
          DEVICESUPPORT "J            "    ; 16 bytes (all spaces)
          ROMADDRESSRANGE $0, -1           ;  8 bytes (-1 is turned into ROM size minus one)
          RAMADDRESSRANGE $FF0000, $FFFFFF ;  8 bytes
          EXTRAMEMORY "RA", $A0, $20, 0, 0 ; 12 bytes (S and E and start and end, both 0)
          MODEMSUPPORT "            "      ; 12 bytes (all spaces)
          REGIONSUPPORT "JUE"              ;  3 bytes
        .ENDSMD

        .BANK 0 SLOT 0
        .ORG 0

        ; @BT linked.rom

        .db "01>"               ; @BT TEST-01 01 START
        // 3
        .align 8                ; @BT AA AA AA AA AA
        // 8
        .db 0                   ; @BT 00
        // 9
        .align 2                ; @BT AA
        // 10
        .db 0, 1, 2, 3, 4, 5    ; @BT 00 01 02 03 04 05
        // 16
        .align 4
        // 16
        .db 4, 5, 6, 7          ; @BT 04 05 06 07
        // 20
        
        .section "ForceSection" FORCE
        .align 16               ; @BT AA AA AA AA AA AA AA AA AA AA AA AA
        // 32
        .db 0, 1, 2             ; @BT 00 01 02
        // 35
        .ends

        .db "<01"               ; @BT END

        .section "Align4-A" ALIGN 4 RETURNORG
        .db "02>"               ; @BT TEST-02 02 START
        // 3
        .align 4                ; @BT AA
        // 4
        .db 0                   ; @BT 00
        // 5
        .align 4                ; @BT AA AA AA
        // 8
        .db 1, 2                ; @BT 01 02
        .db "<02"               ; @BT END
        .ends

        .section "Align4-B" ALIGN 4
        .db "03>"               ; @BT TEST-03 03 START
        // 3
        .align 4                ; @BT AA
        // 4
        .db 0                   ; @BT 00
        // 5
        .align 4                ; @BT AA AA AA
        // 8
        .db 1, 2                ; @BT 01 02
        .db "<03"               ; @BT END
        .ends

        .ORG $201

        .db "04>"               ; @BT TEST-04 04 START
        // 4
        .align 8                ; @BT AA AA AA AA
        // 8
        .db 0                   ; @BT 00
        // 9
        .align 2                ; @BT AA
        // 10
        .db 0, 1, 2, 3, 4, 5    ; @BT 00 01 02 03 04 05
        // 16
        .align 4
        // 16
        .db 4, 5, 6, 7          ; @BT 04 05 06 07
        // 20
        .db "<04"