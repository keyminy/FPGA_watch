module stop_watch_cnt(
    input clk,
    input rst,
    input [3:0] sw,
    output [3:0] an,
    output [6:0] seg,
    output dp
);
    reg pls_1kHz;
    wire w_clk100Hz;
    wire [7:0] seg_d;
    
    wire w_usec;
    wire w_sec;

    reg [15:0] cnt_1kHz; // 50,000 divide

    always @(negedge rst or posedge clk) begin
        if(rst == 0) begin
            cnt_1kHz <= 0;
            pls_1kHz <= 0;
        end
        else begin
            if(cnt_1kHz < 50000-1)
                cnt_1kHz <= cnt_1kHz + 1;
            else begin
                cnt_1kHz <= 0;
                pls_1kHz <= ~pls_1kHz;
            end
        end
    end

    assign an = sw;
    assign dp = ~seg_d[7];
    assign seg = ~seg_d[6:0];
    
    pls_cnt_10 u_pls_cnt_10(
        .rst(rst),
        .clk(clk),
        .plsi(pls_1kHz),
        .plso(w_clk100Hz)
    );

    pls_cnt_100 u_pls_cnt_100_0(
        .clk(clk),
        .plsi(w_clk100Hz),
        .rst(rst),
        .clr(btnu),
        .plso(),
        .qout(w_usec)
    );


    watch_hex2seg u_watch_hex2seg_0(
        .din(temp_cnt),
        .seg_d(seg_d)
    );

endmodule