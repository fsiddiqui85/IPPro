function [] = i_STIMM(fid,KN)
%UNTITLED Summary of this function goes here
%   RD=RC+(Ra*Rb)
TYPE = '011';
OPCODE = '00000';

IME ={'K0','K1','K2','K3','K4','K5','K6','K7','K8','K9','K10','K11','K12','K13','K14','K15','K16','K17','K18','K19','K20','K21','K22','K23','K24','K25','K26','K27','K28','K29','K30','K31'};

reg_comp_M = strcmp(KN,IME);

if max(reg_comp_M)
      KN = (dec2bin(find(reg_comp_M==1)-1,5));
end


fprintf(fid,TYPE);
fprintf(fid,OPCODE);
fprintf(fid,'00000');
fprintf(fid,KN);
fprintf(fid,'00000');
fprintf(fid,'00000');
fprintf(fid,'000000\n');
end



