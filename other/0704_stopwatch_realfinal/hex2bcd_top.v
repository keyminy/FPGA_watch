module hex2bcd_top(
    input rst,clk,
    input start,
    input [5:0] h_val,
    input [6:0] l_val,
    output reg done,
    output reg [3:0] bcd_a,bcd_b,bcd_c,bcd_d
    );

reg st0,st1;
reg [4:0] cnt;
reg convert;
reg [6:0] din;

wire dones;
wire [3:0] bcd_h,bcd_l;

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            bcd_a <= 0;  bcd_b <= 0;  bcd_c <= 0;  bcd_d <= 0;       
        end
    else 
        begin
            if      (cnt == 7)   begin   bcd_a <= bcd_h; bcd_b <= bcd_l;     end
            else if (cnt == 14)   begin   bcd_c <= bcd_h; bcd_d <= bcd_l;     end            
        end
end

hex2bcd u_hex2bcd
(
.rst    (rst    ),
.clk    (clk    ),
.start  (convert),
.din    (din    ),
.done   (dones  ),
.bcd_h  (bcd_h   ),
.bcd_l  (bcd_l   )
);

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        done <= 0;    
    else 
        begin
            done <= 0;    
            if ((cnt > 16) & (cnt < 31))
                done <= 1;
        end
end

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            convert <= 0;  din <= 0;       
        end
    else 
        begin
            convert <= 0;
            din <= l_val;
            if (cnt < 16)
                begin
                    if (cnt[2:0] < 4)   convert <= 1;
                    // DIN Select
                    if (cnt < 7)   din <= h_val;
                end
        end
end

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            st0 <= 1;  st1 <= 1;  
            cnt <= 31;       
        end
    else 
        begin
            st0 <= start;   st1 <= st0;
            if (st1 & ~st0)         // Falling Edge of START
                cnt <= 0;
            else if (cnt < 31)    
                cnt <= cnt + 1;
        end
end

endmodule
