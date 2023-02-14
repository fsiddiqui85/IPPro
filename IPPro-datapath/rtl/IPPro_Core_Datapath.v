//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : IPPro Core Datapath
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : IPPro_Core_Datapath.v
// Generated   : Mon May 27 11:18:41 2013
//
// "IPPro"
// Revision 0.1	   : Wed June 05  14:15:20 2013
// Revision 0.2    : Wed June 05  15:16:10 2013
// Revision 0.3	   : Tue June 11  14:11:12 2013
// Revision 0.4	   : Tue July 02  11:30:45 2013
// Revision 0.5    : Mon July 07  11:48:44 2013
// Revision 0.6    : Fri July 26  12:29:05 2013
// Revision 0.7    : Mon Aug  05  11:39:06 2013
// Revision 0.8	   : Fri Aug  16  11:30:07 2013 
// Revision 0.9    : Fri Aug  23  15:14:48 2013
// Revision 1.0    : Fri Sep  27  14:25:45 2013
// Revision 1.1    : Mon Nov  04  11:16:11 2013
// Revision 1.2    : Fri Nov  08  13:46:23 2013
// Revision 1.3    : Thu Nov  14  11:38:12 2013
//
// "IPPro_General"
// Revision 2.0    : Tue Nov  26  11:27:44 2013
// Revision 2.1    : Mon Dec  02  12:54:55 2013
//
// "IPPro_SIMD"
// Revision 3.0    : Wed Feb  26  10:44:47 2014        
// Revision 3.1    : Fri Feb  28  11:10:45 2014
// Revision 3.2    : Wed Mar  05  15:36:44 2014
//
// "Shared_IPPro_Datapath"
// Revision 4.0    : Fri May  23  14:12:45 2014
// Revision 4.0.1  : Wed June 04  14:58:11 2014
//
// "Direct Streaming IPPro"
// Revision 4.1.0  : Thu Oct  30  11:52:10 2014
//
// "Local Memory Streaming IPPro"
// Revision 4.2.0  : Tue Nov  25  14:10:11 2014
// Revision 4.2.1  : Fri Mar  06  16:00:00 2015
//
//------------------------------------------------------------------------------------------
//
// Description : IPPro Data-path
//
//				Included Module: RF, ALU, Instr_Decoder, DM
//
//				Explicitly Enable: CED, CEA1, CEB1, CEALUMODE, CEINMODE, CECTRL
//				Ignored			 : CED, CEAD (additionally cascade and carry signals)
//			
//				IR_Decoder Controlled : CEA2, CEB2, CEC, CEM, CEP	
//------------------------------------------------------------------------------------------
// Revision: 0.1
//				- Introduce MUX to support IMMEDIATE operations
//				- Control select of MUX is connected with the OPCODE[4] as defined in the decoder
//
// Revision: 0.2
//				- INSTR_TYPE is increased to 3 bits
//				- It will represent (16/32 bit operations, 04 different instruction classes)
//				- 02 MUX are added to support Immediate instructions @ PORTA and PORTC of ALU
//
// Revision: 0.3
//				- LOAD and store instruction is included 
//				- DSP48E_CW is extended to 23-bits
//					DSP48E_CW = INMODE, OPMODE, ALUMODE, CEA2, CEB2, CEC, CEM, CEP, RF_WE, DM_WE	
//
// Revision: 0.4
//				- Include MUX_41 module in data-path
//				- Increase length of MUX select signal IMM_SEL from single bit to [1:0]
//				- Kernel memory is added based on RAM32M primitive
//				- Input Port map is included but not completely
//				- Data-path of Kernel memory is added in support of LDIMM, STIMM 
//				- Complete implementation is generalized using parameters i.e; P16 & P32 
//
// Revision: 0.5
//				- DSP48E_CW is extended to 24-bits
//					DSP48E_CW = {INMODE, OPMODE, ALUMODE, CEA2, CEB2, CEC, CEM, CEP, RF_WE, DM_WE, IMM_MEM_WE}
//				- IMM_MEM_WE is assigned from DSP48E_CW instead of RF_WE
//
// Revision: 0.6
//				- Added EXE1 & EXE2 modules to control the pipeline stages of DSP48E1
//				- Added REG_C i.e Extra PORTC register to fix the latency of all instructions to 2 CLKs
//					- This REG_C is added after EU_Pipeline 
//
// Revision: 0.7
//				- DM_ADDR = RF_ADDRB_WB changed from DM_ADDR = RF_ADDRB to balance the pipeline for ST instruction
//				- DM_WE = DM_WE_WB
//				- Pipelined the MUX control signals
//					- RF_DIN_SEL_WB
//					- DM_DIN_SEL_WB
//				- Immediate memory operations are included
//				
// Revision: 0.8
//				- Instruction Fetch (IF) is included
//
// Revision: 0.9 
//				- IMM_MEM_WE signal is changed to digital gate based decoding to improve the performance
//
// Revision: 1.0 
//				- ALU Flags are Included (ZF, EQF, GTF)
//
// Revision: 1.1  
//				- All Synchronous logic in SCRIP_Datapath.v is bounded by ENABLE and RESET Signals including the following:
//					+ FLAG.v
//					+ EXE2.v
//					+ IR_Decode.v
//				- Additional PUASE Pipeline handling is added to retain the pipeline status
//				- DOUT_Valid signal is added 
//					+ 1 when ALU operations are performed
//					+ 0 when Memory operations are performed
//
// Revision: 1.2 
//				- Added support of shift instructions 
//					+ LSL
//					+ LSR
//
// Revision: 1.3
//				- Added support for Pipeline Execution in case of data transfer
//				- Once the ENBALE = 0 
//					+ Pipeline will keep process already fetched instructions i.e; 4 CLKs
//					+ Reset = HIGH to reset the intermediate data and to avoid unwanted write operations
//					+ Reset = LOW and ENABLE = 1
//				- The above functionality is simulated in the testbench needed to be added in FSM
//				- DOUT_Valid is verified. ENBALE is changed to EN_WB
//				- Changed ENBALE to EN_WB for FLAG Module
//
// Revision: 2.0 
//				- Instrcution Memory based on BRAM36 is added
//				- Removed INSTR and renamed by INSTR_IF 
//				- Removed IF stages
//
// Revision: 2.1
//				- Include JUMP and BRANCH instructions	
//				- BRANCH_module.v ; CHECK_BRANCH.v 
//				- Removed ZF, EQF, GTF, STATUS signals from the module as an output				
//
// Revision: 3.0 
//				- Replace the keyword IPPro --> IPPro
//				- Removed PC, NPC, JPC, BADDR_OUT
//				- Changed BRANCH_module --> BRANCH_SIMD_module
//
// Revision: 3.1
//				- Data Memory is changed to dual true port distributed RAM
//				- Extend the port to IPPro core level
//
// Revision: 3.2
//				- Removed following modules as they could be shared among multi IPPro cores
//				- They are moved to the top-level module where cores are connected together
//					+ IR_Decode
//					+ IMM_MEM_RAM32M
//
// Revision: 4.0
//				- Removed the following modules as resource sharing optimisation
//					+ Instruction Decoder
//					+ Kernel Memory
//					+ Pipeline Synchronization Module
//					+ Execution # 1 & 2 stage modules
//					+ Write Back Stage
//					+ Branch Handler
//					+ Output Data Valid Signals
//					+ ALU (DSP48E1) module
//					+ Shift Module
//					+ Flags Module
//				- Added following module
//					+ Branch SIMD module
// 
// Revision: 4.0.1
//				- Modified the DM back to single port to time multiplex with BRAM
//					 + DPDISTRAM_RAM32M --> DPDISTRAM_RAM32M_MUX
//				 	 + Following Muxltiplexer are added 
//						- MUXF7_DM_BRAM_DIN_COMBINED
//						- MUX_module_ADDR DM_WADDR_MUX
//						- DM_BRAM_WE = SIMDC_BRAM_DM_DIN_SEL ? DM_WE_WB : SM_WE
//				- MIN/MAX instruction support is included
//
// Revision: 4.1.0
//				- Removed the DM and all the relevant signals from core data-path
//					+ SIMDC_BRAM_DM_DIN_SEL, DM_DIN_SEL_WB, DM_WE_WB, DM_DIN_WB
//					+ SM_ADDR, SM_DINB, SM_DOUTB, SM_WEB
//					+ Removed the following RF ports to support streamed Operand i.e OP1
//							+ RF_DOA, RF_DOB, RF_DOC, RF_DOD
//
// Revision: 4.2.0 
//				- Readded RF as a local memory
//				- Renamed RF --> LM
//				- Readded signals
//					+ LM_ADDRA, LM_ADDRD_WB, LM_WE_WB
//				- Added FLAGS as output array
//				- Modified MIN, MAX MUX to MIN_MAX_ID3
//				- Enabled the PIPE_SYNC.v module to handle the FIFO handshaking
//				- Added BYPASS module
//
// Revision: 4.2.1
//				- Included the SHIFT_OUT ==> LM_DIN
//					+ Respective control logic for MUXF7_LM_DIN
//					+ Retiming of LM_DIN_SEL ==> LM_DIN_SEL_reg (from 483-530 MHz)
//
//------------------------------------------------------------------------------------------

