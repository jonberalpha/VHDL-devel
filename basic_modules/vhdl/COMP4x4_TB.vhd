--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   17/04/2019
-- Design Name:   Komperator 4x4 (2x 4 bit Eingaenge)
-- Project Name:  Basic_Elements
-- VHDL Test Bench Created by ISE for module: COMP4x4
-- Revision:      V0.1
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY COMP4x4_TB IS
END COMP4x4_TB;
 
ARCHITECTURE behavior OF COMP4x4_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT COMP4x4
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         ILO : IN  std_logic;
         IEQ : IN  std_logic;
         IHI : IN  std_logic;
         LO : OUT  std_logic;
         EQ : OUT  std_logic;
         HI : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal ILO : std_logic := '0';
   signal IEQ : std_logic := '0';
   signal IHI : std_logic := '0';

   --Outputs
   signal LO : std_logic;
   signal EQ : std_logic;
   signal HI : std_logic;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: COMP4x4 PORT MAP (
          A => A,
          B => B,
          ILO => ILO,
          IEQ => IEQ,
          IHI => IHI,
          LO => LO,
          EQ => EQ,
          HI => HI
        );

   A <= "1011", "1111" after 20 ns, "0011" after 40 ns;
  B <= "1100", "1111" after 20 ns, "0011" after 40 ns;

END;
