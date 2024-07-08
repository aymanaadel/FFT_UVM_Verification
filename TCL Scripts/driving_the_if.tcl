# Define the number of signals
set N 32

# Open a file to write the generated SystemVerilog code
set outfile [open "driving_the_if.sv" "w"]

# driving inputs (FFT_vif.x0=stim_seq_item.x0;)
for {set i 0} {$i < $N} {incr i} {
    puts $outfile "FFT_vif.x$i=stim_seq_item.x$i;" 
}

# Close the file
close $outfile