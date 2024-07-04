module state_ctl(
    input rst,  // rst. High Low Reset
    input clk,  // 100MHz Clock Input
    input btnr, // run_md_btn. Tact Switch Input. Push High
    input btnd, // disp_md_btn. Tact Switch Input. Push High
    input btnu, // clr_btn. Tact Switch Input. Push High
    output reg run_md, disp_md, clr_on,
    output reg [15:0] led
    );
    
wire run_md_btn;    // btnr
wire disp_md_btn;   // btnd
wire clr_btn;       // btnu

reg krn0,krn1;      // Run Mode Button Shift.
reg kdp0,kdp1;      // Display Mode Button Shift.
reg kcl0,kcl1;      // Clear Button Shift.

//reg run_md_reg;     // Run Mode Register.
//reg disp_md_reg;    // Display Mode Register.
//reg clr_on;         // Clear Action On.

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        led <= 0;
    else
        begin
            led[0] <= run_md;  
            led[15] <= disp_md;  
            led[7] <= clr_on;  
            led[8] <= clr_on;  
        end
end    

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            run_md <= 0;    
            disp_md <= 0;
            clr_on <= 0;
        end
    else
        begin
            // Run Mode Register Control
            if (krn0 & ~krn1)
                run_md <= ~run_md;
            // Display Mode Register Control
            if (kdp0 & ~kdp1)
                disp_md <= ~disp_md;
            // Clear On Action Control
            if (kcl1 & ~kcl0)
                clr_on <= 0;
            else if (kcl0 & ~kcl1)
                if (run_md == 0)
                    clr_on <= 1;  
        end
end    

always@(negedge rst, posedge clk)
begin
    if (rst == 0)
        begin
            krn1 <= 0;    krn0 <= 0;
            kdp1 <= 0;    kdp0 <= 0;
            kcl1 <= 0;    kcl0 <= 0;
        end
    else
        begin
            krn1 <= krn0;   krn0 <= run_md_btn;
            kdp1 <= kdp0;   kdp0 <= disp_md_btn;
            kcl1 <= kcl0;   kcl0 <= clr_btn;            
        end
end    

debounce u_debounce_0
(
.rst    (rst        ),
.clk    (clk        ),
.btnr   (btnr       ),
.key    (run_md_btn )
);

debounce u_debounce_1
(
.rst    (rst        ),
.clk    (clk        ),
.btnr   (btnd       ),
.key    (disp_md_btn )
);

debounce u_debounce_2
(
.rst    (rst        ),
.clk    (clk        ),
.btnr   (btnu       ),
.key    (clr_btn )
);

endmodule
