0 value Selected-theme
5 constant THEME-LENGTH
create THEME-TEXTS
  s\" < THEME: Light >\0" drop ,
  s\" < THEME: Dark >\0" drop ,
  s\" < THEME: Darker >\0" drop ,
  s\" < THEME: APERTURE >\0" drop ,
  s\" < THEME: H4x0r >\0" drop ,

255 176 0 255 >color constant APERTURE-COLOR

: beam-color! ( a -- )
  Beam-color
  over color-r c@ over color-r c!
  over color-g c@ over color-g c!
  swap color-b c@ swap color-b c!
;

: default-colors ( -- )
  WHITE to Bg-color
  GRAY to Fg-color

  RED to I-color
  YELLOW to J-color
  PURPLE to L-color
  PINK to T-color
  SKYBLUE to O-color
  GREEN to S-color
  BLUE to Z-color

  DEF-GAME-OVER-RECT-COLOR to Game-over-rect-color
  RED to Game-over-text-color

  GOLD beam-color!
;

: all-pices-color! ( a -- )
  dup to I-color
  dup to J-color
  dup to L-color
  dup to T-color
  dup to O-color
  dup to S-color
      to Z-color
;

: apply-theme ( -- )
  Selected-theme case
    0 of \ LIGHT
      default-colors
    endof
    1 of \ DARK
      default-colors
      DARKGRAY to Bg-color
      BLACK to Fg-color
    endof
    2 of \ DARKER
      default-colors
      BLACK to Bg-color
      GRAY to Fg-color
    endof
    3 of \ APERTURE
      BLACK to Bg-color
      APERTURE-COLOR to Fg-color
      APERTURE-COLOR all-pices-color!
      BLACK beam-color!
      BLACK to Game-over-rect-color
      APERTURE-COLOR to Game-over-text-color
    endof
    4 of \ H4X0R
      BLACK to Bg-color
      DARKGREEN to Fg-color
      GREEN all-pices-color!
      DARKGREEN beam-color!
      DARKGREEN to Game-over-rect-color
      GREEN to Game-over-text-color
    endof
  endcase
;

: change-theme ( f -- ) \ -1 right
  if
    Selected-theme 1+ THEME-LENGTH mod to Selected-theme
  else
    Selected-theme dup 0= if drop THEME-LENGTH then 1- to Selected-theme
  then

  apply-theme
;