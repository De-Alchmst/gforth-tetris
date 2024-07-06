require random.fs


require raylib.4th
\ some stuff needs to run after rl:init-window \
  720 constant WINDOW-HEIGHT
  1024 constant WINDOW-WIDTH
  WINDOW-WIDTH WINDOW-HEIGHT s" tetris clone in gforth" rl:init-window

require pice-handle.4th
require pices.4th
require field.4th
require game.4th
require pice-choice.4th
require draw.4th
require io.4th

0.3e fvalue Max-countdown

\ \ \ \ \ \ \ \ \ \
\ INITIALIZE STUFF \
\ \ \ \ \ \ \ \ \ \ \
: init ( -- )
  60 rl:set-target-fps
  RIGHT set-pice-J
  random-next-pice
  next-pice
;

: handle-play ( r -- r ) \ timer
  read-keys-play

  \ count the down
  rl:get-frame-time f+
  fdup Max-countdown f>
  if
    fdrop 0e
    game-update
    if
      \ go to the next pice
      add-current-pice next-pice
      \ if no space for new pice
      collision? if GAME-OVER to Game-mode then
    then
  then

  \ if animation playing
  draw-game if fdrop 0e then
;

: handle-game-over ( -- )
  read-keys-game-over
  draw-game-over
;

: handle-menu ( -- )
;

\ \ \ \ \ \ \ \
\ MAIN LOOPING \
\ \ \ \ \ \ \ \ \
: main ( -- )
  0e \ countdown
  begin
    rl:window-should-close End? or
    if bye then

    Game-mode case
      MENU of handle-menu endof
      PLAYING of handle-play endof
      GAME-OVER of handle-game-over endof
    endcase
  again
;

\ \ \ \ \ \ \ \ \ \
\ call upon start \
\ \ \ \ \ \ \ \ \ \

init main
