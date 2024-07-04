restart
add_force rst {1 0ns} {0 1ps} {1 50ns}
add_force clk {0 0ns} {1 5ns} -repeat_every 10ns
add_force plsi {0 0ns} {1 500ns} -repeat_every 1000ns
add_force clr 0
run 350ms
add_force clr 1
run 1us
add_force clr 0
run 150us
