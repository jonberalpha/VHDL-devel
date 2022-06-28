-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         tb_io_ctrl
-- FILENAME:       tb_io_ctrl_sim_cfg.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           06.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the configuration for the io_ctrl testbench
--                 of the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 06.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

configuration tb_io_ctrl_sim_cfg of tb_io_ctrl is
  for sim
    for i_io_ctrl : io_ctrl
      use configuration work.io_ctrl_rtl_cfg;
    end for;
  end for;
end tb_io_ctrl_sim_cfg;
