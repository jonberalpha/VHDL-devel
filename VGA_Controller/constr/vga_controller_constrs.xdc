# Constraints for VGA Controller and MC8051 IP Core Demo Design
# FPGA device/board: Xilinx Artix-7 on Digilent Basys3 board
# Author: Jonas Berger
# Date: 29.11.2022

# MC8051 IP Core I/O Definition
set_property PACKAGE_PIN U16 [get_ports {led_o[0]}]
set_property PACKAGE_PIN E19 [get_ports {led_o[1]}]
set_property PACKAGE_PIN U19 [get_ports {led_o[2]}]
set_property PACKAGE_PIN V19 [get_ports {led_o[3]}]
set_property PACKAGE_PIN W18 [get_ports {led_o[4]}]
set_property PACKAGE_PIN U15 [get_ports {led_o[5]}]
set_property PACKAGE_PIN U14 [get_ports {led_o[6]}]
set_property PACKAGE_PIN V14 [get_ports {led_o[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[7]}]

# VGA Controller I/O Definition
set_property IOSTANDARD LVCMOS33 [get_ports {blue_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {blue_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {blue_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {blue_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {green_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {green_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {green_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {green_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {red_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {red_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {red_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {red_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports clk_i]
set_property IOSTANDARD LVCMOS33 [get_ports h_sync_o]
set_property IOSTANDARD LVCMOS33 [get_ports reset_i]
set_property IOSTANDARD LVCMOS33 [get_ports v_sync_o]
set_property IOSTANDARD LVCMOS33 [get_ports {pb_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb_i[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb_i[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb_i[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[0]}]
set_property PACKAGE_PIN G19 [get_ports {red_o[0]}]
set_property PACKAGE_PIN H19 [get_ports {red_o[1]}]
set_property PACKAGE_PIN J19 [get_ports {red_o[2]}]
set_property PACKAGE_PIN N19 [get_ports {red_o[3]}]
set_property PACKAGE_PIN J17 [get_ports {green_o[0]}]
set_property PACKAGE_PIN H17 [get_ports {green_o[1]}]
set_property PACKAGE_PIN G17 [get_ports {green_o[2]}]
set_property PACKAGE_PIN D17 [get_ports {green_o[3]}]
set_property PACKAGE_PIN N18 [get_ports {blue_o[0]}]
set_property PACKAGE_PIN L18 [get_ports {blue_o[1]}]
set_property PACKAGE_PIN K18 [get_ports {blue_o[2]}]
set_property PACKAGE_PIN J18 [get_ports {blue_o[3]}]
set_property PACKAGE_PIN W5 [get_ports clk_i]
set_property PACKAGE_PIN P19 [get_ports h_sync_o]
set_property PACKAGE_PIN R19 [get_ports v_sync_o]
set_property PACKAGE_PIN U18 [get_ports reset_i]
set_property PACKAGE_PIN T18 [get_ports {pb_i[3]}]
set_property PACKAGE_PIN U17 [get_ports {pb_i[2]}]
set_property PACKAGE_PIN W19 [get_ports {pb_i[1]}]
set_property PACKAGE_PIN T17 [get_ports {pb_i[0]}]
set_property PACKAGE_PIN W17 [get_ports {sw_i[3]}]
set_property PACKAGE_PIN W16 [get_ports {sw_i[2]}]
set_property PACKAGE_PIN V16 [get_ports {sw_i[1]}]
set_property PACKAGE_PIN V17 [get_ports {sw_i[0]}]
create_clock -add -period 10.000 -name mclk -waveform {0.000 5.000} [get_ports clk_i]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]