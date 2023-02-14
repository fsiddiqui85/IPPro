//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Programmable By-Pass
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : PBypass_module.v
// Generated   : Thu Jan 07 16:31:26 2015
//
//------------------------------------------------------------------------------------------
//
// Description : Progrmmable Delay By-Pass Instruction
//					- Module takes the following parameters
//						+ COUNT_IN 		--> Loop Iteration count
//						+ COUNT_LIMIT	--> Loop Iteration limit
//						+ LOAD_COUNT	--> Control signal to load COUNT_IN
//						+ LD_LOOP_LIMIT	--> Control signal to load COUNT_LIMIT
//						+ COUNT_DOWN	--> Decrement the loop counter
//						+ C_COUNT		--> Output the current value of loop count
//						+ TERMINATE_LOOP--> Control signal to show the status of loop
//
//------------------------------------------------------------------------------------------

`include "parameters.v"

module PBypass_module(
		CLK,
		RESET,
		LOAD_COUNT,
		COUNT_VALUE,
		TERMINATE
	);
	
	input 			CLK, RESET ;
	input 			LOAD_COUNT ;
	input [`N-1:0]	COUNT_VALUE;
	output reg		TERMINATE ;
		
	reg	[`N-1:0] COUNT;	
	wire		 TER  ;
	//------------------------------------------------------------------------------------------
	// 	Counter
	//------------------------------------------------------------------------------------------	
	//always @ (posedge RESET or posedge LOAD_COUNT)
	always @ (posedge CLK)
	begin
		if (RESET)
			COUNT <= 0 ;
		else if (LOAD_COUNT)
			COUNT <= COUNT_VALUE ;
		else
			COUNT <= COUNT - 1;
	end	
	//------------------------------------------------------------------------------------------
	// 	Output Current Count Value
	//------------------------------------------------------------------------------------------	
	assign TER = (COUNT==0) ? 1:0 ;
	
	always @ (posedge CLK)
	begin
		if(RESET)
			TERMINATE <= 0 ;
		else
			TERMINATE <= TER ;
	end
//------------------------------------------------------------------------------------------
endmodule 
