package FFT_driver_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import FFT_seq_item_pkg::*;

	class FFT_driver extends uvm_driver #(FFT_seq_item);
		`uvm_component_utils(FFT_driver)

		virtual FFT_if FFT_vif;
		FFT_seq_item stim_seq_item;

		function new(string name = "FFT_driver", uvm_component parent = null);
			super.new(name,parent);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				stim_seq_item=FFT_seq_item::type_id::create("stim_seq_item");
				seq_item_port.get_next_item(stim_seq_item);

				// drive the if with the seq item
				FFT_vif.rst=stim_seq_item.rst;
				`include "driving_the_if.sv"
				
				// drive the rst only for 1 cycle
				if (stim_seq_item.rst) begin
					@(negedge FFT_vif.clk);
				end
				// drive a new input every 5 cycles (untill fft 1st stage finishes)
				else begin
					repeat(5) @(negedge FFT_vif.clk);
				end

				seq_item_port.item_done();
			end
		endtask
	endclass
endpackage