`include "parameters.v"

module IPPro_Core_Datapath
	(	
		CLK,
		RESET,
		ENABLE,
		OP1,
		EN_ID,
		EN_EXE1,
		INMODE_EXE1,
		OPMODE_EXE2,
		ALUMODE_EXE2,
		LM_ADDRA,
		LM_ADDRB,
		LM_ADDRC,
		OPCODE,
		KM_DO,
		LM_ADDRD_WB,
		LM_WE_WB,
		LM_DIN_SEL_WB,
		EN_WB,
		CEA2_EXE2,
		CEB2_EXE2,
		CEC_EXE2,
		CEM_EXE2,
		CEP_EXE1,
		INSTR_TYPE,
		P,
		CORE_OUT,
		LM_DOA,
		FLAG
	);
	
	
	// Global Signals
	input	CLK, RESET	;
	input 	ENABLE 		;
	input	EN_ID 		;
	input	EN_EXE1 	;
	
	input   [`N-1:0]			OP1 		;
	input	[2:0] 				INSTR_TYPE 	;

	// Internal connections
	input	[4:0]	INMODE_EXE1 	;
	input	[6:0]	OPMODE_EXE2 	;
	input	[3:0]	ALUMODE_EXE2 	;
	
	output	signed [47:0]		 P 			;
	output  [`FLAGS_LENGTH-1:0]  FLAG 		;
	output	[`ALU_OUT_depth-1:0] CORE_OUT 	;
	output	[`N-1:0]			 LM_DOA 	;
	
	wire	[`ALU_OUT_depth-1:0] 	ALU_OUT ;
	
	//	Immediate Data-path Signals
	wire	[1:0]		IMM_SEL 		;
	wire	[`N-1:0]	MUX_IMM_OUT_A 	;
	wire	[`N-1:0]	MUX_IMM_OUT_B 	;
	wire	[`N-1:0]	MUX_IMM_OUT_C 	;
	
	// 	Instruction Fetch Signals
	wire	[2:0] 	INSTR_TYPE 	;
	input	[4:0]	OPCODE 		;
			
	// Kernel Memory Signals
	wire 	[4:0]					KM_ADDR 	;
	wire	signed [`KM_depth-1:0]	KM_DIN 		;
	input 	signed [`KM_depth-1:0]	KM_DO 		;
	wire							KM_WE 		;
	reg     signed [`N-1:0]			LM_DOC_reg 	;
		
	//	Execution unit inputs
	reg		signed [`N-1:0] EU_DOA, EU_DOB, EU_DOC, EU_DOD 						;
	wire 					DSP48E1_CIN_SEL 									;
	input 					CEA2_EXE2, CEB2_EXE2, CEC_EXE2, CEM_EXE2, CEP_EXE1 	;
	
	reg		signed [`N-1:0] C_REG ;
	
	// Write-Back Stage Signals
	input 			LM_WE_WB 		;
	input	[4:0]	LM_ADDRD_WB 	;
	input			LM_DIN_SEL_WB 	;
	input			EN_WB 			;
	input   [4:0]   LM_ADDRA, LM_ADDRB, LM_ADDRC		;
	
	// Local memory signals
	wire	[`N-1:0] LM_DIN, LM_DOA, LM_DOB, LM_DOC, LM_DOD ;
	wire	[4:0] 	 LM_ADDRA, LM_ADDRB, LM_ADDRC ;
	wire 	[1:0] 	 LM_DIN_SEL ;
	reg 	[1:0] 	 LM_DIN_SEL_reg ;
	wire			 SHIFT_CONTROL ;
	
	// Flag Signals
	wire 	PATTERNDETECT 					;
	wire	ZF, EQF, GTF, NZF, NEQF, NSF, NGTF, STATUS, OVF, UNF 	;
	
	// Shift Module Signals
	reg		MUX_SHIFT_SEL1, MUX_SHIFT_SEL2, MUX_SHIFT_SEL3, MUX_SHIFT_SEL4 ;
	wire	[`N-1:0] SHIFT_OUT ;
	
	// Min Max instruction signals
	reg		signed [`N-1:0] 	OPB1, OPB2, OPB3, OPC1, OPC2, OPC3 ;
	wire	signed [`N-1:0]		MIN_OUT ;
	wire	signed [`N-1:0]		MAX_OUT ;
	wire	signed [`N-1:0]		MIN_MAX_OUT ;
	wire						MIN_MAX_ID ;
	reg							MIN_MAX_ID1, MIN_MAX_ID2, MIN_MAX_ID3, MIN_MAX_ID4 ;
	
	// BYPASS Module signals
	wire 	[`N-1:0]	BP_OP1 ;
		
	//------------------------------------------------------------------------------------------
	// Data-Path Ports Map
	//------------------------------------------------------------------------------------------	
			
		// 	Immediate Instructions Data-Path select
		Port_map ALU_MAP
		(
			.INSTR_TYPE(INSTR_TYPE),
			.IMM_SEL(IMM_SEL)
		);
	
	//------------------------------------------------------------------------------------------
	// Implementation of BYPASS Instruction
	//------------------------------------------------------------------------------------------
	/*
		BYPASS BP
		(
			.CLK(CLK),
			.ENABLE(ENABLE),
			.RESET(RESET),
			.INPUT(OP1),
			.OUTPUT(BP_OP1)
		);
	*/	
	//------------------------------------------------------------------------------------------
	// Input to Register File via MUX 
	//	 LM_DIN = ALU_OUT | OP1 | MIN_MAX_OUT 
	//------------------------------------------------------------------------------------------
	
		MUXF7_41_module MUXF7_LM_DIN
		(
			.OUT(LM_DIN), 
			.DIN0(ALU_OUT[`ALU_OUT_depth-1:0]), 
			.DIN1(OP1), 
			.DIN2(MIN_MAX_OUT), 
			.DIN3(SHIFT_OUT), 
			.SEL(LM_DIN_SEL_reg)							
		);
			
		always @(posedge CLK)
		begin
			LM_DIN_SEL_reg <= LM_DIN_SEL ;
		end
		
		assign LM_DIN_SEL = {(MIN_MAX_ID3| SHIFT_CONTROL),(LM_DIN_SEL_WB| SHIFT_CONTROL)};
		assign SHIFT_CONTROL = MUX_SHIFT_SEL2 | MUX_SHIFT_SEL3 ;
		//assign LM_DIN_SEL = {MIN_MAX_ID4,LM_DIN_SEL_WB};
		assign CORE_OUT = LM_DIN ;
		
	//------------------------------------------------------------------------------------------
	//	Input IMMEDIATE data to ALU 
	//	 MUX_IMM_OUT_A = OP1 | LM_DOA	
	//	 MUX_IMM_OUT_B = LM_DOB | KM_DO
	// 	 MUX_IMM_OUT_C = LM_DOC | LM_DOC | OP1 | ZERO
	//------------------------------------------------------------------------------------------
		
		MUXF7_module MUXF7_IMM_ALU_A
		(
			.OUT(MUX_IMM_OUT_A),
			.DIN0(OP1),					// Have to verify the inputs and relevant control for addressing modes
			.DIN1(LM_DOA),
			.SEL(IMM_SEL[0])					
		);
		
		MUXF7_module MUXF7_IMM_ALU_B
		(
			.OUT(MUX_IMM_OUT_B),
			.DIN0(LM_DOB),
			.DIN1(KM_DO),
			.SEL(INSTR_TYPE[0] & INSTR_TYPE[1])					
		);
		
		MUXF7_41_module MUXF7_IMM_ALU_C 
		(
			.OUT(MUX_IMM_OUT_C), 
			.DIN0(LM_DOC), 
			.DIN1(LM_DOC), 
			.DIN2(OP1), 
			.DIN3(`ZERO), 							// Spare for Future use !!!
			.SEL(IMM_SEL)							// See Port_map module for details
		);
			
	//------------------------------------------------------------------------------------------
	// Local Memory 32 x 16 bits
	//------------------------------------------------------------------------------------------
	
		RF_RAM32M Local_Memory
		(
				.RF_CLK(CLK),							
				.RF_WE(LM_WE_WB),						// Signal is generated by Write-back Stage module
				.RF_ADDRA(LM_ADDRA),
				.RF_ADDRB(LM_ADDRB),
				.RF_ADDRC(LM_ADDRC),
				.RF_ADDRD(LM_ADDRD_WB),					// Destination Register Address generated by Write-Back Stage
				.RF_DIN(LM_DIN),			
				.RF_DOA(LM_DOA),
				.RF_DOB(LM_DOB),
				.RF_DOC(LM_DOC),
				.RF_DOD(LM_DOD)
		);
	
	//------------------------------------------------------------------------------------------
	// Instruction Decode Stage (ID)
	//------------------------------------------------------------------------------------------
	
		always @ (posedge CLK)						
		begin
			if(RESET)
			begin
				EU_DOA <= 0;
				EU_DOB <= 0;	
				EU_DOC <= 0;
				EU_DOD <= 0;
			end
			else if (EN_ID)
			begin
				EU_DOA <= MUX_IMM_OUT_A;
				EU_DOB <= MUX_IMM_OUT_B;
				EU_DOC <= MUX_IMM_OUT_C;
				EU_DOD <= LM_DOD;
			end
			else							
			begin
				EU_DOA <= EU_DOA;			// Retain Contents of Pipeline Registers
				EU_DOB <= EU_DOB;
				EU_DOC <= EU_DOC;
				EU_DOD <= EU_DOD;
			end
		end
	
	//------------------------------------------------------------------------------------------
	// IPPro Flags
	//------------------------------------------------------------------------------------------
	
		FLAG IPPro_flags
		(
			.RESET(RESET),
			.ENABLE(EN_WB),
			.ALU_OUT(ALU_OUT),
			.PATTERNDETECT(PATTERNDETECT),
			.ZF(ZF),
			.EQF(EQF),
			.GTF(GTF),
			.SF(SF),
			.NZF(NZF),
			.NEQF(NEQF),
			.NSF(NSF),
			.NGTF(NGTF)
		);
		
		assign FLAG = {NGTF,NEQF,NSF,NZF,GTF,SF,EQF,ZF};
		
	//------------------------------------------------------------------------------------------
	// Internal Execution Stages of DSP48E1 (EXE1 & EXE2)
	//------------------------------------------------------------------------------------------
				
		// Extra PORTC Register to balance the latency of all instructions
		always @ (posedge CLK)
		begin
			if(RESET)
			begin
				C_REG <= 0;
			end
			else if (EN_EXE1)
			begin
				C_REG <= EU_DOC ;
			end
			else
			begin
				C_REG <= C_REG;			// Retain Contents of Pipeline Registers		
			end
		end
	
	//------------------------------------------------------------------------------------------
	// Min Max Instruction Support  (It is implemented using SF)
	//------------------------------------------------------------------------------------------	
	
	assign MIN_MAX_ID = OPCODE[4] & ~OPCODE[3];	// To avoid conflict with Bypass instr.
	
	always @ (posedge CLK)
	begin
		if(RESET)
		begin
			OPB1 <= 0 ;
			OPB2 <= 0 ;
			OPB3 <= 0 ;
			OPC1 <= 0 ;
			OPC2 <= 0 ;
			OPC3 <= 0 ;
			
			MIN_MAX_ID1 <= 0 ;
			MIN_MAX_ID2 <= 0 ;
			MIN_MAX_ID3 <= 0 ;
			MIN_MAX_ID4 <= 0 ;
		end
		else if (ENABLE)
		begin
			OPB1 <= EU_DOB 	;
			OPB2 <= OPB1 	;
			OPB3 <= OPB2	;
			
			OPC1 <= EU_DOC 	;
			OPC2 <= OPC1 	;
			OPC3 <= OPC2 	;
			
			MIN_MAX_ID1 <= MIN_MAX_ID ;
			MIN_MAX_ID2 <= MIN_MAX_ID1 ;
			MIN_MAX_ID3 <= MIN_MAX_ID2 ;
			MIN_MAX_ID4 <= MIN_MAX_ID3;
		end
		else
		begin
			OPB1 <= OPB1 ;
			OPB2 <= OPB2 ;
			OPB3 <= OPB3 ;
			
			OPC1 <= OPC1 ;
			OPC2 <= OPC2 ;
			OPC3 <= OPC3 ;
			
			MIN_MAX_ID1 <= MIN_MAX_ID1 ;
			MIN_MAX_ID2 <= MIN_MAX_ID2 ;
			MIN_MAX_ID3 <= MIN_MAX_ID3 ;
			MIN_MAX_ID4 <= MIN_MAX_ID4 ;
		end
	end
	
	// Multiplexer for MAX value
	MUXF7_module MIN_SELECT
	(
		.OUT(MIN_OUT),
		.DIN0(OPB3),
		.DIN1(OPC3),
		.SEL(SF)					
	);	
	
	// Multiplexer for MIN value
	MUXF7_module MAX_SELECT
	(
		.OUT(MAX_OUT),
		.DIN0(OPC3),
		.DIN1(OPB3),
		.SEL(SF)					
	);	
	
	// Multiplexer for MIN/MAX instruction
	MUXF7_module MIN_MAX_SELECT
	(
		.OUT(MIN_MAX_OUT),
		.DIN0(MAX_OUT),
		.DIN1(MIN_OUT),
		.SEL(MIN_MAX_ID3)					
	);
	
	//------------------------------------------------------------------------------------------
	// IPPro Shift LUT
	//------------------------------------------------------------------------------------------
	
	MUXF7_module MUXF7_SHIFT_LEFT_RIGHT
	(
		.OUT(SHIFT_OUT),
		.DIN0(P[15:0]),
		.DIN1(P[33:18]),
		.SEL(MUX_SHIFT_SEL4)					
	);	
	
	assign MUX_SHIFT_SEL = OPCODE[3] & OPCODE[2] & OPCODE[1] & OPCODE[0] ;	// Shift Instr. decoding
	
	always @(posedge CLK)
	begin
		if(RESET)
			begin
			MUX_SHIFT_SEL1 <= 0 ;
			MUX_SHIFT_SEL2 <= 0 ;
			MUX_SHIFT_SEL3 <= 0 ;
			MUX_SHIFT_SEL4 <= 0 ;
			end
		else 
			begin
			MUX_SHIFT_SEL1 <= MUX_SHIFT_SEL ;
			MUX_SHIFT_SEL2 <= MUX_SHIFT_SEL1 ;
			MUX_SHIFT_SEL3 <= MUX_SHIFT_SEL2 ;
			MUX_SHIFT_SEL4 <= MUX_SHIFT_SEL3 ;
			end
	end

	//------------------------------------------------------------------------------------------
	// DSP48E1 Execution Unit
	//------------------------------------------------------------------------------------------
	
	assign ALU_OUT[`ALU_OUT_depth-1:0] = P[15:0] ;	// Need to be defined in top level SIMD module
	
		EU_DSP48E1 Execution_Unit
		(
			.CLK(CLK),
			.A({14'b0000_0000_0000_00,EU_DOA}),			// Fixed to 16-bits
			.ACIN(30'b0),
			.ALUMODE(ALUMODE_EXE2),
			.B({2'b00,EU_DOB}),							// Fixed to 16-bits
			.BCIN(18'b0),
			.C({32'h0000_0000,C_REG}),					// Fixed to 16-bits
			.CARRYCASCIN(1'b0),
			.CARRYIN(1'b0),
			.D({9'b0000_0000_0,EU_DOD}),				// Fixed to 16-bits
			.MULTSIGNIN(1'b0),
			.PCIN(48'b0),
			.ACOUT(),
			.BCOUT(),
			.CARRYCASCOUT(),
			.CARRYOUT(),
			.MULTSIGNOUT(),
			.OVERFLOW(),
			.P(P),
			.PATTERNBDETECT(),
			.PATTERNDETECT(PATTERNDETECT),
			.PCOUT(),
			.UNDERFLOW(),
			.OPMODE(OPMODE_EXE2),
			.INMODE(INMODE_EXE1),
			.CARRYINSEL(3'b000),
			.CEA1(`ENABLE),
			.CEA2(CEA2_EXE2),
			.CEAD(`DISABLE),
			.CEALUMODE(`ENABLE),
			.CEB1(`ENABLE),
			.CEB2(CEB2_EXE2),
			.CEC(CEC_EXE2),
			.CECARRYIN(`DISABLE),
			.CECTRL(`ENABLE),
			.CED(`DISABLE),
			.CEINMODE(`ENABLE),
			.CEM(CEM_EXE2),
			.CEP(CEP_EXE1),
			.RSTA(RESET),
			.RSTALLCARRYIN(RESET),
			.RSTALUMODE(RESET),
			.RSTB(RESET),
			.RSTC(RESET),
			.RSTCTRL(RESET),
			.RSTD(RESET),
			.RSTINMODE(RESET),
			.RSTM(RESET),
			.RSTP(RESET)
		);
	
//------------------------------------------------------------------------------------------	
endmodule 
