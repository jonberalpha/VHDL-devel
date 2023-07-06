-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         debounce
-- FILENAME:       debounce_rtl.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           27.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture rtl of the Debouncer
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 27.09.2022
-- ADDITIONAL
-- COMMENTS:       -
-------------------------------------------------------------------------------

architecture rtl of debounce is

type stateType is (s_low, s_low2high, s_high, s_high2low);
signal curState, nextState : stateType;

begin

  state_reg_p : process(clk_i, reset_i) -- state register
  begin
    if reset_i = '1' then 
       curState <= s_low;
    elsif clk_i'event and clk_i = '1' then
      if tick_i = '1' then
         curState <= nextState;
      end if;
    end if;
  end process;

  nextstatelogic_p : process(curState, sw_i) -- next state logic
  begin
    nextState <= curState; -- default assignment
    case curState is
      when s_low =>
        if sw_i = '1' then 
           nextState <= s_low2high; 
        end if;
        swout_o <= '0';
        
      when s_low2high =>
        if sw_i = '1' then
          nextState <= s_high;	
        else
          nextState <= s_low;	
        end if;
        swout_o <= '0';
        
      when s_high =>
        if sw_i = '0' then
          nextState <= s_high2low;
        end if;	
        swout_o <= '1';
        
      when s_high2low =>
        if sw_i = '0' then
          nextState <= s_low;
        else 
          nextState <= s_high;
        end if;
        swout_o <= '1';
        
    end case;	
  end process;

end rtl;


