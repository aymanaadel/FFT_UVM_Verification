package FFT_main_sequence_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import FFT_seq_item_pkg::*;

	class FFT_main_sequence extends uvm_sequence #(FFT_seq_item);
		`uvm_object_utils(FFT_main_sequence)

		FFT_seq_item seq_item;

		string x_str[32];

		function new(string name = "FFT_main_sequence");
			super.new(name);
		endfunction

		task body;
			seq_item=FFT_seq_item::type_id::create("seq_item");
			
			start_item(seq_item);
			`include "first_input.sv"	
			finish_item(seq_item);

			start_item(seq_item);
			`include "second_input.sv"	
			finish_item(seq_item);

			start_item(seq_item);
			`include "third_input.sv"		
			finish_item(seq_item);

			start_item(seq_item);
			`include "fourth_input.sv"		
			finish_item(seq_item);

			// delay/wait till the outputs be generated (increase it if adding more inputs)
			repeat(4) begin
				start_item(seq_item);
				finish_item(seq_item);
			end
		endtask
		
	endclass

endpackage


