\ \ \ \
\ VARS \
\ \ \ \ \
0 value Selected-menu-option

6 constant MENU-LENGTH
create Menu-texts
  s\" PLAY\0" drop ,
  s\" < LEVEL: 1 >\0" drop ,
  s\" SHOW NEXT [ ]\0" drop ,
  s\" SCORES\0" drop ,
  THEME-TEXTS @ ,
  s\" QUIT\0" drop ,

create Menu-rects rectangle% MENU-LENGTH * allot

20 constant MENU-GAPS
5 constant MENU-RECT-PADDING
10 constant MENU-RECT-PADDING2*

WINDOW-HEIGHT
  MENU-GAPS MENU-LENGTH 1- * -
  MENU-LENGTH MAIN-TEXT-SIZE  * -
  MENU-RECT-PADDING2* MENU-LENGTH * -
  2/ constant MENU-OFFSET

\ \ \ \ \ \ \ \ \
\ CONTROLL STUFF \
\ \ \ \ \ \ \ \ \ \

: set-menu-rects ( -- )
  MENU-LENGTH 0 ?do
    Menu-texts i cells + @ MAIN-TEXT-SIZE rl:measure-text
      MENU-RECT-PADDING2* + \ width
    WINDOW-WIDTH over - 2/ \ X
    i MENU-GAPS * i MAIN-TEXT-SIZE * + MENU-OFFSET +
      i MENU-RECT-PADDING2* * + \ Y
    MAIN-TEXT-SIZE MENU-RECT-PADDING2* + \ height

    Menu-rects rectangle% i * +
    swap s>f dup rectangle-height sf!
    swap s>f dup rectangle-y sf!
    swap s>f dup rectangle-x sf!
    swap s>f rectangle-width sf!
  loop
;

: refresh-menu-text ( -- )
  THEME-TEXTS Selected-theme cells + @ Menu-texts 4 cells + !
  set-menu-rects
;

: menu-next ( -- )
  Selected-menu-option 1+ MENU-LENGTH mod to Selected-menu-option ;

: menu-prev ( -- )
  Selected-menu-option
  dup 0= if drop MENU-LENGTH then 1- to Selected-menu-option ;

: toggle-show-next ( -- )
  Show-next? dup 0= to Show-next?

  if 32 ( space ) else 'x' then
  Menu-texts 2 cells + @ 11 + c!
;

: menu-select ( -- )
  Selected-menu-option case
    0 of PLAYING to Game-mode endof
    2 of toggle-show-next endof
    5 of -1 to End? endof
  endcase
  refresh-menu-text
;

: update-level-menu ( -- )
  Level s>d <# #s #> Menu-texts 1 cells + @ 9 + swap move ;

: menu-sideways ( f -- ) \ -1 right
  Selected-menu-option case
    1 of change-level update-level-menu endof
    4 of change-theme endof
  endcase

  refresh-menu-text
;
