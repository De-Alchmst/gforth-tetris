10 constant COLS
20 constant ROWS

variable Game-field COLS ROWS * allot

: pice-to-field-ind ( n -- n )
  dup 4 mod Pice-X +
  swap 4 / Pice-Y + COLS * +
  Game-field +
;

: downshift-field ( n -- ) \ index of beginning of removed line
  -1 swap ?do
    Game-field i + c@
    Game-field i + COLS + c!
  1 -loop

  \ clear top line
  COLS 0 ?do 0 Game-field i + c! loop
;

: remove-lines ( -- )
  ROWS 0 ?do
    i COLS *
    -1
    COLS 0 ?do
      \ leave if 0
      over i + Game-field + c@
      0= if
        drop 0 leave
      then
    loop

    if downshift-field else drop then
      
  loop
;

: add-current-pice ( -- )
  16 0 ?do
    Pice-buffer i + c@

    dup if
      \ transform to position in Game-field
      i pice-to-field-ind c!
    else
      drop
    then
  loop

  remove-lines
;
