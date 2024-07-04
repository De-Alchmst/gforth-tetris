0 value Pice-X
0 value Pice-Y
0 value Pice-width
0 value Pice-height
0 value Pice-off-X

: pice-size! ( offx x y -- )
  to Pice-height
  to Pice-width
  to Pice-off-X
;

\ word used to set the pice to buffer
0 value Pice-set-word

0 value Pice-rotation
0 constant UP
1 constant RIGHT
2 constant DOWN
3 constant LEFT

: rotate-pice ( -- )
  Pice-rotation 1-
  dup 0< if drop 3 then
  to Pice-rotation
;


variable Pice-buffer 16 allot \ 4 * 4 chars
: clear-pice-buffer ( -- )
  14 0 ?do
    0 Pice-buffer i + c!
  loop
;

: pice-buffer! ( n n n n cl -- )
  clear-pice-buffer
  4 0 ?do
    dup rot Pice-buffer + c!
  loop
  drop
;

\ \ \ \ \ \ \ \ \ \
\ DIFFERENT PICES \
\ \ \ \ \ \ \ \ \ \

: set-pice-I ( n -- ) \ rot
  dup UP = swap DOWN = or
  if
    \ 0 1 0 0
    \ 0 1 0 0
    \ 0 1 0 0
    \ 0 1 0 0
    1 2 4 pice-size!
    1 5 9 13 1 pice-buffer!
  else
    \ 0 0 0 0
    \ 1 1 1 1
    \ 0 0 0 0
    \ 0 0 0 0
    0 4 2 pice-size!
    4 5 6 7 1 pice-buffer!
  then
;

: set-pice-J ( n -- )
  case
    UP of
      \ 0 2 0 0
      \ 0 2 0 0
      \ 2 2 0 0
      \ 0 0 0 0
      0 2 3 pice-size!
      1 5 8 9 2 pice-buffer!
    endof

    RIGHT of
      \ 0 0 0 0
      \ 2 2 2 0
      \ 0 0 2 0
      \ 0 0 0 0
      0 3 3 pice-size!
      4 5 6 10 2 pice-buffer!
    endof

    DOWN of
      \ 0 2 2 0
      \ 0 2 0 0
      \ 0 2 0 0
      \ 0 0 0 0
      1 3 3 pice-size!
      1 2 5 9 2 pice-buffer!
    endof

    LEFT of
      \ 2 0 0 0
      \ 2 2 2 0
      \ 0 0 0 0
      \ 0 0 0 0
      0 3 2 pice-size!
      0 4 5 6 2 pice-buffer!
    endof
  endcase
;

: set-pice-L ( n -- )
  case
    UP of
      \ 0 3 0 0
      \ 0 3 0 0
      \ 0 3 3 0
      \ 0 0 0 0
      1 3 3 pice-size!
      1 5 9 10 3 pice-buffer!
    endof

    RIGHT of
      \ 0 0 3 0
      \ 3 3 3 0
      \ 0 0 0 0
      \ 0 0 0 0
      0 3 2 pice-size!
      2 4 5 6 3 pice-buffer!
    endof

    DOWN of
      \ 3 3 0 0
      \ 0 3 0 0
      \ 0 3 0 0
      \ 0 0 0 0
      0 2 3 pice-size!
      0 1 5 9 3 pice-buffer!
    endof

    LEFT of
      \ 0 0 0 0
      \ 3 3 3 0
      \ 3 0 0 0 
      \ 0 0 0 0
      0 3 3 pice-size!
      4 5 6 8 3 pice-buffer!
    endof
  endcase
;

: set-pice-T ( n -- )
  case
    UP of
      \ 0 4 0 0
      \ 4 4 4 0
      \ 0 0 0 0
      \ 0 0 0 0
      0 3 2 pice-size!
      1 4 5 6 4 pice-buffer!
    endof

    RIGHT of
      \ 0 4 0 0
      \ 4 4 0 0
      \ 0 4 0 0
      \ 0 0 0 0
      0 2 3 pice-size!
      1 4 5 9 4 pice-buffer!
    endof

    DOWN of
      \ 0 0 0 0
      \ 4 4 4 0
      \ 0 4 0 0
      \ 0 0 0 0
      0 3 3 pice-size!
      4 5 6 9 4 pice-buffer!
    endof

    LEFT of
      \ 0 4 0 0
      \ 0 4 4 0
      \ 0 4 0 0
      \ 0 0 0 0
      1 3 3 pice-size!
      1 5 6 9 4 pice-buffer!
    endof
  endcase
;

: set-pice-O ( n -- )
  \ 5 5 0 0
  \ 5 5 0 0
  \ 0 0 0 0
  \ 0 0 0 0
  0 2 2 pice-size!
  0 1 4 5 5 pice-buffer!
;

: set-pice-S ( n -- )
  dup UP = swap DOWN = or
  if
    \ 6 0 0 0
    \ 6 6 0 0
    \ 0 6 0 0
    \ 0 0 0 0
    0 2 3 pice-size!
    0 4 5 9 6 pice-buffer!
  else
    \ 0 6 6 0
    \ 6 6 0 0
    \ 0 0 0 0
    \ 0 0 0 0
    0 3 2 pice-size!
    1 2 4 5 6 pice-buffer!
  then
;

: set-pice-Z ( n -- )
  dup UP = swap DOWN = or
  if
    \ 0 7 0 0
    \ 7 7 0 0
    \ 7 0 0 0
    \ 0 0 0 0
    0 2 3 pice-size!
    1 4 5 8 7 pice-buffer!
  else
    \ 7 7 0 0
    \ 0 7 7 0
    \ 0 0 0 0
    \ 0 0 0 0
    0 3 2 pice-size!
    0 1 5 6 7 pice-buffer!
  then
;
