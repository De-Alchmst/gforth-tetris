\ \ \ \ \ \ \
\ VARIABLES \
\ \ \ \ \ \ \
s\" :\0" drop MAIN-TEXT-SIZE rl:measure-text
WINDOW-WIDTH swap - 2/ constant COLON-X

5 constant SCORE-GAPS
WINDOW-HEIGHT
  10 MAIN-TEXT-SIZE * -
  9 SCORE-GAPS * -
  2/ constant SCORES-OFFSET

\ \ \ \ \ \
\ DRAWING \
\ \ \ \ \ \

: draw-colon { n -- }
  s" :" rot COLON-X
  SCORES-OFFSET rot MAIN-TEXT-SIZE SCORE-GAPS + * +
  MAIN-TEXT-SIZE Fg-color rl:draw-text-len
;


: draw-scores ( -- )
  rl:begin-drawing
  draw-bg
  10 0 ?do
    i
    dup draw-colon
  loop
  rl:end-drawing
;
