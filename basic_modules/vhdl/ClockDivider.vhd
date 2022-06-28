----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    10/09/2019 
-- Design Name:    ClockDivider
-- Module Name:    ClockDivider - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ClockDivider is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           CLK_div2 : out  STD_LOGIC;
           CLK_div4 : out  STD_LOGIC;
           CLK_div8 : out  STD_LOGIC;
           CLK_div16 : out  STD_LOGIC);
end ClockDivider;

architecture Behavioral of ClockDivider is

  signal clk_divider : unsigned(3 downto 0);

begin

  clk_divider_p : process(RESET, CLK)
  begin
    if RESET = '1' then
       clk_divider <= (others => '0');
    elsif CLK'event and CLK = '1' then
       clk_divider <= clk_divider + 1;
    end if;
  end process clk_divider_p;
  
  CLK_div2 <= clk_divider(0);
  CLK_div4 <= clk_divider(1);
  CLK_div8 <= clk_divider(2);
  CLK_div16 <= clk_divider(3);

end Behavioral;

