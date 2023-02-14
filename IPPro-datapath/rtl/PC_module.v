//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Program Counter Module
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : PC_module.v
// Generated   : Tue Novemeber 26 13:57:20 2013
//
// Revision 0.1    : xxx xxx  xx  11:20:18 2013
//
//------------------------------------------------------------------------------------------
//
// Description : Program Counter 
//				 
//------------------------------------------------------------------------------------------
// Revision 0.1:
//
//------------------------------------------------------------------------------------------

`include "parameters.v"

module PC_module(
		CLK,
		RESET,
		ENABLE,
		PC,
		NPC
	);
	
	input 						CLK, RESET, ENABLE ;
	input	[`IM_Length-1:0]	PC ;
	output	[`IM_Length-1:0]	NPC	;
			
	reg 	[`IM_Length-1:0]	CPC ;
	
	//------------------------------------------------------------------------------------------
	// Counter Assignment
	//------------------------------------------------------------------------------------------
	
	assign NPC = CPC ;
	//------------------------------------------------------------------------------------------
	// Program Counter
	//------------------------------------------------------------------------------------------ 
	always @ (posedge CLK)
	begin
		if (RESET)
		begin
			CPC <= 0 ;
		end
		else if(ENABLE)
		begin
			CPC <= PC + 1 ; 
		end
		else
		begin
			CPC <= CPC ;
		end
	end
	
//------------------------------------------------------------------------------------------	
endmodule
