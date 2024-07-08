package FFT_scoreboard_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import FFT_seq_item_pkg::*;

/* C++ function description: 
	arguments     : the input applied to the design (x), the design output (Yr, Yi) 
	arguments_type: string
	function 	  : performs FFT then compare	the result with the design output 
	returns	      : 1/0 depending on the C++ output equals/not_equal the design output */
import "DPI-C" function int check_output(input string x[32], input string Yr[32], input string Yi[32]);

	class FFT_scoreboard extends uvm_scoreboard;

		`uvm_component_utils(FFT_scoreboard)

		uvm_analysis_export #(FFT_seq_item) sb_export;
		uvm_tlm_analysis_fifo #(FFT_seq_item) sb_FFT;

		FFT_seq_item seq_item;

		string x_str [32];
		string Yr_str[32];
		string Yi_str[32];

		int error_count=0, correct_count=0;

		int test_case=0;
		parameter TEST_CASES_NUMBER=4;

		function new(string name = "FFT_scoreboard", uvm_component parent = null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			sb_export=new("sb_export",this);
			sb_FFT=new("sb_FFT",this);
		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			sb_export.connect(sb_FFT.analysis_export);
		endfunction


		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				// get the seq item from the monitor
				sb_FFT.get(seq_item);

				// choose the input
				if (test_case==0) begin
					`include "first_input.sv"
					test_case++;
				end
				else if (test_case==1) begin
					`include "second_input.sv"
					test_case++;
				end
				else if (test_case==2) begin
					`include "third_input.sv"
					test_case++;
				end
				else begin
					`include "fourth_input.sv"
					test_case++;
				end

				// convert the binary input/output to string to send them to C++ function
				`include "sformat_file.sv"

				// call the C++ function
				if ( check_output(x_str, Yr_str, Yi_str) ) begin
					correct_count++;
				end
				else begin
					error_count++;
				end

			end // forever
		endtask


		function void report_phase(uvm_phase phase);
			super.report_phase(phase);
			`uvm_info("report_phase", $sformatf("At time %0t: Simulation Ends and Error Count= %0d, Correct Count= %0d",
					 $time, error_count, correct_count), UVM_MEDIUM);
		endfunction

	endclass

endpackage