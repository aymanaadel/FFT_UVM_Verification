# Define the number of signals
set N 32

# Open a file to write the generated SystemVerilog code
set outfile [open "sformat_file.sv" "w"]

# sformat input x generator ($sformat(x_str[0], "%b", seq_item.x0);)
for {set i 0} {$i < $N} {incr i} {
    puts $outfile "\$sformat(x_str\[$i\], \"%b\", seq_item.x$i);" 
}

# sformat output Yr generator ($sformat(Yr_str[0], "%b", seq_item.Yr0);)
for {set i 0} {$i < $N} {incr i} {
    puts $outfile "\$sformat(Yr_str\[$i\], \"%b\", seq_item.Yr$i);" 
}
# sformat output Yi generator ($sformat(Yi_str[0], "%b", seq_item.Yi0);)
for {set i 0} {$i < $N} {incr i} {
    puts $outfile "\$sformat(Yi_str\[$i\], \"%b\", seq_item.Yi$i);" 
}


# Close the file
close $outfile
