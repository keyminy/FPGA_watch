restart
add_force rst {1 0ns} {0 1ps} {1 50ns}
add_force clk {0 0ns} {1 5ns} -repeat_every 10ns

add_force plsi {0 0ns} {1 200ns} -repeat_every 400ns

run 80us