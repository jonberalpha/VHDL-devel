-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         calc_ctrl
-- FILENAME:       calc_ctrl_rtl.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           17.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture rtl of the calc_ctrl submodule
--                 of the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
--                 numeric_std     (numeric library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 17.03.2022
-- ADDITIONAL
-- COMMENTS:       Number 1 in attendance list so User-Interface Variant A
--                 is implemented
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of calc_ctrl is

  -- *** Type definitions ***
  type state_type is (s_EOP1, s_EOP2, s_EOPTYPE, s_CALC, s_DISPR);
  signal nextState: state_type;
  
  -- *** Definitios of constants ***
  constant ADD      : std_logic_vector(3 downto 0) := "0000";
  constant MULTIPLY : std_logic_vector(3 downto 0) := "0010";
  constant LNOT     : std_logic_vector(3 downto 0) := "1000";
  constant LXOR     : std_logic_vector(3 downto 0) := "1011";
  
  -- *** Intermediate signal definitions ... ***
  signal s_start : std_logic;
  
  -- *** Function definitions ***
  function bin2seg(data        : std_logic_vector(3 downto 0);
                   decOrletter : std_logic) return std_logic_vector is 
    variable result : std_logic_vector(6 downto 0);
  begin
    -- BIN-to-seven-segment Decoder:
    --   Pinout: 
    --     "gfedcba"; bit = 0 => LED-segment on
    --     "6543210" <- std-logic-vector index
    --   Segment-encoding:
    --        0
    --       ---  
    --    5 |   | 1
    --       ---   <- 6
    --    4 |   | 2
    --       ---
    --        3
    if decOrletter = '1' then
      case data is
        when "0000" => result := "0001000"; -- A
        when "0001" => result := "0100001"; -- d
        when "0010" => result := "0000110"; -- E
        when "0011" => result := "0101011"; -- n
        when "0100" => result := "0100011"; -- o
        when "0101" => result := "0101111"; -- r
        when others => result := "0001001"; -- X
      end case;
    else
      case data is
        when "0000" => result := "1000000"; -- 0
        when "0001" => result := "1111001"; -- 1
        when "0010" => result := "0100100"; -- 2
        when "0011" => result := "0110000"; -- 3
        when "0100" => result := "0011001"; -- 4
        when "0101" => result := "0010010"; -- 5
        when "0110" => result := "0000010"; -- 6
        when "0111" => result := "1111000"; -- 7
        when "1000" => result := "0000000"; -- 8
        when "1001" => result := "0010000"; -- 9
        when "1010" => result := "0001000"; -- A
        when "1011" => result := "0000011"; -- b
        when "1100" => result := "0100111"; -- c
        when "1101" => result := "0100001"; -- d
        when "1110" => result := "0000110"; -- E
        when others => result := "0001110"; -- F
      end case;
    end if;
    return result;
  end bin2seg;

begin

  fsm_p : process(clk_i, reset_i)
  begin
    if reset_i = '1' then
      nextState <= s_EOP1;
      s_start <= '0';
      op1_o <= (others => '0');
      op2_o <= (others => '0');
      optype_o <= (others => '0');
      dig3_o <= (others => '0');
      dig2_o <= (others => '0');
      dig1_o <= (others => '0');
      dig0_o <= (others => '0');
      led_o <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      if s_start = '1' then -- ensure that start-impulse only takes one clk_period
        s_start <= '0';
      end if;
    
      case nextState is
        -- *** State: Enter operand 1
        when s_EOP1 =>
          led_o <= (others => '0');
          dig3_o <= '0' & bin2seg("0001", '0'); -- display decimal-point and 1
          dig2_o <= '1' & bin2seg(swsync_i(11 downto 8), '0');
          dig1_o <= '1' & bin2seg(swsync_i(7 downto 4), '0');
          dig0_o <= '1' & bin2seg(swsync_i(3 downto 0), '0');
          op1_o <= swsync_i(11 downto 0);
          
          if pbsync_i(3) = '1' then    -- change state forword if BTNL is pressed
            nextState <= s_EOP2;
          --elsif pbsync_i(2) = '1' then -- change state backward if BTNR is pressed
          --  nextState <= s_DISPR;
          --elsif pbsync_i(1) = '1' then -- initiate calculation if start is pressed
          --  s_start <= '1';
          --  nextState <= s_CALC;
          end if;
        
        -- *** State: Enter operand 2
        when s_EOP2 =>
          led_o <= (others => '0');
          dig3_o <= '0' & bin2seg("0010", '0'); -- display decimal-point and 2
          dig2_o <= '1' & bin2seg(swsync_i(11 downto 8), '0');
          dig1_o <= '1' & bin2seg(swsync_i(7 downto 4), '0');
          dig0_o <= '1' & bin2seg(swsync_i(3 downto 0), '0');
          op2_o <= swsync_i(11 downto 0);
          
          if pbsync_i(3) = '1' then    -- change state forword if BTNL is pressed
            nextState <= s_EOPTYPE;
          --elsif pbsync_i(2) = '1' then -- change state backward if BTNR is pressed
          --  nextState <= s_EOP1;
          --elsif pbsync_i(1) = '1' then -- initiate calculation if start is pressed
          --  s_start <= '1';
          --  nextState <= s_CALC;
          end if;
        
        -- *** State: Enter optype
        when s_EOPTYPE =>
          led_o <= (others => '0');
          dig3_o <= '0' & bin2seg("0100", '1'); -- display decimal-point and o
          
          case swsync_i(15 downto 12) is
            when ADD =>
              dig2_o <= '1' & bin2seg("0000", '1'); -- A
              dig1_o <= '1' & bin2seg("0001", '1'); -- d
              dig0_o <= '1' & bin2seg("0001", '1'); -- d
            when MULTIPLY =>
              dig2_o <= '1' & bin2seg("0111", '1'); -- X
              dig1_o <= '1' & "1111111";
              dig0_o <= '1' & "1111111";
            when LNOT =>
              dig2_o <= '1' & bin2seg("0011", '1'); -- n
              dig1_o <= '1' & bin2seg("0100", '1'); -- o
              dig0_o <= '1' & "1111111";
            when LXOR =>
              dig2_o <= '1' & bin2seg("0010", '1'); -- E
              dig1_o <= '1' & bin2seg("0100", '1'); -- o
              dig0_o <= '1' & bin2seg("0101", '1'); -- r
            when others => 
              dig2_o <= '1' & "1111111"; -- all off
              dig1_o <= '1' & "1111111"; -- all off
              dig0_o <= '1' & "1111111"; -- all off
          end case;
          
          optype_o <= swsync_i(15 downto 12);   -- the highest 4 bits contain the optype
          
          if pbsync_i(3) = '1' then    -- change state forword if BTNL is pressed
             --nextState <= s_DISPR;
          --elsif pbsync_i(2) = '1' then -- change state backward if BTNR is pressed
          --  nextState <= s_EOP2;
          --elsif pbsync_i(1) = '1' then -- initiate calculation if start is pressed
            s_start <= '1';
            nextState <= s_CALC;
          end if;

        -- *** State: Do Calculation
        when s_CALC =>
          led_o <= (others => '0');
          
          if finished_i = '1' then
            nextState <= s_DISPR;
          end if;
        
        -- *** State: Display result
        when s_DISPR =>
          led_o <= b"1000_0000_0000_0000"; -- if calculation is finished switch most left LED on
          if error_i = '1' then
            dig3_o <= '1' & "1111111"; -- switch off all segments
            dig2_o <= '1' & bin2seg("0010", '1'); -- E
            dig1_o <= '1' & bin2seg("0101", '1'); -- r
            dig0_o <= '1' & bin2seg("0101", '1'); -- r
          elsif overflow_i = '1' then
            dig3_o <= '1' & bin2seg("0100", '1'); -- o
            dig2_o <= '1' & bin2seg("0100", '1'); -- o
            dig1_o <= '1' & bin2seg("0100", '1'); -- o
            dig0_o <= '1' & bin2seg("0100", '1'); -- o
          else
            -- else display result  
            dig3_o <= '1' & bin2seg(result_i(15 downto 12), '0');
            dig2_o <= '1' & bin2seg(result_i(11 downto 8), '0');
            dig1_o <= '1' & bin2seg(result_i(7 downto 4), '0');
            dig0_o <= '1' & bin2seg(result_i(3 downto 0), '0');
          end if;
          
          if pbsync_i(3) = '1' then    -- change state forword if BTNL is pressed
            nextState <= s_EOP1;
          --elsif pbsync_i(2) = '1' then -- change state backward if BTNR is pressed
          --  nextState <= s_EOPTYPE;
          --elsif pbsync_i(1) = '1' then -- initiate calculation if start is pressed
          --  s_start <= '1';
          --  nextState <= s_CALC;
          end if;

      end case;
    end if;
  end process;
  
  start_o <= s_start;
  
end rtl;
