clear all;close all; clc;
%%
addpath Instructions/Branch;
addpath Instructions/CoProcessor;
addpath Instructions/FIFO;
addpath Instructions/KM-FIFO;
addpath Instructions/LM-FIFO;
addpath Instructions/LM-LM;
%%
fid=fopen('../../../../../Dropbox/IpproSystem/test/instructions.coe','w');
%%
fprintf(fid,'memory_initialization_radix=2;\nmemory_initialization_vector=\n');

%%
i_GET(fid);
i_PUT(fid);
i_GET(fid);
i_PUT(fid);
i_GET(fid);
i_PUT(fid);
i_GET(fid);
i_PUT(fid);
i_GET(fid);
i_PUT(fid);
i_GET(fid);
i_GET(fid);
i_GET(fid);
i_GET(fid);
i_GET(fid);
i_GET(fid);
i_GET(fid);
i_GET(fid);
i_GET(fid);
i_GET(fid);
i_GET(fid);
i_GET(fid);
i_GET(fid);


% i_PUTLM(fid,'R1')
% i_GET(fid);
% i_PUTLM(fid,'R2')
% i_ADD(fid,'R3','R2','R1')
% i_PUT(fid);

for x=1:1:30
    i_NOP(fid);
end

% fprintf(fid,'------Register to Register---------\n');
% i_NOP(fid);
% i_ADD(fid,'R0','R0','R0');
% i_SUB(fid,'R0','R0','R0');
% i_MUL(fid,'R0','R0','R0');
% i_MULADD(fid,'R0','R0','R0','R0');
% i_MULSUB(fid,'R0','R0','R0','R0');
% i_MULACC(fid,'R0','R0','R0');
% i_LAND(fid,'R0','R0','R0');
% i_LXOR(fid,'R0','R0','R0');
% i_LXNR(fid,'R0','R0','R0');
% i_LOR(fid,'R0','R0','R0');
% i_LNOR(fid,'R0','R0','R0');
% i_LNOT(fid,'R0','R0','R0');
% i_LNAND(fid,'R0','R0','R0');
% fprintf(fid,'------Register to Immediate---------\n');
% i_ADDI(fid,'R0','R0',0);
% i_SUBI(fid,'R0','R0',0);
% i_LANDI(fid,'R0','R0',0);
% i_LXORI(fid,'R0','R0',0);
% i_LXNRI(fid,'R0','R0',0);
% i_LORI(fid,'R0','R0',0);
% i_LNORI(fid,'R0','R0',0);
% i_LNOTI(fid,'R0','R0',0);
% i_LNANDI(fid,'R0','R0',0);
% fprintf(fid,'------Data Memory-------------------\n');
% i_LD(fid,'R0','M0')
% i_ST(fid,'R0','M0')
% fprintf(fid,'------Register to IMM/Kernel Memory--------\n');
% i_STIMM(fid,'K0');
% i_ADDK(fid,'R0','K0','R0');
% i_SUBK(fid,'R0','K0','R0');
% i_MULK(fid,'R0','K0','R0');
% i_MULADDK(fid,'R0','K0','R0','R0');
% i_MULSUBK(fid,'R0','K0','R0','R0');
% i_MULACCK(fid,'R0','K0','R0');
% i_LXORK(fid,'R0','K0','R0');
% i_LXNRK(fid,'R0','K0','R0');
% i_LORK(fid,'R0','K0','R0');
% i_LNORK(fid,'R0','K0','R0');
% i_LNANDK(fid,'R0','K0','R0');
% i_LANDK(fid,'R0','K0','R0');
%%
fclose(fid);
