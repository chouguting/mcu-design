vsim -voptargs=+acc work.testbench_alu_7bits
view structure wave signals

do wave.do

log -r *
run -all

