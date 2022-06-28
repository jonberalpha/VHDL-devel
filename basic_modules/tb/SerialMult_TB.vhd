--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   24/04/2019
-- Design Name:   Serial Multiplier
-- Project Name:  Basic_Elements
-- VHDL Test Bench Created by ISE for module: SerialMult
-- Revision:      V0.1
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY SerialMult_TB IS
END SerialMult_TB;
 
ARCHITECTURE behavior OF SerialMult_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SerialMult
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         CE : IN  std_logic;
         rdy : OUT  std_logic;
         Product : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal CE : std_logic := '0';

   --Outputs
   signal rdy : std_logic;
   signal Product : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: SerialMult PORT MAP (
          A => A,
          B => B,
          clk => clk,
          rst => rst,
          CE => CE,
          rdy => rdy,
          Product => Product
        );

   -- Clock process definitions
   clk_process :process
   begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
   end process;
 
--   -- Stimulus process
--   stim_proc: process
--   begin    
--      rst <= '1';
--      wait for 100 ns;
--    rst <= '0';
--      wait for clk_period*2;
--    CE <= '1';
--    A <= x"7FFF";
--    B <= x"7C0B";
--    wait until rdy = '1';
--    A <= x"9348";
--    B <= x"B470";
--    wait until rdy = '1';
--    wait;
--   end process;

   rst <= '1', '0' after 100 ns;
  CE <= '1';
   A <= x"7FFF";
   B <= x"7C0B";

END;
