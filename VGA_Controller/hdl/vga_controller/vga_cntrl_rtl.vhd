-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         vga_cntrl
-- FILENAME:       vga_cntrl_rtl.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           19.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture rtl of the VGA Control Unit
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 19.09.2022
-- ADDITIONAL
-- COMMENTS:       -
-------------------------------------------------------------------------------

architecture rtl of vga_cntrl is
  
  constant C_HD  : natural := 639;  -- 639  Horizontal Display (640)
  constant C_HFP : natural :=  16;  --  16  Right border (front porch)
  constant C_HSP : natural :=  96;  --  96  Sync pulse (Retrace)
  constant C_HBP : natural :=  48;  --  48  Left boarder (back porch)
  
  constant C_VD  : natural := 479;  -- 479  Vertical Display (480)
  constant C_VFP : natural :=  10;  --  10  Right border (front porch)
  constant C_VSP : natural :=   2;  --   2  Sync pulse (Retrace)
  constant C_VBP : natural :=  33;  --  33  Left boarder (back porch)

  -- Define signals
  signal s_hpos : integer range 0 to (C_HD + C_HFP + C_HSP + C_HBP);
  signal s_vpos : integer range 0 to (C_VD + C_VFP + C_VSP + C_VBP);
  
  signal s_visible_hpos : integer range 0 to (C_HD + C_HFP + C_HSP + C_HBP);
--  signal s_visible_vpos : integer range 0 to (C_VD + C_VFP + C_VSP + C_VBP);
  
  signal s_video_on : std_logic;

begin
  
  -- Horizontal counter process
  P_horizontal_pos_counter : process(clk_i, reset_i)
  begin
    if reset_i = '1' then
      s_hpos <= 0;
    elsif clk_i'event and clk_i = '1' then
      if px_en_i = '1' then
        if s_hpos = (C_HD + C_HFP + C_HSP + C_HBP) then
          s_hpos <= 0;
        else
          s_hpos <= s_hpos + 1;
        end if;
      end if;
    end if;
  end process;
  
  -- Vertical counter process
  P_vertical_pos_counter : process(clk_i, reset_i)
  begin
    if reset_i = '1' then
      s_vpos <= 0;
    elsif clk_i'event and clk_i = '1' then
      if px_en_i = '1' then
        if s_hpos = (C_HD + C_HFP + C_HSP + C_HBP) then
          if s_vpos = (C_VD + C_VFP + C_VSP + C_VBP) then
            s_vpos <= 0;
          else
            s_vpos <= s_vpos + 1;
          end if;
        end if;
      end if;
    end if;
  end process;
  
  -- Visible area horizontal counter process
  P_visible_horizontal_pos_counter : process(clk_i, reset_i)
  begin
    if reset_i = '1' then
      s_visible_hpos <= 0;
    elsif clk_i'event and clk_i = '1' then
      if px_en_i = '1' then
        if s_hpos > C_HD then
          s_visible_hpos <= 0;
        else
          s_visible_hpos <= s_visible_hpos + 1;
        end if;
      end if;
    end if;
  end process;
  
  P_assign_hpos_o : process(s_visible_hpos, s_hpos, s_vpos)
  begin
    if (s_hpos <= C_HD) and (s_vpos <= C_VD) then
      hpos_o <= std_logic_vector(to_unsigned(s_visible_hpos, hpos_o'length));
    else
      hpos_o <= (others => '0');
    end if;
  end process;
  
  vpos_o <= std_logic_vector(to_unsigned(s_vpos, vpos_o'length));
  
  -- Horizontal synchronization process
  P_horizontal_sync : process(clk_i, reset_i)
  begin
    if reset_i = '1' then   
      h_sync_o <= '0';
    elsif clk_i'event and clk_i = '1' then
      if px_en_i = '1' then
        if (s_hpos <= (C_HD + C_HFP)) or (s_hpos > (C_HD + C_HFP + C_HSP)) then
          h_sync_o <= '0';
        else
          h_sync_o <= '1';
        end if;
      end if;
    end if;
  end process;
  
  -- Vertical synchronization process
  P_vertical_sync : process(clk_i, reset_i)
  begin
    if reset_i = '1' then
      v_sync_o <= '0';
    elsif clk_i'event and clk_i = '1' then
      if px_en_i = '1' then
        if (s_vpos <= (C_VD + C_VFP)) or (s_vpos > (C_VD + C_VFP + C_VSP)) then
          v_sync_o <= '0';
        else
          v_sync_o <= '1';
        end if;
      end if;
    end if;
  end process;
  
  -- Video on process
  P_video_on : process(clk_i, reset_i)
  begin
    if reset_i = '1' then   
      s_video_on <= '0';
    elsif clk_i'event and clk_i = '1' then
      if px_en_i = '1' then
        if (s_hpos <= C_HD) and (s_vpos <= C_VD) then
          s_video_on <= '1';
        else
          s_video_on <= '0';
        end if;
      end if;
    end if;
  end process;
  
  -- Storage Element which stores the rgb values
  P_rgb_mux : process(s_video_on, red_i, green_i, blue_i)
  begin
    if s_video_on = '1' then
      red_o   <= red_i;
      green_o <= green_i;
      blue_o  <= blue_i;
    else
      red_o   <= x"0";
      green_o <= x"0";
      blue_o  <= x"0";
    end if;
  end process;

end rtl;
