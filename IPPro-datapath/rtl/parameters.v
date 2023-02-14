//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Architectural Parameters Definition
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : parameters.v
// Generated   : Wed June 19 14:31:22 2013
//
// "SCRIP"
// Revision 0.1	   : Wed June 19  14:37:03 2013
// Revision 0.2	   : Thu July 04  10:19:22 2013
// Revision 0.3    : Fri July 26  11:45:46 2013
// Revision 0.4    : Fri Aug  23  14:44:10 2013
//
// "SCRIP_General"
// Revision 2.0    : Tue Nov  26  11:56:44 2013
//
// "SCRIP_SIMD"
// Revision 3.0    : Wed Feb  26  10:44:47 2014
//
// "Streaming Models"
// Revision 4.0    : Thu Nov  13  12:56:44 2014
// Revision 4.1    : Tue Nov  18  22:30:45 2014
// Revision 4.2    : Wed Mar  11  15:52:12 2015
//
//------------------------------------------------------------------------------------------
//
// Description : Defines all the parameters including RF_depth, DM_depth and various 
//				 DSP48E specific parameters
//
// Revision 0.1 
//				- Processor is extended to 32-bits 
//				- ALU_OUT_depth, N, MUX_depth , INSTR_length, INSTR_frame, ZERO_16, ZERO_32 is defined 
//
// Revision 0.2
//				- KM_depth is defined for Immediate data memory
//				- RR, RI, RK, DM is defined for instruction decoding
//				- ldimm & stimm instructions are included
//				- P16 & P32 arguments are included
//				
// Revision 0.3
//				- CARRYINSELREG_Pipeline value is changed to 1 due to warning of OPMODE and CARRYINSEL mismatch
//
// Revision 0.4
//				- OPCODE of STIMM is changed from 00001 => 00000 (To simplify the STIMM decoding & improve performance)
//
// Revision 2.0 
//				- Included parameters for Instruction Memory
//				- JMP, BNZ is included
//
// Revision 3.0
//				- Removed the branch, jump instructions
//
// Revision 4.0
//				- Included the length of PC
// 
// Revision 4.1
//				- Included PUT & GET instructions for FIFO based model
//					+ PUT_LM instructions to support "Local Memory Streaming Model"
//					+ MULLM, MULLMACC, MULLMADD, MULLMSUB
//					+ PBYPASS
//				- Added LM-FIFO addressing mode
//				- Added MINLM, MAXLM instructions
//				
// Revision 4.2
//				- Included the following instructions
//					+ PUTKM
//
//------------------------------------------------------------------------------------------

// Go-to Synthesis Properties --> Verilog Macros 
//       Insert either P16|P32 as you wish to implement
/*
`ifdef P16
	`define		NP				1
	`define		N				16
	`define		INSTR_length	34
	`define 	INSTR_frame		6
	`define 	ZERO			`ZERO_16 	
	`define 	MASK   			`MASK_16 
`elsif P32
	`define		NP				2
	`define		N				32
	`define		INSTR_length	50
	`define 	INSTR_frame		22
	`define 	ZERO			`ZERO_32
	`define 	MASK   			`MASK_32
`endif
*/

// SIMD Parameters
//`define NC		9

// n-bit Processor 
`define NP				1			//  1|2
`define N 				16			//	N = 16 | 32
`define INSTR_length	34			//	34 | 50
`define INSTR_decode    `N

// Details of Instruction Memory
`define IM_Length		10			// 1024 == 10

// Shared Memory BRAM 18K parameters
`define SM18_READ_WIDTH_A	`N+2		// CAUTION: Could not be more than 18-bits !!!
`define SM18_READ_WIDTH_B	`N+2
`define SM18_WRITE_WIDTH_A	`N+2
`define SM18_WRITE_WIDTH_B	`N+2
`define SM18_ADDR			14

// Streaming mode parameters (FIFO)
`define FIFO_datasize		`N

// Defines the valid fields of Instruction									
`define INSTR_frame	6			//	6 | 22
// Change value based on n-bit architecture
`define ZERO `ZERO_16				// ZERO_16 | ZERO_32
// Chemge value based on n-bit architecture
`define MASK 			`MASK_16
// Defines the compare value 
`define FLAGS_MASK 	2'b11
 
 //---------------------------------------------------------------//
// Branch Handler Parameters
//---------------------------------------------------------------//

`define FLAGS_LENGTH	8
`define BZ_MASK			8'b0000_0001
`define BEQ_MASK		8'b0000_0010
`define BS_MASK			8'b0000_0100
`define BGT_MASK		8'b0000_1000
`define BNZ_MASK		8'b0001_0000
`define BNS_MASK		8'b0010_0000
`define BNEQ_MASK		8'b0100_0000
`define BNGT_MASK		8'b1000_0000

