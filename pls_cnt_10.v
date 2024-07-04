module pls_cnt_10(
    input rst,clk,
    input clr,plsi,
    output reg plso,
    output reg [5:0] qout
);

reg cl0,cl1;
reg pl0,pl1;

always @(negedge rst,posedge clk) begin
    if(!rst) begin
        cl0 <=0; cl1 <= 0;
        pl0 <= 0; pl1 <= 0;
        plso <= 0;
        qout <= 0;
    end
    else begin
        cl0 <= clr; cl1 <= cl0;
        pl0 <= plsi; pl1 <= pl0;
        if(cl0 & ~cl1) begin
            // rising edge of clear signal
            qout <= 0; plso <= 0;
            pl0 <= 0; pl1 <= 0; // Added this 07021047
        end else if(pl1 & ~pl0) begin
            //falling edge of Pulse signal
            if(qout >= 10-1) begin
                qout <= 0;
                plso <= 0;
            end else begin
                qout <= qout + 1;
                if(qout < 10-1) begin
                    plso <= 0;
                end else begin
                    plso <= 1;
                end
            end
        end
    end
end

endmodule