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
// Create Date:   23:46:46 02/13/2015
// Design Name:   tb_IPPro_single_core_datapath
// Module Name:   C:/Git_Repo/IPPro_Simulation/Streaming_IPPro/single_core_sim/src/tb_IPPro_single_core_datapath.v
// Project Name:  Streaming IPPro
// Target Device:  
// Tool versions:  
// Description: 
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "parameters.v"

`define nCLK  	20

module tb_IPPro_single_core_datapath;

	integer LM_File ;
	integer i, j, value ;

	// Inputs
	reg CLK;
	reg RESET;
	reg ENABLE;
	reg ENABLE_PC ;
	reg EMPTY, FULL ;
	reg	[`INSTR_length-1:0]		INSTR ;
	reg [`FIFO_datasize-1:0]	DIN;
	

	// Outputs
	wire [`FIFO_datasize-1:0]	DOUT;
	wire DValid;
	wire READ_EN;
	wire WRITE_EN;
	wire [9:0] PC ;

	// Instantiate the Unit Under Test (UUT)
	IPPro_single_core_datapath uut (
		.CLK(CLK), 
		.RESET(RESET), 
		.ENABLE(ENABLE), 
		.ENABLE_PC(ENABLE_PC),
		.DIN(DIN), 
		.EMPTY(EMPTY),
		.FULL(FULL),
		.INSTR(INSTR),
		.PC(PC),
		.DValid(DValid), 
		.WRITE_EN(WRITE_EN), 
		.READ_EN(READ_EN), 
		.DOUT(DOUT)
	);

	initial begin
	// Initialize Inputs

	// Initialization files
	// Output data files
		//ALU_ptr 			= $fopen("../init/ALU.txt","w");
		//RF_DIN_ptr 		= $fopen("../init/RF_DIN.txt","w");
		//DM_DIN_ptr 		= $fopen("../init/DM_DIN.txt","w");
		//IMM_MEM_DO_ptr  	= $fopen("../init/IMM_MEM_DO.txt","w");
	
		// Initialize Inputs
		CLK = 0;
		RESET = 1;
		EMPTY = 0 ;
		FULL = 0 ;
		INSTR = 0 ;
		ENABLE_PC =  0;
		
		#110 
		RESET = 0 ;
		ENABLE = 1;
		
		// Manually FIFO simulation of Get instruction
		man_PUSH(2);
		man_PUSH(30);
		man_PUSH(40);
		man_PUSH(50);
		man_PUSH(60);
		man_PUSH(70);
		man_PUSH(80);
		man_PUSH(90);
		
		// Initialize the K1,K2,K3
		init_KM ;
		init_LM ;

		// Start running program
		#110
		start_processing ;
		
		//#1000
		//$fclose(ALU_ptr);
		//$fclose(RF_DIN_ptr);
		//$fclose(DM_DIN_ptr);
		//$fclose(IMM_MEM_DO_ptr);
	end
	
