-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         tb_alu
-- FILENAME:       tb_alu_sim_cfg.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           10.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the configuration for the alu testbench
--                 of the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 10.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

configuration tb_alu_sim_cfg of tb_alu is
  for sim
    for i_alu : alu
      use configuration work.alu_rtl_cfg;
    end for;
  end for;
end tb_alu_sim_cfg;
