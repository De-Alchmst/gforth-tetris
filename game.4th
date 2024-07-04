0 constant LEFT
-1 constant RIGHT

10 constant COLS
20 constant ROWS

variable Game-field COLS ROWS * allot

: wall-collision? ( -- f )
  Pice-X Pice-off-X + 0<
  Pice-X Pice-width + COLS >
  Pice-Y Pice-height + ROWS >
  or or
;

: collision? ( -- f )
  wall-collision? ;

: move-pice-sideways ( f -- ) \ direction
  dup if
    1  +to Pice-X
  else
    -1 +to Pice-X
  then

  collision?
  if
    if
      -1 +to Pice-X
    else
      1  +to Pice-X
    then
  else
    drop
  then
;

: rotate-pice ( f -- ) \ direction
  dup if
    rotate-pice-right
  else
    rotate-pice-left
  then
  Pice-rotation pice-set-word execute

  collision?
  if
    if
      rotate-pice-left
    else
      rotate-pice-right
    then
    Pice-rotation pice-set-word execute
  else
    drop
  then
;

: move-pice-down ( -- f )
  1 +to Pice-Y

  collision?
  dup if
    -1 +to Pice-Y
  then
;

: game-update ( -- f )
  move-pice-down
;
