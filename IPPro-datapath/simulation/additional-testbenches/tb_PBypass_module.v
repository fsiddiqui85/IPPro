`timescale 1ns / 1ps
//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------// Company: 
// Engineer:
//
// Create Date:   12:40:31 01/08/2015
// Design Name:   PBypass_module
// Module Name:   C:/Git_Repo/canvas/Streaming-IPPro/local-streaming/src/tb_PBypass_module.v
// Project Name:  Local_streaming
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PBypass_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_PBypass_module;

	// Inputs
	reg CLK;
	reg RESET;
	reg LOAD_COUNT;
	reg [15:0] COUNT_VALUE;

	// Outputs
	wire TERMINATE;

	// Instantiate the Unit Under Test (UUT)
	PBypass_module uut (
		.CLK(CLK), 
		.RESET(RESET), 
		.LOAD_COUNT(LOAD_COUNT), 
		.COUNT_VALUE(COUNT_VALUE), 
		.TERMINATE(TERMINATE)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 1;
		LOAD_COUNT = 0;
		COUNT_VALUE = 0;

		// Wait 100 ns for global reset to finish
		#100
        RESET = 0 ;
		COUNT_VALUE = 5 ;
		LOAD_COUNT 	= 1 ;
		
		#20
		LOAD_COUNT = 0 ;
		
		#200
		COUNT_VALUE = 10 ;
		LOAD_COUNT = 1 ;
		
		#20
		LOAD_COUNT = 0 ;
	end
	
	always #10 CLK = ~CLK ;
      
endmodule

