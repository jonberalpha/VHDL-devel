----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    Voll-Addierer
-- Module Name:    Full_Adder - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder is
    Port ( A_i : in  STD_LOGIC;
           B_i : in  STD_LOGIC;
           Cin_i : in  STD_LOGIC;
           SUM_i : out  STD_LOGIC;
           Cout_i : out  STD_LOGIC);
end Full_Adder;

architecture Behavioral of Full_Adder is

begin

  SUM_i <= A_i xor B_i xor Cin_i ;
  Cout_i <= (A_i and B_i) or (Cin_i and A_i) or (Cin_i and B_i) ;

end Behavioral;

