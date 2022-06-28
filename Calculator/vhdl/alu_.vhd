-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         alu
-- FILENAME:       alu_.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           09.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the entity declaration of the alu submodule
--                 of the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 09.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
  port (clk_i      :  in std_logic;
        reset_i    :  in std_logic;
        
        start_i    :  in std_logic;
        
        op1_i      :  in std_logic_vector(11 downto 0);
        op2_i      :  in std_logic_vector(11 downto 0);
        optype_i   :  in std_logic_vector (3 downto 0);
        
        result_o   : out std_logic_vector(15 downto 0);
        
        finished_o : out std_logic;
        sign_o     : out std_logic;
        overflow_o : out std_logic;
        error_o    : out std_logic);
end alu;

