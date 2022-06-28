--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   19/01/2019
-- Design Name:   FSM_TB
-- Project Name:  Line_Follower
-- Revision:      V01
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY FSM_TB IS
END FSM_TB;
 
ARCHITECTURE behavior OF FSM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FSM
    PORT(
         HDSensoren : IN  std_logic_vector(3 downto 0);
         LDRs : IN  std_logic_vector(1 downto 0);
         clk : IN  std_logic;
         tick : IN  std_logic;
         rst : IN  std_logic;
         Motor : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal HDSensoren : std_logic_vector(3 downto 0) := (others => '0');
   signal LDRs : std_logic_vector(1 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal tick : std_logic := '0';
   signal rst : std_logic := '0';

   --Outputs
   signal Motor : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: FSM PORT MAP (
          HDSensoren => HDSensoren,
          LDRs => LDRs,
          clk => clk,
          tick => tick,
          rst => rst,
          Motor => Motor
        );

   -- Clock process definitions
   clk_process :process
   begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
   end process;
 
   --Nebenlaeufige Anweisungen
   rst <= '1', '0' after 25 ns;
   tick <= '1';
   HDSensoren <= "0000", 
                 "1100" after 60 ns, 
                 "1111" after 130 ns, 
                 "0011" after 180 ns, 
                 "1111" after 240 ns;
   LDRs <= "00", "01" after 260 ns;

END;
