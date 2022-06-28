--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   10/09/2019
-- Design Name:   ClockDivider_TB
-- Project Name:  Basic_Elements
-- VHDL Test Bench Created by ISE for module: ClockDivider
-- Revision:      V0.1
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ClockDivider_TB IS
END ClockDivider_TB;
 
ARCHITECTURE behavior OF ClockDivider_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ClockDivider
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         CLK_div2 : OUT  std_logic;
         CLK_div4 : OUT  std_logic;
         CLK_div8 : OUT  std_logic;
         CLK_div16 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';

   --Outputs
   signal CLK_div2 : std_logic;
   signal CLK_div4 : std_logic;
   signal CLK_div8 : std_logic;
   signal CLK_div16 : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: ClockDivider PORT MAP (
          CLK => CLK,
          RESET => RESET,
          CLK_div2 => CLK_div2,
          CLK_div4 => CLK_div4,
          CLK_div8 => CLK_div8,
          CLK_div16 => CLK_div16
        );

   -- Clock process definitions
   CLK_process :process
   begin
    CLK <= '0';
    wait for CLK_period/2;
    CLK <= '1';
    wait for CLK_period/2;
   end process;
  
  RESET <= '1', '0' after 100 ns;

END;
