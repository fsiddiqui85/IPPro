//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Immediate Memory Basic Module
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : RAM32M_IMM_module.v
// Generated   : Tue July 02 14:37:26 2013
//
//------------------------------------------------------------------------------------------
//
// Description : Single-Port Immediate Memory (32 X 8 Bits)
//
//				 DIN = DINA = DINB = DINC = DIND
//					- PORT A,B,C  	(Asynchronous Read)
//					- PORT D		(Synchronous Write)
//
//------------------------------------------------------------------------------------------

module RAM32M_IMM_module
	(
		WCLK,
		WE,
		ADDR,
		DIN,
		DO
	);
	
input			WCLK,WE ;
input	[4:0]	ADDR ;
input	[7:0]	DIN ;
output	[7:0]	DO ;
	
	// RAM32M: 32-deep by 8-wide Multi Port LUT RAM
	// Virtex-6
	// Xilinx HDL Libraries Guide, version 12.3
	RAM32M #(
		.INIT_A(64'h1111111111111111), 	// Initial contents of A Port
		.INIT_B(64'h2222222222222222), 	// Initial contents of B Port
		.INIT_C(64'h3333333333333333), 	// Initial contents of C Port
		.INIT_D(64'h4444444444444444) 	// Initial contents of D Port
	) RAM32M_IMM (
		.DOA(DO[7:6]), 					// Read port A 2-bit output
		.DOB(DO[5:4]), 					// Read port B 2-bit output
		.DOC(DO[3:2]), 					// Read port C 2-bit output
		.DOD(DO[1:0]), 					// Read/rite port D 2-bit output
		.ADDRA(ADDR), 					// Read port A 5-bit address input
		.ADDRB(ADDR), 					// Read port B 5-bit address input
		.ADDRC(ADDR), 					// Read port C 5-bit address input
		.ADDRD(ADDR), 					// Read/rite port D 5-bit address input
		
		.DIA(DIN[7:6]), 				// RAM 2-bit data write input addressed by ADDRD,
		
		// read addressed by ADDRA
		.DIB(DIN[5:4]), 				// RAM 2-bit data write input addressed by ADDRD,
		
		// read addressed by ADDRB
		.DIC(DIN[3:2]), 				// RAM 2-bit data write input addressed by ADDRD,
		
		// read addressed by ADDRC
		.DID(DIN[1:0]), 				// RAM 2-bit data write input addressed by ADDRD,
		
		// read addressed by ADDRD
		.WCLK(WCLK), 					// Write clock input
		.WE(WE) 						// Write enable input
	);
	// End of RAM32M_inst instantiation
//------------------------------------------------------------------------------------------	
endmodule 
