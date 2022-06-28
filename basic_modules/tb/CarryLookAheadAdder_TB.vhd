--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   01/04/2019
-- Design Name:   Carry Look Ahead Adder
-- Project Name:  Basic_Elements
-- VHDL Test Bench Created by ISE for module: CarryLookAheadAdder
-- Revision:      V0.1
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY CarryLookAheadAdder_TB IS
END CarryLookAheadAdder_TB;
 
ARCHITECTURE behavior OF CarryLookAheadAdder_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CarryLookAheadAdder
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         SUM : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');

   --Outputs
   signal SUM : std_logic_vector(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: CarryLookAheadAdder PORT MAP (
          A => A,
          B => B,
          SUM => SUM
        );
 
  A <= "1100", "1001" after 20 ns, "0111" after 40 ns, "0000" after 60 ns;
  B <= "0010", "1010" after 20 ns, "1011" after 40 ns, "0000" after 60 ns;

END;
