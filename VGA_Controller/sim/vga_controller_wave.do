onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format LOGIC /tb_vga_controller/s_clk
add wave -noupdate -format LOGIC /tb_vga_controller/s_reset
add wave -noupdate -format LOGIC /tb_vga_controller/s_pb
add wave -noupdate -format LOGIC /tb_vga_controller/s_sw
add wave -noupdate -format LOGIC /tb_vga_controller/i_fpga_top/i_vga_cntrl/hpos_o
add wave -noupdate -format LOGIC /tb_vga_controller/i_fpga_top/i_vga_cntrl/vpos_o
add wave -noupdate -radix hexadecimal /tb_vga_controller/i_fpga_top/s_rom1_addr
add wave -noupdate -radix hexadecimal /tb_vga_controller/i_fpga_top/s_rom1_data
add wave -noupdate -radix hexadecimal /tb_vga_controller/s_red
add wave -noupdate -radix hexadecimal /tb_vga_controller/s_green
add wave -noupdate -radix hexadecimal /tb_vga_controller/s_blue
add wave -noupdate -format LOGIC /tb_vga_controller/s_h_sync
add wave -noupdate -format LOGIC /tb_vga_controller/s_v_sync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
#WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
WaveRestoreZoom {0 ps} {105 us}
