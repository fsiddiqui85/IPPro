//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Instruction Decoder implementation (Enable Control Signals Included)
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : IR_Decoder.v
// Generated   : Wed May 22 10:15:04 2013
//
// Revision 0.1	   : Wed June 05 11:49:45 2013 
// Revision 0.2	   : Tue June 11 14:11:12 2013
// Revision 0.3    : Wed June 19 14:34:05 2013
// Revision 0.4    : Thu July 04 10:51:14 2013
// Revision 0.5    : Mon July 07 11:48:44 2013
// Revision 0.6    : Wed July 24 15:30:47 2013
// Revision 0.7    : Fri July 25 11:35:14 2013
// Revision 0.8	   : Tue July 30 14:45:10 2013
// Revision 0.9	   : Tue Aug  06 13:36:45 2013
// Revision 1.0    : Mon Aug  19 12:15:55 2013
// Revision 1.1    : Mon Nov  04 11:20:18 2013
// Revision 1.2    : Fri Nov  08 13:47:12 2013
// Revision 1.3    : Mon Oct  13 11:16:11 2014
// Revision 2.0	   : Tue Nov  18 22:01:45 2014		(Programmable Direct Streaming Model)
// Revision 2.0.1  : Thu Nov  27 15:54:47 2014		(Local Memory Streaming Model)
//
//------------------------------------------------------------------------------------------
//
// Description : Instruction Decoder (DSP48E_CW = 23-bits)
//
//				OPCODE = 5-bits
//				INSTR_TYPE = 3-bit
//
//				DSP48E_CW = {INMODE, OPMODE, ALUMODE, CEA2, CEB2, CEC, CEM, CEP, RF_WE, DM_WE}
//				IMM_MEM_WE
//
//					INMODE = 5-bits
//					OPMODE = 7-bits
//					ALUMODE= 4-bits
//------------------------------------------------------------------------------------------
// Revision 0.1 
//				- Introduced 16-bits IMMEDIATE Operations
//
// Revision 0.2
//				- LOAD instruction is included 
//				- Store instruction is included 
//				- DSP48E_CW is extended to 23-bits
//					DSP48E_CW = {INMODE, OPMODE, ALUMODE, CEA2, CEB2, CEC, CEM, CEP, RF_WE, DM_WE}
//
// Revision 0.3
//				- Added in IPPro_basic_32 project 
//
// Revision 0.4 
//				- Immediate memory instructions are added i.e ldimm, stimm
//				- The length of DSP48E_CW remains the same except IMM_MEM_WE is controlled by setting RF_WE
//
// Revision 0.5
//				- DSP48E_CW is extended to 24-bits
//					DSP48E_CW = {INMODE, OPMODE, ALUMODE, CEA2, CEB2, CEC, CEM, CEP, RF_WE, DM_WE, IMM_MEM_WE}
//
// Revision 0.6 
//				- DSP48E_CW is verified via modelsim for all the ALU instructions and included into this file
//				- The pipeline of the DSP48E1 is changed to REGA=REGB=1 
//				- Latency
//					- MUL based operations takes 2 CLKs
//					- ADD and other takes 01 CLKs
//
// Revision 0.7 
//				- DSP48E_CW is are verified in modelsim for all ALU instructions supported till date 
//				- The pipeline latency is fixed to 02 CLKs for all instructions 
//				- REGA = REGB = 2 in DSP48E1 Primitives
//				- Transition from MUL, MULACC etc. --> ADD, SUB, AND etc. is verified
//				- Execution unit is divided into 02 pipeline stages
//					- EXE1 & EXE2
//
// Revision 0.8
//				- Extra Pipeline is added to synchronize the instruction execution
//				- CLK signal is added !! 
//				- DSP48E_CW_REG <= DSP48E_CW
//				- muladdi, mulsubi & mov is removed !!!
//
// Revision 0.9
//				- Register - Immediate Memory Operations are added (CLASS 11)
//
// Revision 1.0
//				- IMM_MEM_WE is removed from DSP48E_CW_REG and IR_Decoder.v
//				- IMM_MEM_WE is generated in IPPro_16_Datapth
//				- DSP48E_CW is extended to 23-bits
//					DSP48E_CW = {INMODE, OPMODE, ALUMODE, CEA2, CEB2, CEC, CEM, CEP, RF_WE, DM_WE}
//
// Revision 1.1:
//				- ENABLE and RESET control signal is added
//				- Additional PUASE Pipeline handling is added to retain the pipeline status
//
// Revision 1.2:
// 				- Added support of shift instructions 
//					+ LSL
//					+ LSR
//
// Revision 1.3:
//				- MIN & MAX instruction is included
//
// Revision 2.0:
//				- Included the PUT & GET streaming mode FIFO instructions 
//				- The DW bit is been used to activate the modules
//				- Both instructions activates the respective modules i.e PUT_MODULE & GET_MODULE
//					+ GET is equivalent to LD except the data will be read from input FIFO and stored into RF
//					+ PUT check TASK STATUS and store data into output FIFO
//
// Revision 2.0.1: 
//				- Inlcuded GET_LM & PUT_LM
//					+ GET_LM	Reads data from FIFO and store into LM
//					+ PUT_LM	Reads data from Core and store into LM
//					+ MULLM		Mutiply two LMx and store them into LMy
//					+ MULLMADD, MULLMSUB, MULLMACC
//					+ MINLM, MAXLM
//					+ PBYPASS
//------------------------------------------------------------------------------------------

