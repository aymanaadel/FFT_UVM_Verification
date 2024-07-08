package FFT_env_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import FFT_agent_pkg::*;
import FFT_scoreboard_pkg::*;
import FFT_coverage_pkg::*;

	class FFT_env extends uvm_env;
		`uvm_component_utils(FFT_env)

		FFT_agent agt;
		FFT_scoreboard sb;
		FFT_coverage cov;

		function new(string name = "FFT_env", uvm_component parent = null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			agt=FFT_agent::type_id::create("agt",this);
			sb=FFT_scoreboard::type_id::create("sb",this);
			cov=FFT_coverage::type_id::create("cov",this);
		endfunction

		function void connect_phase(uvm_phase phase);
			// super.connect_phase(phase);
			agt.agt_ap.connect(sb.sb_export);
			agt.agt_ap.connect(cov.cov_export);
		endfunction
	endclass

endpackage