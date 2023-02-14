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
// Create Date:   15:30:39 09/23/2014
// Design Name:   FIFO_module
// Module Name:   C:/Git_Repo/canvas/BRAM-FIFO/src/tb_FIFO_module.v
// Project Name:  BRAM-FIFO
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FIFO_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module tb_FIFO_module;

`define nCLK 20

	// Inputs
	reg CLK;
	reg RESET;
	reg ENABLE;
	reg WRITE_EN;
	reg READ_EN;
	reg [15:0]	FIFO_IN;

	// Outputs
	wire [15:0]	FIFO_OUT;
	wire EMPTY;
	wire FULL;
	wire ALMOST_EMPTY;
	wire ALMOST_FULL;
	wire [9:0]	RDCOUNT;
	wire [9:0] WRCOUNT;
	wire RDERR;
	wire WRERR;

	// Instantiate the Unit Under Test (UUT)
	FIFO_module uut (
		.CLK(CLK), 
		.RESET(RESET), 
		.ENABLE(ENABLE), 
		.WRITE_EN(WRITE_EN), 
		.READ_EN(READ_EN), 
		.FIFO_IN(FIFO_IN), 
		.FIFO_OUT(FIFO_OUT), 
		.EMPTY(EMPTY), 
		.FULL(FULL), 
		.ALMOST_EMPTY(ALMOST_EMPTY), 
		.ALMOST_FULL(ALMOST_FULL), 
		.RDCOUNT(RDCOUNT), 
		.WRCOUNT(WRCOUNT), 
		.RDERR(RDERR), 
		.WRERR(WRERR)
	);

	integer i ;
	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 1;
		ENABLE = 0;
		WRITE_EN = 0;
		READ_EN = 0;
		FIFO_IN = 0;

		// Wait 100 ns for global reset to finish
		#100
		RESET = 0 ;
		#110
				
		#`nCLK
		ENABLE = 1 ;
		PUSH(20);
		PUSH(30);
		PUSH(40);
		PUSH(50);
		for(i=1;i<1024;i=i+1)
			PUSH(i);
		for(i=1;i<1024;i=i+1)
			POP;
		POP;
		POP;
		POP;
		POP;
		PUSH(20);
		PUSH(30);
		PUSH(40);
		POP;
		PUSH(60);
		POP;
	
	end
//------------------------------------------------------------------------------------------     
	always #10 CLK = ~CLK ;
//------------------------------------------------------------------------------------------
// This task writes data into FIFO
//------------------------------------------------------------------------------------------
	task PUSH ;
	
		input signed 	[15:0]   data	;
		
		begin
			force  tb_FIFO_module.FIFO_IN = data ;		// Store FIFO
			force  tb_FIFO_module.WRITE_EN = 1 ;		// Write Enable
			#20
			force  tb_FIFO_module.WRITE_EN = 0 ;		// Write Disable
		end
	endtask
//------------------------------------------------------------------------------------------
// This task reads data into FIFO
//------------------------------------------------------------------------------------------
	task POP ;
	
		begin
			force  tb_FIFO_module.READ_EN = 1 ;			// Read FIFO Enable
			#20
			force  tb_FIFO_module.READ_EN = 0 ;			// Read FIFO Disable
		end
	endtask
//------------------------------------------------------------------------------------------
endmodule 
