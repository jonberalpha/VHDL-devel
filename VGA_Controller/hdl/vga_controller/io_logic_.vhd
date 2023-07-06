-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         io_logic
-- FILENAME:       io_logic_.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           27.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the entity declaration of the IO Logic
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 27.09.2022
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;

entity io_logic is
  generic (
        G_BTN_CNT : natural := 4; -- button count
        G_SW_CNT  : natural := 4  -- switch count
      );
  port(
        clk_i     : in   STD_LOGIC;
        reset_i   : in   STD_LOGIC;
        pb_i      : in   STD_LOGIC_VECTOR(G_BTN_CNT-1 downto 0);
        sw_i      : in   STD_LOGIC_VECTOR (G_SW_CNT-1 downto 0);
        pb_sync_o : out  STD_LOGIC_VECTOR(G_BTN_CNT-1 downto 0);
        sw_sync_o : out  STD_LOGIC_VECTOR (G_SW_CNT-1 downto 0)
      );
end io_logic;
