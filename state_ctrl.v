module state_ctrl(
    input clk,
    input btnl, // reset, high active reset
    input btnr, // control run mode button
    input btnd, // control display mode button
    input btnu, // clear button, tact switch input. Only works when in stop state.
    output led15_disp,
    output led0_run,
    output led7,
    output led8,
    input [3:0] sw,
    output [3:0] an,
    output [6:0] seg,
    output dp
);
    wire rst;
    wire w_run_md_btn; // btnr
    wire w_disp_md_btn; //btnd
    wire w_clr_btn; // btnu

    reg krn0,krn1; // Keys for Run mode Button Shift.
    reg kdp0,kdp1; // Keys for Display mode Button Shift.
    reg kcl0,kcl1; // Keys for Clear Button Shift.

    reg run_md_reg; // Run Mode Register
    reg disp_md_reg; // Display Mode Register
    reg clr_on; // Clear Action On Register.

    assign led15_disp = disp_md_reg;
    assign led0_run = run_md_reg;
    assign led7 = clr_on;
    assign led8 = clr_on;

    always @(negedge rst or posedge clk) begin
        if(!rst) begin
            run_md_reg <= 0;
            disp_md_reg <= 0;
            clr_on <= 0;
        end else begin
            // Run Mode Register Control
            if(krn0 & ~krn1) begin
                // detcet rising edge
                // state <= S_RUN;
                run_md_reg <= ~run_md_reg;
            end 
            // Display Mode Register Control
            if (kdp0 & ~kdp1) begin
                // detcet rising edge
                disp_md_reg <= ~disp_md_reg;
            end
            // Clear On Action Control
            if(kcl0 & ~kcl1) begin
                // detect rising edge
                if(run_md_reg == 0) begin
                    // clear button only works when in stop state.
                    clr_on <= 1;
                end
            end else if(kcl1 & ~kcl0) begin
                // detect falling edge
                clr_on <= 0;
            end
        end
    end

    always @(negedge rst or posedge clk) begin
        if(!rst) begin
            krn0 <= 0; krn1 <= 0;
            kdp0 <= 0; kdp1 <= 0;
            kcl0 <= 0; kcl1 <= 0;
        end
        else begin
            krn0 <= w_run_md_btn; krn1 <= krn0;
            kdp0 <= w_disp_md_btn; kdp1 <= kdp0;
            kcl0 <= w_clr_btn; kcl1 <= kcl0;
        end
    end

    debounce u_debounce_btnd(
        .rst(rst),
        .clk(clk),
        .btn(btnd),
        .key(w_disp_md_btn)
    );

    debounce u_debounce_btnu(
        .rst(rst),
        .clk(clk),
        .btn(btnu),
        .key(w_clr_btn)
    );

    debounce u_debounce_btnr(
        .rst(rst),
        .clk(clk),
        .btn(btnr),
        .key(w_run_md_btn)
    );
    assign rst = ~btnl;

    stop_watch_cnt u_stop_watch_cnt_0(
        .clk(clk),
        .rst(rst),
        .sw(sw),
        .an(an),
        .seg(seg),
        .dp(dp)
    );

endmodule