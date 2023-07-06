-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         patgen1
-- FILENAME:       patgen1_rtl.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           28.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture rtl of the Pattern Generator 1
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 28.09.2022
-- ADDITIONAL
-- COMMENTS:       -
-------------------------------------------------------------------------------

architecture rtl of patgen1 is

constant C_RED   : unsigned(3 downto 0) := "0001";
constant C_GREEN : unsigned(3 downto 0) := "0010";
constant C_BLUE  : unsigned(3 downto 0) := "0100";
constant C_BLACK : unsigned(3 downto 0) := "1000";

constant C_COLOR_SWITCHED_ON  : std_logic_vector(3 downto 0) := x"F";
constant C_COLOR_SWITCHED_OFF : std_logic_vector(3 downto 0) := x"0";

-- C_COL_WIDTH: pixel width of each horizontal screen
constant C_COL_WIDTH : integer := G_SCREEN_WIDTH / (12 * G_COL_CNT);

signal s_color_mux : unsigned(3 downto 0);
signal s_cnt       : integer range 0 to C_COL_WIDTH;
signal s_last_hpos : std_logic_vector(9 downto 0);

begin
  
  P_up_counter: process(clk_i, reset_i)
  begin
    -- Preload counter, set colour to red and set previous pixel to invalid
    if reset_i = '1' then
      s_cnt <= 0;
      s_color_mux <= C_RED;
      s_last_hpos <= (others => '1');
    elsif clk_i'event and clk_i = '1' then
      if hpos_i /= s_last_hpos then
        if hpos_i = b"00000_00000" then -- reset at new column
          s_cnt <= 0;
          s_color_mux <= C_RED;
        elsif s_cnt = (C_COL_WIDTH - 1) then      -- reset counter and shift
          s_cnt <= 0;
          if s_color_mux = C_BLACK then
            s_color_mux <= C_RED;
          else
            s_color_mux <= s_color_mux(2 downto 0) & '0';
          end if;
        else
          s_cnt <= s_cnt + 1;          -- increase counter
        end if;
      end if;
      -- Store last value
      s_last_hpos <= hpos_i;
    end if;
  end process P_up_counter;
  
  -- color chooser mux
  P_color_pattern_mux : process(s_color_mux)
  begin
    -- assign output rgb according to s_color_mux
    case s_color_mux is
      when C_RED =>
        red_o   <= C_COLOR_SWITCHED_ON;
        green_o <= C_COLOR_SWITCHED_OFF;
        blue_o  <= C_COLOR_SWITCHED_OFF;
      when C_GREEN =>
        red_o   <= C_COLOR_SWITCHED_OFF;
        green_o <= C_COLOR_SWITCHED_ON;
        blue_o  <= C_COLOR_SWITCHED_OFF;
      when C_BLUE =>
        red_o   <= C_COLOR_SWITCHED_OFF;
        green_o <= C_COLOR_SWITCHED_OFF;
        blue_o  <= C_COLOR_SWITCHED_ON;
      when C_BLACK =>
        red_o   <= C_COLOR_SWITCHED_OFF;
        green_o <= C_COLOR_SWITCHED_OFF;
        blue_o  <= C_COLOR_SWITCHED_OFF;
      when others => -- BLACK
        red_o   <= C_COLOR_SWITCHED_OFF;
        green_o <= C_COLOR_SWITCHED_OFF;
        blue_o  <= C_COLOR_SWITCHED_OFF;
    end case;
  end process P_color_pattern_mux;

end rtl;
