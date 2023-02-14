onerror {resume}
quietly virtual signal -install /tb_IPPro_single_core_datapath/uut { /tb_IPPro_single_core_datapath/uut/P[15:0]} P16
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_IPPro_single_core_datapath/uut/CLK
add wave -noupdate /tb_IPPro_single_core_datapath/uut/RESET
add wave -noupdate /tb_IPPro_single_core_datapath/uut/ENABLE
add wave -noupdate /tb_IPPro_single_core_datapath/uut/ENABLE_PC
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/DIN
add wave -noupdate /tb_IPPro_single_core_datapath/uut/EMPTY
add wave -noupdate /tb_IPPro_single_core_datapath/uut/FULL
add wave -noupdate -radix unsigned /tb_IPPro_single_core_datapath/uut/PC
add wave -noupdate /tb_IPPro_single_core_datapath/uut/DValid
add wave -noupdate /tb_IPPro_single_core_datapath/uut/READ_EN
add wave -noupdate /tb_IPPro_single_core_datapath/uut/WRITE_EN
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUT_EN_MASK
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/DOUT
add wave -noupdate /tb_IPPro_single_core_datapath/uut/INSTR
add wave -noupdate /tb_IPPro_single_core_datapath/uut/INSTR_TYPE
add wave -noupdate -divider {Program Counter}
add wave -noupdate -color Turquoise -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/PC
add wave -noupdate -color Turquoise -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/NPC
add wave -noupdate -color Turquoise -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/JPC
add wave -noupdate -divider {Kernel Memory}
add wave -noupdate /tb_IPPro_single_core_datapath/uut/KM_WE
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/KM_ADDR
add wave -noupdate {/tb_IPPro_single_core_datapath/uut/OPCODE[0]}
add wave -noupdate -radix decimal -childformat {{{/tb_IPPro_single_core_datapath/uut/KM_DIN[15]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[14]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[13]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[12]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[11]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[10]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[9]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[8]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[7]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[6]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[5]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[4]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[3]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[2]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[1]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/KM_DIN[0]} -radix decimal}} -subitemconfig {{/tb_IPPro_single_core_datapath/uut/KM_DIN[15]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[14]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[13]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[12]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[11]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[10]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[9]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[8]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[7]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[6]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[5]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[4]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[3]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[2]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[1]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/KM_DIN[0]} {-height 15 -radix decimal}} /tb_IPPro_single_core_datapath/uut/KM_DIN
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/KM_DO
add wave -noupdate -divider {FIFO Signals}
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PB_STATUS
add wave -noupdate /tb_IPPro_single_core_datapath/uut/BRANCH_MASK
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/LM_DOA_4
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUT_EN_WB_1
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUSH_LM_KM_SEL_4
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/SHIFT_OUT
add wave -noupdate -color Gold /tb_IPPro_single_core_datapath/uut/LM_WE_WB
add wave -noupdate -color Gold -radix unsigned /tb_IPPro_single_core_datapath/uut/LM_ADDRD_WB
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/Local_Memory/RF_DIN
add wave -noupdate -radix decimal -childformat {{{/tb_IPPro_single_core_datapath/uut/DOUT[15]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[14]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[13]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[12]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[11]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[10]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[9]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[8]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[7]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[6]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[5]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[4]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[3]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[2]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[1]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/DOUT[0]} -radix decimal}} -subitemconfig {{/tb_IPPro_single_core_datapath/uut/DOUT[15]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[14]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[13]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[12]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[11]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[10]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[9]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[8]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[7]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[6]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[5]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[4]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[3]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[2]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[1]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/DOUT[0]} {-height 15 -radix decimal}} /tb_IPPro_single_core_datapath/uut/DOUT
add wave -noupdate -radix decimal -childformat {{{/tb_IPPro_single_core_datapath/uut/CORE_OUT[15]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[14]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[13]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[12]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[11]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[10]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[9]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[8]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[7]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[6]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[5]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[4]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[3]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[2]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[1]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[0]} -radix decimal}} -subitemconfig {{/tb_IPPro_single_core_datapath/uut/CORE_OUT[15]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[14]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[13]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[12]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[11]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[10]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[9]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[8]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[7]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[6]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[5]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[4]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[3]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[2]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[1]} {-height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/CORE_OUT[0]} {-height 15 -radix decimal}} /tb_IPPro_single_core_datapath/uut/CORE_OUT
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/ALU_OUT
add wave -noupdate -color Cyan -radix decimal -childformat {{{/tb_IPPro_single_core_datapath/uut/P[47]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[46]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[45]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[44]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[43]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[42]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[41]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[40]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[39]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[38]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[37]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[36]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[35]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[34]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[33]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[32]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[31]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[30]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[29]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[28]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[27]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[26]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[25]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[24]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[23]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[22]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[21]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[20]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[19]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[18]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[17]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[16]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[15]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[14]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[13]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[12]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[11]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[10]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[9]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[8]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[7]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[6]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[5]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[4]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[3]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[2]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[1]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/P[0]} -radix decimal}} -subitemconfig {{/tb_IPPro_single_core_datapath/uut/P[47]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[46]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[45]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[44]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[43]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[42]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[41]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[40]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[39]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[38]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[37]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[36]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[35]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[34]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[33]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[32]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[31]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[30]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[29]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[28]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[27]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[26]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[25]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[24]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[23]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[22]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[21]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[20]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[19]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[18]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[17]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[16]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[15]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[14]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[13]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[12]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[11]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[10]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[9]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[8]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[7]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[6]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[5]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[4]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[3]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[2]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[1]} {-color Cyan -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/P[0]} {-color Cyan -height 15 -radix decimal}} /tb_IPPro_single_core_datapath/uut/P
add wave -noupdate -divider {Local Memory Contents}
add wave -noupdate /tb_IPPro_single_core_datapath/uut/Core/Local_Memory/RF_WE
add wave -noupdate -radix unsigned /tb_IPPro_single_core_datapath/uut/LM_ADDRD
add wave -noupdate -radix unsigned /tb_IPPro_single_core_datapath/uut/LM_ADDRB
add wave -noupdate -radix unsigned /tb_IPPro_single_core_datapath/uut/LM_ADDRA
add wave -noupdate -radix unsigned /tb_IPPro_single_core_datapath/uut/LM_ADDRC
add wave -noupdate -color {Orange Red} -radix decimal /tb_IPPro_single_core_datapath/uut/Core/LM_DOD
add wave -noupdate -color {Orange Red} -radix decimal -childformat {{{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[15]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[14]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[13]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[12]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[11]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[10]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[9]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[8]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[7]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[6]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[5]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[4]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[3]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[2]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[1]} -radix decimal} {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[0]} -radix decimal}} -subitemconfig {{/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[15]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[14]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[13]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[12]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[11]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[10]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[9]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[8]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[7]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[6]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[5]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[4]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[3]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[2]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[1]} {-color {Orange Red} -height 15 -radix decimal} {/tb_IPPro_single_core_datapath/uut/Core/LM_DOB[0]} {-color {Orange Red} -height 15 -radix decimal}} /tb_IPPro_single_core_datapath/uut/Core/LM_DOB
add wave -noupdate -color {Orange Red} -radix decimal /tb_IPPro_single_core_datapath/uut/Core/LM_DOA
add wave -noupdate -color {Orange Red} -radix decimal /tb_IPPro_single_core_datapath/uut/Core/LM_DOC
add wave -noupdate -divider {ALU Operands}
add wave -noupdate -color Magenta -radix decimal /tb_IPPro_single_core_datapath/uut/Core/EU_DOA
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/Execution_Unit/DSP48E1_inst/A
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/Execution_Unit/DSP48E1_inst/B
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/Execution_Unit/DSP48E1_inst/C
add wave -noupdate -divider DSP48E1
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/Execution_Unit/DSP48E1_inst/ad_addsub
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/Execution_Unit/DSP48E1_inst/qa_o_reg2
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/Execution_Unit/DSP48E1_inst/qb_o_reg2
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/Execution_Unit/DSP48E1_inst/qc_o_reg1
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/Execution_Unit/DSP48E1_inst/qx_o_mux
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/Execution_Unit/DSP48E1_inst/qy_o_mux
add wave -noupdate -radix decimal /tb_IPPro_single_core_datapath/uut/Core/Execution_Unit/DSP48E1_inst/qz_o_mux
add wave -noupdate -divider {ByPass Module}
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PB/CLK
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PB/RESET
add wave -noupdate -color Yellow /tb_IPPro_single_core_datapath/uut/PB/LOAD_COUNT
add wave -noupdate -color Yellow -radix unsigned /tb_IPPro_single_core_datapath/uut/PB/COUNT_VALUE
add wave -noupdate -color Yellow -radix unsigned /tb_IPPro_single_core_datapath/uut/PB/COUNT
add wave -noupdate -color Yellow /tb_IPPro_single_core_datapath/uut/PB/TERMINATE
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PB_STATUS
add wave -noupdate -divider {Data Forwarding}
add wave -noupdate -radix unsigned /tb_IPPro_single_core_datapath/uut/ADDRB_DF
add wave -noupdate -radix unsigned /tb_IPPro_single_core_datapath/uut/ADDRD_DF
add wave -noupdate /tb_IPPro_single_core_datapath/uut/Data_Forwarding/OPMODE
add wave -noupdate -radix unsigned /tb_IPPro_single_core_datapath/uut/OPMODE_DF
add wave -noupdate -divider {Check Branch}
add wave -noupdate /tb_IPPro_single_core_datapath/uut/CB/CLK
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/Core/EU_DOB
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/Core/EU_DOC
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/P16
add wave -noupdate /tb_IPPro_single_core_datapath/uut/Core/Execution_Unit/PATTERNDETECT
add wave -noupdate -color Magenta /tb_IPPro_single_core_datapath/uut/Core/IPPro_flags/ZF
add wave -noupdate -color Yellow /tb_IPPro_single_core_datapath/uut/Core/IPPro_flags/EQF
add wave -noupdate /tb_IPPro_single_core_datapath/uut/Core/IPPro_flags/GTF
add wave -noupdate /tb_IPPro_single_core_datapath/uut/Core/IPPro_flags/SF
add wave -noupdate -radix binary /tb_IPPro_single_core_datapath/uut/FLAG
add wave -noupdate -radix binary /tb_IPPro_single_core_datapath/uut/BR/IM_FLAGS
add wave -noupdate -radix binary -childformat {{{/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[7]} -radix binary} {{/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[6]} -radix binary} {{/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[5]} -radix binary} {{/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[4]} -radix binary} {{/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[3]} -radix binary} {{/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[2]} -radix binary} {{/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[1]} -radix binary} {{/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[0]} -radix binary}} -subitemconfig {{/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[7]} {-height 15 -radix binary} {/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[6]} {-height 15 -radix binary} {/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[5]} {-height 15 -radix binary} {/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[4]} {-height 15 -radix binary} {/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[3]} {-height 15 -radix binary} {/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[2]} {-height 15 -radix binary} {/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[1]} {-height 15 -radix binary} {/tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS[0]} {-height 15 -radix binary}} /tb_IPPro_single_core_datapath/uut/CB/ALU_FLAGS
add wave -noupdate -radix unsigned -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BR/BADDR_IN
add wave -noupdate -radix unsigned -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BR/BADDR_OUT
add wave -noupdate /tb_IPPro_single_core_datapath/uut/CB/BRANCH_SEL
add wave -noupdate -divider {Branch Select}
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BRANCH_SELECT/DIN0
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BRANCH_SELECT/DIN1
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BRANCH_SELECT/SEL
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BRANCH_SELECT/OUT
add wave -noupdate -divider {Jump Select}
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/JUMP_SELECT/DIN0
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/JUMP_SELECT/DIN1
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/JUMP_SELECT/SEL
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/JUMP_SELECT/OUT
add wave -noupdate -divider {Branch module}
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BR/F
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BR/F1
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BR/F2
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BR/B1
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BR/B2
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BR/B3
add wave -noupdate -radix decimal -radixshowbase 0 /tb_IPPro_single_core_datapath/uut/BR/B4
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUT_EN_1
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUT_EN_2
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUT_EN
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUT_EN_WB
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUT_EN_WB_1
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUT_EN_WB_2
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUT_EN_WB_3
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUSH_LM_KM_SEL_1
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUSH_LM_KM_SEL_2
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUSH_LM_KM_SEL_3
add wave -noupdate /tb_IPPro_single_core_datapath/uut/PUSH_LM_KM_SEL_4
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2040 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 147
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1669 ns} {2153 ns}
