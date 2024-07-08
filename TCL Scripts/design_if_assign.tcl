# Define the number of signals
set N 32

# Open a file to write the generated SystemVerilog code
set outfile [open "design_if_assign.sv" "w"]

# clk & rst assigns
puts $outfile "assign clk = fft_if.clk;"
puts $outfile "assign rst = fft_if.rst;"

# input assigns (assign x0=fft_if.x0;)
puts $outfile "// input assigns"
for {set i 0} {$i < $N} {incr i} {
    puts $outfile "assign x$i = fft_if.x$i;" 
}

# output assigns (assign fft_if.Yr0=Yr0;)
puts $outfile "// output assigns"
for {set i 0} {$i < $N} {incr i} {
    puts $outfile "assign fft_if.Yr$i = Yr$i;" 
}
for {set i 0} {$i < $N} {incr i} {
    puts $outfile "assign fft_if.Yi$i = Yi$i;" 
}

# Close the file
close $outfile