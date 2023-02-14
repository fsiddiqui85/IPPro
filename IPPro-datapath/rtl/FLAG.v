//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : ALU Flags Module
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : flag.v
// Generated   : Fri September 27 14:04:35 2013
//
// Revision 0.1    : Mon Nov  04  11:20:18 2013
// Revision 0.2    : Mon Mar  24  14:54:00 2014
// Revision 0.3    : Wed Jun  18  11:50:45 2014
//
//------------------------------------------------------------------------------------------
//
// Description : Handle the IPPro Flags  (Z,EQ,GT,STATUS)
//				 
//------------------------------------------------------------------------------------------
// Revision 0.1:
//				- ENABLE and RESET control signal is added
//				- Additional PUASE Pipeline handling is added to retain the pipeline status
//
// Revision 0.2:
//				- Signed Flag is included (SF)
//
// Revision 0.3
//				- Added NZF, NEQF, NSF, NGTF
//------------------------------------------------------------------------------------------
`include "parameters.v"

module FLAG
	(
		RESET,
		ENABLE,
		ALU_OUT,
		PATTERNDETECT,
		ZF,
		EQF,
		GTF,
		SF,
		NZF,
		NEQF,
		NSF,
		NGTF
	);
	
input		RESET, ENABLE ;
input		PATTERNDETECT ;
input 		[`ALU_OUT_depth-1:0] ALU_OUT ;
output	reg	ZF, EQF, GTF, SF ;
output		NZF, NEQF, NSF, NGTF;

	always @ (*)
	begin
		if (RESET)
		begin
			ZF	= 0 ;
			EQF = 0 ;
			GTF = 0 ;
			SF 	= 0 ;
		end
		else if (ENABLE)
		begin 
			ZF 	= (ALU_OUT[`ALU_OUT_depth-1:0]==0) ? 1:0 ;
			//ZF	= (ALU_OUT[`ALU_OUT_depth-1:0] && 16'hFFFF) ;
			EQF	= PATTERNDETECT ; 
			GTF = ALU_OUT[`ALU_OUT_depth-1]& ~PATTERNDETECT	;
			SF	= ALU_OUT[`ALU_OUT_depth-1] ;		
		end
		else
		begin
			ZF	= ZF  ;
			EQF	= EQF ;
			GTF	= GTF ;
			SF 	= SF  ;
		end
	end
	
	assign 	NZF 	= ~ZF ;
	assign	NEQF 	= ~EQF ;
	assign 	NSF 	= ~SF ;
	assign 	NGTF	= ~GTF ;
endmodule 
