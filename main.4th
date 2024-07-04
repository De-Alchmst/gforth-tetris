require random.fs

require raylib.4th
require pices.4th
require game.4th
require pice-choice.4th
require draw.4th
require io.4th

\ \ \ \ \ \ \ \ \ \
\ INITIALIZE STUFF \
\ \ \ \ \ \ \ \ \ \ \
: init ( -- )
  WINDOW-WIDTH WINDOW-HEIGHT s" tetris clone in gforth" rl:init-window
  60 rl:set-target-fps
  RIGHT set-pice-J
  random-next-pice
  next-pice
;

\ \ \ \ \ \ \ \
\ MAIN LOOPING \
\ \ \ \ \ \ \ \ \
: main ( -- )
  begin

    rl:window-should-close End? or
    if
      bye
    else
      read-keys
      game-update
      draw
    then

  again
;

\ \ \ \ \ \ \ \ \ \
\ call upon start \
\ \ \ \ \ \ \ \ \ \

init main
