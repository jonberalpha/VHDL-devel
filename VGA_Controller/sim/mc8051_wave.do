onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_mc8051/clk_i
add wave -noupdate /tb_mc8051/reset_i
add wave -noupdate /tb_mc8051/i_fpga_top/s_locked
add wave -noupdate /tb_mc8051/i_fpga_top/s_reset_8051
add wave -noupdate /tb_mc8051/i_fpga_top/s_clk25
add wave -noupdate -radix hexadecimal /tb_mc8051/i_fpga_top/i_mc8051_top/s_rom_adr
add wave -noupdate -radix hexadecimal /tb_mc8051/i_fpga_top/i_mc8051_top/s_rom_data
add wave -noupdate /tb_mc8051/led_o(0)
add wave -noupdate /tb_mc8051/led_o(1)
add wave -noupdate /tb_mc8051/led_o(2)
add wave -noupdate /tb_mc8051/led_o(3)
add wave -noupdate /tb_mc8051/led_o(4)
add wave -noupdate /tb_mc8051/led_o(5)
add wave -noupdate /tb_mc8051/led_o(6)
add wave -noupdate /tb_mc8051/led_o(7)
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
#WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
WaveRestoreZoom {0 ps} {105 us}
