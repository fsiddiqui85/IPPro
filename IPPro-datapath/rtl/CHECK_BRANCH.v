//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Branch Unit
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : CHECK_BRANCH.v
// Generated   : Tue Novemeber 29 14:29:40 2013
//
// Revision 0.1    : xxx xxx  xx  11:20:18 2013
//
//------------------------------------------------------------------------------------------
//
// Description : Checks the Flags and Compare them for Branch Instructions
//				 
//------------------------------------------------------------------------------------------
// Revision 0.1:
//
//------------------------------------------------------------------------------------------

`include "parameters.v"

module CHECK_BRANCH
	(
		CLK,
		IM_FLAGS,
		ALU_FLAGS,
		BRANCH_SEL
	);
	
	input [`FLAGS_LENGTH-1:0] IM_FLAGS  ;
	input CLK;
	input [`FLAGS_LENGTH-1:0] ALU_FLAGS ;
	output reg BRANCH_SEL ;
	
	wire [`FLAGS_LENGTH-1:0] BR ;
	wire  SEL ;
	
	assign BR = IM_FLAGS & ALU_FLAGS ;
	assign SEL = BR && `CB_MASK ;
	
	
	always @ (posedge CLK)						// Retiming
	begin
		BRANCH_SEL <= SEL ;	
	end
	
//------------------------------------------------------------------------------------------	
endmodule 
