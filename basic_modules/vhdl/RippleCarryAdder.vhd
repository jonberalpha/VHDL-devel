----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    Ripple Carry Addierer 4 bit
-- Module Name:    RippleCarryAdder4bit - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleCarryAdder is
    Generic( Width : natural := 4 );
    Port ( A : in  STD_LOGIC_VECTOR(Width-1 downto 0);
           B : in  STD_LOGIC_VECTOR(Width-1 downto 0);
           SUM : out  STD_LOGIC_VECTOR(Width-1 downto 0);
           Cout : out  STD_LOGIC);
end RippleCarryAdder;

architecture Behavioral of RippleCarryAdder is

  component Full_Adder is
    port (
      A_i : in  std_logic;
      B_i : in  std_logic;
      Cin_i : in  std_logic;
      SUM_i : out std_logic;
      Cout_i : out std_logic);
  end component Full_Adder;
  
  signal w_Carry : std_logic_vector(Width downto 0);
  signal w_SUM   : std_logic_vector(Width-1 downto 0);

begin

  w_Carry(0) <= '0';                -- no carry input on first full adder
   
  SET_WIDTH : 
  for i in 0 to Width-1 generate
    FULL_ADDER_INST : Full_Adder
      port map (
        A_i => A(i),
        B_i => B(i),
        Cin_i => w_Carry(i),
        SUM_i => w_SUM(i),
        Cout_i => w_Carry(i+1)
      );
  end generate SET_WIDTH;
 
  SUM <= w_SUM;  -- VHDL Concatenation
  Cout <= w_Carry(Width);

end Behavioral;

