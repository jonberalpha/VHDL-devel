--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   16/10/2020
-- Design Name:   ClockDivider_TB
-- Project Name:  Basic_Elements
-- VHDL Test Bench Created by ISE for module: ClockDivider
-- Revision:      V0.1
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY ChangeSign_TB IS
END ChangeSign_TB;
 
ARCHITECTURE behavior OF ChangeSign_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ChangeSign
    PORT(
         a : IN  SIGNED(3 downto 0);
         b : OUT  SIGNED(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : SIGNED(3 downto 0) := (others => '0');

   --Outputs
   signal b : SIGNED(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: ChangeSign PORT MAP (
          a => a,
          b => b
        );

  a <= "0110", "1010" after 20 ns, "1000" after 40 ns, "0000" after 60 ns;
   

END;
