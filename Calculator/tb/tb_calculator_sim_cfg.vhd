-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         tb_calculator
-- FILENAME:       tb_calculator_sim_cfg.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           18.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the configuration for the calculator testbench
--                 of the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 18.03.2022
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

configuration tb_calculator_sim_cfg of tb_calculator is
  for sim
    for i_calculator : calculator
      use configuration work.calculator_struc_cfg;
    end for;
  end for;
end tb_calculator_sim_cfg;