`define DEFAULT_MASK	8'b0000_0000
`define CB_MASK			8'b1111_1111
 
 
//------------------------------------------------------------------------------------------
// Please don't change any value below this line as they all are dependent on the above parameters
//------------------------------------------------------------------------------------------									
// n-bits Constant
`define ZERO_16			16'h0000
`define ZERO_32			32'h0000_0000
`define ONES_16			16'hffff
`define ONES_32			32'hffff_ffff
// Pattern Detector Parameters
`define MASK_16   		48'hffff_ffff_8000
`define MASK_32   		48'hffff_8000_0000 

// Instruction Memory Parameters
`define DOA_REG			1
`define READ_WIDTH_A 	36
`define WRITE_WIDTH_A	36
	
// Register File, Data Memory Size (Length is restricted to 32 x X)
// Multiplexer size and DSP48E1 output data width
`define RF_depth		`N
`define KM_depth		`N	
`define DM_depth  		`N	
`define MUX_depth 		`N
`define ALU_OUT_depth	`N
`define IMM_MEM_depth	`N
`define MUX_depth_addr  5

// Standard Constants
`define ENABLE 		1'b1
`define DISABLE 	1'b0

// Instruction Classes
`define	RR		3'b000
`define	RI		3'b001
`define DM		3'b010
`define RK		3'b011
`define RRFIFO  3'b100

// Registers Definition
`define R0	5'b00000
`define R1	5'b00001
`define R2	5'b00010
`define R3	5'b00011
`define R4	5'b00100
`define R5	5'b00101
`define R6  5'b00110
`define R7  5'b00111
`define R8  5'b01000
`define R9  5'b01001
`define R10 5'b01010
`define R11 5'b01011
`define R12 5'b01100
`define R13 5'b01101
`define R14 5'b01110
`define R15 5'b01111
`define R16 5'b10000
`define R17 5'b10001
`define R18 5'b10010
`define R19 5'b10011
`define R20 5'b10100
`define R21 5'b10101
`define R22 5'b10110
`define R23 5'b10111
`define R24 5'b11000
`define R25 5'b11001
`define R26 5'b11010
`define R27 5'b11011
`define R28 5'b11100
`define R29 5'b11101
`define R30 5'b11110
`define R31 5'b11111


// Data Memory Locations
`define M0	5'b00000
`define M1	5'b00001
`define M2 	5'b00010
`define M3	5'b00011
`define M4	5'b00100
`define M5 	5'b00101
`define M6  5'b00110
`define M7  5'b00111
`define M8  5'b01000
`define M9  5'b01001
`define M10 5'b01010
`define M11 5'b01011
`define M12 5'b01100
`define M13 5'b01101
`define M14 5'b01110
`define M15 5'b01111
`define M16 5'b10000
`define M17 5'b10001
`define M18 5'b10010
`define M19 5'b10011
`define M20 5'b10100
`define M21 5'b10101
`define M22 5'b10110
`define M23 5'b10111
`define M24 5'b11000
`define M25 5'b11001
`define M26 5'b11010
`define M27 5'b11011
`define M28 5'b11100
`define M29 5'b11101
`define M30 5'b11110
`define M31 5'b11111

// Data Memory Locations
`define K0	5'b00000
`define K1	5'b00001
`define K2 	5'b00010
`define K3	5'b00011
`define K4	5'b00100
`define K5 	5'b00101
`define K6  5'b00110
`define K7  5'b00111
`define K8  5'b01000
`define K9  5'b01001
`define K10 5'b01010
`define K11 5'b01011
`define K12 5'b01100
`define K13 5'b01101
`define K14 5'b01110
`define K15 5'b01111
`define K16 5'b10000
`define K17 5'b10001
`define K18 5'b10010
`define K19 5'b10011
`define K20 5'b10100
`define K21 5'b10101
`define K22 5'b10110
`define K23 5'b10111
`define K24 5'b11000
`define K25 5'b11001
`define K26 5'b11010
`define K27 5'b11011
`define K28 5'b11100
`define K29 5'b11101
`define K30 5'b11110
`define K31 5'b11111

//---------------------------------------------------
// DSP48E1 specific parameters
`define REGA_Pipeline 			2
`define REGB_Pipeline 			2
`define REGC_Pipeline 			1
`define REGD_Pipeline 			1
`define INMODEREG_Pipeline 		1
`define OPMODEREG_Pipeline 		1
`define MREG_Pipeline 			1
`define PREG_Pipeline 			1
`define ALUMODEREG_Pipeline 	1
`define ACASCREG_Pipeline 		2
`define ADREG_Pipeline 			1
`define BCASCREG_Pipeline 		2
`define CARRYINREG_Pipeline 	1
`define CARRYINSELREG_Pipeline 	1

//	Instruction Table

	`define nop 	8'b0_00_00000

	//	LM - FIFO   	CLASS 00
	`define add		8'b0_00_00001
	`define sub		8'b0_00_00010
	`define mul		8'b0_00_00011
	`define	muladd	8'b0_00_00100
	`define	mulsub	8'b0_00_00101
	`define mulacc	8'b0_00_00110
	`define land	8'b0_00_00111
	`define lxor	8'b0_00_01000
	`define lxnr	8'b0_00_01001
	`define lor		8'b0_00_01010
	`define lnor	8'b0_00_01011
	`define	lnot	8'b0_00_01100
	`define lnand	8'b0_00_01101
	`define lsl		8'b0_00_01110
	`define lsr		8'b0_00_01111
	`define max		8'b0_00_10000
	`define min		8'b0_00_10001

	// LM - LM CLASS 01
	`define mullm		8'b0_01_00011
	`define mullmadd	8'b0_01_00100
	`define mullmsub 	8'b0_01_00101
	`define mullmacc	8'b0_01_00110	
	`define addlm		8'b0_01_00001
	`define sublm		8'b0_01_00010
	`define landlm		8'b0_01_00111
	`define lxorlm		8'b0_01_01000
	`define lxnrlm		8'b0_01_01001
	`define lorlm		8'b0_01_01010
	`define lnorlm		8'b0_01_01011
	`define	lnotlm		8'b0_01_01100
	`define lnandlm		8'b0_01_01101
	`define lsllm		8'b0_01_01110
	`define lsrlm		8'b0_01_01111
	`define maxlm		8'b0_01_10000
	`define minlm		8'b0_01_10001
	
	//------------- Shall only be used in Memory Mapped Architecture --------------//
	`define ld		8'b0_10_00000
	`define st		8'b0_10_00001
	
	//----------- Shall only be used in Streaming based Architecture --------------//
	// Streaming FIFO read/write instructions
	`define get		8'b0_10_00010
	
	`define push	8'b0_10_00011
	`define pushlm  8'b0_10_00111
	`define pushkm  8'b0_10_01011
	
	`define putlm	8'b0_10_00101
	
	// BYPASS Instruction
	//`define bypass  8'b0_10_11010
	`define pbypass 8'b0_10_11000
	
	//	KM - FIFO			CLASS 11
	`define stimm	8'b0_11_00000
	`define putkm   8'b0_11_00001

	`define addk	8'b0_11_00010
	`define subk	8'b0_11_00011	
	`define mulk 	8'b0_11_00100
	`define	muladdk	8'b0_11_00101
	`define	mulsubk	8'b0_11_00110
	`define mulacck 8'b0_11_00111
	`define lxork	8'b0_11_01000
	`define lxnrk	8'b0_11_01001
	`define lork	8'b0_11_01010
	`define lnork	8'b0_11_01011
	`define landk	8'b0_11_01100
	`define lnandk	8'b0_11_01101
	`define lslk	8'b0_11_01110
	`define lsrk	8'b0_11_01111
	`define mink	8'b0_11_10000
	`define maxk	8'b0_11_10001

	// Branch and Jump Instructions			(All the following are treated as NOP)
	`define jmp		8'b1_00_00000
	`define bneq	8'b1_00_00001
	`define beq		8'b1_00_00010
	`define bz		8'b1_00_00011
	`define bnz		8'b1_00_00100
	`define bs		8'b1_00_00101
	`define bns  	8'b1_00_01000
	`define bngt	8'b1_00_00110
	`define bgt		8'b1_00_00111
//------------------------------------------------------------------------------------------	
