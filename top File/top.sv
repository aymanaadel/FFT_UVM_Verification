import uvm_pkg::*;
`include "uvm_macros.svh"
import FFT_test_pkg::*;

module top;
	// clock generation
	bit clk;
	initial begin
		clk=0;
		forever #1 clk=~clk;
	end
	// interface
	FFT_if fft_if(clk);
	// DUT
	FFT dut(fft_if);
	// assertions
	bind FFT FFT_sva FFT_sva_inst (fft_if);

	initial begin
		uvm_config_db#(virtual FFT_if)::set(null, "uvm_test_top", "FFT_IF", fft_if);
		run_test("FFT_test");
	end

endmodule