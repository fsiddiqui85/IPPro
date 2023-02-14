//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Pipeline_Synchronization Module
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : Pipe_Sync.v
// Generated   : Mon November 11 16:34:25 2013
//
// Revision 0.1    : Wed November 13 22:15:45
//
// Revision 2.0    : Tue November 26 12:41:22
//
//------------------------------------------------------------------------------------------
//
// Description : Generate ENBALE signals for different stages to maintain smooth transition 
//    			 into different states
//
//				i.e FINISH_PIPELINE, START, PAUSE, RESET
//					
//				 
//------------------------------------------------------------------------------------------
// Revision 0.1:
//				-  Removed EN_EXE2 signal from the module
//
// Revision 2.0:
//				-  EN_IF is removed as not been used by any module
//
//------------------------------------------------------------------------------------------
`include "parameters.v"

module Pipe_Sync
	(
		CLK,
		RESET,
		ENABLE,
		EN_ID,
		EN_EXE1,
		EN_WB
	);
	
	input		CLK, RESET, ENABLE ;
	output  reg	EN_ID, EN_EXE1, EN_WB ;
		
	// Local Registers
	reg	ID1  				;
	reg	EXE11,EXE12  		;
	reg	WB1,WB2,WB3,WB4		;
	
	always @ (posedge CLK)
	begin
		if (RESET)					//	Halt all stages instantly (at the moment but later shall be modified)!!!!
		begin						// 	RESET STATE
			EN_ID 	<= 0 ;
			EN_EXE1 <= 0 ;
			
			EN_WB 	<= 0 ;	

			ID1		<= 0 ;
			EXE11	<= 0 ;
			EXE12	<= 0 ;
			
			WB1		<= 0 ;
			WB2		<= 0 ;
			WB3 	<= 0 ;
			WB4		<= 0 ;
		end
		else if (ENABLE)			// Synchronize according to the pipeline depth 
		begin						// PROCESS STATE
			ID1		<= ENABLE;
			EN_ID 	<= ENABLE   ;
			
			EXE11	<= ENABLE;
			EXE12	<= ENABLE ;
			EN_EXE1 <= ENABLE ;
					
			WB1		<= ENABLE;
			WB2		<= ENABLE;
			WB3 	<= ENABLE   ;
			WB4		<= ENABLE   ;
			EN_WB   <= ENABLE   ;				
		end
		else
		begin
			ID1		<= ENABLE;
			EN_ID 	<= ID1   ;
			
			EXE11	<= ENABLE;
			EXE12	<= EXE11 ;
			EN_EXE1 <= EXE12 ;
	
			WB1		<= ENABLE;
			WB2		<= WB1	 ;
			WB3 	<= WB2   ;
			WB4		<= WB3   ;
			EN_WB   <= WB4   ;	
		end
	end
//------------------------------------------------------------------------------------------	
endmodule 
