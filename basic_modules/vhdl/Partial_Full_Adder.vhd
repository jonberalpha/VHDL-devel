----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    Partieller-Voll-Addierer
-- Module Name:    Partial_Full_Adder - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Partial_Full_Adder is
    Port ( A_i : in  STD_LOGIC;
           B_i : in  STD_LOGIC;
           Cin_i : in  STD_LOGIC;
           SUM_i : out  STD_LOGIC;
           P_i : out  STD_LOGIC;
           G_i : out  STD_LOGIC);
end Partial_Full_Adder;

architecture Behavioral of Partial_Full_Adder is

begin

  SUM_i <= A_i xor B_i xor Cin_i;
  P_i <= A_i xor B_i; -- Propagate (P)
  G_i <= A_i and B_i; -- Generate (G)

end Behavioral;

