-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         vga_cntrl
-- FILENAME:       vga_cntrl_.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           19.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the entity declaration of the VGA Conrol Unit
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 19.03.2022
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_cntrl is
  port(
        clk_i   : in  std_logic;                    -- 25 MHz clock signal coming from clock oscillator
        px_en_i : in  std_logic;                    -- pixel enable coming from the pll
        
        reset_i : in  std_logic;                    -- reset signal
        
        red_i   : in std_logic_vector(3 downto 0);  -- red value in
        green_i : in std_logic_vector(3 downto 0);  -- green value in
        blue_i  : in std_logic_vector(3 downto 0);  -- blue value in
        
        hpos_o : out std_logic_vector (9 downto 0); -- 10 bit to fit max 640 count ...
        vpos_o : out std_logic_vector (9 downto 0); -- ... for both h_pos and v_pos
        
        red_o   : out std_logic_vector(3 downto 0); -- red value vga out
        green_o : out std_logic_vector(3 downto 0); -- green value vga out
        blue_o  : out std_logic_vector(3 downto 0); -- blue value vga out
       
        h_sync_o : out std_logic;
        v_sync_o : out std_logic
      );
end vga_cntrl;
