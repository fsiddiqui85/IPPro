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
// Create Date:   13:51:18 10/02/2014
// Design Name:   DF_Module
// Module Name:   C:/Git_Repo/canvas/Dataforwarding/src/tb_DF_Module.v
// Project Name:  dataforwarding
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DF_Module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define ADD	7'b0110011

module tb_DF_Module;

	// Inputs
	reg CLK;
	reg RESET;
	reg ENABLE;
	reg [4:0] D;
	reg [4:0] C;
	reg [6:0] OPMODE;

	// Outputs
	wire [6:0] OPMODE_DF;

	// Instantiate the Unit Under Test (UUT)
	DF_Module uut (
		.CLK(CLK), 
		.RESET(RESET), 
		.ENABLE(ENABLE), 
		.D(D), 
		.C(C), 
		.OPMODE(OPMODE), 
		.OPMODE_DF(OPMODE_DF)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 1;
		ENABLE = 0;
		D = 0;
		C = 0;
		OPMODE = 0;

		// Wait 100 ns for global reset to finish
		#90
		RESET = 0 ; 
		ENABLE = 1 ;
		
		#20
		OPMODE = `ADD ;
		D = 2 ;
		C = 1 ;
		
		#20
		OPMODE = `ADD ;
		D = 3 ;
		C = 2 ;
		
		#20
		OPMODE = `ADD ;
		D = 2 ;
		C = 3 ;
		
		#20
		OPMODE = `ADD ;
		D = 1 ;
		C = 1 ;

	end
	
	always #10 CLK = ~CLK ;
      
endmodule

