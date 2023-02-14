`timescale 1ns / 1ps
//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : FIFO PUT
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : PUT_module.v
// Generated   : Tue Nov 18 22:36:14 2014
//
// Revision 0.1    :
//
//------------------------------------------------------------------------------------------
//
// Description : This module implements the handshaking between FIFO and cores
//
//------------------------------------------------------------------------------------------
// Revision 0.1:
//				- 
//				
//------------------------------------------------------------------------------------------
`include "parameters.v"

module PUT_module(
		CLK,
		RESET,
		ENABLE,
		FULL,
		FIFO_WRITE_EN
	);
	
	input 		CLK, RESET, ENABLE, FULL ;
	output	reg FIFO_WRITE_EN ;
	
	always @ (posedge CLK)
	begin
		if(ENABLE & ~FULL)
			FIFO_WRITE_EN = 1 ;
		else
			FIFO_WRITE_EN = 0 ;
	end
//------------------------------------------------------------------------------------------	
endmodule
