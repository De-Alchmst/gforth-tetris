# gforth-tetris
tetris using gforth and raylib

inspred by [tint](https://github.com/DavidGriffith/tint.git)

# score
- upon pice landing, add 1 to score
- add additional 1 for every line dropped
- if show next enabled, divide by two (and add 1 to make up for one lost by
        division rounding)
- multiply by current level

# levels
- there is 9 levels
- block falls each 1/level seconds
- level increses each 10 lines
- first increas takes 10*level lines

# themes
- [Kanagawa](https://github.com/rebelot/kanagawa.nvim)
