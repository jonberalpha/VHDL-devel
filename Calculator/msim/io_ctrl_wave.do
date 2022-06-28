onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format LOGIC /tb_io_ctrl/clk_i
add wave -noupdate -format LOGIC /tb_io_ctrl/reset_i
add wave -noupdate -format LOGIC /tb_io_ctrl/sw_i
add wave -noupdate -format LOGIC /tb_io_ctrl/pb_i
add wave -noupdate -hex /tb_io_ctrl/dig0_i
add wave -noupdate -hex /tb_io_ctrl/dig1_i
add wave -noupdate -hex /tb_io_ctrl/dig2_i
add wave -noupdate -hex /tb_io_ctrl/dig3_i
add wave -noupdate -format LOGIC /tb_io_ctrl/led_i
add wave -noupdate -hex /tb_io_ctrl/ss_o
add wave -noupdate -format LOGIC /tb_io_ctrl/ss_sel_o
add wave -noupdate -format LOGIC /tb_io_ctrl/led_o
add wave -noupdate -hex /tb_io_ctrl/swsync_o
add wave -noupdate -hex /tb_io_ctrl/pbsync_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
