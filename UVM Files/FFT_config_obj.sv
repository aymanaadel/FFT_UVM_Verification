package FFT_config_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

	class FFT_config extends uvm_object;
		`uvm_object_utils(FFT_config)

		virtual FFT_if FFT_vif;

		function new(string name = "FFT_config");
			super.new(name);
		endfunction

	endclass

endpackage