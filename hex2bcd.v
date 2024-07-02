module hex2bcd(
    input rst,
    input clk,
    input start,
    input [6:0] din,
    output reg done,
    output reg [3:0] bcd_h,
    output reg [3:0] bcd_l,
);

reg st0;
reg st1;
reg [2:0] stcnt;
reg [3:0] bcdh;
reg [6:0] temp;

/* idea */
// d_10 <= (din/10);
// d_1 <= ((d_10 * 10) - din);

always @(negedge rst or posedge clk) begin
    if(rst ==0) begin
        done <= 0;
    end
    else begin
        if ((stcnt >= 4) & (stcnt < 7)) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end
end

always @(negedge rst or posedge clk) begin
    if(rst == 0) begin
        temp <= 0; bcdh <= 0;
        bcd_h <= 0; bcd_l <= 0;
    end
    else begin
        if(st0 & ~st1) begin
            // rising edge of start
            temp <= din;
        end else if(stcnt == 0) begin
            // Decide 10's Value
            if      (temp >= 90) begin bcdh <= 9; temp <= temp - 90; end
            else if (temp >= 80) begin bcdh <= 8; temp <= temp - 80; end
            else if (temp >= 70) begin bcdh <= 7; temp <= temp - 70; end
            else if (temp >= 60) begin bcdh <= 6; temp <= temp - 60; end
            else if (temp >= 50) begin bcdh <= 5; temp <= temp - 50; end
            else if (temp >= 40) begin bcdh <= 4; temp <= temp - 40; end
            else if (temp >= 30) begin bcdh <= 3; temp <= temp - 30; end
            else if (temp >= 20) begin bcdh <= 2; temp <= temp - 20; end
            else if (temp >= 10) begin bcdh <= 1; temp <= temp - 10; end
            else  begin                bcdh <= 0; end
        end
        else if(stcnt == 1) begin
            // Decide 1's Value
            bcd_h <= bcdh; 
            bcd_l <= temp[3:0];
        end
    end
end

always @(negedge rst or posedge clk) begin
   if(rst == 0) begin
        st0 <= 0; st1 <= 0;
        stcnt <= 15;
   end 
   else begin
        st0 <= start; st1 <= st0;
        if(st0 & ~st1) begin
            //rising edge of start
            stcnt <= 0;
        end 
        else if(stcnt < 7) begin
            stcnt <= stcnt + 1;
        end
   end
end

endmodule