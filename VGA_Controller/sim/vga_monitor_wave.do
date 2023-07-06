onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format LOGIC /tb_vga_monitor/clk_i
add wave -noupdate -format LOGIC /tb_vga_monitor/reset_i
add wave -noupdate -radix hexadecimal /tb_vga_monitor/s_red
add wave -noupdate -radix hexadecimal /tb_vga_monitor/s_green
add wave -noupdate -radix hexadecimal /tb_vga_monitor/s_blue
add wave -noupdate -format LOGIC /tb_vga_monitor/s_h_sync
add wave -noupdate -format LOGIC /tb_vga_monitor/s_v_sync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
#WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
WaveRestoreZoom {0 ps} {105 us}
