restart
add_force rst {1 0ns} {0 1ps} {1 50ns}
add_force clk {0 0ns} {1 5ns} -repeat_every 10ns

add_force start 1

add_force h_val -radix unsigned 17
add_force l_val -radix unsigned 45

run 100ns

add_force start 0
run 350ns
