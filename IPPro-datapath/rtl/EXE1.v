//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : EXE1 Pipeline Stage (Internal to DSP48E1)
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : EXE1.v
// Generated   : Fri July 26 11:51:11 2013
//
// Revision 0.1    :
//
//------------------------------------------------------------------------------------------
//
// Description : Execution Stage 1 
//				 - It controls the control signals of DSP48E1 needed for this EXE1 pipeline stage
//				 - INMODE, CEP 
//
//------------------------------------------------------------------------------------------
// Revision 0.1:
//				- 
//				
//------------------------------------------------------------------------------------------

`include "parameters.v"

module EXE1
	(
		INMODE,
		CEP,
		INMODE_EXE1,
		CEP_EXE1
	);
	
	input	[4:0]	INMODE ;
	input 			CEP ;
	
	output  [4:0]	INMODE_EXE1 ;
	output			CEP_EXE1 ;
	
	assign INMODE_EXE1 	= INMODE ;
	assign CEP_EXE1 	= CEP ;

endmodule 
//------------------------------------------------------------------------------------------
