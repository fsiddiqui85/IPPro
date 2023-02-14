// Code Snippets

// FIFO Instructions
INSTR = {`get, 5'b00000, 5'b00000, 5'b00000, 5'b00000, 6'b000000};
INSTR = {`put, 5'b00000, 5'b00000, 5'b00000, 5'b00000, 6'b000000};
INSTR = {`putlm, `R1, 5'b00000, 5'b00000, 5'b00000, 6'b000000};
INSTR = {`putkm, 5'b00000, `K1, 5'b00000, 5'b00000, 6'b000000};

// KM store instruction
INSTR = {`stimm, 5'b00000, `K1, 16'h0001};

// FIFO - LM Instructions
INSTR = {`mul,`R4,`R10, 5'b00000, 5'b00000, 6'b000000} 	;
INSTR = {`mulacc,`R10,`R6,5'b00000,5'b00000,6'b000000} 	;	
INSTR = {`muladd,`R6,`R7, 5'b00000,`R9,6'b000000} 		;
INSTR = {`mulsub,`R7,`R8, 5'b00000,`R10,6'b000000} 		;
INSTR = {`add,`R11,`R10,5'b00000,5'b00000,6'b000000} 	;
INSTR = {`sub,`R13,`R7,5'b00000,5'b00000,6'b000000} 	;
INSTR = {`lsl,`R10,`R4,5'b00000,5'b00000,6'b000000} 	;
INSTR = {`lsr,`R16,`R11,5'b00000,5'b00000,6'b000000} 	;
INSTR = {`min,`R1,`R9,5'b00000,5'b00000,6'b000000} 		;
INSTR = {`max,`R2,`R30,5'b00000,5'b00000,6'b000000} 	;

// FIFO - KM Instructions
INSTR = {`mulk,`R10,`K3, 5'b00000, 5'b00000, 6'b000000} 	;
INSTR = {`mulacck,`R10,`K1, 5'b00000 ,5'b00000,6'b000000} 	;	
INSTR = {`muladdk,`R6,`K3, 5'b00000,`R9,6'b000000} 			;
INSTR = {`mulsubk,`R7,`K2, 5'b00000,`R10,6'b000000} 		;
INSTR = {`addk,`R3,`K2,  5'b00000, 5'b00000, 6'b000000} 	;
INSTR = {`subk,`R4,`K3,  5'b00000, 5'b00000, 6'b000000} 	;

// LM - LM
INSTR = {`mullm,`R16,`R11,`R9, 5'b00000, 6'b000000} 	;
INSTR = {`mullmacc,`R10,`R7,`R8,5'b00000,6'b000000} 	;	
INSTR = {`mullmadd,`R14,`R8,`R9,`R6,6'b000000} 			;
INSTR = {`mullmsub,`R10,`R9,`R10,`R11,6'b000000}		;
INSTR = {`addlm,`R11,`R10,5'b00000,`R12,6'b000000} 		;	
INSTR = {`sublm,`R13,`R7,5'b00000,`R6,6'b000000} 		;		
INSTR = {`minlm,`R1,`R9,5'b00000,`R12,6'b000000} 		;
INSTR = {`maxlm,`R2,`R30,5'b00000,`R21,6'b000000} 		;

// Branch Instruction
INSTR = {`jmp, 5'b00000,5'b00000,16'h0007}	;
INSTR = {`bneq,5'b00000,5'b00000,16'h0007}	;
INSTR = {`beq, 5'b00000,5'b00000,16'h0007}	;
INSTR = {`bz,  5'b00000,5'b00000,16'h0007}	;
INSTR = {`bnz, 5'b00000,5'b00000,16'h0007}	;
INSTR = {`bs,  5'b00000,5'b00000,16'h0007}	;
INSTR = {`bns, 5'b00000,5'b00000,16'h0007}	;
INSTR = {`bgt, 5'b00000,5'b00000,16'h0007}	;
INSTR = {`bngt,5'b00000,5'b00000,16'h0007}	;

// NOP
INSTR = {`nop,`R0,`R0,`R0,`R0,6'b000000} ;