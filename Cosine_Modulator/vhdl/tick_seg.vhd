----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    24/02/2018
-- Module Name:    tick_seg - Behavioral 
-- Project Name:   Cosine_Modulator
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tick_seg is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           tick : out  STD_LOGIC);
end tick_seg;

architecture Behavioral of tick_seg is

  type tick_counter_type is range 249999 downto 0; -- 200 Hz
  signal tickcounter: tick_counter_type;
  constant max: tick_counter_type := 249999; 

begin
  counter_p: process(clk,rst)
  begin
    if rst='1' then
       tickcounter <= max;
    elsif clk'event and clk='1' then
       if tickcounter = 0 then
          tickcounter <= max;
          tick <= '1';
       else
          tickcounter <= tickcounter - 1;
          tick <= '0';
       end if;
    end if;
  end process;

end Behavioral;
