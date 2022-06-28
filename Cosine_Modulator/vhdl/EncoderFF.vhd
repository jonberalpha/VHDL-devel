----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    16/03/2018
-- Module Name:    EncoderFF - Behavioral 
-- Project Name:   Cosine_Modulator
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EncoderFF is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           TR : out  STD_LOGIC;
           TL : out  STD_LOGIC);
end EncoderFF;

architecture Behavioral of EncoderFF is

  type state_type is (s_idle, s_L1, s_L2, s_L3, s_R1, s_R2, s_R3); 
  signal curState, nextState: state_type;

  constant ENABLE:STD_LOGIC:='1';
  constant DISABLE:STD_LOGIC:='0';

begin
  reg_p: process(rst,clk)
  begin
    if rst='1' then
       curState <= s_idle;
    elsif clk'event and clk='1' then
       curState <= nextState;
    end if;
  end process;
  
  nextstatelogic_p: process(A, B, curState)
  begin
    nextState <= curState;     --default Anweisung
    case curState is
      when s_idle =>
        if A='0' and B='1' then
           nextState <= s_L1;
        end if;
        if A='1' and B='0' then
           nextState <= s_R1;
        end if;
     
      when s_L1 =>
        if A='1' and B='1' then
          nextState <= s_L2;
        end if;
        if B='0' then
          nextState <= s_idle;
        end if;
       
      when s_L2 =>
        if A='1' and B='0' then
          nextState <= s_L3;
        end if;
        if A='0' and B='1' then
          nextState <= s_L1;
        end if;
        if A='0' and B='0' then
          nextState <= s_idle;
        end if;
      
      when s_L3 =>
        nextState <= s_idle;
      
      when s_R1 =>
        if A='1' and B='1' then
          nextState <= s_R2;
        end if;
        if A='0' then
          nextState <= s_idle;
        end if;
      
      when s_R2 =>
        if A='0' and B='1' then
          nextState <= s_R3;
        end if;
        if A='0' and B='0' then
          nextState <= s_idle;
        end if;
      
      when s_R3 =>
        nextState <= s_idle;
      
      when others =>
        nextState <= s_idle;
      
    end case;
  end process;
  
  outputlogic_p: process(curState)
  begin
    case curState is
      when s_idle =>
        TR <= DISABLE;
        TL <= DISABLE;
      when s_L1 =>
          TR <= DISABLE;
          TL <= DISABLE;
      when s_L2 =>
          TR <= DISABLE;
          TL <= DISABLE;
      when s_L3 =>
          TR <= DISABLE;
          TL <= ENABLE;
      when s_R1 =>
          TR <= DISABLE;
          TL <= DISABLE;
      when s_R2 =>
          TR <= DISABLE;
          TL <= DISABLE;
      when s_R3 =>
          TR <= ENABLE;
          TL <= DISABLE;
      
    end case;
  end process;
  
end Behavioral;
