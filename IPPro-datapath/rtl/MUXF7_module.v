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
// Revision 0.1	   : Wed June 19 16:04:47 2013
//
//------------------------------------------------------------------------------------------
//
// File        : MUXF7_module.v
// Generated   : Tue May 28 16:33:10 2013
//
//------------------------------------------------------------------------------------------
//
// Description : Optimized Multiplexer Module 
//
// Revision: 0.1
//				- Parameters are included in parameters.v
//
//------------------------------------------------------------------------------------------
`include "parameters.v"
module MUXF7_module 
	(
		OUT,
		DIN0,
		DIN1,
		SEL
	);
	
	parameter MUX_depth = 16 ;
	
	input	[MUX_depth-1:0]	DIN0;
	input	[MUX_depth-1:0]	DIN1;
	input						SEL ;
	
	output	[MUX_depth-1:0]	OUT;

	genvar i ;
	generate
		for (i = 0; i < MUX_depth; i=i+1)
		begin: MUX_Block
			MUXF7 MUXF7_MUX 
			(
				.O(OUT[i]),			// Output of MUX to general routing
				.I0(DIN0[i]), 		// Input (tie to LUT6 O6 pin)
				.I1(DIN1[i]), 		// Input (tie to LUT6 O6 pin)
				.S(SEL) 			// Input select to MUX
			);
		end
	endgenerate
//------------------------------------------------------------------------------------------		
endmodule 
