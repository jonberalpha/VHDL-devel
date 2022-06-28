-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         alu
-- FILENAME:       alu_rtl.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           09.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture rtl of the alu submodule
--                 of the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
--                 numeric_std     (numeric library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 09.03.2022
-- ADDITIONAL
-- COMMENTS:       Number 1 in attendance list so the following
--                 logic and arithmetic operations are implemented:
--                   Add, Multiply, Logical NOT, Logical Ex-OR
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of alu is
  
  -- *** Definitios of constants ***
  constant ADD      : std_logic_vector(3 downto 0) := "0000";
  constant MULTIPLY : std_logic_vector(3 downto 0) := "0010";
  constant LNOT     : std_logic_vector(3 downto 0) := "1000";
  constant LXOR     : std_logic_vector(3 downto 0) := "1011";
  
  -- *** Intermediate signal definitions ... ***
  -- ... for Adder
  signal finished_add : std_logic;
  signal result_add   : std_logic_vector(12 downto 0);
  
  -- ... for Accumulation Multiplyer
  signal result_mul : std_logic_vector(15 downto 0);
  signal sign_mul        : std_logic;
  signal overflow_mul    : std_logic;
  signal finished_mul    : std_logic;
  signal sum_mul : std_logic_vector(16 downto 0);

begin

  -- *** Add-Implementation ***
  add_p : process(clk_i, reset_i)
  begin
    if reset_i = '1' then
       result_add <= (others => '0');
       finished_add <= '0';
    elsif clk_i'event and clk_i = '1' then
      if start_i = '1' and optype_i = ADD then -- Start calculation if start_i is set and optype_i = ADD
        result_add <= std_logic_vector(unsigned('0' & op1_i) + unsigned('0' & op2_i));
        finished_add <= '1'; -- Calculation of 'Add' finished
      else
        finished_add <= '0'; -- Calculation of 'Add' not finished
      end if;
    end if;
  end process;
  
  -- *** Multiply-Implementation ***
  mult_p : process(clk_i, reset_i)
    variable counter : unsigned(11 downto 0);
    variable calcinprogress : std_logic;
  begin
    if reset_i = '1' then
       calcinprogress := '0';
       result_mul <= (others => '0');
       counter := (others => '0');
       sum_mul <= (others => '0');
       sign_mul <= '0';
       overflow_mul <= '0';
       finished_mul <= '0';
    elsif clk_i'event and clk_i = '1' then
      if optype_i = MULTIPLY then
        finished_mul <= '0';
        if start_i = '1' then
           sum_mul <= (others => '0');
           counter := unsigned(op2_i);      -- down counter is initialized to operand2
           calcinprogress := '1';           -- calcinprogress = 1, cause calculation in progress
           overflow_mul <= '0';
           result_mul <= (others => '0');   -- reset sum
        end if;

        if calcinprogress = '1' then              -- continue calculation, if calcinprogress = 1
          if op1_i = b"0000_0000_0000" or op2_i = b"0000_0000_0000" then
             overflow_mul <= '0';
             finished_mul <= '1';
             calcinprogress := '0';              -- calcinprogress = 0 to stop calculation if overflow occures
             result_mul <= (others => '0');
          else 
            if sum_mul > b"0_1111_1111_1111_1111" then
               overflow_mul <= '1';             -- set overflow flag
               finished_mul <= '1';
               calcinprogress := '0';           -- calcinprogress = 0 to stop calculation if overflow occures
               result_mul <= (others => '1');
               sum_mul <= (others => '0');      -- reset sum
            elsif counter = 0 then     
               overflow_mul <= '0';
               finished_mul <= '1';
               calcinprogress := '0';           -- calcinprogress = 0 when calculation is finished
               result_mul <= sum_mul(15 downto 0);
               sum_mul <= (others => '0');      -- reset sum
            else
               sum_mul <= std_logic_vector(unsigned(sum_mul) + unsigned(op1_i));
               counter := counter - 1;
            end if;
          end if;
          sign_mul <= '0';
        end if;
      end if;
    end if;
  end process;
  
  -- Multiplexer-Implementation
  clk_mux_p : process(clk_i, reset_i)
    variable v_fin_flag : std_logic;
  begin
    if reset_i = '1' then
      result_o   <= (others => '0');
      finished_o <= '0';
      sign_o     <= '0';
      overflow_o <= '0';
      error_o    <= '0';
      v_fin_flag := '0';
    elsif clk_i'event and clk_i = '1' then
    
      if start_i = '1' then -- if a new calculation starts reset the flags
        v_fin_flag := '0';
      end if;
      
      case optype_i is -- switch through optype
        when ADD =>
          if finished_add = '1' and v_fin_flag = '0' then
            result_o <= "000" & result_add;
            error_o <= '0';
            overflow_o <= '0';
            sign_o <= '0';
            v_fin_flag := '1'; -- change flag so the finished flag only take one clk_period
            finished_o <= '1';
          else
            finished_o <= '0';
          end if;
            
        when MULTIPLY =>
          if finished_mul = '1' and v_fin_flag = '0' then
            result_o <= result_mul;
            sign_o <= '0';
            overflow_o <= overflow_mul;
            error_o <= '0';
            v_fin_flag := '1'; -- change flag so the finished flag only take one clk_period
            finished_o <= '1';
          else
            finished_o <= '0';
          end if;
          
        when LNOT =>
          result_o <= "0000" & (not op1_i);
          sign_o <= '0';
          overflow_o <= '0';
          error_o <= '0';
          finished_o <= '1';
          
        when LXOR =>
          result_o <= "0000" & (op1_i xor op2_i);
          sign_o <= '0';
          overflow_o <= '0';
          error_o <= '0';
          finished_o <= '1';

        when others =>
          result_o <= (others => '0');
          sign_o <= '0';
          overflow_o <= '0';
          error_o <= '1';
          finished_o <= '1';
          
      end case;
    end if;
  end process;
  
end rtl;
