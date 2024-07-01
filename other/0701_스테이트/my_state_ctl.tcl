restart
add_force btnl {0 0ns} {1 1ps} {0 10ns}
add_force clk {0 0ns} {1 5ns} -repeat_every 10ns
add_force btnu 0
add_force btnd 0
add_force btnr 0

source D:/fpga/2024a/pjt_lab/pjt_lab.srcs/sources_1/new/disp_mode_ctl.tcl

add_force btnu 1
run 35us

add_force btnr 0
run 35us
add_force btnr 1
run 35us

add_force btnu 0
run 35us

add_force btnr 0
run 35us

add_force btnu 1
run 35us

add_force btnr 1
run 35us
add_force btnr 0
run 35us

add_force btnu 0
run 35us

source D:/fpga/2024a/pjt_lab/pjt_lab.srcs/sources_1/new/clr_ctl.tcl
