\ \ \ \ \
\ SETUP \
\ \ \ \ \

720 constant WINDOW-HEIGHT
1024 constant WINDOW-WIDTH

30 constant TILE-SIZE
WHITE constant BG-COLOR
GRAY constant FG-COLOR

\ setup rectangles \
create Field-rect rectangle% allot

TILE-SIZE COLS * 20 + s>f Field-rect rectangle-width sf!
TILE-SIZE ROWS * 20 + s>f Field-rect rectangle-height sf!

WINDOW-WIDTH Field-rect rectangle-width sf@ f>s - 2/ constant FIELD-OFFSET-X
FIELD-OFFSET-X 10 - s>f Field-rect rectangle-x sf!
WINDOW-HEIGHT Field-rect rectangle-height sf@ f>s - 2/ constant FIELD-OFFSET-Y
FIELD-OFFSET-Y 10 - s>f Field-rect rectangle-y sf!

255 203 0 255 >Color constant Beam-color
TILE-SIZE 2 / constant BEAM-WIDTH
TILE-SIZE BEAM-WIDTH - 2/ constant BEAM-OFFSET

\ \ \ \ \ \
\ DRAWING \
\ \ \ \ \ \

: draw-bg ( -- )
  BG-COLOR rl:clear-background
;

: draw-block ( n x y -- )
  \ positions
  TILE-SIZE * FIELD-OFFSET-Y +
  swap
  TILE-SIZE * FIELD-OFFSET-X +
  swap
  rot
  TILE-SIZE TILE-SIZE
  rot

  \ color
  case
    0 of
      FG-COLOR rl:draw-rectangle-lines
      exit
    endof

    1 of RED endof
    2 of YELLOW endof
    3 of PURPLE endof
    4 of PINK endof
    5 of SKYBLUE endof
    6 of GREEN endof
    7 of BLUE endof
  endcase

  rl:draw-rectangle
;

: draw-field ( -- )
  \ border
  Field-rect 10e FG-COLOR rl:draw-rectangle-lines-ex

  \ contents
  COLS ROWS * 0 ?do
    Game-field i + c@
    i COLS mod
    i COLS /
    draw-block
  loop
;

: draw-active-pice ( -- )
  16 0 ?do
    Pice-buffer i + c@
    dup if 
      i 4 mod Pice-X +
      i 4 / Pice-Y +
      draw-block
    else
      drop
    then
  loop
;

: break-anim ( -- )
  0
  rows-to-break-row TILE-SIZE * FIELD-OFFSET-Y + BEAM-OFFSET +
  WINDOW-WIDTH BEAM-WIDTH Beam-color
  rl:draw-rectangle

  Beam-color color-a c@
  \ lower alpha
  dup 5 > if
    15 - Beam-color color-a c!
  \ finish animation
  else
    drop 255 Beam-color color-a c!
    rows-to-break-shift downshift-field
  then
;

\ call the all the stuff \
: draw ( -- f ) \ if animation
  rl:begin-drawing
  draw-bg
  draw-field
  \ break animation
  rows-to-break-len
  dup if break-anim then
  draw-active-pice
  rl:end-drawing
;
