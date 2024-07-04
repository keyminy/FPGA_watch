restart
add_force btnl {0 0ns} {1 1ps} {0 10ns}
add_force clk {0 0ns} {1 5ns} -repeat_every 10ns
add_force btnu 0
add_force btnd 0

add_force btnr 0
run 35us
add_force btnr 1
run 35us

