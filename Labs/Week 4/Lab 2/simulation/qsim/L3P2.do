onerror {quit -f}
vlib work
vlog -work work L3P2.vo
vlog -work work L3P2.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.L3P2_vlg_vec_tst
vcd file -direction L3P2.msim.vcd
vcd add -internal L3P2_vlg_vec_tst/*
vcd add -internal L3P2_vlg_vec_tst/i1/*
add wave /*
run -all
