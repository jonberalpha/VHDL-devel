----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    Carry-Look-Ahead Addierer
-- Module Name:    CarryLookAheadAdder - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CarryLookAheadAdder is
    Generic ( Width : natural := 4 );
    Port ( A : in  STD_LOGIC_VECTOR (Width-1 downto 0);
           B : in  STD_LOGIC_VECTOR (Width-1 downto 0);
           SUM : out  STD_LOGIC_VECTOR (Width downto 0));
end CarryLookAheadAdder;

architecture Behavioral of CarryLookAheadAdder is

  component Full_Adder is
    port (
      A_i : in  std_logic;
      B_i : in  std_logic;
      Cin_i : in  std_logic;
      SUM_i : out std_logic;
      Cout_i : out std_logic);
  end component Full_Adder;

  signal w_Gen : std_logic_vector(Width-1 downto 0); -- Generate
  signal w_Prop : std_logic_vector(Width-1 downto 0); -- Propagate
  signal w_Carry : std_logic_vector(Width downto 0); -- Carry
 
  signal w_SUM   : std_logic_vector(Width-1 downto 0);

begin

  -- Create the Full Adders
  GEN_FULL_ADDERS : 
  for i in 0 to Width-1 generate
    FULL_ADDER_INST : Full_Adder
      port map (
        A_i => A(i),
        B_i => B(i),
        Cin_i => w_Carry(i),        
        SUM_i => w_SUM(i),
        Cout_i => open
      );
  end generate GEN_FULL_ADDERS;

  -- Create the Generate (G) Terms:  Gi=Ai*Bi
  -- Create the Propagate (P) Terms: Pi=Ai+Bi
  -- Create the Carry Terms:
  GEN_CLA : 
  for j in 0 to Width-1 generate
    w_Gen(j) <= A(j) and B(j);
    w_Prop(j) <= A(j) or B(j);
    w_Carry(j+1) <= w_Gen(j) or (w_Prop(j) and w_Carry(j));
  end generate GEN_CLA;
  
  w_Carry(0) <= '0'; -- no carry input
  
  SUM <= w_Carry(Width) & w_SUM;  -- VHDL Concatenation

end Behavioral;

