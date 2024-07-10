\ \ \ \
\ VARS \
\ \ \ \ \
0 value Prev-mode

create Scores-values 10 cells allot
create Scores-names  30 cells allot

\ adds empty entries to Scores-names
: scores-init ( -- )
  10 0 ?do
    s\" ---NO-ONE---\0"
    Scores-names i 3 cells *
  loop
;
