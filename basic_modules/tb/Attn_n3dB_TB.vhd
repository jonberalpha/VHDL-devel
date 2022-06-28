--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   05/05/2019
-- Design Name:   Attn_n3dB
-- Project Name:  Basic_Elements
-- VHDL Test Bench Created by ISE for module: Attn_n3dB
-- Revision:      V0.1
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY Attn_n3dB_TB IS
END Attn_n3dB_TB;
 
ARCHITECTURE behavior OF Attn_n3dB_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Attn_n3dB
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Ce : IN  std_logic;
         Attn : IN  std_logic_vector(2 downto 0);
         Din : IN  std_logic_vector(15 downto 0);
         Rdy : OUT  std_logic;
         DOut : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Ce : std_logic := '0';
   signal Attn : std_logic_vector(2 downto 0) := (others => '0');
   signal Din : std_logic_vector(15 downto 0) := (others => '0');

   --Outputs
   signal Rdy : std_logic;
   signal DOut : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: Attn_n3dB PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Ce => Ce,
          Attn => Attn,
          Din => Din,
          Rdy => Rdy,
          DOut => DOut
        );

   -- Clock process definitions
   Clk_process :process
   begin
    Clk <= '0';
    wait for Clk_period/2;
    Clk <= '1';
    wait for Clk_period/2;
   end process;
 
   Rst <= '0', '1' after 20 ns;
   Ce <= '1';
   Attn <= "011";
   Din <= x"7FFF";

END;
