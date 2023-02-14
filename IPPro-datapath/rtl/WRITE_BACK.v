//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Write-Back Stage (Results written back to Register File)
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : WRITE_BACK.v
// Generated   : Thu August 01 12:08:22 2013
//
// Revision 0.1	   : Fri Aug 02 15:32:11 2013
// Revision 0.2    : Mon Nov 04 11:20:18 2013
// Revision 0.3    : Thu Nov 14 10:31:11 2013
// Revision 0.4    : Wed Oct 08 16:13:14 2014
//
//------------------------------------------------------------------------------------------
//
// Description : Write-Back Stage 
//				 - It controls the RF_WE signal Pipeline and synchronize it with the instruction
//				 - Match the latency of EU and generates the RF_WE respectively
//				 - Delay RF_ADDRB & RF_WE by 03 CLKs
//
//------------------------------------------------------------------------------------------
// Revision: 0.1
//				- Included DM_DOUT registers to balance the LD instruction
//				- DM_WE_WB is added to control signals pipeline 
//				
// Revision: 0.2
//				- ENABLE and RESET control signal is added
//				- Additional PUASE Pipeline handling is added to retain the pipeline status
//
// Revision: 0.3
//				- ELSE IF construct is added to implement the PAUSE and PIPELINE CLEAR states
//				- ELSE construct is modified and all registers are cleared to zero in order to 
//				  spare 03 CLK's needed for initialization i.e (RF_ADDRD_WB, DM_WE_WB etc)
//
// Revision: 0.4
//				- Added following signals to support Data-forwarding
//				- These signals are needed to evaluate and compare the (Source-Destination) of
//				  data dependent instructions
//					+ ADDRB_DF, ADDRD_DF
//------------------------------------------------------------------------------------------

`include "parameters.v"

module WRITE_BACK
	(
		CLK,
		RESET,
		ENABLE,
		RF_ADDRD,
		RF_ADDRB,
		RF_WE,	
		DM_WE,
		DM_DIN_SEL,
		RF_DIN_SEL,
		RF_WE_WB,
		RF_ADDRD_WB,
		RF_ADDRB_WB,
		DM_WE_WB,
		DM_DIN_SEL_WB,
		RF_DIN_SEL_WB,
		ADDRD_DF,
		ADDRB_DF
	);
	
	input					CLK, RESET, ENABLE ;
	input 					RF_WE, DM_WE ;
	input		[4:0] 		RF_ADDRD ;
	input		[4:0] 		RF_ADDRB ;
	input					DM_DIN_SEL ;
	input					RF_DIN_SEL;
	output reg 	[4:0] 		RF_ADDRD_WB ;
	output reg 	[4:0] 		RF_ADDRB_WB ;
	output reg 				RF_WE_WB, DM_WE_WB ;
	output reg 				DM_DIN_SEL_WB ;
	output reg 				RF_DIN_SEL_WB ;
	output		[4:0]		ADDRD_DF;
	output		[4:0]		ADDRB_DF ;
	
	reg			 			P1,P2 ;
	reg [4:0]	 			AP1, AP2, AP3;
	reg [4:0]	 			AB1, AB2, AB3;
	reg			 D1, D2 ;
	reg	DMSEL1, DMSEL2, DMSEL3 ;
	reg	RFSEL1, RFSEL2, RFSEL3 ;
		
	always @ (posedge CLK)
	begin
		if (RESET)
		begin
			P1 <= 0 ;
			P2 <= 0 ;
			
			AP1 <= 0 ;
			AP2 <= 0 ;
			AP3 <= 0;
			RF_WE_WB <= 0 ;
			RF_ADDRD_WB <= 0 ;
			
			AB1 <= 0 ;
			AB2 <= 0 ;
			AB3 <= 0 ;
			RF_ADDRB_WB <= 0;
						
			D1 <= 0 ;
			D2 <= 0 ;
			DM_WE_WB <= 0 ;
					
			DMSEL1 <= 0 ;
			DMSEL2 <= 0 ;
			DMSEL3 <= 0 ;
			DM_DIN_SEL_WB <= 0 ;
			
			RFSEL1 <= 0 ;
			RFSEL2 <= 0 ;
			RFSEL3 <= 0 ;
			RF_DIN_SEL_WB <= 0 ;
		end
		else if (ENABLE)
		begin
			P1 <= RF_WE ;
			P2 <= P1 ;				
			RF_WE_WB <= P2 ;		
					
			AP1 <= RF_ADDRD ;
			AP2 <= AP1 ;
			AP3 <= AP2 ;
			RF_ADDRD_WB <= AP3 ;
			
			AB1 <= RF_ADDRB ;
			AB2 <= AB1 ;
			AB3 <= AB2 ;
			RF_ADDRB_WB <= AB3;
								
			D1 <= DM_WE ;
			D2 <= D1 ;
			DM_WE_WB <= D2 ;
					
			DMSEL1 <= DM_DIN_SEL ;
			DMSEL2 <= DMSEL1 ;
			DMSEL3 <= DMSEL2 ;
			DM_DIN_SEL_WB <= DMSEL3 ;
			
			RFSEL1 <= RF_DIN_SEL ;
			RFSEL2 <= RFSEL1 ;
			RFSEL3 <= RFSEL2 ;
			//RF_DIN_SEL_WB <= RFSEL3 ;	
			RF_DIN_SEL_WB <= RFSEL2 ;	
		end
		else
		begin
			P1 <= 0 ;
			P2 <= 0 ;					
			RF_WE_WB <= 0 ;		
					
			AP1 <= 0 ;
			AP2 <= 0 ;
			AP3 <= 0 ;
			RF_ADDRD_WB <= 0 ;
			
			AB1 <= AB1 ;
			AB2 <= AB2 ;
			AB3 <= AB3 ;
			RF_ADDRB_WB <= 0;
								
			D1 <= 0 ;
			D2 <= 0 ;
			DM_WE_WB <= 0 ;
					
			DMSEL1 <= DMSEL1 ;
			DMSEL2 <= DMSEL2 ;
			DMSEL3 <= DMSEL3 ;
			DM_DIN_SEL_WB <= DM_DIN_SEL_WB ;
			
			RFSEL1 <= RFSEL1 ;
			RFSEL2 <= RFSEL2 ;
			RFSEL3 <= RFSEL3 ;
			RF_DIN_SEL_WB <= RF_DIN_SEL_WB ;	
		end
	end
	
	assign ADDRD_DF = AP1 ;
	assign ADDRB_DF = AB1 ;
//------------------------------------------------------------------------------------------	
endmodule 
