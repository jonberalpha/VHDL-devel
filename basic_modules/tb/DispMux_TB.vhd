--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   13:18:13 09/01/2018
-- Design Name:   disp_mux_01
-- Project Name:  Projekt_1
-- VHDL Test Bench Created by ISE for module: disp_mux_01
-- Revision 0.01 - File Created
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DispMux_TB IS
END DispMux_TB;
 
ARCHITECTURE behavior OF DispMux_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DispMux
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         C : IN  std_logic_vector(3 downto 0);
         D : IN  std_logic_vector(3 downto 0);
         dpi : IN  std_logic_vector(3 downto 0);
      clk : IN std_logic;
         tick : IN  std_logic;
         rst : IN  std_logic;
         seg : OUT  std_logic_vector(6 downto 0);
         dpo : OUT  std_logic;
         an : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal C : std_logic_vector(3 downto 0) := (others => '0');
   signal D : std_logic_vector(3 downto 0) := (others => '0');
   signal dpi : std_logic_vector(3 downto 0) := (others => '0');
  signal clk : std_logic := '0';
   signal tick : std_logic := '0';
   signal rst : std_logic := '0';

   --Outputs
   signal seg : std_logic_vector(6 downto 0);
   signal dpo : std_logic;
   signal an : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: DispMux PORT MAP (
          A => A,
          B => B,
          C => C,
          D => D,
          dpi => dpi,
       clk => clk,
          tick => tick,
          rst => rst,
          seg => seg,
          dpo => dpo,
          an => an
        );
  
  -- Clock process definitions
   clk_process :process
   begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
   end process;
  
  --Tick Prozess: alle vier Clock Perioden ein Tick
  tick_process :process
   begin
    tick <= '0';
    wait for clk_period*10;
    tick <= '1';
    wait for clk_period*10;
   end process;
  
  rst <= '1', '0' after 15 ns;
   A <= x"A";
  B <= x"B";
  C <= x"C";
  D <= X"D";
  dpi <= "0100";

END;
