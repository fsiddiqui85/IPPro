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
// Create Date:   14:56:51 11/19/2014
// Design Name:   PUT_module
// Module Name:   C:/Git_Repo/canvas/Streaming-IPPro/Programmable-Direct-streaming/src/tb_PUT_module.v
// Project Name:  Programmable_Direct_Streaming
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PUT_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_PUT_module;

	// Inputs
	reg CLK;
	reg RESET;
	reg ENABLE;
	reg FULL;

	// Outputs
	wire ENABLE_CORE;
	wire FIFO_WRITE_EN;

	// Instantiate the Unit Under Test (UUT)
	PUT_module uut (
		.CLK(CLK), 
		.RESET(RESET), 
		.ENABLE(ENABLE), 
		.FULL(FULL), 
		.ENABLE_CORE(ENABLE_CORE), 
		.FIFO_WRITE_EN(FIFO_WRITE_EN)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 1;
		ENABLE = 0;
		FULL = 0;

		// Wait 100 ns for global reset to finish
		#100
        RESET = 0;
		ENABLE = 1;
		FULL = 0;
		
		#40
		FULL = 1;

	end
//---------------------------------------------------------------------------------//
	always #10 CLK = ~CLK ;
//---------------------------------------------------------------------------------//
endmodule

