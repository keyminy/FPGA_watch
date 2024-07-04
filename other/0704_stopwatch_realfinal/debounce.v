module debounce(
    input rst,clk,
    input btnr,
    output reg key
    );
    
reg [15:0] cnt; // 5만 분주
reg pls_1k0,pls_1k1;

reg btn0,btn1;
reg [4:0] btn_cnt; // 31 분주

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            btn0 <= 0;  btn1 <= 0;  btn_cnt <= 0;   key <= 0;         
        end
    else if (pls_1k0 & ~pls_1k1)
        begin
            btn0 <= btnr;   btn1 <= btn0;
            if (btn0 ^ btn1)
                btn_cnt <= 0;
            else if (btn_cnt < 30)
                btn_cnt <= btn_cnt + 1;
            //
            if (btn_cnt == 29)
                key <= btn1;
        end
end

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            cnt <= 0;   pls_1k0 <= 0; pls_1k1 <= 0;
        end
    else 
        begin
            pls_1k1 <= pls_1k0;
            if (cnt < 49999)  // for Board Implementation
       //     if (cnt < 49)   // for Simulation Only
                cnt <= cnt + 1;
            else
                begin
                    cnt <= 0;
                    pls_1k0 <= ~pls_1k0;    
                end   
        end         
end    

endmodule
