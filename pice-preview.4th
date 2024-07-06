\ PREVIEW BUFFERS \

create I-preview 0 c, 0 c, 0 c, 0 c,
                 1 c, 1 c, 1 c, 1 c,
                 0 c, 0 c, 0 c, 0 c,
                 0 c, 0 c, 0 c, 0 c,

create J-preview 0 c, 0 c, 0 c, 0 c,
                 2 c, 2 c, 2 c, 0 c,
                 0 c, 0 c, 2 c, 0 c,
                 0 c, 0 c, 0 c, 0 c,

create L-preview 0 c, 0 c, 0 c, 0 c,
                 3 c, 3 c, 3 c, 0 c,
                 3 c, 0 c, 0 c, 0 c,
                 0 c, 0 c, 0 c, 0 c,

create T-preview 0 c, 0 c, 0 c, 0 c,
                 4 c, 4 c, 4 c, 0 c,
                 0 c, 4 c, 0 c, 0 c,
                 0 c, 0 c, 0 c, 0 c,

create O-preview 5 c, 5 c, 0 c, 0 c,
                 5 c, 5 c, 0 c, 0 c,
                 0 c, 0 c, 0 c, 0 c,
                 0 c, 0 c, 0 c, 0 c,

create S-preview 0 c, 6 c, 6 c, 0 c,
                 6 c, 6 c, 0 c, 0 c,
                 0 c, 0 c, 0 c, 0 c,
                 0 c, 0 c, 0 c, 0 c,

create Z-preview 7 c, 7 c, 0 c, 0 c,
                 0 c, 7 c, 7 c, 0 c,
                 0 c, 0 c, 0 c, 0 c,
                 0 c, 0 c, 0 c, 0 c,

: preview-buffer ( -- a )
  Next-pice-shape case
    I-PICE of I-preview endof
    J-PICE of J-preview endof
    L-PICE of L-preview endof
    T-PICE of T-preview endof
    O-PICE of O-preview endof
    S-PICE of S-preview endof
    Z-PICE of Z-preview endof
  endcase
;
