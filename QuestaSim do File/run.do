vlib work
vlog -f src_files.list -mfcu +cover -covercells
vsim -voptargs=+acc work.top -cover -classdebug -uvmcontrol=all
add wave /top/fft_if/*
run -all
