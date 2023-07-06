-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         debounce
-- FILENAME:       debounce_.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           27.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the entity declaration of the Debouncer
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 27.09.2022
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;

entity debounce is
  port(
        clk_i   : in  STD_LOGIC;
        reset_i : in  STD_LOGIC;
        tick_i  : in  STD_LOGIC;
        sw_i    : in  STD_LOGIC;   -- input
        swout_o : out  STD_LOGIC   -- debounced output
      );
end debounce;
