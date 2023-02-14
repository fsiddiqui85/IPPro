//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : DSP48E based ALU Implementation
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : EU_DSP48E1.v
// Generated   : Tue May 22 15:45:47 2013
//
//------------------------------------------------------------------------------------------
//
// Description : Execution Unit
//------------------------------------------------------------------------------------------

`include "parameters.v"

module EU_DSP48E1 (
				CLK,
				A,
				ACIN,
				ALUMODE,
				B,
				BCIN,
				C,
				CARRYCASCIN,
				CARRYIN,
				D,
				MULTSIGNIN,
				PCIN,
				ACOUT,
				BCOUT,
				CARRYCASCOUT,
				CARRYOUT,
				MULTSIGNOUT,
				OVERFLOW,
				P,
				PATTERNBDETECT,
				PATTERNDETECT,
				PCOUT,
				UNDERFLOW,
				OPMODE,
				INMODE,
				
				CARRYINSEL,
				CEA1,
				CEA2,
				CEAD,
				CEALUMODE,
				CEB1,
				CEB2,
				CEC,
				CECARRYIN,
				CECTRL,
				CED,
				CEINMODE,
				CEM,
				CEP,
				RSTA,
				RSTALLCARRYIN,
				RSTALUMODE,
				RSTB,
				RSTC,
				RSTCTRL,
				RSTD,
				RSTINMODE,
				RSTM,
				RSTP
			);

input 					CLK  ;
input 	signed 	[29:0] 	A	 ;
input 			[29:0] 	ACIN ;
input 			[3:0] 	ALUMODE ;
input 	signed 	[17:0] 	B	 ;
input 			[17:0] 	BCIN ;
input 	signed 	[47:0] 	C	 ;
input				 	CARRYCASCIN ;
input					CARRYIN ;
input 	signed	[24:0] 	D;
input 			 		MULTSIGNIN ;
input			[47:0]	PCIN ;
input 			[6:0] 	OPMODE  ;
input 			[4:0] 	INMODE  ;
			
output			[29:0] 	ACOUT ;
output			[17:0] 	BCOUT;
output					CARRYCASCOUT ;
output			[3:0]  	CARRYOUT ;
output					MULTSIGNOUT;
output					OVERFLOW;
output 	signed 	[47:0] 	P    ;
output					PATTERNBDETECT;
output					PATTERNDETECT;
output			[47:0]	PCOUT ;
output					UNDERFLOW ;

input			[2:0] 	CARRYINSEL;
input					CEA1;
input					CEA2;
input					CEAD;
input					CEALUMODE;
input					CEB1;
input					CEB2;
input					CEC;
input					CECARRYIN;
input					CECTRL;
input					CED;
input					CEINMODE;
input					CEM;
input					CEP;
input					RSTA;
input					RSTALLCARRYIN;
input					RSTALUMODE;
input					RSTB;
input					RSTC;
input					RSTCTRL;
input					RSTD;
input					RSTINMODE;
input					RSTM;
input					RSTP;

	// DSP48E1: 48-bit Multi-Functional Arithmetic Block
	//          Virtex-6
	// Xilinx HDL Language Template, version 14.1

   DSP48E1 #(
      
		// Feature Control Attributes: Data Path Selection
      .A_INPUT("DIRECT"),               // Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
      .B_INPUT("DIRECT"),               // Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
      .USE_DPORT("FALSE"),              // Select D port usage (TRUE or FALSE)
      .USE_MULT("DYNAMIC"),             // Select multiplier usage ("MULTIPLY", "DYNAMIC", or "NONE")
    
		// Pattern Detector Attributes: Pattern Detection Configuration
      .AUTORESET_PATDET("NO_RESET"),    // "NO_RESET", "RESET_MATCH", "RESET_NOT_MATCH" 
      .MASK(`MASK_16),          		// 48-bit mask value for pattern detect (1=ignore)
      .PATTERN(48'h000000000000),       // 48-bit pattern match for pattern detect
      .SEL_MASK("MASK"),                // "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2" 
      .SEL_PATTERN("C"), 				// Select pattern value ("PATTERN" or "C")
      .USE_PATTERN_DETECT("PATDET"), 	// Enable pattern detect ("PATDET" or "NO_PATDET")
      
		// Register Control Attributes: Pipeline Register Configuration
      .ACASCREG(`ACASCREG_Pipeline),    // Number of pipeline stages between A/ACIN and ACOUT (0, 1 or 2)
      .ADREG(`ADREG_Pipeline),          // Number of pipeline stages for pre-adder (0 or 1)
      .ALUMODEREG(`ALUMODEREG_Pipeline),// Number of pipeline stages for ALUMODE (0 or 1)
      .AREG(`REGA_Pipeline),            // Number of pipeline stages for A (0, 1 or 2)
      .BCASCREG(`BCASCREG_Pipeline),    // Number of pipeline stages between B/BCIN and BCOUT (0, 1 or 2)
      .BREG(`REGB_Pipeline),            // Number of pipeline stages for B (0, 1 or 2)
      .CARRYINREG(`CARRYINREG_Pipeline),// Number of pipeline stages for CARRYIN (0 or 1)
      .CARRYINSELREG(`CARRYINSELREG_Pipeline),   // Number of pipeline stages for CARRYINSEL (0 or 1)
      .CREG(`REGC_Pipeline),            // Number of pipeline stages for C (0 or 1)
      .DREG(`REGD_Pipeline),            // Number of pipeline stages for D (0 or 1)
      .INMODEREG(`INMODEREG_Pipeline),  // Number of pipeline stages for INMODE (0 or 1)
      .MREG(`MREG_Pipeline),          	// Number of multiplier pipeline stages (0 or 1)
      .OPMODEREG(`OPMODEREG_Pipeline),  // Number of pipeline stages for OPMODE (0 or 1)
      .PREG(`PREG_Pipeline),         	// Number of pipeline stages for P (0 or 1)
      .USE_SIMD("ONE48")                // SIMD selection ("ONE48", "TWO24", "FOUR12")
   )
   DSP48E1_inst (
      // Cascade: 30-bit (each) output: Cascade Ports
      .ACOUT(ACOUT),                   // 30-bit output: A port cascade output
      .BCOUT(BCOUT),                   // 18-bit output: B port cascade output
      .CARRYCASCOUT(CARRYCASCOUT),     // 1-bit output: Cascade carry output
      .MULTSIGNOUT(MULTSIGNOUT),       // 1-bit output: Multiplier sign cascade output
      .PCOUT(PCOUT),                   // 48-bit output: Cascade output
      // Control: 1-bit (each) output: Control Inputs/Status Bits
      .OVERFLOW(OVERFLOW),             // 1-bit output: Overflow in add/acc output
      .PATTERNBDETECT(PATTERNBDETECT), // 1-bit output: Pattern bar detect output
      .PATTERNDETECT(PATTERNDETECT),   // 1-bit output: Pattern detect output
      .UNDERFLOW(UNDERFLOW),           // 1-bit output: Underflow in add/acc output
      // Data: 4-bit (each) output: Data Ports
      .CARRYOUT(CARRYOUT),             // 4-bit output: Carry output
      .P(P),                           // 48-bit output: Primary data output
      // Cascade: 30-bit (each) input: Cascade Ports
      .ACIN(ACIN),                     // 30-bit input: A cascade data input
      .BCIN(BCIN),                     // 18-bit input: B cascade input
      .CARRYCASCIN(CARRYCASCIN),       // 1-bit input: Cascade carry input
      .MULTSIGNIN(MULTSIGNIN),         // 1-bit input: Multiplier sign input
      .PCIN(PCIN),                     // 48-bit input: P cascade input
      // Control: 4-bit (each) input: Control Inputs/Status Bits
      .ALUMODE(ALUMODE),          // 4-bit input: ALU control input
      .CARRYINSEL(CARRYINSEL),         // 3-bit input: Carry select input
      .CEINMODE(CEINMODE),             // 1-bit input: Clock enable input for INMODEREG
      .CLK(CLK),                       // 1-bit input: Clock input
      .INMODE(INMODE),                // 5-bit input: INMODE control input
      .OPMODE(OPMODE),            	  // 7-bit input: Operation mode input
      .RSTINMODE(RSTINMODE),           // 1-bit input: Reset input for INMODEREG
      // Data: 30-bit (each) input: Data Ports
      .A(A),                           // 30-bit input: A data input
      .B(B),                           // 18-bit input: B data input
      //.C({32'h00000000,C}),    	   // 48-bit input: C data input
	  .C(C),    	   // 48-bit input: C data input
      .CARRYIN(CARRYIN),               // 1-bit input: Carry input signal
      .D(D),                           // 25-bit input: D data input
      // Reset/Clock Enable: 1-bit (each) input: Reset/Clock Enable Inputs
      .CEA1(CEA1),                     // 1-bit input: Clock enable input for 1st stage AREG
      .CEA2(CEA2),                     // 1-bit input: Clock enable input for 2nd stage AREG
      .CEAD(CEAD),                     // 1-bit input: Clock enable input for ADREG
      .CEALUMODE(CEALUMODE),           // 1-bit input: Clock enable input for ALUMODERE
      .CEB1(CEB1),                     // 1-bit input: Clock enable input for 1st stage BREG
      .CEB2(CEB2),                     // 1-bit input: Clock enable input for 2nd stage BREG
      .CEC(CEC),                   // 1-bit input: Clock enable input for CREG
      .CECARRYIN(CECARRYIN),           // 1-bit input: Clock enable input for CARRYINREG
      .CECTRL(CECTRL),                 // 1-bit input: Clock enable input for OPMODEREG and CARRYINSELREG
      .CED(CED),                       // 1-bit input: Clock enable input for DREG
      .CEM(CEM),                   // 1-bit input: Clock enable input for MREG
      .CEP(CEP),                       // 1-bit input: Clock enable input for PREG
      .RSTA(RSTA),                     // 1-bit input: Reset input for AREG
      .RSTALLCARRYIN(RSTALLCARRYIN),   // 1-bit input: Reset input for CARRYINREG
      .RSTALUMODE(RSTALUMODE),         // 1-bit input: Reset input for ALUMODEREG
      .RSTB(RSTB),                     // 1-bit input: Reset input for BREG
      .RSTC(RSTC),                     // 1-bit input: Reset input for CREG
      .RSTCTRL(RSTCTRL),               // 1-bit input: Reset input for OPMODEREG and CARRYINSELREG
      .RSTD(RSTD),                     // 1-bit input: Reset input for DREG and ADREG
      .RSTM(RSTM),                     // 1-bit input: Reset input for MREG
      .RSTP(RSTP)                      // 1-bit input: Reset input for PREG
   );
endmodule 
