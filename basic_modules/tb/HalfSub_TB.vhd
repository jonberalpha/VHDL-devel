--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   01/04/2019
-- Design Name:   Halb-Subtrahierer
-- Project Name:  Basic_Elements
-- VHDL Test Bench Created by ISE for module: HalfSub
-- Revision:      V0.1
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY HalfSub_TB IS
END HalfSub_TB;
 
ARCHITECTURE behavior OF HalfSub_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HalfSub
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         DIFF : OUT  std_logic;
         Bout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';

   --Outputs
   signal DIFF : std_logic;
   signal Bout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: HalfSub PORT MAP (
          A => A,
          B => B,
          DIFF => DIFF,
          Bout => Bout
        );
      
   A <= '0', '0' after 20 ns, '1' after 40 ns, '1' after 60 ns;
   B <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns;

END;
