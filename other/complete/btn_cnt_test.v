module btn_cnt_test(
    input btnl, // High Active Reset
    input clk,  // 100MHz Clock Input
    input btnr, // Tact Switch Input
    output [15:0] led
    );
wire rst;
reg [15:0] cnt;
wire k0;
reg k1;

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
