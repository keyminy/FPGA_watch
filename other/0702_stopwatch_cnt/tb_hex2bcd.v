module tb_hex2bcd(
    input rst,clk,
    input plsi,
//  input [6:0] din,
    output done,
    output [3:0] bcd_h,bcd_l
    );

reg pl0,pl1;
reg [7:0] cnt;

wire convert;
wire [6:0] din;

hex2bcd u_hex2bcd
(
.rst    (rst    ),
.clk    (clk    ),
.start  (convert),
.din    (din    ),
.done   (done   ),
.bcd_h  (bcd_h   ),
.bcd_l  (bcd_l   )
);

assign convert = cnt[0];
assign din = cnt[7:1];

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            pl0 <= 0;  pl1 <= 0;  
            cnt <= 0;       
        end
    else 
        begin
            pl0 <= plsi;   pl1 <= pl0;
            if (pl1 & ~pl0)         // Rising Edge of START
                if (cnt < 199)    
                    cnt <= cnt + 1;
        end
end

endmodule
