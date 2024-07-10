\ FILE LAYOUT
\  1 byte  : level
\  1 byte  : theme
\  1 byte  : show-next
\  5 bytes : reserved for futre use
\ 
\ ( 10 times: )
\  8 bytes : score
\ 24 bytes : plyer name (null terminated => 23 usable)
\
\ players are sorted from highest score to the lovest

\ \ \ \ \ \ \ \ \ \ \ \ \
\ GET SAVE FILE ADDRESS \
\ \ \ \ \ \ \ \ \ \ \ \ \

\ get dir
sourcefilename dirname 
\ allocate spcae
create SAVE-FILE-NAME dup 8 + allot
dup 8 + constant SAVE-FILE-LENGTH

\ add last part
dup SAVE-FILE-NAME + s" save.dat" rot swap move

\ add dir part
SAVE-FILE-NAME swap move

: save.dat ( -- a u)
  SAVE-FILE-NAME SAVE-FILE-LENGTH ;

\ \ \ \ \ \ \
\ OPARATIONS \
\ \ \ \ \ \ \ \

: save-write ( -- )
  save.dat w/o open-file throw
  Selected-level over emit-file throw
  Selected-theme over emit-file throw
  Show-next? over emit-file throw

  dup s\" \0\0\0\0\0" rot write-file throw
  close-file
;

: save-load ( -- )
  save.dat slurp-file drop
  dup     c@ to Selected-level
  dup 1 + c@ to Selected-theme
  dup 2 + c@ to Show-next?
;

: save-init ( -- )
  save.dat w/o open-file
  0= if \ file found
    close-file throw save-load
  else \ file not found
    drop
    save.dat w/o create-file throw drop
    save-write
  then
;
