: reset-game ( -- )
  reset-pice-count
  clear-field
  reset-next-pice
  PLAYING to Game-mode
;

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

      KEY-R of
        reset-game
      endof

      KEY-M of
        reset-game
        MENU to Game-mode
      endof
    endcase
  repeat
  drop
; 

: read-keys-menu ( -- )
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

      \ select \
      KEY-ENTER of
        menu-select
      endof

      \ move selection \
      dup KEY-J = over KEY-DOWN = or ?of
        drop
        menu-next
      endof

      dup KEY-K = over KEY-UP = or ?of
        drop
        menu-prev
      endof

      \ select-sideways \
      dup KEY-H = over KEY-LEFT = or ?of
        drop
        LEFT menu-sideways
      endof

      dup KEY-L = over KEY-RIGHT = or ?of
        drop
        RIGHT menu-sideways
      endof
    endcase
  repeat
  drop
;
