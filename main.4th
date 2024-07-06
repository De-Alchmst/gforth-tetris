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
require pice-preview.4th
require draw.4th
require io.4th \ <- game-reset is here

\ \ \ \ \ \ \ \ \ \
\ INITIALIZE STUFF \
\ \ \ \ \ \ \ \ \ \ \
0.3e fvalue Max-countdown

: init ( -- )
  60 rl:set-target-fps
  reset-next-pice
;

\ \ \ \ \ \ \
\ GAME STUFF \
\ \ \ \ \ \ \ \
: handle-play ( r -- r ) \ timer
  \ don't update keys during animation
  fdup 0e f> if read-keys-play then

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

: handle-game-over ( n -- n ) \ timer
  read-keys-game-over
  draw-game-over

  fdrop 0e \ keep timer at 0
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
