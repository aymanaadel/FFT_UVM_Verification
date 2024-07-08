package FFT_test_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import FFT_env_pkg::*;
import FFT_reset_sequence_pkg::*;
import FFT_main_sequence_pkg::*;

import FFT_config_pkg::*;

	class FFT_test extends uvm_component;
		`uvm_component_utils(FFT_test)

		// env
		FFT_env env;
		// sequences
		FFT_reset_sequence reset_sequence;
		FFT_main_sequence main_sequence;

		// config object to get the if
		FFT_config FFT_cfg;

		function new(string name = "FFT_test", uvm_component parent = null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			env=FFT_env::type_id::create("env",this);
			reset_sequence=FFT_reset_sequence::type_id::create("reset_sequence");
			main_sequence=FFT_main_sequence::type_id::create("main_sequence");

			FFT_cfg=FFT_config::type_id::create("FFT_cfg");
			// get the IF
			if (!uvm_config_db#(virtual FFT_if)::get(this, "", "FFT_IF", FFT_cfg.FFT_vif)) begin
				`uvm_fatal("build_phase", "TEST - unable to get the IF");
			end
			// set the config object (which containing the IF)
			uvm_config_db#(FFT_config)::set(this, "*", "CFG", FFT_cfg);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			phase.raise_objection(this);

			// start the sequences
			`uvm_info("run_phase", "Reset Asserted", UVM_LOW);
			reset_sequence.start(env.agt.sqr);
			`uvm_info("run_phase", "Reset De-asserted", UVM_LOW);

			`uvm_info("run_phase", "main_sequence starts", UVM_LOW);
			main_sequence.start(env.agt.sqr);
			`uvm_info("run_phase", "main_sequence ends", UVM_LOW);

			phase.drop_objection(this);
		endtask

	endclass

endpackage