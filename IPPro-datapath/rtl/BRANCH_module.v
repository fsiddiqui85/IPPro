//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Branch Handler
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : BRANCH_module.v
// Generated   : Tue Novemeber 28 16:36:20 2013
//
// Revision 0.1    : xxx xxx  xx  11:20:18 2013
//
//------------------------------------------------------------------------------------------
//
// Description : Branch Address and Detection
//				 
//------------------------------------------------------------------------------------------
// Revision 0.1:
//
//------------------------------------------------------------------------------------------

`include "parameters.v"

module BRANCH_module(
		CLK,
		RESET,
		ENABLE,
		INSTR_TYPE,
		OPCODE,
		BADDR_IN,
		IM_FLAGS,
		BADDR_OUT
	);
	
	input 	CLK, RESET, ENABLE ;
	input	[2:0]	INSTR_TYPE;
	input	[4:0]	OPCODE	;
	input	[9:0]	BADDR_IN ;
	
	output	reg [`FLAGS_LENGTH-1:0]	IM_FLAGS ;		
	output	reg [9:0]	BADDR_OUT ;
	
	reg 	[`FLAGS_LENGTH-1:0]	F  ;
	
	
	always @ (*)
	begin
		case({INSTR_TYPE,OPCODE})
			8'b1_00_00011	: F = `BZ_MASK 	;	// 	BZ
			8'b1_00_00010	: F = `BEQ_MASK ;	//	BEQ
			8'b1_00_00101   : F = `BS_MASK ;	//	BSF
			8'b1_00_00100	: F = `BNZ_MASK ;	// 	BNZ
			8'b1_00_01000	: F = `BNS_MASK;	// 	BNSF
			8'b1_00_00110	: F = `BNGT_MASK;	// 	BNGTF
			8'b1_00_00111	: F = `BGT_MASK;	// 	BGTF
			8'b1_00_00001	: F = `BNEQ_MASK;	// 	BNEQF
			
			default: F = 8'b0000_0000 ;
		endcase
	end
	
//------------------------------------------------------------------------------------------	
	
	reg [`FLAGS_LENGTH-1:0]	F1, F2 ;
	reg [9:0]	B1, B2, B3, B4 ;
	
	
	always @ (posedge CLK)
	begin
		if (RESET)
		begin
			IM_FLAGS <= 0 ;
			BADDR_OUT<= 0 ;
			
			F1 <= 0 ;
			F2 <= 0 ;
			
			B1 <= 0;
			B2 <= 0;
			B3 <= 0;
			B4 <= 0;
		end
		else if (ENABLE)
		begin
			F1		<= F  ;
			F2		<= F1 ;
			IM_FLAGS<= F2 ;
			
			
			B1 	<= BADDR_IN ;
			B2 	<= B1 ;
			B3 	<= B2 ;
			B4  <= B3 ;
			BADDR_OUT	<= B3 ;
		end
		else
		begin
			IM_FLAGS 	<= IM_FLAGS ;
			BADDR_OUT 	<= BADDR_OUT ;
			
			F1 <= F1 ;
			F2 <= F2 ;
			
			B1 <= B1;
			B2 <= B2;
			B3 <= B3;
			B4 <= B4;
		end
	end
//------------------------------------------------------------------------------------------	
endmodule 
