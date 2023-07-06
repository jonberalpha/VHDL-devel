-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         patgen2
-- FILENAME:       patgen2_rtl.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           30.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture rtl of the Pattern Generator 2
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 30.09.2022
-- ADDITIONAL
-- COMMENTS:       -
-------------------------------------------------------------------------------

architecture rtl of patgen2 is

  constant C_RED   : unsigned(2 downto 0) := "001";
  constant C_GREEN : unsigned(2 downto 0) := "010";
  constant C_BLUE  : unsigned(2 downto 0) := "100";

  constant C_COLOR_SWITCHED_ON  : std_logic_vector(3 downto 0) := x"F";
  constant C_COLOR_SWITCHED_OFF : std_logic_vector(3 downto 0) := x"0";

  signal s_color_mux : unsigned(2 downto 0);

  -- define BLOCK size's width and height
  constant C_BLOCK_WIDTH  : natural := (G_SCREEN_WIDTH / 10)-1;
  constant C_BLOCK_HEIGHT : natural := (G_SCREEN_HEIGHT / 10)-1;

  signal s_last_hpos   : std_logic_vector (9 downto 0);
  signal s_default_col : unsigned (2 downto 0);

  signal s_hpos_cnt : integer range 0 to G_SCREEN_WIDTH;
  signal s_vpos_cnt : integer range 0 to G_SCREEN_WIDTH;

begin
  
  P_process: process(clk_i, reset_i)
  begin
    if reset_i = '1' then
      s_hpos_cnt <= 0;
      s_vpos_cnt <= 0;
      s_last_hpos   <= (others => '1');
      s_color_mux   <= C_RED;
      s_default_col <= C_RED;
    elsif clk_i'event and clk_i = '1' then

      -- Increase counter only if pixel changed
      if s_last_hpos /= hpos_i then
        s_hpos_cnt <= s_hpos_cnt + 1;
        
        -- hpos counter referes to block width
        if s_hpos_cnt = C_BLOCK_WIDTH then
          s_hpos_cnt <= 0;
          if s_color_mux = C_BLUE then -- last shift is blue set back to red
            s_color_mux <= C_RED;
          else
            s_color_mux <= s_color_mux(1 downto 0) & '0';
          end if;
        end if;

        -- Horizontal pixel is at 0
        if hpos_i = b"00000_00000" then
          -- Increment vpos counter and reset hpos counter
          s_vpos_cnt <= s_vpos_cnt + 1;
          s_hpos_cnt <= 0;

          -- vpos counter referes to block height
          if s_vpos_cnt = C_BLOCK_HEIGHT then
            s_vpos_cnt <= 0;
            
            if s_default_col = C_BLUE then -- last shift is blue set back to red
              s_default_col <= C_RED;
            else
              s_default_col <= s_default_col(1 downto 0) & '0';
            end if;
            
            if s_default_col = C_BLUE then -- last shift is blue set back to red
              s_default_col <= C_RED;
            else
              s_color_mux <= s_default_col(1 downto 0) & '0';
            end if;
            
          else
            -- Set default colour
            s_color_mux <= s_default_col;
          end if;
        end if;
      end if;

      -- reset all on new start
      if vpos_i = b"00000_00000" and hpos_i = b"00000_00000" then
        s_hpos_cnt <= 0;
        s_vpos_cnt <= 0;
        s_color_mux <= C_RED;
        s_default_col <= C_RED;
      end if;
      
      s_last_hpos <= hpos_i; -- store last pixel position
    end if;
  end process P_process;
  
  -- color chooser mux
  P_color_chooser_mux : process(s_color_mux)
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
      when others => -- BLACK
        red_o   <= C_COLOR_SWITCHED_OFF;
        green_o <= C_COLOR_SWITCHED_OFF;
        blue_o  <= C_COLOR_SWITCHED_OFF;
    end case;
  end process P_color_chooser_mux;

end rtl;
