
        ///////////////////////////////////////////////////////////////////////
        // Testing .INCBIN with FILTER and FILTERSIZE
        ///////////////////////////////////////////////////////////////////////
        
        .gbheader
          version $0f
          version 15
          countrycode 1
          ramsize 2
          cartridgetype 7
          name "HELLO WORLD"
          version $0f
          licenseecodenew "FI"
          ramsize $2
          countrycode 1
          name "HELLO WORLD"
          destinationcode 1
          cartridgetype $7
          licenseecodenew "FI"
          ramsize 2
          countrycode $1
          destinationcode $1
        .endgb
        
        .MEMORYMAP
          DEFAULTSLOT 1.01
          SLOT 0.001 $0000 $2000
          SLOT 1.2 STArT $2000 sIzE $6000
        .ENDME

        .ROMBANKMAP
          BANKSTOTAL 2
          BANKSIZE $2000
          BANKS 1
          BANKSIZE $6000
          BANKS 1
        .ENDRO

        ; @BT linked.gb

        .macro FILTER4
          .assert NARGS == 3 && \3 == 4
          .redefine _out \1
        .endm
        .macro FILTER4PLUS1
          .assert NARGS == 3 && \3 == 4
          .redefine _out \1 + 1
        .endm

        .macro FILTER3
          .assert NARGS == 3 && \3 == 3
          .redefine _out \1
        .endm
        .macro FILTER3PLUS1
          .assert NARGS == 3 && \3 == 3
          .redefine _out \1 + 1
        .endm

        .macro FILTER2
          .assert NARGS == 3 && \3 == 2
          .redefine _out \1
        .endm
        .macro FILTER2PLUS1
          .assert NARGS == 3 && \3 == 2
          .redefine _out \1 + 1
        .endm
        
        .db "01>"               ; @BT TEST-01 01 START
        .incbin "data4.bin" filter FILTER4 filtersize 4
                                ; @BT 31 32 33 34
                                ; @BT 35 36 37 38
                                ; @BT 61 62 63 64
        .incbin "data4.bin" filter FILTER4PLUS1 filtersize 4
                                ; @BT 32 32 33 34
                                ; @BT 36 36 37 38
                                ; @BT 62 62 63 64
        .incbin "data4.bin" filter FILTER4 filtersize 4 swap
                                ; @BT 34 33 32 31
                                ; @BT 38 37 36 35
                                ; @BT 64 63 62 61
        .incbin "data4.bin" filter FILTER4PLUS1 filtersize 4 swap
                                ; @BT 35 33 32 31
                                ; @BT 39 37 36 35
                                ; @BT 65 63 62 61
        .db "<01"               ; @BT END
        
        .db "02>"               ; @BT TEST-02 02 START
        .incbin "data3.bin" filter FILTER3 filtersize 3
                                ; @BT 31 32 33
                                ; @BT 34 35 36
                                ; @BT 61 62 63
        .incbin "data3.bin" filter FILTER3PLUS1 filtersize 3
                                ; @BT 32 32 33
                                ; @BT 35 35 36
                                ; @BT 62 62 63
        .incbin "data3.bin" filter FILTER3 filtersize 3 swap
                                ; @BT 33 32 31
                                ; @BT 36 35 34
                                ; @BT 63 62 61
        .incbin "data3.bin" filter FILTER3PLUS1 filtersize 3 swap
                                ; @BT 34 32 31
                                ; @BT 37 35 34
                                ; @BT 64 62 61
        .db "<02"               ; @BT END

        .db "03>"               ; @BT TEST-03 03 START
        .incbin "data4.bin" filter FILTER2 filtersize 2
                                ; @BT 31 32
                                ; @BT 33 34
                                ; @BT 35 36
                                ; @BT 37 38
                                ; @BT 61 62
                                ; @BT 63 64
        .incbin "data4.bin" filter FILTER2PLUS1 filtersize 2
                                ; @BT 32 32
                                ; @BT 34 34
                                ; @BT 36 36
                                ; @BT 38 38
                                ; @BT 62 62
                                ; @BT 64 64
        .incbin "data4.bin" filter FILTER2 filtersize 2 swap
                                ; @BT 32 31
                                ; @BT 34 33
                                ; @BT 36 35
                                ; @BT 38 37
                                ; @BT 62 61
                                ; @BT 64 63
        .incbin "data4.bin" filter FILTER2PLUS1 filtersize 2 swap
                                ; @BT 33 31
                                ; @BT 35 33
                                ; @BT 37 35
                                ; @BT 39 37
                                ; @BT 63 61
                                ; @BT 65 63
        .db "<03"               ; @BT END
       
        .db "04>"               ; @BT TEST-04 04 START
        .incbin "data4.bin" filter FILTER2 filtersize 2 skip 2 read 4
                                ; @BT 33 34
                                ; @BT 35 36
        .incbin "data4.bin" filter FILTER2 filtersize 2 skip 2 read 4 swap
                                ; @BT 34 33
                                ; @BT 36 35
        .incbin "data4.bin" filter FILTER2 filtersize 2 skip 1 read 4
                                ; @BT 32 33
                                ; @BT 34 35
        .incbin "data4.bin" filter FILTER2 filtersize 2 skip 1 read 4 swap
                                ; @BT 33 32
                                ; @BT 35 34
        .incbin "data4.bin" filter FILTER2PLUS1 filtersize 2 skip 2 read 4
                                ; @BT 34 34
                                ; @BT 36 36
        .incbin "data4.bin" filter FILTER2PLUS1 filtersize 2 skip 2 read 4 swap
                                ; @BT 35 33
                                ; @BT 37 35
        .incbin "data4.bin" filter FILTER2PLUS1 filtersize 2 skip 1 read 4
                                ; @BT 33 33
                                ; @BT 35 35
        .incbin "data4.bin" filter FILTER2PLUS1 filtersize 2 skip 1 read 4 swap
                                ; @BT 34 32
                                ; @BT 36 34
        .incbin "data4.bin" filter FILTER3PLUS1 filtersize 3 skip 1 read 6
                                ; @BT 33 33 34
                                ; @BT 36 36 37
        .incbin "data4.bin" filter FILTER3PLUS1 filtersize 3 skip 1 read 6 swap
                                ; @BT 35 33 32
                                ; @BT 38 36 35
        .db "<04"               ; @BT END

        .db "05>"               ; @BT TEST-05 05 START
        .incbin "250-255.bin" filter FILTER2 filtersize 2 read 4
                                ; @BT FE FF
                                ; @BT FA FE
        .incbin "250-255.bin" filter FILTER3 filtersize 3 read 6
                                ; @BT FE FF FA
                                ; @BT FE FD FE
        .incbin "250-255.bin" filter FILTER4 filtersize 4 read 8
                                ; @BT FE FF FA FE
                                ; @BT FD FE FC FA
        .db "<05"               ; @BT END
