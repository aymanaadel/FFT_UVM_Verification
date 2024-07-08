package FFT_monitor_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import FFT_seq_item_pkg::*;

	class FFT_monitor extends uvm_monitor;
		`uvm_component_utils(FFT_monitor)

		virtual FFT_if FFT_vif;
		FFT_seq_item rsp_seq_item;

		uvm_analysis_port #(FFT_seq_item) mon_ap;

		function new(string name = "FFT_monitor", uvm_component parent = null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			mon_ap=new("mon_ap",this);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			// wait until before the 1st output generated with 5 cycles
			repeat(21) @(negedge FFT_vif.clk);

			forever begin
				rsp_seq_item=FFT_seq_item::type_id::create("rsp_seq_item");
				// sample the outputs every 5 cycles (pipelined output)
				repeat(5) @(negedge FFT_vif.clk);
				// monitor the if and assign to seq item
				`include "monitor_the_if.sv"
				// broadcast the seq item
				mon_ap.write(rsp_seq_item);
			end
		endtask

	endclass
endpackage