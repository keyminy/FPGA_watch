`timescale 1ns / 1ps

module debounce(
    input btn,
    input clk,rst,
    output reg key
    );
    reg [15:0] cnt; // 50,000 divide
    reg pls_1k0,pls_1k1;

    reg btn0,btn1;
    reg [4:0] btn_cnt; // wait 30ms
    
    always @(negedge rst or posedge clk) begin
        if(rst == 0) begin
            btn0 <= 0;
            btn1 <= 0;
            btn_cnt <= 0;
            key <= 0;
        end else if(pls_1k0 & ~pls_1k1) begin
            //detect rising edge
            btn0 <= btn;
            btn1 <= btn0;
            if(btn0 ^ btn1)
                btn_cnt <= 0;
            else if(btn_cnt < 30)
                btn_cnt <= btn_cnt + 1;
            if(btn_cnt == 29)
                key <= btn1; // key is clean signal with no noise
        end
    end

    always @(negedge rst or posedge clk) begin
        if(rst == 0) begin
            cnt <= 0;
            pls_1k0<=0;
            pls_1k1<=0;
        end
        else begin
            pls_1k1 <= pls_1k0;
            if(cnt < 50000-1) // for Board Implementation
            // if(cnt < 50-1) // for simulation Only
                cnt <= cnt + 1;
            else begin
                cnt <= 0;
                pls_1k0 <= ~pls_1k0;
                // pls_1k1 <= pls_1k0; //err
            end
        end
    end

endmodule