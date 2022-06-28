onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format LOGIC /tb_calculator/clk_i
add wave -noupdate -format LOGIC /tb_calculator/reset_i
add wave -noupdate -format LOGIC /tb_calculator/pb_i
add wave -noupdate -format LOGIC /tb_calculator/sw_i
add wave -noupdate -format LOGIC /tb_calculator/ss_o
add wave -noupdate -format LOGIC /tb_calculator/ss_sel_o
add wave -noupdate -format LOGIC /tb_calculator/led_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
