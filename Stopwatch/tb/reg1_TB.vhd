--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   15/03/2018
-- Design Name:   reg1_TB
-- Project Name:  Projekt_2
-- VHDL Test Bench Created by ISE for module: reg1
-- Revision 0.01 - File Created
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY reg1_TB IS
END reg1_TB;
 
ARCHITECTURE behavior OF reg1_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg1
    PORT(
         A_i : IN  std_logic_vector(3 downto 0);
         B_i : IN  std_logic_vector(3 downto 0);
         C_i : IN  std_logic_vector(3 downto 0);
         D_i : IN  std_logic_vector(3 downto 0);
         en : IN  std_logic;
         rst : IN  std_logic;
         clk : IN  std_logic;
         enanzreg1 : OUT  std_logic;
         A_o : OUT  std_logic_vector(3 downto 0);
         B_o : OUT  std_logic_vector(3 downto 0);
         C_o : OUT  std_logic_vector(3 downto 0);
         D_o : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A_i : std_logic_vector(3 downto 0) := (others => '0');
   signal B_i : std_logic_vector(3 downto 0) := (others => '0');
   signal C_i : std_logic_vector(3 downto 0) := (others => '0');
   signal D_i : std_logic_vector(3 downto 0) := (others => '0');
   signal en : std_logic := '0';
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal enanzreg1 : std_logic;
   signal A_o : std_logic_vector(3 downto 0);
   signal B_o : std_logic_vector(3 downto 0);
   signal C_o : std_logic_vector(3 downto 0);
   signal D_o : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg1 PORT MAP (
          A_i => A_i,
          B_i => B_i,
          C_i => C_i,
          D_i => D_i,
          en => en,
          rst => rst,
          clk => clk,
          enanzreg1 => enanzreg1,
          A_o => A_o,
          B_o => B_o,
          C_o => C_o,
          D_o => D_o
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
	en <= '1', '0' after 45 ns, '1' after 95 ns;
	A_i <= "0000", "1101" after 30 ns, "1000" after 60 ns;

END;
