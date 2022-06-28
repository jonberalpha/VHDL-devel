----------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   20/03/2018 
-- Design Name:   rising2tic
-- Module Name:   rising2tic - Behavioral 
-- Project Name:  labue
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rising2tic is
    Port ( clk : in  STD_LOGIC;
           swi : in  STD_LOGIC;
           tic : out  STD_LOGIC);
end rising2tic;

architecture Behavioral of rising2tic is

signal swi1_temp, swi2_temp: std_logic;

begin

  tic <= swi1_temp and not swi2_temp;
  
  sr_p: process(clk)
  begin
    if clk'event and clk ='1' then
       swi1_temp <= swi;
       swi2_temp <= swi1_temp;
    end if;
  end process;
  
end Behavioral;

