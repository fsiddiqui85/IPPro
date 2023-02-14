`timescale 1ns / 1ps
//------------------------------------------------------------------------------------------
// Copyright (c) 2017 Fahad Siddiqui
// All rights reserved.
//
// This source code is licensed under the BSD-4-Clause license found in the
// LICENSE file in the root directory of this source tree. 
//------------------------------------------------------------------------------------------
//
// Title       : FIFO GET
// Design      : Streaming IPPro
// Author      : Fahad Manzoor Siddiqui	
// Company     : ECIT, QUB
//
//------------------------------------------------------------------------------------------
//
// File        : GET_module.v
// Generated   : Tue Nov 18 22:31:14 2014
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

module GET_module(
		CLK,
		RESET,
		ENABLE,
		EMPTY,
		FIFO_READ_EN
	);
	
	input 		CLK, RESET, ENABLE, EMPTY ;
	output	reg FIFO_READ_EN ;
	
	always @ (*)
	begin
		if(ENABLE & ~ EMPTY)
			FIFO_READ_EN = 1 ;
		else
			FIFO_READ_EN = 0 ;
	end
//------------------------------------------------------------------------------------------	
endmodule
