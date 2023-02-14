function [] = i_BNS(fid)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
TYPE = '100';
OPCODE = '01000';

fprintf(fid,TYPE);
fprintf(fid,OPCODE);
fprintf(fid,'00000');
fprintf(fid,'00000');
fprintf(fid,'00000');
fprintf(fid,'00000');
fprintf(fid,'000000\n');
fprintf(fid,'\n');
end
