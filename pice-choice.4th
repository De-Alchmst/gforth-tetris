0 constant I-PICE
1 constant J-PICE
2 constant L-PICE
3 constant T-PICE
4 constant O-PICE
5 constant S-PICE
6 constant Z-PICE

0 value Next-pice-shape

variable Next-pice-buffer 16 allot \ 4 * 4 chars

: random-next-pice ( -- )
  7 random to Next-pice-shape ;

: next-pice ( -- )
  \ set word to update with
  Next-pice-shape case
    I-PICE of ['] set-pice-I endof
    J-PICE of ['] set-pice-J endof
    L-PICE of ['] set-pice-L endof
    T-PICE of ['] set-pice-T endof
    O-PICE of ['] set-pice-O endof
    S-PICE of ['] set-pice-S endof
    Z-PICE of ['] set-pice-Z endof
  endcase
  to Pice-set-word

  \ reset variables
  UP-ROT to Pice-rotation
  0 to Pice-Y

  \ to get width and offset
  UP-ROT Pice-set-word execute

  COLS Pice-width - Pice-off-X - 2/ to Pice-X
  
  random-next-pice
;
