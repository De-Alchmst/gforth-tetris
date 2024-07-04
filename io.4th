0 value End?

: read-keys ( -- )
  begin
    \ read through all qued keys (0 on end)
    rl:get-key-pressed
    dup
  while
    case
      \ exit \
      KEY-Q of
        -1 to End?
      endof

      \ pice movement \
      KEY-J of
        LEFT move-pice-sideways
      endof
      KEY-L of
        RIGHT move-pice-sideways
      endof

      \ rotation \
      KEY-K of
        RIGHT rotate-pice
      endof

      KEY-D of
        move-pice-down
      endof
    endcase
  repeat
  drop
;
