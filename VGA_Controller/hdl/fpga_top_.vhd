-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         fpga_top
-- FILENAME:       fpga_top_.vhd
-- ARCHITECTURE:   struc
-- ENGINEER:       Jonas Berger
-- DATE:           19.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the entity declaration of the VGA Controller
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 19.09.2022
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all; 

library work;
use work.vga_controller_pkg.all; -- location of component declarations
use work.mc8051_p.all;

entity fpga_top is
  port(
        clk_i   : in  std_logic;                    -- 100 MHz clock signal
        reset_i : in  std_logic;                    -- reset signal
        
        pb_i    : in  std_logic_vector(3 downto 0); -- push buttons
        sw_i    : in  std_logic_vector(3 downto 0); -- switches
        
        red_o   : out std_logic_vector(3 downto 0); -- red value
        green_o : out std_logic_vector(3 downto 0); -- green value
        blue_o  : out std_logic_vector(3 downto 0); -- blue value
       
        h_sync_o : out std_logic; -- sync signal
        v_sync_o : out std_logic; -- sync signal
        
        led_o : out std_logic_vector(7 downto 0) -- 8 LEDs LED0 - LED7
      );
end fpga_top;
