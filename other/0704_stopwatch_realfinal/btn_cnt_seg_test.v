module btn_cnt_seg_test(
    input btnl, // High Active Reset
    input clk,  // 100MHz Clock Input
    input btnr, // Tact Switch Input
    input [3:0] sw,
    output [3:0] an,
    output dp,
    output [6:0] seg, // g,~ a
    output [3:0] led
    );
wire rst;
reg [3:0] cnt;
wire k0;
reg k1;

wire [7:0] seg_d;

hex2seg u_hex2seg_0
(
.din    (cnt    ),    
.seg_d  (seg_d  )
);

assign an = sw;
assign pd = ~seg_d[7];
assign seg = ~seg_d[6:0];
    
assign rst = ~btnl;    
assign led = cnt;

debounce u_debounce_0
(
.rst    (rst    ),
.clk    (clk    ),
.btnr   (btnr   ),
.key    (k0     )
);

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            k1 <= 0;    cnt <= 0;
        end
    else
        begin
            k1 <= k0;
            if (k0 & ~k1)
                cnt <= cnt + 1;
        end
end    
endmodule
