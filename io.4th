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
        LEFT move-pice
      endof
      KEY-L of
        RIGHT move-pice
      endof
    endcase
  repeat
  drop
;
