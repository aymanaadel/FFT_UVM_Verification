package FFT_coverage_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import FFT_seq_item_pkg::*;

	class FFT_coverage extends uvm_component;
		`uvm_component_utils(FFT_coverage)

		uvm_analysis_export #(FFT_seq_item) cov_export;
		uvm_tlm_analysis_fifo #(FFT_seq_item) cov_FFT;

		FFT_seq_item seq_item_cov;

		covergroup cvr_grp;

			// Write your Cover points here...
		
		endgroup

		function new(string name = "FFT_coverage", uvm_component parent = null);
			super.new(name,parent);
			cvr_grp=new();
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			cov_export=new("cov_export",this);
			cov_FFT=new("cov_FFT",this);
		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			cov_export.connect(cov_FFT.analysis_export);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				cov_FFT.get(seq_item_cov);
				cvr_grp.sample();
			end
		endtask

	endclass
endpackage