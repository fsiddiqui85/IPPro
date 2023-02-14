//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : Single Core IPPro Datapath
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : IPPro_single_core_datapath.v
// Generated   : Fri Feb 13 11:50:11 2015
//
//------------------------------------------------------------------------------------------
//
// Description : Single Core IPPro Datapath
//
//------------------------------------------------------------------------------------------

`include "parameters.v"

module IPPro_single_core_datapath
	(
		CLK,
		RESET,			// Global Reset
		ENABLE,			// Global Enable
		
		INSTR,			// 34-bits Instruction
		ENABLE_PC,		// PC Enable
		PC,				// 10 Bits PC
		
		EMPTY,			
		DIN,			// Input Data
		READ_EN,		// Read Enable
		
		DOUT,			// Output Data
		WRITE_EN,		// Write Enable
		FULL,			
		DValid			// Output Valid
	);
	
	input 									CLK, RESET, ENABLE, ENABLE_PC;
	input 	signed [(`FIFO_datasize)-1:0] 	DIN ;
	input 									EMPTY, FULL ;
	input 	[`INSTR_length-1:0]				INSTR ;
	
	output 	signed [(`FIFO_datasize)-1:0] 	DOUT 				;
	output	[9:0]							PC 					;
	output									DValid 				;
	output									READ_EN, WRITE_EN 	;
	
	// Branch Signals
	wire					BRANCH_MASK  ;
	wire	signed 	[47:0] 	P ;
	
	wire	signed [`N-1:0]  CORE_OUT ;
	
	// Input/Output FIFO data array
	wire 	[`FIFO_datasize-1:0] OP1 ;
	
	// Execution Stage 1 & 2 Pipeline Signals
	wire 	[4:0]	INMODE_EXE1 ;
	wire 	[6:0] 	OPMODE_EXE2 ;
	wire 	[3:0]	ALUMODE_EXE2 ;
	wire 			CEA2_EXE2, CEB2_EXE2, CEC_EXE2, CEM_EXE2, CEP_EXE1 ;
	
	// 	Instruction Fetch Signals
	wire	[4:0]	OPCODE ;
	wire	[4:0]	LM_ADDRA, LM_ADDRB, LM_ADDRC, LM_ADDRD ;
	
	// Kernel Memory Signals
	wire 	[4:0]					KM_ADDR 	;
	wire	signed [`KM_depth-1:0]	KM_DIN 		;
	wire 	signed [`KM_depth-1:0]	KM_DO 		;
	wire							KM_DIN_SEL 	;

	// Write-Back Stage Signals
	wire	[4:0]			LM_ADDRD_WB ;
	wire	[4:0]			LM_ADDRB_WB ;
	
	// Internal connections
	wire	[4:0]			INMODE ;
	wire	[6:0]			OPMODE ;
	wire	[3:0]			ALUMODE ;
	wire	signed [`RF_depth-1:0]	LM_DOA ;
	wire					CEA1, CEA2, CEB1, CEB2, CEC, CEM, CEP ;
	wire	[2:0] 			INSTR_TYPE ;
	
	// Pipeline Stage Synchronization in case of PAUSE
	wire 	EN_ID, EN_EXE1, EN_WB ;
	
	// Data-Forwarding Signals
	wire 	[4:0]	ADDRB_DF, ADDRD_DF ;
	wire	[6:0]	OPMODE_DF ;
	
	// Branch and Jump Instrcutions signals
	wire	[`FLAGS_LENGTH-1:0]	IM_FLAGS ;
	wire	[9:0]	BADDR_OUT, JPC, NPC ;
	reg   	[9:0]	JPC_reg ;
	wire  	[9:0]   PC ;
	
	// Instruction memory
	wire	[35:0] IR_INSTR ;
	
	// Core Flags
	wire 	[7:0]	FLAG ; 
	
	// Bypass Singals
	wire	PB_DONE;
	reg		PB_STATUS ;
	wire 	[`N-1:0] CORE_OUT_MUXED ;
	
	// FIFO Signals
	reg 	PUT_EN_1, PUT_EN_2, PUT_EN_WB ;
	wire	FULL, EMPTY ;
	wire	PUT_EN, GET_EN ;
	
	// PUSHLM & PUSHKM select signal
	wire	PUSH_LM_KM_SEL ;
	reg 	[`N-1:0] LM_DOA_1, LM_DOA_2, LM_DOA_3, LM_DOA_4 ;
	reg		PUSH_LM_KM_SEL_1, PUSH_LM_KM_SEL_2, PUSH_LM_KM_SEL_3, PUSH_LM_KM_SEL_4 ;
	reg		PUT_EN_WB_1, PUT_EN_WB_2, PUT_EN_WB_3 ;
	wire	PUT_EN_MUX;
	wire	PUT_WRITE_EN;
	reg		PUT_WRITE_EN_1 ;
	
	//------------------------------------------------------------------------------------------
	// Instruction Memory (IM)
	//------------------------------------------------------------------------------------------
	PC_module Program_Counter
	(
		.CLK(CLK),
		.RESET(RESET),
		.ENABLE(ENABLE_PC),
		.PC(PC),
		.NPC(NPC)
	);

	//------------------------------------------------------------------------------------------
	// Instruction Decoder
	//------------------------------------------------------------------------------------------
	IR_decode Instruction_Decoder
	(
		.CLK(CLK),
		.RESET(RESET),
		.ENABLE(EN_ID),
		.INSTR_TYPE(INSTR_TYPE),
		.OPCODE(OPCODE),
		.DSP48E_CW_REG({INMODE, OPMODE, ALUMODE, CEA2, CEB2, CEC, CEM, CEP, LM_WE, DM_WE})
	);
		

	//------------------------------------------------------------------------------------------
	// Kernel Memory 32 x 16 bits
	//------------------------------------------------------------------------------------------
	KM_RAM32M Kernel_Memory 
	(
		.KM_CLK(CLK), 
		.KM_WE(KM_WE), 
		.KM_ADDR(KM_ADDR), 
		.KM_DIN(KM_DIN), 
		.KM_DO(KM_DO)
    );
	
	// KM_WE for STIMM & PUTKM
	//assign KM_WE = (!OPCODE) & INSTR_TYPE[0] & INSTR_TYPE[1];		// 574.053 MHz
	assign KM_WE = (!OPCODE[4:1]) & INSTR_TYPE[0] & INSTR_TYPE[1];		
	
	// Kernel Memory Port Mapping 
	assign KM_ADDR 	= LM_ADDRB ;
	
	// Kernel memory input data mapping
	assign KM_DIN 	= OPCODE[0] ? OP1 : INSTR[`N-1:0] ;
	
	//------------------------------------------------------------------------------------------
	// Data-Path Ports Map
	//------------------------------------------------------------------------------------------
	
	// 	Fixed Data-Path Assignments
	assign {INSTR_TYPE, OPCODE, LM_ADDRD, LM_ADDRB, LM_ADDRA, LM_ADDRC} = INSTR[`INSTR_length-1:`INSTR_frame] ;
	
	//------------------------------------------------------------------------------------------
	// IPPro Pipeline Synchronization
	//------------------------------------------------------------------------------------------	
	
	//------- Uncomment Following is valid only for memory mapped based implementations ---------//
		
	Pipe_Sync Stage_Sync
	( 
		.CLK(CLK),
		.RESET(RESET),
		.ENABLE(ENABLE),
		.EN_ID(EN_ID),
		.EN_EXE1(EN_EXE1),
		.EN_WB(EN_WB)
	);
		
	//------------------------------------------------------------------------------------------
	// Execution Stages of DSP48E1 (EXE1 & EXE2)
	//------------------------------------------------------------------------------------------	
	
	DF_Module Data_Forwarding
	(
		.CLK(CLK),
		.RESET(RESET),
		.ENABLE(EN_ID),
		.D(ADDRD_DF),
		.B(ADDRB_DF),
		.OPMODE(OPMODE),
		.OPMODE_DF(OPMODE_DF)		
	);
	
	//------------------------------------------------------------------------------------------
	// Execution Stages of DSP48E1 (EXE1 & EXE2)
	//------------------------------------------------------------------------------------------
	
		// EXE1 Stage
		EXE1 Execution_1
		(
			.INMODE(INMODE),
			.CEP(CEP),
			.INMODE_EXE1(INMODE_EXE1),
			.CEP_EXE1(CEP_EXE1)
		);

		// EXE2 Stage
		EXE2 Execution_2
		(
			.CLK(CLK),
			.RESET(RESET),
			.ENABLE(EN_EXE1),
			.OPMODE(OPMODE_DF), 				
			//.OPMODE(OPMODE), 
			.ALUMODE(ALUMODE),
			.CEA2(CEA2),
			.CEB2(CEB2),
			.CEC(CEC),
			.CEM(CEM),
			.OPMODE_EXE2(OPMODE_EXE2),
			.ALUMODE_EXE2(ALUMODE_EXE2),
			.CEA2_EXE2(CEA2_EXE2),
			.CEB2_EXE2(CEB2_EXE2),
			.CEC_EXE2(CEC_EXE2),
			.CEM_EXE2(CEM_EXE2)
		);
	
	//------------------------------------------------------------------------------------------
	// Write-Back Stage (WB)
	//------------------------------------------------------------------------------------------
	
	assign LM_DIN_SEL 	= INSTR_TYPE[1] & ~(INSTR_TYPE[1] & INSTR_TYPE[0]);
	
	WRITE_BACK WB
	(
		.CLK(CLK),
		.RESET(RESET),
		.ENABLE(EN_WB),
		.RF_ADDRD(LM_ADDRD),
		.RF_ADDRB(LM_ADDRB),
		.RF_WE(LM_WE),
		.DM_WE(DM_WE),
		.RF_DIN_SEL(LM_DIN_SEL),
		.RF_WE_WB(LM_WE_WB),
		.RF_ADDRD_WB(LM_ADDRD_WB),
		.RF_ADDRB_WB(),
		.DM_WE_WB(DM_WE_WB),
		.RF_DIN_SEL_WB(LM_DIN_SEL_WB),
		.ADDRD_DF(ADDRD_DF),				// Enable ADDRB_DF & ADDRD_DF for data-forwarding					
		.ADDRB_DF(ADDRB_DF)					
	);
	
	//------------ GET & PUT Instruction Decode signals -------------// 	
	assign GET_EN 	= INSTR_TYPE[1] & ~INSTR_TYPE[0] & OPCODE[1] & ~OPCODE[0] ;
	assign PUT_EN 	= (INSTR_TYPE[1] & ~INSTR_TYPE[0] & OPCODE[1] &  OPCODE[0]) |  PB_DONE ;	 
	assign PB_ENABLE = OPCODE[3] ;
	//------------------------------------------------------------------------------------------
	// Programmable ByPass Module
	//------------------------------------------------------------------------------------------	
	
	PBypass_module PB
	(
		.CLK(CLK),
		.RESET(RESET),
		.LOAD_COUNT(PB_ENABLE),
		.COUNT_VALUE(INSTR[`N-1:0]),
		.TERMINATE(PB_DONE)
	);
	
	always @ (posedge CLK)
	begin
		if(RESET)
			PB_STATUS <= 0 ;
		else if (PB_ENABLE)
			PB_STATUS <= 1 ;
		else if (PB_DONE)
			PB_STATUS <= 0 ;
		else
			PB_STATUS <= PB_STATUS ;
	end
	
	//------------------------------------------------------------------------------------------
	// IPPro Out Data Valid Signal Generation
	//------------------------------------------------------------------------------------------
		
		reg INSTR_TYPE11, INSTR_TYPE12, INSTR_TYPE13, INSTR_TYPE14 ;
		reg INSTR_TYPE01, INSTR_TYPE02, INSTR_TYPE03, INSTR_TYPE04 ;
		
		always @ (posedge CLK)
		begin
			if (RESET)
			begin
				INSTR_TYPE01 <= 0 ;
				INSTR_TYPE02 <= 0 ;
				INSTR_TYPE03 <= 0 ;
				INSTR_TYPE04 <= 0 ;
				
				INSTR_TYPE11 <= 0 ;
				INSTR_TYPE12 <= 0 ;
				INSTR_TYPE13 <= 0 ;
				INSTR_TYPE14 <= 0 ;
			end
			else if (EN_WB)
			begin
				INSTR_TYPE01 <= INSTR_TYPE[0] 	;
				INSTR_TYPE02 <= INSTR_TYPE01 	;
				INSTR_TYPE03 <= INSTR_TYPE02 	;
				INSTR_TYPE04 <= INSTR_TYPE03 	;
								
				INSTR_TYPE11 <= INSTR_TYPE[1]	;
				INSTR_TYPE12 <= INSTR_TYPE11 	;
				INSTR_TYPE13 <= INSTR_TYPE12 	;
				INSTR_TYPE14 <= INSTR_TYPE13 	;
			end
			else
			begin
				INSTR_TYPE01 <= INSTR_TYPE01 	;
				INSTR_TYPE02 <= INSTR_TYPE02 	;
				INSTR_TYPE03 <= INSTR_TYPE03 	;
				INSTR_TYPE04 <= INSTR_TYPE04 	;
				
				INSTR_TYPE11 <= INSTR_TYPE11 	;
				INSTR_TYPE12 <= INSTR_TYPE12 	;
				INSTR_TYPE13 <= INSTR_TYPE13 	;
				INSTR_TYPE14 <= INSTR_TYPE14 	;
			end
		end
		
		assign DValid 	= LM_WE_WB & EN_WB & (~INSTR_TYPE14 | INSTR_TYPE04);  
		assign OP1 		= DIN 	;
	//------------------------------------------------------------------------------------------
	// DSP48E1 Execution Unit
	//------------------------------------------------------------------------------------------
	
	//------------------------------------------------------------------------------------------
	// IPPro Core
	//------------------------------------------------------------------------------------------
	
	IPPro_Core_Datapath Core
	(	
		.CLK(CLK),
		.RESET(RESET),
		.ENABLE(ENABLE),
		.OP1(OP1),
		.EN_ID(EN_ID),
		.EN_EXE1(EN_EXE1),
		.INMODE_EXE1(INMODE_EXE1),
		.OPMODE_EXE2(OPMODE_EXE2),
		.ALUMODE_EXE2(ALUMODE_EXE2),
		.LM_ADDRA(LM_ADDRA),
		.LM_ADDRB(LM_ADDRB),
		.LM_ADDRC(LM_ADDRC),
		.LM_ADDRD_WB(LM_ADDRD_WB),
		.LM_WE_WB(LM_WE_WB),
		.OPCODE(OPCODE),
		.KM_DO(KM_DO),
		.LM_DIN_SEL_WB(LM_DIN_SEL_WB),
		.EN_WB(EN_WB),
		.CEA2_EXE2(CEA2_EXE2),
		.CEB2_EXE2(CEB2_EXE2),
		.CEC_EXE2(CEC_EXE2),
		.CEM_EXE2(CEM_EXE2),
		.CEP_EXE1(CEP_EXE1),
		.INSTR_TYPE(INSTR_TYPE),
		.P(P),
		.CORE_OUT(CORE_OUT),
		.LM_DOA(LM_DOA),
		.FLAG(FLAG)
	);
	
	//assign CORE_OUT_MUXED = PUT_EN ? OP1:CORE_OUT ; 
	
	MUXF7_41_module MUXF7_CORE_OUT
		(
			.OUT(DOUT), 
			.DIN0(OP1), 
			.DIN1(CORE_OUT), 
			.DIN2(KM_DO), 							/// Not working PUSHKM
			.DIN3(LM_DOA_4), 
			.SEL({PUSH_LM_KM_SEL_4,PUT_EN_WB_1})
		);
	
	assign PUSH_LM_KM_SEL = INSTR_TYPE[1] & ~INSTR_TYPE[0] & OPCODE[2] & OPCODE[1] & OPCODE[0] ;
	
	always @ (posedge CLK)
	begin	
		LM_DOA_1 <= LM_DOA ;
		LM_DOA_2 <= LM_DOA_1 ;
		LM_DOA_3 <= LM_DOA_2 ;
		LM_DOA_4 <= LM_DOA_3 ;
		
		PUSH_LM_KM_SEL_1 <= PUSH_LM_KM_SEL  ;
		PUSH_LM_KM_SEL_2 <= PUSH_LM_KM_SEL_1 ;
		PUSH_LM_KM_SEL_3 <= PUSH_LM_KM_SEL_2 ;
		PUSH_LM_KM_SEL_4 <= PUSH_LM_KM_SEL_3 ;
		
		PUT_EN_WB_1 <= PUT_EN_WB ;
	//	PUT_EN_WB_2 <= PUT_EN_WB_1 ;
	//	PUT_EN_WB_3 <= PUT_EN_WB_2 ;
		
	end
	
	//------------------------------------------------------------------------------------------
	// Branch Handling
	//------------------------------------------------------------------------------------------
	
	BRANCH_module BR
	(
		.CLK(CLK),
		.RESET(RESET),
		.ENABLE(ENABLE),
		.INSTR_TYPE(INSTR_TYPE),
		.OPCODE(OPCODE),
		.BADDR_IN(INSTR[`N-7:0]),
		.IM_FLAGS(IM_FLAGS),
		.BADDR_OUT(BADDR_OUT)
	);
	
	// Compares the respective Branch instrcution Flag result
	
	CHECK_BRANCH CB
	(
		.CLK(CLK),
		.IM_FLAGS(IM_FLAGS),
		.ALU_FLAGS(FLAG),
		.BRANCH_SEL(BRANCH_SEL)
	);
	
	// Multiplexer for Branch Instrcutions
	MUXF7_module #(10) BRANCH_SELECT
	(
		.OUT(PC),
		.DIN0(JPC),
		.DIN1(BADDR_OUT),
		.SEL(BRANCH_SEL)					
	);	
	
	always @ (posedge CLK)
	begin
		JPC_reg <= JPC ;
	end
		
	// Multiplexer for Jump Instrcutions
	MUXF7_module #(10)	JUMP_SELECT
	(
		.OUT(JPC),
		.DIN0(NPC),
		.DIN1(INSTR[`N-1:0]),
		.SEL(INSTR[33] && ~(| INSTR[30:26]))		// 510.308 MHz			
	);	
	
	// --------------------------------------------
	// Input FIFO data interlock check and control
	//---------------------------------------------
	GET_module GETM
	(
		.CLK(CLK),
		.RESET(RESET),
		.ENABLE(GET_EN),		
		.EMPTY(EMPTY),
		.FIFO_READ_EN(READ_EN)
	);
	// ---------------------------------------------
	// Output FIFO data interlock check and control
	//----------------------------------------------
	
	assign PUT_EN_MASK = INSTR_TYPE[1] & ~INSTR_TYPE[0] & (OPCODE[2] | OPCODE[3]) & OPCODE[1] & OPCODE[0] ; 
	assign WRITE_EN = PUT_EN_MASK ? PUT_WRITE_EN_1 : PUT_EN_WB_1 ;
	
	PUT_module PUTM
	(
		.CLK(CLK),
		.RESET(RESET),
		.ENABLE(PUT_EN_WB),		
		.FULL(FULL),						
		.FIFO_WRITE_EN(PUT_WRITE_EN)
	);	
	
	always @(posedge CLK)
	begin
		PUT_WRITE_EN_1 <= PUT_WRITE_EN ;
	end
	// ----------------------------------------------------------------------
	// PUT instruction need to be sync with instruction pipeline.....
	// ----------------------------------------------------------------------
	always @ (posedge CLK)
	begin
		if(RESET)
			begin
				PUT_EN_1 <= 	0 	;
				PUT_EN_2 <= 	0 	;
				PUT_EN_WB <= 	0	;
			end
		else if (ENABLE)
			begin
				PUT_EN_1 <= PUT_EN 		;
				PUT_EN_2 <= PUT_EN_1 	;
				PUT_EN_WB <= PUT_EN_1	;
			end
		else
			begin
				PUT_EN_1 <= PUT_EN_1 	;
				PUT_EN_2 <= PUT_EN_2 	;
				PUT_EN_WB <= PUT_EN_WB	;
			end
	end
	
	//assign DOUT = CORE_OUT_MUXED ;
//------------------------------------------------------------------------------------------	
endmodule 
