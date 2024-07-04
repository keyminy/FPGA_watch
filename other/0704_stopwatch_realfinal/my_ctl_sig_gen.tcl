restart
add_force rst {1 0ns} {0 1ps} {1 20ns}
add_force clk {0 0ns} {1 5ns} -repeat_every 10ns
add_force run_md 0
add_force clr_on 0
add_force sw -radix unsigned 2

run 5us

add_force run_md 1
run 5us

add_force clr_on 1
run 1us
add_force clr_on 0
run 5us

add_force run_md 0
run 5us

add_force clr_on 1
run 1us
add_force clr_on 0
run 5us

add_force run_md 1
run 5us

#run 11ms