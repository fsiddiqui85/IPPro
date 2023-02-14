function [] = i_LXNRK(fid,RD,KN)
%UNTITLED Summary of this function goes here
%   RD=RC+(Ra*Rb)
TYPE = '011';
OPCODE = '01001';

RFE = {'R0','R1','R2','R3','R4','R5','R6','R7','R8','R9','R10','R11','R12','R13','R14','R15','R16','R17','R18','R19','R20','R21','R22','R23','R24','R25','R26','R27','R28','R29','R30','R31'};
IME ={'K0','K1','K2','K3','K4','K5','K6','K7','K8','K9','K10','K11','K12','K13','K14','K15','K16','K17','K18','K19','K20','K21','K22','K23','K24','K25','K26','K27','K28','K29','K30','K31'};

reg_comp_M = strcmp(KN,IME);

reg_comp_D = strcmp(RD,RFE);

if max(reg_comp_D)
      RD = (dec2bin(find(reg_comp_D==1)-1,5));
end
if max(reg_comp_M)
      KN = (dec2bin(find(reg_comp_M==1)-1,5));
end


fprintf(fid,TYPE);
fprintf(fid,OPCODE);
fprintf(fid,RD);
fprintf(fid,KN);
fprintf(fid,'00000');
fprintf(fid,'00000');
fprintf(fid,'000000\n');
end

