restart
add_force rst {1 0ns} {0 1ps} {1 20ns}
add_force clk {0 0ns} {1 5ns} -repeat_every 10ns

# add_force pls_100hz {0 0ns} {1 500ns} -repeat_every 1000ns

add_force sw -radix unsigned 2

run 5us

run 11ms