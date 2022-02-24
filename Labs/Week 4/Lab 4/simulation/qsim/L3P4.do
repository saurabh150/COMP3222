onerror {quit -f}
vlib work
vlog -work work L3P4.vo
vlog -work work L3P4.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.L3P4_vlg_vec_tst
vcd file -direction L3P4.msim.vcd
vcd add -internal L3P4_vlg_vec_tst/*
vcd add -internal L3P4_vlg_vec_tst/i1/*
add wave /*
run -all
