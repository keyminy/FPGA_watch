module stop_watch_top(
    input btnl, // rst. High Active Reset
    input clk,  // 100MHz Clock Input
    input btnr, // run_md_btn. Tact Switch Input. Push High
    input btnd, // disp_md_btn. Tact Switch Input. Push High
    input btnu, // clr_btn. Tact Switch Input. Push High
    input [1:0] sw,
    output reg [3:0] an,
    output reg dp,
    output reg [6:0] seg, // g,~ a
    output [15:0] led
    );
    
wire rst;
wire pls_100hz,pls_sel;
wire [1:0] sel;

wire run_md;
wire disp_md;
wire clr_on;

wire convert;

wire [6:0] usec;
wire [5:0] sec;
wire [5:0] min;

reg [5:0] h_val;
reg [6:0] l_val;

wire bcd_done;

wire [3:0] bcd_a,bcd_b,bcd_c,bcd_d;
reg [3:0] bcd_sel;

wire [6:0] seg_d;

reg pl0,pl1;

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            pl0 <= 0;   pl1 <= 0;
            seg <= 7'h7f;    dp <= 1;    an <= 4'hf;
        end
    else
        begin
            pl0 <= pls_sel; pl1 <= pl0;
            if (pl0 & ~ pl1)
                begin
                    seg <= ~seg_d;
                    case(sel)
                    // dp도 0일때 led on(즉 3번째자리 dp는 항상on)
                    2'd0    : begin     an <= 4'b0111;  dp <= 1;        end
                    2'd1    : begin     an <= 4'b1011;  dp <= 0;        end
                    2'd2    : begin     an <= 4'b1101;  dp <= 1;        end
                    default : begin     an <= 4'b1110;  dp <= ~disp_md; end
                    endcase
                end
        end        
end

hex2seg u_hex2seg
(
.din    (bcd_sel	),
.seg_d  (seg_d  	)
);

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        bcd_sel <= 0;
    else
        if      (sel == 0)  bcd_sel <= bcd_a;
        else if (sel == 1)  bcd_sel <= bcd_b;
        else if (sel == 2)  bcd_sel <= bcd_c;
        else                bcd_sel <= bcd_d;
end

// Hexa to BCD Conversion
hex2bcd_top u_hex2bcd_top
(
.rst        (rst        ),
.clk        (clk        ),
//.start      (pls_100hz  ),
.start      (convert    ),
.h_val      (h_val      ),
.l_val      (l_val      ),
// Output
.done       (bcd_done   ),
.bcd_a      (bcd_a      ),
.bcd_b      (bcd_b      ),
.bcd_c      (bcd_c      ),
.bcd_d      (bcd_d      )
);

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin   h_val <= 0; l_val <= 0; end
    else
        if (disp_md == 0)
            begin   h_val <= sec; l_val <= usec; end
        else
            begin   h_val <= min; l_val <= sec;  end
end

// Stop Watch Counter
stop_watch_cnt u_stop_watch_cnt
(
.rst        (rst        ),
.clk        (clk        ),
.clr        (clr_on     ),
.plsi       (pls_100hz  ),
.usec       (usec       ),
.sec        (sec        ),
.min        (min        )
);
    
// Control Signal Generation Module
sel_sig_gen u_sel_sig_gen
(
.rst        (rst        ),
.clk        (clk        ),
//.run_md     (run_md     ),
//.clr_on     (clr_on     ),
.sw         (sw         ),
.pls_100hz  (pls_100hz  ),
// Output
.convert    (convert    ),
.pls_sel    (pls_sel    ),
.sel        (sel        )
);

// Control Signal Generation Module
ctl_sig_gen u_ctl_sig_gen
(
.rst        (rst        ),
.clk        (clk        ),
.run_md     (run_md     ),
.clr_on     (clr_on     ),
//.sw         (sw         ),
// Output
.pls_100hz  (pls_100hz  )//,
//.pls_sel    (pls_sel    ),
//.sel        (sel        )
);

// State Control Module
state_ctl u_state_ctl
(
.rst        (rst        ),
.clk        (clk        ),
.btnr       (btnr       ),
.btnd       (btnd       ),
.btnu       (btnu       ),
// Output
.run_md     (run_md     ),
.disp_md    (disp_md    ),
.clr_on     (clr_on     ),
.led        (led        )
);

assign rst = ~btnl;

endmodule
