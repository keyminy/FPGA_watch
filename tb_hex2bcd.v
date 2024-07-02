module tb_hex2bcd(
    input rst,
    input clk,
    input plsi,
    output done,
    output [3:0] bcd_h,
    output [3:0] bcd_l
);
reg pl0,pl1;
reg [7:0] cnt;

wire convert;
wire [6:0] din;

hex2bcd u_hex2bcd(
    .rst(rst),
    .clk(clk),
    .start(convert),
    .din(din),
    .done(done),
    .bcd_h(bcd_h),
    .bcd_l(bcd_l)
);

assign convert = cnt[0];
assign din = cnt[7:1];

always @(negedge rst or posedge clk) begin
    if(!rst) begin
        pl0 <= 0; pl1 <= 0;
        cnt <= 0;
    end else begin
        pl0 <= plsi;
        pl1 <= pl0;
        if(pl1 & ~pl0) begin
            // neg edge of start
            if(cnt < 199) begin
                cnt <= cnt+1;
            end
        end
    end
end


endmodule