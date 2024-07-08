package FFT_sequencer_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import FFT_seq_item_pkg::*;

	class FFT_sequencer extends uvm_sequencer #(FFT_seq_item);
		`uvm_component_utils(FFT_sequencer)

		function new(string name = "FFT_sequencer", uvm_component parent = null);
			super.new(name,parent);
		endfunction

	endclass

endpackage