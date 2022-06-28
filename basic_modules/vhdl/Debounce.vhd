----------------------------------------------------------------------------------
-- Project Name:  utils
-- Module Name:   debounce - Behavioral 
-- Revision 1.1 2013-09-29 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debounce is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           tick : in  STD_LOGIC;  -- period longer then max. time of bouncing
           undeb_in : in  STD_LOGIC;  -- input
           deb_out : out  STD_LOGIC); -- debounced output
end Debounce;

architecture Behavioral of Debounce is

  type stateType is (s_lo, s_hi, s_re, s_fe);
  signal curState, nextState : stateType;

begin

  reg_p : process(clk, reset) -- state register
  begin
    if reset = '1' then 
       curState <= s_lo;
    elsif clk'event and clk = '1' then
      if tick = '1' then
         curState <= nextState;
      end if;
    end if;
  end process;

  comb_p : process(curState, undeb_in) 
  begin
    nextState <= curState; 
    case curState is
   
      when s_lo =>   
        if undeb_in = '1' then 
           nextState <= s_re; 
        end if;
        deb_out <= '0';

      when s_re => 
        if undeb_in = '1' then 
            nextState <= s_hi;  
        else 
           nextState <= s_lo;
        end if;
        deb_out <= '0';

      when s_hi => 
        if undeb_in = '0' then
           nextState <= s_fe;
        end if;  
        deb_out <= '1';
        
      when s_fe => 
        if undeb_in = '0' then 
           nextState <= s_lo;
        else 
           nextState <= s_hi;  
        end if;
        deb_out <= '1';
      
    end case;  
  end process;

end Behavioral;

