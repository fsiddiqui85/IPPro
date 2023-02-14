`timescale 1ns / 1ps
//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
// Company: 
// Engineer:
//
// Create Date:   14:50:34 11/19/2014
// Design Name:   GET_module
// Module Name:   C:/Git_Repo/canvas/Streaming-IPPro/Programmable-Direct-streaming/src/tb_GET_module.v
// Project Name:  Programmable_Direct_Streaming
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: GET_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_GET_module;

	// Inputs
	reg CLK;
	reg RESET;
	reg ENABLE;
	reg EMPTY;

	// Outputs
	wire ENABLE_CORE;
	wire FIFO_READ_EN;

	// Instantiate the Unit Under Test (UUT)
	GET_module uut (
		.CLK(CLK), 
		.RESET(RESET), 
		.ENABLE(ENABLE), 
		.EMPTY(EMPTY), 
		.ENABLE_CORE(ENABLE_CORE), 
		.FIFO_READ_EN(FIFO_READ_EN)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 1;
		ENABLE = 0;
		EMPTY = 0;

		// Wait 100 ns for global reset to finish
		#100
		RESET = 0 ;
		ENABLE = 1 ;
		
		#40
		EMPTY = 0 ;
		#20
		EMPTY = 1 ;
	end
//-----------------------------------------------------------------------------------------//     
	always #10 CLK = ~CLK ;
//-----------------------------------------------------------------------------------------//	
endmodule

