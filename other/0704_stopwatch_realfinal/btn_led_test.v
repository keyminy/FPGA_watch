module btn_led_test(
    input btnl,btnr,
    output ld0,ld15
    );
assign ld0 = btnr;
assign ld15 = btnl;    
endmodule
