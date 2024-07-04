require random.fs

require raylib.4th
require pices.4th
require game.4th
require pice-choice.4th
require draw.4th
require io.4th

0.1e fvalue Max-countdown

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
  0e \ countdown
  begin
    rl:window-should-close End? or
    if bye then
    read-keys

    \ count the down
    rl:get-frame-time f+
    \ fdup f>s Max-countdown mod invert
    fdup Max-countdown f>
    if
      fdrop 0e
      game-update if next-pice then
    then

    draw
  again
;

\ \ \ \ \ \ \ \ \ \
\ call upon start \
\ \ \ \ \ \ \ \ \ \

init main
