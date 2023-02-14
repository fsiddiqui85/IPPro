//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Data Forwarding Module
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : DF_Module.v
// Generated   : Thu Oct 2 12:19:04 2014
//
// "SCRIP"
// Revision 0.1	   : Wed June 05 11:49:45 2013 
//------------------------------------------------------------------------------------------
//
// Description : Data Forwarding module that checks and compare the source and destination
//				 operands of current to previous instruction and modify the DSP48_CW accordingly
//
//				RF_ADDRD, RF_ADDRB, RF_ADDRA, RF_ADDRC = 5-bits
//				OPMODE = 7-bits
//				OPMODE_DF = 7-bits (Modified OPMODE to forward data)
//------------------------------------------------------------------------------------------
// Revision 0.1 
//------------------------------------------------------------------------------------------

`include "parameters.v"

module DF_Module(
		CLK,
		RESET,
		ENABLE,
		D,
		B,
		OPMODE,
		OPMODE_DF
	);

	input 			CLK, ENABLE, RESET 	;
	input 	[4:0] 	D,B 				;	// Doesnt need A as it is need only for MULTIPLY
	input 	[6:0] 	OPMODE 				;
	output	[6:0]	OPMODE_DF 			;
	
	reg		[4:0]	PD		;	
	//------------------------------------------------------------------------------------------
	// Registers to store the address of previous operands
	//------------------------------------------------------------------------------------------	
	always @ (posedge CLK)
	begin
		if (RESET)
		begin
			PD	<= 0 ;
		end
		else if (ENABLE)
		begin
			PD	<= D ;
		end
		else
		begin
			PD	<= PD ;
		end
	end	
	
	assign OPMODE_DF = (PD==B) ? 7'b010_11_00 : OPMODE ; 
//------------------------------------------------------------------------------------------	
endmodule
