0 value End?

: read-keys-play ( -- )
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

      \ drop \
      KEY-SPACE of
        drop-pice
      endof

      \ debug \
      KEY-E of
        GAME-OVER to Game-mode
      endof
    endcase
  repeat
  drop
;

: read-keys-game-over ( -- )
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