`include "parameters.v"

module IR_decode 
	(
		CLK,
		RESET,
		ENABLE,
		INSTR_TYPE,
		OPCODE,
		DSP48E_CW_REG
	);
	
	input				CLK, RESET, ENABLE ;
	input 		[2:0]	INSTR_TYPE 	;
	input		[4:0]	OPCODE		;
	output  reg [22:0] 	DSP48E_CW_REG ;
	
	reg			[22:0]	DSP48E_CW	;

	
	// Control Word Pipeline 
	always @(posedge CLK)
	begin
		if (RESET)
		begin
			DSP48E_CW_REG <= 0 ;
		end
		else if (ENABLE)
		begin
			DSP48E_CW_REG <= DSP48E_CW ;
		end
		else
		begin
			DSP48E_CW_REG <= DSP48E_CW_REG	;
		end
	end
	
	// Control Word Assignments
	always @ (*)
	begin
		case ({INSTR_TYPE,OPCODE})	
			`nop	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// nop
			//`bypass : DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// bypass
			`pbypass: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// pbypass
			
			//	Register - FIFO  (CLASS 00)
			`add 	: DSP48E_CW = {24'b00000_0110011_0000_11101_10} ;	// add
			`sub 	: DSP48E_CW = {24'b00000_0110011_0011_11101_10} ;	// sub
			`mul 	: DSP48E_CW = {24'b10001_0000101_0000_00111_10} ;	// mul
			`muladd	: DSP48E_CW = {24'b10001_0110101_0000_00111_10} ;	// muladd
			`mulsub	: DSP48E_CW = {24'b10001_0110101_0011_00111_10} ;	// mulsub
			`mulacc	: DSP48E_CW = {24'b10001_1000101_0000_00111_10} ;	// mulacc
			`land 	: DSP48E_CW = {24'b00000_0110011_1100_11101_10} ;	// and
			`lxor 	: DSP48E_CW = {24'b00000_0110011_0100_11101_10} ;	// xor
			`lxnr 	: DSP48E_CW = {24'b00000_0110011_0101_11101_10} ;	// xnr
			`lor  	: DSP48E_CW = {24'b00000_0111011_1100_11101_10} ;	// or
			`lnor 	: DSP48E_CW = {24'b00000_0111011_1110_11101_10} ;	// nor
			`lnot 	: DSP48E_CW = {24'b00000_0110011_1111_11101_10} ;	// not
			`lnand	: DSP48E_CW = {24'b00000_0110011_1110_11101_10} ;   // nand
			`lsl 	: DSP48E_CW = {24'b10001_0000101_0000_00111_10} ;	// lsl (Equivalent to Mul)
			`lsr 	: DSP48E_CW = {24'b10001_0000101_0000_00111_10} ;	// lsr (Equivalent to Mul)
			`min 	: DSP48E_CW = {24'b00000_0110011_0011_11101_10} ;	// min
			`max 	: DSP48E_CW = {24'b00000_0110011_0011_11101_10} ;	// max
		
			// Additional Local Memory Instructions (Streaming Mode Only) (CLASS 01)
			`mullm 		: DSP48E_CW = {24'b10001_0000101_0000_00111_10} ;	// mullm
			`mullmacc	: DSP48E_CW = {24'b10001_1000101_0000_00111_10} ;	// mullmacc
			`mullmadd	: DSP48E_CW = {24'b10001_0110101_0000_00111_10} ;	// mullmadd
			`mullmsub	: DSP48E_CW = {24'b10001_0110101_0011_00111_10} ;	// mullmsub
			
			`addlm 	: DSP48E_CW = {24'b00000_0110011_0000_11101_10} ;	// addlm
			`sublm 	: DSP48E_CW = {24'b00000_0110011_0011_11101_10} ;	// sublm
			`landlm	: DSP48E_CW = {24'b00000_0110011_1100_11101_10} ;	// andlm
			`lxorlm	: DSP48E_CW = {24'b00000_0110011_0100_11101_10} ;	// xorlm
			`lxnrlm	: DSP48E_CW = {24'b00000_0110011_0101_11101_10} ;	// xnrlm
			`lorlm 	: DSP48E_CW = {24'b00000_0111011_1100_11101_10} ;	// orlm
			`lnorlm	: DSP48E_CW = {24'b00000_0111011_1110_11101_10} ;	// norlm
			`lnotlm	: DSP48E_CW = {24'b00000_0110011_1111_11101_10} ;	// notlm
			`lnandlm: DSP48E_CW = {24'b00000_0110011_1110_11101_10} ;   // nandlm
			`lsllm 	: DSP48E_CW = {24'b10001_0000101_0000_00111_10} ;	// lsllm (Equivalent to Mul)
			`lsrlm 	: DSP48E_CW = {24'b10001_0000101_0000_00111_10} ;	// lsrlm (Equivalent to Mul)
			`minlm 	: DSP48E_CW = {24'b00000_0110011_0011_11101_10} ;	// minlm
			`maxlm 	: DSP48E_CW = {24'b00000_0110011_0011_11101_10} ;	// maxlm
				
			//	Data Memory Operations			(CLASS 10)
			`ld		: DSP48E_CW = {24'b00000_0000000_0000_11101_10} ;	// ld		
			`st		: DSP48E_CW = {24'b00000_0000000_0000_11101_01} ;	// st
			
			// Streaming mode instructions
			`push	: DSP48E_CW = {24'b00000_0000000_0000_11101_01} ;	// put
			`pushlm : DSP48E_CW = {24'b00000_0000000_0000_11101_01} ;	// pushlm
			`pushkm : DSP48E_CW = {24'b00000_0000000_0000_11101_01} ;	// pushkm
			
			`get	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// get == ld (Activate Modules PUT & GET)
			
			
			`putlm  : DSP48E_CW = {24'b00000_0000000_0000_11101_10} ;	// Store Core output into LM
			
			// Kernel Memory Operations		(CLASS 11)
			`stimm	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// stimm	WRITE
			`putkm	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// Write FIFO into KMx
		
			//	Register - Immediate Memory Operations  (CLASS 11)
			`addk 	: DSP48E_CW = {24'b00000_0110011_0000_11101_10} ;	// addk
			`subk	: DSP48E_CW = {24'b00000_0110011_0011_11101_10} ;	// subk
			`mulk 	: DSP48E_CW = {24'b10001_0000101_0000_00111_10} ;	// mulk
			`muladdk: DSP48E_CW = {24'b10001_0110101_0000_00111_10} ;	// muladdk
			`mulsubk: DSP48E_CW = {24'b10001_0110101_0011_00111_10} ;	// mulsubk
			`mulacck: DSP48E_CW = {24'b10001_1000101_0000_00111_10} ;	// mulacck
			`landk 	: DSP48E_CW = {24'b00000_0110011_1100_11101_10} ;	// andk
			`lxork 	: DSP48E_CW = {24'b00000_0110011_0100_11101_10} ;	// xork
			`lxnrk 	: DSP48E_CW = {24'b00000_0110011_0101_11101_10} ;	// xnrk
			`lork  	: DSP48E_CW = {24'b00000_0111011_1100_11101_10} ;	// ork
			`lnork 	: DSP48E_CW = {24'b00000_0111011_1110_11101_10} ;	// nork
			`lnandk	: DSP48E_CW = {24'b00000_0110011_1110_11101_10} ;   // nandk
			
			`lslk 	: DSP48E_CW = {24'b10001_0000101_0000_00111_10} ;	// lslk (Equivalent to Mul)
			`lsrk 	: DSP48E_CW = {24'b10001_0000101_0000_00111_10} ;	// lsrk (Equivalent to Mul)
			`mink 	: DSP48E_CW = {24'b00000_0110011_0011_11101_10} ;	// mink
			`maxk 	: DSP48E_CW = {24'b00000_0110011_0011_11101_10} ;	// maxk
			
			// Jump and Branch Instructions
			`jmp	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// jmp
			`bz 	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// bz		
			`beq	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// beq	
			`bgt	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// bgt
			`bs		: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// bsf
			
			`bnz	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// bnz
			`bneq	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// bneq
			`bns	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// bnsf
			`bngt	: DSP48E_CW = {24'b00000_0000000_0000_11101_00} ;	// bngt
			
			default	: DSP48E_CW = 0;							// NOP Operation
		endcase	
	end
// -----------------------------------------------------//	
endmodule 
