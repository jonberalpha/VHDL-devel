----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    0-3 Counter
-- Module Name:    CNT0to3 - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CNT0to3 is
    Port ( EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (1 downto 0));
end CNT0to3;

architecture Behavioral of CNT0to3 is

  signal count : unsigned(1 downto 0);
  constant maxwert : unsigned(1 downto 0) := "11";

begin

  -- 0-3 Counter
  count_p : process(CLK, RESET)
  begin
    if RESET = '1' then
       count <= (others => '0');
    elsif CLK'event and CLK = '1' then
       if EN = '1' then
          if count = maxwert then
             count <= "00";
          else
             count <= count + 1;
          end if;
       end if;
    end if;
  end process;

  Q <= std_logic_vector(count);

end Behavioral;

