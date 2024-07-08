# Define the number of signals
set N 32

# Open a file to write the generated SystemVerilog code
set outfile [open "monitor_the_if.sv" "w"]

# monitor reset
puts $outfile "rsp_seq_item.rst=FFT_vif.rst;" 

# monitor inputs (rsp_seq_item.x0=FFT_vif.x0;)
puts $outfile "// inputs"
for {set i 0} {$i < $N} {incr i} {
    puts $outfile "rsp_seq_item.x$i=FFT_vif.x$i;" 
}
                
# monitor outputs (rsp_seq_item.Yr0=FFT_vif.Yr0; , rsp_seq_item.Yi0=FFT_vif.Yi0;)
puts $outfile "// outputs"
for {set i 0} {$i < $N} {incr i} {
    puts $outfile "rsp_seq_item.Yr$i=FFT_vif.Yr$i;" 
}
puts $outfile ""
for {set i 0} {$i < $N} {incr i} {
    puts $outfile "rsp_seq_item.Yi$i=FFT_vif.Yi$i;" 
}


# Close the file
close $outfile