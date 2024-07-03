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
    endcase
  repeat
  drop
;
