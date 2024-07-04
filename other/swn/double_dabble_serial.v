module bin2bcd_sync(
    input rst,
    input clk,
    input start,
    input [6:0] binary_in,
    output reg [7:0] bcd_out_reg
  );
  
wire done;    
reg [7:0] bcd_out=0;
reg [6:0] binary_shift = 0;
reg [3:0] binary_count = 0;

always@(negedge rst, posedge clk) begin
    if(rst==0) begin
        bcd_out_reg <= 0;
    end
        else begin 
        if(done == 1) begin
            bcd_out_reg <= bcd_out;
        end
        else begin
            bcd_out_reg <= bcd_out_reg;
        end
    end
end

always @(posedge clk,negedge rst) begin
    if(rst==0) binary_shift<=0;
    else begin
        if(start) begin
          binary_shift <= binary_in;
          binary_count <= 7;
        end
        else if (binary_count != 0) begin
          binary_shift <= { binary_shift[5:0], 1'b0 };
          binary_count <= binary_count - 1'b1;
        end
    end
end

wire bcd_carry = FOMore & ~start;
wire clock_enable   = start | ~done;
wire FOMore = bcd_out[3:0] >= 5;

assign done = binary_count == 0;

always @(posedge clk,negedge rst) begin
    if(rst==0) bcd_out<=0;
    else begin
        if (clock_enable) begin
          bcd_out[0] <= binary_shift[6];
          bcd_out[1] <= ~start & (~bcd_carry ? bcd_out[0] : ~bcd_out[0]);
          bcd_out[2] <= ~start & (~bcd_carry ? bcd_out[1] : bcd_out[1] == bcd_out[0]);
          bcd_out[3] <= ~start & (~bcd_carry ? bcd_out[2] : bcd_out[0] & bcd_out[3]);
          bcd_out[4] <= ~start & (~bcd_carry ? bcd_out[3] : 1'b1);
          bcd_out[5] <= ~start & bcd_out[4];
          bcd_out[6] <= ~start & bcd_out[5];
          bcd_out[7] <= ~start & bcd_out[6];
        end
    end
end
endmodule