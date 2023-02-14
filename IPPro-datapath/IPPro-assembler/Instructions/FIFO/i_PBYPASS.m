function [] = i_PBYPASS(fid,IM)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
TYPE = '010';
OPCODE = '11000';

fprintf(fid,TYPE);
fprintf(fid,OPCODE);
IM2=dec2bin(IM,16);
fprintf(fid,IM2);
fprintf(fid,'\n');
end
