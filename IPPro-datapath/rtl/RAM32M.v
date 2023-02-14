//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Register File Basic Module
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : RAM32M.v
// Generated   : Wed May 22 13:35:04 2013
//
//------------------------------------------------------------------------------------------
//
// Description : Quad-Port Register File (32 X 2 Bits)
//
//				 DIN = DINA = DINB = DINC = DIND
//					- PORT A,B,C  	(Asynchronous Read)
//					- PORT D		(Synchronous Write)
//
//------------------------------------------------------------------------------------------

module RAM32M_module
	(
		WCLK,
		WE,
		ADDRA,
		ADDRB,
		ADDRC,
		ADDRD,
		DIN,
		DOA,
		DOB,
		DOC,
		DOD
	);
	
input			WCLK,WE ;
input		[4:0]	ADDRA, ADDRB, ADDRC, ADDRD ;
input		[1:0]	DIN ;
output	[1:0]	DOA, DOB, DOC, DOD ;
	
	// RAM32M: 32-deep by 8-wide Multi Port LUT RAM
	// Virtex-6
	// Xilinx HDL Libraries Guide, version 12.3
	RAM32M #(
		.INIT_A(64'h1111111111111111), 	// Initial contents of A Port
		.INIT_B(64'h2222222222222222), 	// Initial contents of B Port
		.INIT_C(64'h3333333333333333), 	// Initial contents of C Port
		.INIT_D(64'h4444444444444444) 	// Initial contents of D Port
	) RAM32M_RF (
		.DOA(DOA), 						// Read port A 2-bit output
		.DOB(DOB), 						// Read port B 2-bit output
		.DOC(DOC), 						// Read port C 2-bit output
		.DOD(DOD), 						// Read/write port D 2-bit output
		.ADDRA(ADDRA), 					// Read port A 5-bit address input
		.ADDRB(ADDRB), 					// Read port B 5-bit address input
		.ADDRC(ADDRC), 					// Read port C 5-bit address input
		.ADDRD(ADDRD), 					// Read/write port D 5-bit address input
		
		.DIA(DIN), 						// RAM 2-bit data write input addressed by ADDRD,
		
		// read addressed by ADDRA
		.DIB(DIN), 						// RAM 2-bit data write input addressed by ADDRD,
		
		// read addressed by ADDRB
		.DIC(DIN), 						// RAM 2-bit data write input addressed by ADDRD,
		
		// read addressed by ADDRC
		.DID(DIN), 						// RAM 2-bit data write input addressed by ADDRD,
		
		// read addressed by ADDRD
		.WCLK(WCLK), 					// Write clock input
		.WE(WE) 						// Write enable input
	);
	// End of RAM32M_inst instantiation
	
	
	/*
//   RAM64M    : In order to incorporate this function into the design,
//   Verilog   : the following instance declaration needs to be placed
//  instance   : in the body of the design code.  The instance name
// declaration : (RAM64M_inst) and/or the port declarations within the
//    code     : parenthesis may be changed to properly reference and
//             : connect this function to the design.  All inputs
//             : and outputs must be connected.

//  <-----Cut code below this line---->

   // RAM64M: 64-deep by 4-wide Multi Port LUT RAM
   //         Virtex-6
   // Xilinx HDL Language Template, version 14.1
   
   RAM64M #(
      .INIT_A(64'h0000000000000000), // Initial contents of A Port
      .INIT_B(64'h0000000000000000), // Initial contents of B Port
      .INIT_C(64'h0000000000000000), // Initial contents of C Port
      .INIT_D(64'h0000000000000000)  // Initial contents of D Port
   ) RAM64M_inst (
      .DOA(DOA),     // Read port A 1-bit output
      .DOB(DOB),     // Read port B 1-bit output
      .DOC(DOC),     // Read port C 1-bit output
      .DOD(DOD),     // Readw/rite port D 1-bit output
      .DIA(DIN),     // RAM 1-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRA
      .DIB(DIN),     // RAM 1-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRB
      .DIC(DIN),     // RAM 1-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRC
      .DID(DIN),     // RAM 1-bit data write input addressed by ADDRD, 
                     //   read addressed by ADDRD
      .ADDRA(ADDRA), // Read port A 6-bit address input
      .ADDRB(ADDRB), // Read port B 6-bit address input
      .ADDRC(ADDRC), // Read port C 6-bit address input
      .ADDRD(ADDRD), // Readw/rite port D 6-bit address input
      .WE(WE),       // Write enable input
      .WCLK(WCLK)    // Write clock input
   );
	*/
   // End of RAM64M_inst instantiation
						
//------------------------------------------------------------------------------------------	
endmodule 
