--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   16:40:10 03/12/2018
-- Design Name:   FTS_TB
-- Project Name:  Projekt_2
-- VHDL Test Bench Created by ISE for module: FTS
-- Revision 0.01 - File Created
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FTS_TB IS
END FTS_TB;
 
ARCHITECTURE behavior OF FTS_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FTS
    PORT(
         btn1 : IN  std_logic;
         btn2 : IN  std_logic;
         btn3 : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
			enanzreg1 : IN std_logic;
         enanzreg2 : IN  std_logic;
         strl : OUT  std_logic_vector(1 downto 0);
         reg1en : OUT  std_logic;
         reg2en : OUT  std_logic;
         cnten : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal btn1 : std_logic := '0';
   signal btn2 : std_logic := '0';
   signal btn3 : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
	signal enanzreg1 : std_logic := '0';
   signal enanzreg2 : std_logic := '0';

 	--Outputs
   signal strl : std_logic_vector(1 downto 0);
   signal reg1en : std_logic;
   signal reg2en : std_logic;
   signal cnten : std_logic;

   -- Clock period definition
	-- clk von BASYS 2 Board f=50MHz => T=20 ns
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FTS PORT MAP (
          btn1 => btn1,
          btn2 => btn2,
          btn3 => btn3,
          clk => clk,
          rst => rst,
			 enanzreg1 => enanzreg1,
          enanzreg2 => enanzreg2,
          strl => strl,
          reg1en => reg1en,
          reg2en => reg2en,
          cnten => cnten
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
	btn1 <= '0', '1' after 50 ns, '0' after 70 ns, '1' after 490 ns, '0' after 510 ns;
	btn2 <= '0', '1' after 150 ns, '0' after 180 ns;
	enanzreg1 <= '1';
	enanzreg2 <= '1';
	btn3 <= '0', '1' after 250 ns, '0' after 280 ns, '1' after 330 ns, '0' after 360 ns;

END;
