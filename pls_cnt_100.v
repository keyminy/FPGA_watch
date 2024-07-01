module pls_cnt_100(
    input rst,clk,
    input clr,plsi,
    output reg plso,
    output reg [6:0] qout
    );
    
reg cl0,cl1;
reg pl0,pl1;

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            cl0 <= 0;  cl1 <= 0;  pl0 <= 0;   pl1 <= 0;  
            plso <= 0;
            qout <= 0;       
        end
    else 
        begin
            cl0 <= clr;   cl1 <= cl0;
            pl0 <= plsi;  pl1 <= pl0;
            if (cl0 & ~cl1)         // Rising Edge of CLR
                begin
                    qout <= 0;  plso <= 0;
                end
            else if (pl1 & ~pl0)    // Falling Edge of PLSI
                begin
                    if (qout >= 100-1)
                        begin
                            qout <= 0;
                            plso <= 0;
                        end
                    else
                        begin
                            qout <= qout + 1;
                            if (qout < 50-1)
                                plso <= 0;
                            else
                                plso <= 1;
                        end
                end
        end
end

endmodule
