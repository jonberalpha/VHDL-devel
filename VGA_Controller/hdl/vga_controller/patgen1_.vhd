-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         patgen1
-- FILENAME:       patgen1_.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           28.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the entity declaration of the Pattern Generator 1
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 28.09.2022
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity patgen1 is
  generic(
        G_SCREEN_WIDTH : natural := 1920;
        G_COL_CNT      : natural := 4
  );
  port(
        clk_i    : in  std_logic;                   -- 25 MHz clock signal coming from clock oscillator
        reset_i  : in  std_logic;                   -- reset signal
        
        hpos_i   : in std_logic_vector(9 downto 0); -- 10 bit to fit max 640 count for both h_pos and v_pos
        
        red_o   : out std_logic_vector(3 downto 0); -- red value vga out
        green_o : out std_logic_vector(3 downto 0); -- green value vga out
        blue_o  : out std_logic_vector(3 downto 0)  -- blue value vga out
      );
end patgen1;
