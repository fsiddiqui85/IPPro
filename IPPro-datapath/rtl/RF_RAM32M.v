//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Register File implementation
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : RF_RAM32M.v
// Generated   : Wed May 22 14:25:04 2013
//
//------------------------------------------------------------------------------------------
//
// Description : Quad-Port 16-bits Register File (32 X 16 Bits)
//
//				 DIN = DINA = DINB = DINC = DIND
//					- PORT A,B,C  	(Asynchronous Read)
//					- PORT D		(Synchronous Write)
//
//------------------------------------------------------------------------------------------

`include "parameters.v"

module RF_RAM32M
	(
			RF_CLK,
			RF_WE,
			RF_ADDRA,
			RF_ADDRB,
			RF_ADDRC,
			RF_ADDRD,
			RF_DIN,
			RF_DOA,
			RF_DOB,
			RF_DOC,
			RF_DOD
	);
	
input					RF_CLK, RF_WE ;
input	[4:0]			RF_ADDRA, RF_ADDRB, RF_ADDRC, RF_ADDRD ;
input	[`RF_depth-1:0]	RF_DIN;
output	[`RF_depth-1:0]	RF_DOA, RF_DOB, RF_DOC, RF_DOD ; 

wire	[`RF_depth-1:0]	DIN  ;
wire	[`RF_depth-1:0]	DOA  ;
wire	[`RF_depth-1:0]	DOB  ;
wire	[`RF_depth-1:0]	DOC  ;
wire	[`RF_depth-1:0]	DOD  ;

	
	genvar i ;
	generate
		for (i=0 ; i < (`RF_depth/2) ; i=i+1)
		begin: RF_Blocks
		RAM32M_module RF(
				.WCLK(RF_CLK),
				.WE(RF_WE),
				.ADDRA(RF_ADDRA),
				.ADDRB(RF_ADDRB),
				.ADDRC(RF_ADDRC),
				.ADDRD(RF_ADDRD),
				.DIN(DIN[2*i+1:2*i]),
				.DOA(DOA[2*i+1:2*i]),
				.DOB(DOB[2*i+1:2*i]),
				.DOC(DOC[2*i+1:2*i]),
				.DOD(DOD[2*i+1:2*i])
				);
		end
	endgenerate
	
	
	// Generation of 64x16 size RF/LM
	/*
	genvar i ;
	generate
		for (i=0 ; i < `RF_depth/4 ; i=i+1)
		begin: RF_Blocks
		RAM32M_module RF(
				.WCLK(RF_CLK),
				.WE(RF_WE),
				.ADDRA(RF_ADDRA),
				.ADDRB(RF_ADDRB),
				.ADDRC(RF_ADDRC),
				.ADDRD(RF_ADDRD),
				.DIN(DIN[2*i+1:2*i]),
				.DOA(DOA[2*i+1:2*i]),
				.DOB(DOB[2*i+1:2*i]),
				.DOC(DOC[2*i+1:2*i]),
				.DOD(DOD[2*i+1:2*i])
				);
		end
	endgenerate
	*/
	
	assign DIN = RF_DIN ;
	assign RF_DOA = DOA ;
	assign RF_DOB = DOB ;
	assign RF_DOC = DOC ;
	assign RF_DOD = DOD ;
	
//------------------------------------------------------------------------------------------	
endmodule 
