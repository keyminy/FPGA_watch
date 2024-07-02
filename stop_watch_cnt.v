module stop_watch_cnt(
    input clk,
    input rst,
    input clr, // Clear the Counter at rising edge of CLR Input
    input plsi, // 100Hz Pulse Input, Count up at falling edge of PLSI.
    output [6:0] o_usec,
    output [5:0] o_sec,
    output [5:0] o_min
);
    wire w_pls_sec;
    wire w_pls_min;
    wire w_pls_hour;
    
    // Under sec, counter : 00 ~ 99
    pls_cnt_100 u_usec_cnt(
        .rst(rst),
        .clk(clk),
        .clr(clr),
        .plsi(plsi),
        .plso(w_pls_sec),
        .qout(o_usec)
    );

    // Sec, counter : 00 ~ 59
    pls_cnt_60 u_sec_cnt(
        .rst(rst),
        .clk(clk),
        .clr(clr),
        .plsi(w_pls_sec),
        .plso(w_pls_min),
        .qout(o_sec)
    );

    // Min, counter : 00 ~ 59
    pls_cnt_60 u_min_cnt(
        .rst(rst),
        .clk(clk),
        .clr(clr),
        .plsi(w_pls_min),
        .plso(w_pls_hour),
        .qout(o_min)
    );

    // pls_cnt_10 u_pls_cnt_10(
    //     .rst(rst),
    //     .clk(clk),
    //     .plsi(pls_1kHz),
    //     .plso(w_clk100Hz)
    // );


    


    // watch_hex2seg u_watch_hex2seg_0(
    //     .din(w_usec),
    //     .seg_d(seg_d)
    // );

endmodule