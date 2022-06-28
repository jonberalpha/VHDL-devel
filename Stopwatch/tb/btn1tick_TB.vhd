--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   13/03/2018
-- Design Name:   btn1tick_TB
-- Project Name:  Projekt_2
-- VHDL Test Bench Created by ISE for module: btn1tick
-- Revision 0.01 - File Created
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY btn1tick_TB IS
END btn1tick_TB;
 
ARCHITECTURE behavior OF btn1tick_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT btn1tick
    PORT(
         btn1 : IN  std_logic;
         rst : IN  std_logic;
         clk : IN  std_logic;
         tick : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal btn1 : std_logic := '0';
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal tick : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: btn1tick PORT MAP (
          btn1 => btn1,
          rst => rst,
          clk => clk,
          tick => tick
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
rst <= '0', '1' after 2 ns, '0' after 7 ns;
btn1 <= '0', '1' after 50 ns, '0' after 60 ns, '1' after 100 ns, '0' after 180 ns;

END;