//------------------------------------------------------------------------------------------
// This task generate the stream of data
//------------------------------------------------------------------------------------------
	task start_processing ;
	begin
		// -------------------- Start Program ------------------------//
		// Read data from FIFO
		force tb_IPPro_single_core_datapath.uut.Program_Counter.RESET = 1 ;
		#`nCLK 
		release tb_IPPro_single_core_datapath.uut.Program_Counter.RESET ;
		ENABLE_PC =  1;
		//-------------- Simple IPPro Core Instructions Check ---------------------//
		
		// ------------- FIFO Data Interlock Check -----------------------//
		/*
		for(i=0;i<10*10;i=i+1)
		begin
			#`nCLK
				INSTR = {`get, 5'b00000, 5'b00000, 5'b00000, 5'b00000, 6'b000000};
			#`nCLK
				INSTR = {`push, 5'b00000, 5'b00000, 5'b00000, 5'b00000, 6'b000000};
			EMPTY = 0 ;
			#`nCLK
				INSTR = {`get, 5'b00000, 5'b00000, 5'b00000, 5'b00000, 6'b000000};
			#`nCLK
				INSTR = {`push, 5'b00000, 5'b00000, 5'b00000, 5'b00000, 6'b000000};
			
		end
		*/
			//----------------------
			// Kernel Memory - FIFO
			//----------------------
			#`nCLK
				INSTR = {`mulk,`R10,`K1, 5'b00000, 5'b00000, 6'b000000} ;
			#`nCLK
				INSTR = {`mulacck,`R10,`K1, 5'b00000 ,5'b00000,6'b000000} ;	
			#`nCLK
				INSTR = {`muladdk,`R6,`K3, 5'b00000, 5'b00000 ,6'b000000} ;
			#`nCLK
				INSTR = {`mulsubk,`R7,`K2, 5'b00000, 5'b00000 ,6'b000000} ;
			#`nCLK
				INSTR = {`stimm, 5'b00000, `K5, 16'h07FE};
			#`nCLK
				INSTR = {`stimm, 5'b00000, `K8, 16'h0008};
			#`nCLK
				INSTR = {`stimm, 5'b00000, `K9, 16'h07FF};
			#`nCLK
				INSTR = {`addk,`R20,`K3, 5'b00000, 5'b00000, 6'b000000} ;
			#`nCLK
				INSTR = {`push, 5'b00000, 5'b00000, 5'b00000, 5'b00000, 6'b000000};
			#`nCLK
				INSTR = {`addk,`R8,`K2, 5'b00000, 5'b00000, 6'b000000} ;
			#`nCLK
				INSTR = {`putlm, `R15, 5'b00000, 5'b00000, 5'b00000, 6'b000000};
			#`nCLK
				INSTR = {`subk,`R4,`K3, 5'b00000, 5'b00000, 6'b000000} ;
			#`nCLK
				INSTR = {`addk,`R3,`K1, 5'b00000, 5'b00000, 6'b000000} ;
			#`nCLK
				INSTR = {`addk,`R20,`K5, 5'b00000, 5'b00000, 6'b000000} ;
			#`nCLK
				INSTR = {`mink,`R1,`K1,5'b00000,5'b00000,6'b000000} ;
			#`nCLK
				INSTR = {`maxk,`R2,`K3,5'b00000,5'b00000,6'b000000} ;
				
			//-------------------------------------------
			// Store values into FIFO, KM and PUSH them
			//-------------------------------------------	
			#`nCLK
				INSTR = {`putkm, 5'b00000, `K6, 5'b00000, 5'b00000, 6'b000000};	
			#`nCLK
				INSTR = {`pushlm, 5'b00000, 5'b00000, `R10, 5'b00000, 6'b000000};
			#`nCLK
				INSTR = {`pushkm, 5'b00000, `K5, 5'b00000, 5'b00000, 6'b000000};		
			
			//----------------------
			// Local Memory - FIFO
			//----------------------
			#`nCLK	
				INSTR = {`mul,`R4,`R10, 5'b00000, 5'b00000, 6'b000000} ;
			#`nCLK	
				INSTR = {`mulacc,`R10,`R6,5'b00000,5'b00000,6'b000000} ;	
			#`nCLK
				INSTR = {`muladd,`R6,`R7, 5'b00000,5'b00000,6'b000000} ;
			#`nCLK
				INSTR = {`mulsub,`R7,`R8, 5'b00000,5'b00000,6'b000000} ;
			#`nCLK
				INSTR = {`add,`R11,`R10,5'b00000,5'b00000,6'b000000} ;
			#`nCLK
				INSTR = {`sub,`R13,`R7,5'b00000,5'b00000,6'b000000} ;
			#`nCLK
				INSTR = {`pushlm, 5'b00000, 5'b00000, `R13, 5'b00000, 6'b000000};
			#`nCLK
				INSTR = {`nop,`R0,`R0,`R0,`R0,6'b000000} ;
			#`nCLK
				INSTR = {`min,`R1,`R6,5'b00000,5'b00000,6'b000000} ;
			#`nCLK
				INSTR = {`max,`R2,`R30,5'b00000,5'b00000,6'b000000} ;
			//------ Branch if Zero ----------------//
			// Checks the value of ALU_OUT==0?
			//--------------------------------------//
			#`nCLK
				INSTR = {`nop,`R5,`R0,`R0,`R0,6'b000000} ;
		
			#`nCLK
				INSTR = {`bz,  5'b00000,5'b00000,16'h0003}	;
		
			//------ Branch if Not Zero --------//
		/*
			#`nCLK
				INSTR = {`bnz,  5'b00000,5'b00000,16'h0003}	;
		*/
			//------ Branch if not equal --------//
		/*
			#`nCLK
				INSTR = {`sub,`R20,`R7,5'b00000,5'b00000,6'b000000} ;
		
			#`nCLK
				INSTR = {`bneq,  5'b00000,5'b00000,16'h0003}	;
		*/
			//------ Branch if equal --------//
			// Compare the result with Rc 	 //
			//-------------------------------//
		/*
			#`nCLK
				INSTR = {`sublm,`R20,`R31, 5'b00000, `R8 ,6'b000000} ;
		
			#`nCLK
				INSTR = {`beq,  5'b00000,5'b00000,16'h0003}	;
		*/	
			//------ Branch if greater than ----------------//
			// Compare the Operands RC, RB  by doing Rc-Rb //
			//---------------------------------------------//
		
			#`nCLK
				INSTR = {`sublm,`R20,`R4, 5'b00000, `R8 ,6'b000000} ;
		
			#`nCLK
				INSTR = {`bgt,  5'b00000,5'b00000,16'h0003}	;
		
			//----------------------
			// Shift Operations
			//----------------------
			
			#`nCLK	
				INSTR = {`lsl,`R8,`R4,5'b00000,5'b00000,6'b000000} ;	// 	Verified
			#`nCLK	
				INSTR = {`lsllm,`R10,`R4,`R4,5'b00000,6'b000000} ;	
			man_PUSH(8);
			#`nCLK	
				INSTR = {`lslk,`R11,`K8, 5'b00000,5'b00000,6'b000000} ;		
			man_PUSH(256);
			#`nCLK	
				INSTR = {`lsr,`R12,`R20,5'b00000,5'b00000,6'b000000} ;	// 	Verified
			#`nCLK	
				INSTR = {`lsrlm,`R13,`R20,`R20,5'b00000,6'b000000} ;		
			#`nCLK	
				INSTR = {`lsrk,`R14,`K9, 5'b00000,5'b00000,6'b000000} ;	
			man_PUSH(2);
			//-----------------------------
			// Local Memory - Local Memory
			//-----------------------------
			#`nCLK	
				INSTR = {`mullm,`R16,`R11,`R4, 5'b00000, 6'b000000} ;
			#`nCLK	
				INSTR = {`mullmacc,`R10,`R7,`R8,5'b00000,6'b000000} ;	
			#`nCLK	
				INSTR = {`mullmadd,`R14,`R8,`R9,`R6,6'b000000} ;
			#`nCLK
				INSTR = {`push, 5'b00000, 5'b00000, 5'b00000, 5'b00000, 6'b000000};
			#`nCLK
				INSTR = {`mullmsub,`R10,`R9,`R10,`R11,6'b000000};
			#`nCLK
				INSTR = {`addlm,`R11,`R10,5'b00000,`R12,6'b000000} ;
			#`nCLK
				INSTR = {`sublm,`R13,`R7,5'b00000,`R6,6'b000000} ;		
			#`nCLK
				INSTR = {`minlm,`R1,`R9,5'b00000,`R12,6'b000000} ;
			#`nCLK
				INSTR = {`maxlm,`R2,`R9,5'b00000,`R21,6'b000000} ;
			#`nCLK
				INSTR = {`putlm, `R15, 5'b00000, 5'b00000, 5'b00000, 6'b000000};	
			//-----------------------------
			// Data Forwarding
			//-----------------------------		
			#`nCLK
				INSTR = {`addlm,`R12,`R2,5'b00000,`R3,6'b000000} ;
			#`nCLK
				INSTR = {`nop,`R0,`R0,`R0,`R0,6'b000000} ;
			#`nCLK
				INSTR = {`sublm,`R13,`R7,5'b00000,`R4,6'b000000} ;
			#`nCLK
				INSTR = {`addlm,`R10,`R4,5'b00000,`R14,6'b000000} ;		//	R14 is read after 04 CLKs  // DF
			#`nCLK		
				INSTR = {`addlm,`R15,`R10,5'b00000,`R11,6'b000000} ;	// 	R11 is read after 04 CLKs		
			#`nCLK
				INSTR = {`addlm,`R16,`R5,5'b00000,`R12,6'b000000} ;		// 	R12 is read twice in simultaneous instructions
			#`nCLK
				INSTR = {`addlm,`R17,`R12,5'b00000,`R12,6'b000000} ;	// 	R12 is used as operand twice in the same instr
			#`nCLK
				INSTR = {`nop,`R0,`R0,`R0,`R0,6'b000000} ;
			#`nCLK	
				INSTR = {`mullm,`R10,`R1,`R2,5'b00000,6'b000000} ;		// 	R10 is reused as destination after 04 CLKs
			#`nCLK
				INSTR = {`addlm,`R9,`R10,5'b00000,`R1,6'b000000} ;		//	DF
			#`nCLK
				INSTR = {`nop,`R0,`R0,`R0,`R0,6'b000000} ;
			#`nCLK
				INSTR = {`pbypass, 5'b00000, 5'b00000, 15'h0004};	
			//----------------------
			// Branch Instructions
			//----------------------	
			
			//#`nCLK
			//	INSTR = {`jmp, 5'b00000, 5'b00000, 16'h0004} ;
			
			#`nCLK
				INSTR = {`mulk,`R10,`K1, 5'b00000, 5'b00000, 6'b000000} ;
			#`nCLK
				INSTR = {`mulacck,`R10,`K1, 5'b00000 ,5'b00000,6'b000000} ;	
			#`nCLK
				INSTR = {`muladdk,`R6,`K3, 5'b00000, 5'b00000 ,6'b000000} ;
			#`nCLK
				INSTR = {`mulsubk,`R7,`K2, 5'b00000, 5'b00000 ,6'b000000} ;
			#`nCLK
				INSTR = {`nop,`R0,`R0,`R0,`R0,6'b000000} ;
			#`nCLK
				INSTR = {`bz,  5'b00000,5'b00000,16'h0003}	;
			#`nCLK
				INSTR = {`nop,`R0,`R0,`R0,`R0,6'b000000} ;

			#`nCLK
			#`nCLK
			#`nCLK
			#`nCLK
			#`nCLK
			#`nCLK
			#`nCLK
		ENABLE = 0 ;
		RESET = 1; 
	end
	endtask	
//------------------------------------------------------------------------------------------
	always 
		#10	CLK  = ~CLK ;
//------------------------------------------------------------------------------------------
// This task is to initialize the cores with constant value in KM
//------------------------------------------------------------------------------------------
	task init_KM ;
	begin
		RESET = 0 ;
		ENABLE = 1 ;
		#`nCLK
			INSTR = {`stimm, 5'b00000, `K1, 16'h0001};
		#`nCLK
			INSTR = {`stimm, 5'b00000, `K2, 16'h0002};		
		#`nCLK
			INSTR = {`stimm, 5'b00000, `K3, 16'h0003};	
		#`nCLK
			INSTR = {`nop,`R0,`R0,`R0,`R0,6'b000000} ;
	end
	endtask	
//------------------------------------------------------------------------------------------
// This task is to maually pass data to core
//------------------------------------------------------------------------------------------
	task man_PUSH ;
	input signed 	[15:0]   data	;
		begin		
		#`nCLK
			DIN = data ;
	end
	endtask	
//------------------------------------------------------------------------------------------
// This task is used to Enable and Disable the processing
//------------------------------------------------------------------------------------------
	task enable_processing ;
		begin
			#`nCLK 
			ENABLE = 1 ;
		end
	endtask 
//------------------------------------------------------------------------------------------
// This task is to disable the processor for N CLKs 
//------------------------------------------------------------------------------------------	
	 task disable_processing ;
	input [15:0] delay ;
	integer i ;
		begin
			for (i=1;i<=delay;i=i+1)
			begin
				#10 
				ENABLE = 0 ;
			end
		end
	endtask 
//------------------------------------------------------------------------------------------
// Write data in both input/output stage FIFO's
//------------------------------------------------------------------------------------------
	/*
	task PUSH ;
		input signed 	[15:0]   data	;
		begin
			force  tb_Programmable_Direct_Streaming.uut.SIMD_IPPro.STAGE1_FIFO[0].FB1.FIFO_IN = data ;		// Store FIFO
			force  tb_Programmable_Direct_Streaming.uut.SIMD_IPPro.STAGE2_FIFO[0].FB2.FIFO_IN = data ;		// Store FIFO
			force  tb_Programmable_Direct_Streaming.uut.SIMD_IPPro.STAGE1_FIFO[0].FB1.WRITE_EN = 1 ;		// Write Enable
			force  tb_Programmable_Direct_Streaming.uut.SIMD_IPPro.STAGE2_FIFO[0].FB2.WRITE_EN = 1 ;		// Write Enable
			#`nCLK
			force  tb_Programmable_Direct_Streaming.uut.SIMD_IPPro.STAGE1_FIFO[0].FB1.WRITE_EN = 0 ;		// Write Disable
			force  tb_Programmable_Direct_Streaming.uut.SIMD_IPPro.STAGE2_FIFO[0].FB2.WRITE_EN = 0 ;		// Write Disable
		end
	endtask
	*/
//------------------------------------------------------------------------------------------
// This task reads data into FIFO
//------------------------------------------------------------------------------------------
	/*
	task POP ;
		begin
			force  tb_Programmable_Direct_Streaming.uut.SIMD_IPPro.STAGE1_FIFO[0].FB1.READ_EN = 1 ;			// Read FIFO Enable
			force  tb_Programmable_Direct_Streaming.uut.SIMD_IPPro.STAGE2_FIFO[0].FB2.READ_EN = 1 ;			// Read FIFO Enable
			#`nCLK
			force  tb_Programmable_Direct_Streaming.uut.SIMD_IPPro.STAGE1_FIFO[0].FB1.READ_EN = 0 ;			// Read FIFO Disable
			force  tb_Programmable_Direct_Streaming.uut.SIMD_IPPro.STAGE2_FIFO[0].FB2.READ_EN = 0 ;			// Read FIFO Disable
		end
	endtask
	*/
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
// This task is used to initialize the Register File 
//------------------------------------------------------------------------------------------
	task store_LM ;
		input 			[4:0] 	LM_address ;
		input signed 	[15:0]  LM_data 	;
		
		begin
			force  tb_IPPro_single_core_datapath.uut.LM_ADDRD = LM_address ;	// Load LM_address
			force  tb_IPPro_single_core_datapath.uut.Core.LM_DIN = LM_data ;	// Load LM_data
			force  tb_IPPro_single_core_datapath.uut.LM_WE = 1 ;				// Write Enable
			#10
			force  tb_IPPro_single_core_datapath.uut.LM_WE = 0 ;				// Write Disable
		end
	endtask
//------------------------------------------------------------------------------------------	
// This task is to initialize Register File from file
//------------------------------------------------------------------------------------------	
	task init_LM ;
	integer j, value ; 
	begin
		j = 1 ;	
		LM_File		= $fopen("LM_init.dat","r");
		if (LM_File == 0) 
		begin
         $display("Error: Failed to open RF_init...\nExiting Simulation.");
         $finish;
		end	
	
		for(j=0;j<32;j=j+1)
		begin
			#10
			$fscanf(LM_File, "%d", value);
			$display("RF_Address = %d ; RF_Content = %d",j, value);
			store_LM(j,value);
		end
		
		// This task is to release the forced signal used for RF initialization
		#`nCLK
		release tb_IPPro_single_core_datapath.uut.LM_ADDRD ;
		release tb_IPPro_single_core_datapath.uut.Core.LM_DIN ;
		release tb_IPPro_single_core_datapath.uut.LM_WE ;
		
		$fclose(LM_File);
	end
	endtask
//------------------------------------------------------------------------------------------
endmodule  
