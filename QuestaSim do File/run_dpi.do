vlib work
vlog -f src_files.list -mfcu +cover -covercells
vsim -sv_lib ./FFT_check_output top
run -all
