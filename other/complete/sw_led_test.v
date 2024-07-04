module sw_led_test(
    input [15:0] sw,
    output [15:0] led
    );
assign led = sw;    
endmodule
