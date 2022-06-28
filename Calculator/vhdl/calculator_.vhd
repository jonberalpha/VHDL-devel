-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         calculator
-- FILENAME:       calculator_.vhd
-- ARCHITECTURE:   struc
-- ENGINEER:       Jonas Berger
-- DATE:           09.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the entity declaration of the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 09.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity calculator is
  port (reset_i  :  in std_logic;
        clk_i    :  in std_logic;
        pb_i     :  in std_logic_vector(3 downto 0);
        sw_i     :  in std_logic_vector(15 downto 0);
        ss_o     : out std_logic_vector(7 downto 0);
        ss_sel_o : out std_logic_vector(3 downto 0);
        led_o    : out std_logic_vector(15 downto 0));
end calculator;

