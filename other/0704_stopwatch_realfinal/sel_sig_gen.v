module sel_sig_gen(
    input   rst,        // rst. Active Low Reset
    input   clk,        // 100MHz Clock Input
//    input   run_md,     // run_md. Count Up at High
//    input   clr_on,     // Clear counter at Rising Edge when RUN_MD is Low
    input   [1:0] sw,   // SEL period selection
    input   pls_100hz,  // 100Hz Pulse Output
    output  reg convert,    // SEL Period Cycle Pulse Output
    output  reg pls_sel,    // SEL Period Cycle Pulse Output
    output  reg [1:0] sel   // Digit select for 7 Segment Display 
    );
    
reg cl0,cl1;      // Clear counter at Rising Edge when RUN_MD is Low

reg [13:0] cnta;
reg [4:0]  cntb;

reg pl0,pl1;

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin   sel <= 0;  pls_sel <= 0; end      
    else
        begin
            convert <= cntb[4];
            //
            case(sw)
            2'd0 :      begin   sel <= cntb[1:0];   pls_sel <= pl1;      end
            2'd1 :      begin   sel <= cntb[2:1];   pls_sel <= cntb[0];  end
            2'd2 :      begin   sel <= cntb[3:2];   pls_sel <= cntb[1];  end
            default :   begin   sel <= cntb[4:3];   pls_sel <= cntb[2];  end
            endcase
        end
end    

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        cntb <= 0;       
    else
        if (cl0 & ~cl1)
            cntb <= 0;
        else 
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
        	if (cl0 & ~cl1)
        		begin
             	   cnta <= 0;	pl0 <= 0;	pl1 <= 0;
            	end
            else 
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
        begin   cl1 <= cl0;     cl0 <= ~pls_100hz;  end
end    

endmodule
