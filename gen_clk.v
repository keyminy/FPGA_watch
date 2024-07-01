module gen_clk(
    input clk,
    input rst,
    output reg clk_div
);
    integer i;
    parameter div_num = 5;  
    always @(posedge clk) begin
        if(rst) begin
            i<=0;
            clk_div<=0;
        end
        else begin
            if(i < div_num-1) begin
                i = i+1;
            end else begin
                i=0;
                clk_div = ~clk_div;
            end
        end
    end
endmodule