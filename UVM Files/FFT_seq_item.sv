package FFT_seq_item_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

	class FFT_seq_item extends uvm_sequence_item;
		`uvm_object_utils(FFT_seq_item)

		// Design inputs
		rand logic rst;
		rand logic [15:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15;
		rand logic [15:0] x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26 , x27 , x28 , x29 , x30 , x31;
		// Design outputs
		logic [15:0] Yr0, Yr1, Yr2, Yr3, Yr4, Yr5, Yr6, Yr7, Yr8, Yr9, Yr10, Yr11, Yr12, Yr13, Yr14, Yr15;
		logic [15:0] Yr16, Yr17, Yr18, Yr19, Yr20, Yr21, Yr22, Yr23, Yr24, Yr25, Yr26, Yr27, Yr28, Yr29, Yr30, Yr31; 
		logic [15:0] Yi0, Yi1, Yi2, Yi3, Yi4, Yi5, Yi6, Yi7, Yi8, Yi9, Yi10, Yi11, Yi12, Yi13, Yi14, Yi15;
		logic [15:0] Yi16, Yi17, Yi18, Yi19, Yi20, Yi21, Yi22, Yi23, Yi24, Yi25, Yi26, Yi27, Yi28, Yi29, Yi30, Yi31;

		// Assert reset less often
		constraint rst_c { rst dist {1:=2, 0:=98}; }

		function new(string name = "FFT_seq_item");
			super.new(name);
		endfunction

	endclass

endpackage