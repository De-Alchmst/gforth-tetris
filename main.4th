require raylib.4th
require pices.4th
require game.4th
require draw.4th
require io.4th

\ \ \ \ \ \ \ \ \ \
\ INITIALIZE STUFF \
\ \ \ \ \ \ \ \ \ \ \
: init ( -- )
  WINDOW-WIDTH WINDOW-HEIGHT s" tetris clone in gforth" rl:init-window
  60 rl:set-target-fps
  RIGHT set-pice-J
;

\ \ \ \ \ \ \ \
\ MAIN LOOPING \
\ \ \ \ \ \ \ \ \
: main ( -- )
  begin
    -1
  while

    rl:window-should-close End? or if
      bye
    else
      read-keys
      draw
    then

  repeat
;

\ \ \ \ \ \ \ \ \ \
\ call upon start \
\ \ \ \ \ \ \ \ \ \

init main
