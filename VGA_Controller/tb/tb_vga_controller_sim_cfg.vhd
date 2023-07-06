-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         tb_vga_controller
-- FILENAME:       tb_vga_controller_sim_cfg.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           20.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the configuration for the vga controller testbench
--                 of the VGA Controller - Project
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 20.09.2022
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

configuration tb_vga_controller_sim_cfg of tb_vga_controller is
  for sim
    for i_fpga_top : fpga_top
      use configuration work.fpga_top_struc_cfg;
    end for;
  end for;
end tb_vga_controller_sim_cfg;
