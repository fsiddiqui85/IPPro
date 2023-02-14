onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /LSM_Sim/ENABLE
add wave -noupdate /LSM_Sim/RESET
add wave -noupdate -divider Testbench
add wave -noupdate /LSM_Sim/INSTR
add wave -noupdate -radix decimal /LSM_Sim/VEC_DATA_IN
add wave -noupdate /LSM_Sim/FIFO_I_WRITE_EN
add wave -noupdate /LSM_Sim/PROGRAM_LENGTH
add wave -noupdate -radix decimal /LSM_Sim/VEC_DATA_OUT
add wave -noupdate /LSM_Sim/VEC_DValid
add wave -noupdate /LSM_Sim/TASK_END
add wave -noupdate -divider PC
add wave -noupdate /LSM_Sim/uut/Program_Counter/ENABLE
add wave -noupdate -radix unsigned /LSM_Sim/uut/Program_Counter/PC
add wave -noupdate -radix unsigned /LSM_Sim/uut/Program_Counter/NPC
add wave -noupdate -radix unsigned /LSM_Sim/uut/Program_Counter/CPC
add wave -noupdate -divider {Input FIFO}
add wave -noupdate {/LSM_Sim/uut/SIMD_IPPro/STAGE_I[0]/FB1/ENABLE}
add wave -noupdate {/LSM_Sim/uut/SIMD_IPPro/STAGE_I[0]/FB1/READ_EN}
add wave -noupdate -radix unsigned {/LSM_Sim/uut/SIMD_IPPro/STAGE_I[0]/FB1/RDCOUNT}
add wave -noupdate -radix unsigned {/LSM_Sim/uut/SIMD_IPPro/STAGE_I[0]/FB1/WRCOUNT}
add wave -noupdate -divider {MIN MAX module}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/MIN_MAX_SELECT/DIN0}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/MIN_MAX_SELECT/DIN1}
add wave -noupdate {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/MIN_MAX_SELECT/SEL}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/MIN_MAX_SELECT/OUT}
add wave -noupdate -divider {Local Memory}
add wave -noupdate {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/LM_DIN_SEL_WB}
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/LM_WE_WB
add wave -noupdate -color Blue -radix unsigned {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Local_Memory/RF_ADDRD}
add wave -noupdate -color Magenta -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Local_Memory/RF_DIN}
add wave -noupdate -radix unsigned {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Local_Memory/RF_ADDRA}
add wave -noupdate -radix unsigned {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Local_Memory/RF_ADDRB}
add wave -noupdate -radix unsigned {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Local_Memory/RF_ADDRC}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Local_Memory/RF_DOA}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Local_Memory/RF_DOB}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Local_Memory/RF_DOC}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Local_Memory/RF_DOD}
add wave -noupdate -divider PGBypass
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/PB/RESET
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/PB/LOAD_COUNT
add wave -noupdate -radix decimal /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/PB/COUNT_VALUE
add wave -noupdate -radix decimal /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/PB/COUNT
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/PB/TERMINATE
add wave -noupdate -expand /LSM_Sim/uut/SIMD_IPPro/ENABLE_Core
add wave -noupdate -divider Core
add wave -noupdate /LSM_Sim/CLK
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/IPPro_DValid
add wave -noupdate -radix decimal /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_OUT
add wave -noupdate -radix decimal /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/IPPro_OUT
add wave -noupdate -color Gold -radix decimal {/LSM_Sim/uut/SIMD_IPPro/STAGE_I[0]/FB1/FIFO_IN}
add wave -noupdate -color Red -radix decimal {/LSM_Sim/uut/SIMD_IPPro/STAGE_I[0]/FB1/FIFO_OUT}
add wave -noupdate -radix decimal /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/OP1
add wave -noupdate -color Magenta -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/EU_DOA}
add wave -noupdate -color Magenta -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/EU_DOB}
add wave -noupdate -color Gold -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/EU_DOC}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/EU_DOD}
add wave -noupdate -radix unsigned /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/LM_ADDRA
add wave -noupdate -radix unsigned /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/LM_ADDRB
add wave -noupdate -radix unsigned /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/LM_ADDRC
add wave -noupdate -radix unsigned /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/LM_ADDRD
add wave -noupdate -divider {Kernel Memory}
add wave -noupdate -radix unsigned /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/KM_ADDR
add wave -noupdate -radix decimal /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/KM_DIN
add wave -noupdate -radix decimal /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/KM_DO
add wave -noupdate -divider {Output FIFO}
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/PUT_EN
add wave -noupdate {/LSM_Sim/uut/SIMD_IPPro/STAGE_O[0]/FB2/WRITE_EN}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/STAGE_O[0]/FB2/FIFO_IN}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/STAGE_O[0]/FB2/FIFO_OUT}
add wave -noupdate -radix unsigned {/LSM_Sim/uut/SIMD_IPPro/STAGE_O[0]/FB2/RDCOUNT}
add wave -noupdate -radix unsigned {/LSM_Sim/uut/SIMD_IPPro/STAGE_O[0]/FB2/WRCOUNT}
add wave -noupdate -divider {Put Module}
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/ENABLE
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/FIFO_I_WRITE_EN
add wave -noupdate -divider {Get Module}
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/ENABLE
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/FIFO_I_WRITE_EN
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/FIFO_I_READ_EN
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Execution_Unit/DSP48E1_inst/ALUMODE}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Execution_Unit/DSP48E1_inst/A}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Execution_Unit/DSP48E1_inst/B}
add wave -noupdate -radix decimal {/LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/CORE_BLOCKS[0]/Core/Execution_Unit/DSP48E1_inst/C}
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/WB/RF_DIN_SEL
add wave -noupdate /LSM_Sim/uut/SIMD_IPPro/IPPro_SIMD9/WB/RF_DIN_SEL_WB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5858650 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 195
configure wave -valuecolwidth 100
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
WaveRestoreZoom {5858078 ns} {5858712 ns}
