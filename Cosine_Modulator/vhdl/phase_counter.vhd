----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    12/09/2018 
-- Module Name:    phase_counter - Behavioral 
-- Project Name:   Cosine_Modulator
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity phase_counter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           inc : in  STD_LOGIC;
           dec : in  STD_LOGIC;
           phase : out STD_LOGIC_VECTOR(7 downto 0));
end phase_counter;

architecture Behavioral of phase_counter is

constant maxwert: signed(7 downto 0):= x"FF";
constant minwert: signed(7 downto 0):= x"00";
signal count_i: signed(7 downto 0) := x"00";

begin

  --Up/Down Counter Process
  up_down_counter_p: process(rst,clk)
  begin
    if rst = '1' then
       count_i <= x"00";
    elsif clk'event and clk = '1' then
       if inc = '1' then
          count_i <= count_i + 1;
          if count_i = maxwert then
             count_i <= minwert;
          end if;
       end if;
       if dec = '1' then
          count_i <= count_i - 1;
          if count_i = minwert then
             count_i <= maxwert;
          end if;
       end if;
       if inc = '1' and dec = '1' then
          -- leeres if
       end if;
    end if;
  end process;
  
  phase <= std_logic_vector(count_i);

end Behavioral;

