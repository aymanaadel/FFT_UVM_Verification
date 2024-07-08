package FFT_reset_sequence_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import FFT_seq_item_pkg::*;

	class FFT_reset_sequence extends uvm_sequence #(FFT_seq_item);
		`uvm_object_utils(FFT_reset_sequence)

		FFT_seq_item seq_item;

		function new(string name = "FFT_reset_sequence");
			super.new(name);
		endfunction

		task body;
			seq_item=FFT_seq_item::type_id::create("seq_item");
			start_item(seq_item);

			seq_item.rst=1;
			
			finish_item(seq_item);
		endtask
		
	endclass

endpackage