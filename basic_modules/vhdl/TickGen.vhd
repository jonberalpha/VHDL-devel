----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    28/04/2019 
-- Design Name:    TickGen
-- Module Name:    TickGen - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TickGen is
    Generic ( CLK_PERIOD : integer := 50*10**6/15 ); -- 50 MHz / 15 Hz = ~ 3 333 333 Anzahl
    Port ( RESET : in STD_LOGIC;
           CLK : in  STD_LOGIC;
           div_CLK : out  STD_LOGIC);
end TickGen;

architecture Behavioral of TickGen is

  signal count : integer range 0 to CLK_PERIOD;

begin

  -- Counter Prozess
  count_p : process(RESET, CLK)
  begin
    if RESET = '1' then
       count <= CLK_PERIOD;
       div_CLK <= '0';
    elsif CLK'event and CLK = '1' then
       if count = 0 then
          count <= CLK_PERIOD;
          div_CLK <= '1';
       else
          count <= count - 1;
          div_CLK <= '0';
       end if;
    end if;
  end process;

end Behavioral;

