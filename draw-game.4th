\ \ \ \ \
\ SETUP \
\ \ \ \ \
30 constant TILE-SIZE

WHITE value Bg-color
GRAY value Fg-color

RED value I-color
YELLOW value J-color
PURPLE value L-color
PINK value T-color
SKYBLUE value O-color
GREEN value S-color
BLUE value Z-color
RED value Game-over-text-color

0 0 0 200 >color constant DEF-GAME-OVER-RECT-COLOR

\ setup rectangles \
create Field-rect rectangle% allot

TILE-SIZE COLS * 20 + s>f Field-rect rectangle-width sf!
TILE-SIZE ROWS * 20 + s>f Field-rect rectangle-height sf!

WINDOW-WIDTH Field-rect rectangle-width sf@ f>s - 2/ 10 +
constant FIELD-OFFSET-X
WINDOW-HEIGHT Field-rect rectangle-height sf@ f>s - 2/ 10 +
constant FIELD-OFFSET-Y

FIELD-OFFSET-X 10 - s>f Field-rect rectangle-x sf!
FIELD-OFFSET-Y 10 - s>f Field-rect rectangle-y sf!

\ TEXT \
50 constant MAIN-TEXT-SIZE
20 constant SECONDARY-TEXT-SIZE

s\" Game Over" drop constant GAME-OVER-TEXT

WINDOW-WIDTH
GAME-OVER-TEXT MAIN-TEXT-SIZE rl:measure-text
- 2/ constant GAME-OVER-TEXT-X

WINDOW-HEIGHT MAIN-TEXT-SIZE - 2/ constant GAME-OVER-TEXT-Y

s\" J - Left | L - Right | K - Rotate | SPACE - Drop P - Pause\0"
drop constant GAME-HINT-TEXT
WINDOW-WIDTH
GAME-HINT-TEXT SECONDARY-TEXT-SIZE rl:measure-text
- 2/ constant GAME-HINT-X

WINDOW-HEIGHT SECONDARY-TEXT-SIZE - 10 - constant GAME-HINT-Y

create Count-text 2 cells allot

\ other \
255 203 0 255 >Color constant Beam-color
TILE-SIZE 2 / constant BEAM-WIDTH
TILE-SIZE BEAM-WIDTH - 2/ constant BEAM-OFFSET

DEF-GAME-OVER-RECT-COLOR value Game-over-rect-color

\ \ \ \ \ \
\ DRAWING \
\ \ \ \ \ \

: draw-bg ( -- )
  Bg-color rl:clear-background
;

: draw-block-offset ( n x y offX offY -- )
  \ positions
  rot TILE-SIZE * +
  rot TILE-SIZE * rot +
  \ n Y X
  swap rot
  TILE-SIZE TILE-SIZE
  rot
  \ X Y W H n

  \ color
  case
    0 of
      Fg-color rl:draw-rectangle-lines
      exit
    endof

    1 of I-color endof
    2 of J-color endof
    3 of L-color endof
    4 of T-color endof
    5 of O-color endof
    6 of S-color endof
    7 of Z-color endof
  endcase

  rl:draw-rectangle
;

: draw-block-field ( n x y -- )
  FIELD-OFFSET-X FIELD-OFFSET-Y draw-block-offset ;

: draw-field ( -- )
  \ border
  Field-rect 10e Fg-color rl:draw-rectangle-lines-ex

  \ contents
  COLS ROWS * 0 ?do
    Game-field i + c@
    i COLS mod
    i COLS /
    draw-block-field
  loop
;

: draw-active-pice ( -- )
  16 0 ?do
    Pice-buffer i + c@
    dup if 
      i 4 mod Pice-X +
      i 4 / Pice-Y +
      draw-block-field
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

: draw-game-hint ( -- )
  GAME-HINT-TEXT GAME-HINT-X GAME-HINT-Y SECONDARY-TEXT-SIZE
  Fg-color rl:draw-text
;

: draw-pice-buf-pos { a x y -- }
  16 0 ?do
    a i + c@
    dup if
      i 4 mod
      i 4 /
      x y draw-block-offset
    else drop then
  loop
;

: draw-pice-pos ( n x y -- )
  rot pice-to-buf -rot draw-pice-buf-pos
;

: draw-next-pice ( -- )
  s\" Next Pice:\0" drop 10 30 SECONDARY-TEXT-SIZE Fg-color rl:draw-text
  preview-buffer 80 60 draw-pice-buf-pos
;

: count-reset ( -- )
  s\" Count:     \0" Count-text swap move ; \ move ( src dest len -- )

: count-display ( n x y -- )
  count-reset
  rot s>d <# #s #> \ convert number to string
  Count-text 7 + swap move \ copy to buffer
  Count-text -rot SECONDARY-TEXT-SIZE Fg-color rl:draw-text
;

: draw-pice-count ( -- )
  I-PICE 700 50 draw-pice-pos
  I-pice-count 860 85 count-display

  J-PICE 710 100 draw-pice-pos
  J-pice-count 830 150 count-display

  L-PICE 750 190 draw-pice-pos
  L-pice-count 860 225 count-display

  T-PICE 700 260 draw-pice-pos
  T-pice-count 830 300 count-display

  O-PICE 780 350 draw-pice-pos
  O-pice-count 860 370 count-display

  S-PICE 720 420 draw-pice-pos
  S-pice-count 830 440 count-display

  Z-PICE 760 490 draw-pice-pos
  Z-pice-count 860 510 count-display
;

\ call the all the stuff \
: draw-game-insides ( -- f )
  draw-bg
  draw-field
  \ break animation
  rows-to-break-len
  dup if break-anim then
  draw-active-pice

  draw-game-hint
  Show-next? if draw-next-pice then
  draw-pice-count
;

: draw-game ( -- f ) \ if animation
  rl:begin-drawing
  draw-game-insides
  rl:end-drawing
;

: draw-game-over ( -- )
  rl:begin-drawing
  \ dra the lost game
  draw-game-insides drop

  \ draw rect
  0 GAME-OVER-TEXT-Y 10 - WINDOW-WIDTH MAIN-TEXT-SIZE 10 +
  Game-over-rect-color rl:draw-rectangle

  \ draw game over text
  GAME-OVER-TEXT GAME-OVER-TEXT-X GAME-OVER-TEXT-Y MAIN-TEXT-SIZE
  Game-over-text-color rl:draw-text

  \ draw score
  s\" Score : 10000\0" drop 40 400 SECONDARY-TEXT-SIZE Fg-color rl:draw-text

  \ draw hints
  s\" R - Reset\0" drop 40 400 SECONDARY-TEXT-SIZE 10 + +
  SECONDARY-TEXT-SIZE Fg-color rl:draw-text
  s\" M - Menu\0" drop 40 400 SECONDARY-TEXT-SIZE 10 + 2* +
  SECONDARY-TEXT-SIZE Fg-color rl:draw-text
  s\" S - Scores\0" drop 40 400 SECONDARY-TEXT-SIZE 10 + 3 * +
  SECONDARY-TEXT-SIZE Fg-color rl:draw-text

  rl:end-drawing
;
