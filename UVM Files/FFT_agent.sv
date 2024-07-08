package FFT_agent_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import FFT_sequencer_pkg::*;
import FFT_driver_pkg::*;
import FFT_monitor_pkg::*;
import FFT_config_pkg::*;
import FFT_seq_item_pkg::*;

	class FFT_agent extends uvm_agent;
		`uvm_component_utils(FFT_agent)

		FFT_sequencer sqr;
		FFT_driver drv;
		FFT_monitor mon;
		// config object to get the IF
		FFT_config FFT_cfg;
		uvm_analysis_port #(FFT_seq_item) agt_ap;

		function new(string name = "FFT_agent", uvm_component parent = null);
			super.new(name,parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			sqr=FFT_sequencer::type_id::create("sqr",this);
			drv=FFT_driver::type_id::create("drv",this);
			mon=FFT_monitor::type_id::create("mon",this);
			agt_ap=new("agt_ap",this);

			if ( !uvm_config_db#(FFT_config)::get(this, "", "CFG", FFT_cfg) ) begin
				`uvm_fatal("build_phase", "AGENT - unable to get the IF");
			end

		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			drv.FFT_vif=FFT_cfg.FFT_vif;
			mon.FFT_vif=FFT_cfg.FFT_vif;
			drv.seq_item_port.connect(sqr.seq_item_export);
			mon.mon_ap.connect(agt_ap);
		endfunction
	endclass

endpackage