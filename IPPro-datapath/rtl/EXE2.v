//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : EXE2 Pipeline Stage (Internal to DSP48E1)
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : EXE2.v
// Generated   : Fri July 26 11:51:11 2013
//
// Revision 0.1    : Mon Nov  04  11:20:18 2013
//
//------------------------------------------------------------------------------------------
//
// Description : Execution Stage 2
//				 - It controls the control signals of DSP48E1 needed for this EXE2 pipeline stage
//				 - OPMODE, ALUMODE, CEA2, CEB2, CEC, CEM
//
//------------------------------------------------------------------------------------------
// Revision 0.1:
//				- ENABLE and RESET control signal is added
//				- Additional PUASE Pipeline handling is added to retain the pipeline status
//				
//------------------------------------------------------------------------------------------

`include "parameters.v"

module EXE2
	(
		CLK,
		RESET,
		ENABLE,
		OPMODE,
		ALUMODE,
		CEA2,
		CEB2,
		CEC,
		CEM,
		OPMODE_EXE2,
		ALUMODE_EXE2,
		CEA2_EXE2,
		CEB2_EXE2,
		CEC_EXE2,
		CEM_EXE2
	);
	
	input 			CLK, RESET, ENABLE ;
	input	[6:0]	OPMODE ;
	input	[3:0] 	ALUMODE ;
	input 			CEA2, CEB2, CEC, CEM ;
	
	output  reg [6:0]	OPMODE_EXE2 ;
	output  reg [3:0]	ALUMODE_EXE2 ;
	output	reg 		CEA2_EXE2 , CEB2_EXE2, CEC_EXE2, CEM_EXE2 ;
	
	always @ (posedge CLK)
	begin
		if (RESET)
		begin
			OPMODE_EXE2 	<= 0 ;
			ALUMODE_EXE2 	<= 0 ;
			CEC_EXE2 		<= 0 ;
			CEA2_EXE2 		<= 0 ;
			CEB2_EXE2 		<= 0 ;
		end
		else if (ENABLE)
		begin
			OPMODE_EXE2 	<= OPMODE ;
			ALUMODE_EXE2 	<= ALUMODE ;
			CEC_EXE2 		<= CEC ;
			CEM_EXE2 		<= CEM ;
			CEA2_EXE2 		<= CEA2 ;
			CEB2_EXE2 		<= CEB2 ;
		end
		else
		begin
			OPMODE_EXE2 	<= OPMODE_EXE2 ;
			ALUMODE_EXE2 	<= ALUMODE_EXE2 ;
			CEC_EXE2 		<= CEC_EXE2 ;
			CEA2_EXE2 		<= CEA2_EXE2 ;
			CEB2_EXE2 		<= CEB2_EXE2 ;
		end
	end
	
endmodule
//------------------------------------------------------------------------------------------
