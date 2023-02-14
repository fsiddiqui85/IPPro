//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Data-path implementation
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : MUXF7_41_module.v
// Generated   : Tue July 02 11:14:15 2013
//
//------------------------------------------------------------------------------------------
//
// Description : 4-1 Multiplexer Implementation
//
//------------------------------------------------------------------------------------------

`include "parameters.v"

module MUXF7_41_module 
	(
		OUT,
		DIN0,
		DIN1,
		DIN2,
		DIN3,
		SEL
	);
	
	input	[`MUX_depth-1:0]	DIN0;
	input	[`MUX_depth-1:0]	DIN1;
	input	[`MUX_depth-1:0]	DIN2;
	input	[`MUX_depth-1:0]	DIN3;
	input	[1:0]				SEL ;
	
	output	[`MUX_depth-1:0]	OUT;
	
	wire	[`MUX_depth-1:0]	MUX1_OUT;
	wire	[`MUX_depth-1:0]	MUX2_OUT;

	genvar i ;
	generate
		for (i = 0; i < `MUX_depth; i=i+1)
		begin: MUX_41_Block
			MUXF7 MUXF7_MUX1
			(
				.O(MUX1_OUT[i]),	// Output of MUX to general routing
				.I0(DIN0[i]), 		// Input (tie to LUT6 O6 pin)
				.I1(DIN1[i]), 		// Input (tie to LUT6 O6 pin)
				.S(SEL[0]) 			// Input select to MUX
			);
			
			MUXF7 MUXF7_MUX2
			(
				.O(MUX2_OUT[i]),	// Output of MUX to general routing
				.I0(DIN2[i]), 		// Input (tie to LUT6 O6 pin)
				.I1(DIN3[i]), 		// Input (tie to LUT6 O6 pin)
				.S(SEL[0]) 			// Input select to MUX
			);
			
			MUXF7 MUXF7_MUX3
			(
				.O(OUT[i]),			// Output of MUX to general routing
				.I0(MUX1_OUT[i]), 	// Input (tie to LUT6 O6 pin)
				.I1(MUX2_OUT[i]), 	// Input (tie to LUT6 O6 pin)
				.S(SEL[1]) 			// Input select to MUX
			);
		end
	endgenerate
//------------------------------------------------------------------------------------------		
endmodule 
