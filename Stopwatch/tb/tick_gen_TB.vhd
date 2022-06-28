--------------------------------------------------------------------------------
-- Create Date:   08:43:45 03/20/2018
-- Project Name:  Projekt_2
-- Target Device:  
-- Tool versions:  
-- VHDL Test Bench Created by ISE for module: tick_gen
-- Revision 0.01 - File Created
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tick_gen_TB IS
END tick_gen_TB;
 
ARCHITECTURE behavior OF tick_gen_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tick_gen
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         tick : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal tick : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: tick_gen PORT MAP (
          clk => clk,
          rst => rst,
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
 

   rst <= '0', '1' after 5 ns, '0' after 35 ns;

END;
