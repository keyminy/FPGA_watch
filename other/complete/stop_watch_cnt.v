module stop_watch_cnt
    (
    input rst,clk,
    input clr,              // Clear the Counter at rising edge of CLR Input
    input plsi,             // 100Hz Pulse Input. Count up at falling edge of PLSI.
    output [6:0] usec,
    output [5:0] sec,
    output [5:0] min
    );
    
wire pls_sec,pls_min,pls_hr;

// Under Sec. Counter : 00 ~ 99
pls_cnt_100 u_usec_cnt
(
.rst    (rst    ),
.clk    (clk    ),
.clr    (clr    ),
.plsi   (plsi   ),
.plso   (pls_sec),
.qout   (usec   )
);
    
// Sec. Counter : 00 ~ 59
pls_cnt_60 u_sec_cnt
(
.rst    (rst    ),
.clk    (clk    ),
.clr    (clr    ),
.plsi   (pls_sec),
.plso   (pls_min),
.qout   (sec    )
);
    
// Min. Counter : 00 ~ 59
pls_cnt_60 u_min_cnt
(
.rst    (rst    ),
.clk    (clk    ),
.clr    (clr    ),
.plsi   (pls_min),
.plso   (pls_hr ),
.qout   (min    )
);
    
endmodule
