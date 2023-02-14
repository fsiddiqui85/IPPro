function [] = i_LXOR(fid,RD,RB)
%UNTITLED Summary of this function goes here
%   RD=RC+(Ra*Rb)
TYPE = '000';
OPCODE = '01000';

RFE = {'R0','R1','R2','R3','R4','R5','R6','R7','R8','R9','R10','R11','R12','R13','R14','R15','R16','R17','R18','R19','R20','R21','R22','R23','R24','R25','R26','R27','R28','R29','R30','R31'};
% reg_comp_A = strcmp(RA,RFE);
reg_comp_B = strcmp(RB,RFE);
reg_comp_D = strcmp(RD,RFE);
% if max(reg_comp_A)
%       RA = (dec2bin(find(reg_comp_A==1)-1,5));
% end
if max(reg_comp_B)
      RB = (dec2bin(find(reg_comp_B==1)-1,5));
end

if max(reg_comp_D)
      RD = (dec2bin(find(reg_comp_D==1)-1,5));
end

fprintf(fid,TYPE);
fprintf(fid,OPCODE);
fprintf(fid,RD);
fprintf(fid,RB);
fprintf(fid,'00000');
fprintf(fid,'00000');
fprintf(fid,'000000\n');

end



