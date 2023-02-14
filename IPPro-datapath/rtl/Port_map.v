//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : ALU Port Map Module
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : Port_map.v
// Generated   : Wed July 03 16:24:35 2013
//
//------------------------------------------------------------------------------------------
//
// Description : Map the PORTC of DSP48E depending on the type of Instruction
//
//				INSTR_TYPE 	| DSP48E PORTC (IMM_SEL)
//
//				    000		|         00			(Register - Register)
//					001 	|		  01			(Register - Immediate Constant)
//					010		|		  XX			(Data Memory Operations) not applicable here
//					011		|		  10			(Register - Immediate Memory)
//
//------------------------------------------------------------------------------------------
`include "parameters.v"

module Port_map
	(
		INSTR_TYPE,
		IMM_SEL
	);
	
	input		[2:0] 	INSTR_TYPE  ;
	output	reg [1:0] 	IMM_SEL		;
	
	always @(*)
	begin
		case (INSTR_TYPE)
			`RR	: IMM_SEL = 2'b10 ;			
			`RI	: IMM_SEL = 2'b01 ;
			`RK	: IMM_SEL = 2'b10 ;
			
			default: IMM_SEL = 2'b00 ;
		endcase
	end
//------------------------------------------------------------------------------------------	
endmodule 
