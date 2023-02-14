//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Kernel Memory implementation
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : KM_RAM32M.v
// Generated   : Tue July 02 12:23:26 2013
//
//------------------------------------------------------------------------------------------
//
// Description : Single-Port 16-bits Immediate Memory (32 X 16 Bits)
//
//				 DIN = DINA = DINB = DINC = DIND
//					- PORT A,B,C  	(Asynchronous Read)
//					- PORT D		(Synchronous Write)
//
//------------------------------------------------------------------------------------------

`include "parameters.v"

module KM_RAM32M
	(
			KM_CLK,
			KM_WE,
			KM_ADDR,
			KM_DIN,
			KM_DO
	);
	
input							KM_CLK, KM_WE ;
input	[4:0]					KM_ADDR ;
input	[`KM_depth-1:0]	KM_DIN;
output	[`KM_depth-1:0]	KM_DO ;

	genvar j ;
	generate
		for (j=0 ; j < (`KM_depth/8) ; j=j+1)
		begin: KM_Blocks
		RAM32M_IMM_module KM
		(
			.WCLK(KM_CLK),
			.WE(KM_WE),
			.ADDR(KM_ADDR),
			.DIN(KM_DIN[((8*j)+7):(8*j)]),
			.DO(KM_DO[((8*j)+7):(8*j)])
		);
		end
	endgenerate	
//------------------------------------------------------------------------------------------	
endmodule 
