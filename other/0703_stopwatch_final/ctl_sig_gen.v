module ctl_sig_gen(
    input   rst,        // rst. Active Low Reset
    input   clk,        // 100MHz Clock Input
    input   run_md,     // run_md. Count Up at High
    input   clr_on,     // Clear counter at Rising Edge when RUN_MD is Low
    input   [1:0] sw,   // SEL period selection
    output  reg plso,       // 100Hz Pulse Output
    output  reg [1:0] sel   // Digit select for 7 Segment Display 
    );
    
reg cl0,cl1;      // Clear counter at Rising Edge when RUN_MD is Low

reg [13:0] cnta;
reg [4:0]  cntb;

reg pl0,pl1; // 32kHz falling edge검출하기위함

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin   plso <= 0;  sel <= 0;   end      
    else
        begin
            plso <= cntb[4];
            //
            case(sw)
            2'd0 : sel <= cntb[1:0];
            2'd1 : sel <= cntb[2:1];
            2'd2 : sel <= cntb[3:2];
            default :   sel <= cntb[4:3];
            endcase
        end
end    

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        cntb <= 0;       
    else
        if ((run_md == 0) & (cl0 & ~cl1))
            cntb <= 0;
        else if (run_md == 1)
            if (pl1 & ~pl0)
                cntb <= cntb + 1;
end    

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin   cnta <= 0;  pl0 <= 0;   pl1 <= 0;   end       
    else
        begin
            pl1 <= pl0;
			// 정지모드 && clear 의 rising edge
            if ((run_md == 0) & (cl0 & ~cl1))
                cnta <= 0;
            else if (run_md == 1)
                if (cnta < 15624)
                    cnta <= cnta + 1;
                else
                    begin
                        cnta <= 0;
                        pl0 <= ~pl0;
                    end
        end
end    

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin   cl1 <= 0;       cl0 <= 0;       end
    else
        begin   cl1 <= cl0;     cl0 <= clr_on;  end
end    

endmodule
