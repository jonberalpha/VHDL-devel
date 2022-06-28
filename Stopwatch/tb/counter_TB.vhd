--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   12/03/2018
-- Design Name:   counter_TB
-- Project Name:  Projekt_2
-- VHDL Test Bench Created by ISE for module: counter
-- Revision 0.01 - File Created
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY counter_TB IS
END counter_TB;
 
ARCHITECTURE behavior OF counter_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter
    PORT(
         tick : IN  std_logic;
         en : IN  std_logic;
         rst : IN  std_logic;
         cnt_A : OUT  std_logic_vector(3 downto 0);
         cnt_B : OUT  std_logic_vector(3 downto 0);
         cnt_C : OUT  std_logic_vector(3 downto 0);
         cnt_D : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal tick : std_logic := '0';
   signal en : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal cnt_A : std_logic_vector(3 downto 0);
   signal cnt_B : std_logic_vector(3 downto 0);
   signal cnt_C : std_logic_vector(3 downto 0);
   signal cnt_D : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant tick_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter PORT MAP (
          tick => tick,
          en => en,
          rst => rst,
          cnt_A => cnt_A,
          cnt_B => cnt_B,
          cnt_C => cnt_C,
          cnt_D => cnt_D
        );

   -- Clock process definitions
   tick_process :process
   begin
		tick <= '0';
		wait for tick_period/2;
		tick <= '1';
		wait for tick_period/2;
   end process;
   
   rst <= '0', '1' after 10 ns, '0' after 20 ns;
   en <= '1', '0' after 100 ns, '1' after 130 ns;

END;
