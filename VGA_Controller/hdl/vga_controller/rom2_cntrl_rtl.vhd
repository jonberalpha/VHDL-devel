-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         rom2_cntrl
-- FILENAME:       rom2_cntrl_rtl.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           01.10.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture rtl of the ROM 2 Control Unit
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 01.10.2022
-- ADDITIONAL
-- COMMENTS:       -
-------------------------------------------------------------------------------

architecture rtl of rom2_cntrl is

  constant C_IMG_WIDTH, C_IMG_HEIGHT : natural := 100;
  constant C_ROM_SIZE : natural := 10000; 
  signal   s_img_flag : std_logic;
  
  signal s_last_hpos     : std_logic_vector (9 downto 0);
  signal s_image_counter : unsigned (13 downto 0);

  signal s_last_uC : std_logic_vector (3 downto 0);
  signal s_last_pb : std_logic_vector (3 downto 0);

  signal s_h_temp_ofs : integer;
  signal s_v_temp_ofs : integer;
  signal s_h_ofs : integer;
  signal s_v_ofs : integer;

begin

  P_rd_rom_mv_img: process(clk_i, reset_i)
  begin
    if clk_i'event and clk_i = '1' then
      -- sync. reset for rom
      if reset_i = '1' then
        s_image_counter <= (others => '0');
        rom_addr_o <= (others => '0');
        
        s_img_flag <= '0';
        s_last_hpos <= (others => '0');
        s_last_uC <= (others => '0');
        s_last_pb <= (others => '0');

        s_h_temp_ofs <= 0;
        s_v_temp_ofs <= 0;
        s_h_ofs <= 0;
        s_v_ofs <= 0;
      else
        
        if sw_i = '1' then -- if switch is set to on, let the mc8051-uC move the image else
          
          if s_last_uC(0) = '0' and uC_i(0) = '1' and uC_i(7 downto 4) = "0000" then -- right
            if s_h_temp_ofs < G_SCREEN_WIDTH - C_IMG_WIDTH then
              s_h_temp_ofs <= s_h_temp_ofs + 60;
            end if;
          end if;
          if s_last_uC(1) = '0' and uC_i(1) = '1' and uC_i(7 downto 4) = "0000" then -- down
            if s_v_temp_ofs >= 60 then
              s_v_temp_ofs <= s_v_temp_ofs - 60;
            end if;
          end if;
          if s_last_uC(2) = '0' and uC_i(2) = '1' and uC_i(7 downto 4) = "0000" then -- left
            if s_h_temp_ofs >= 60 then
              s_h_temp_ofs <= s_h_temp_ofs - 60;
            end if;
          end if;
          if s_last_uC(3) = '0' and uC_i(3) = '1' and uC_i(7 downto 4) = "0000" then -- up
            if s_v_temp_ofs < G_SCREEN_HEIGHT - C_IMG_HEIGHT then
              s_v_temp_ofs <= s_v_temp_ofs + 60;
            end if;
          end if;
          
        else -- use push buttons to move image
        
          -- According to push button values add or subtract offset (ofs)
          if s_last_pb(0) = '0' and pb_i(0) = '1' then -- Move right
            if s_h_temp_ofs < G_SCREEN_WIDTH - C_IMG_WIDTH then
              s_h_temp_ofs <= s_h_temp_ofs + 30;
            end if;
          end if;
          if s_last_pb(1) = '0' and pb_i(1) = '1' then -- Move left
            if s_h_temp_ofs >= 30 then
              s_h_temp_ofs <= s_h_temp_ofs - 30;
            end if;
          end if;
          if s_last_pb(2) = '0' and pb_i(2) = '1' then -- Move up
            if s_v_temp_ofs < G_SCREEN_HEIGHT - C_IMG_HEIGHT then
              s_v_temp_ofs <= s_v_temp_ofs + 30;
            end if;
          end if;
          if s_last_pb(3) = '0' and pb_i(3) = '1' then -- Move down
            if s_v_temp_ofs >= 30 then
              s_v_temp_ofs <= s_v_temp_ofs - 30;
            end if;
          end if;
          
        end if;
        
        if s_last_hpos /= hpos_i then -- pixel pos. changed?
          -- set img flag if pixel position is inside the image
          if (to_integer(unsigned(hpos_i)) >= s_h_ofs) and (to_integer(unsigned(hpos_i)) < C_IMG_WIDTH + s_h_ofs) and
             (to_integer(unsigned(vpos_i)) >= s_v_ofs) and (to_integer(unsigned(vpos_i)) < C_IMG_HEIGHT + s_v_ofs) then
            s_image_counter <= s_image_counter + 1;
            s_img_flag <= '1';
          else
            s_img_flag <= '0';
          end if;

          -- on new start reset counter and store offset values
          if hpos_i = b"00000_00000" and vpos_i = b"00000_00000" then
            s_image_counter <= (others => '0');
            rom_addr_o      <= (others => '0');
            s_h_ofs <= s_h_temp_ofs;
            s_v_ofs <= s_v_temp_ofs;
          elsif unsigned(s_image_counter) >= C_ROM_SIZE-1 then -- limit ROM output to max address
            rom_addr_o <= std_logic_vector(to_unsigned(C_ROM_SIZE-1, 14));
          else
            rom_addr_o <= std_logic_vector(s_image_counter + 1);
          end if;
        end if;
        s_last_hpos <= hpos_i; -- store last hpos-, pb-values, uC-values
        s_last_uC   <= uC_i(3 downto 0);
        s_last_pb   <= pb_i;
      end if;
    end if;
  end process P_rd_rom_mv_img;
  
  -- rgb-set mux process
  P_mux : process(s_img_flag, rom_data_i)
  begin
    case s_img_flag is
      when '0' => -- assign black if flag is zero
        red_o   <= (others => '0');
        green_o <= (others => '0');
        blue_o  <= (others => '0');
      when others => 
        red_o   <= rom_data_i(11 downto 8);
        green_o <= rom_data_i (7 downto 4);
        blue_o  <= rom_data_i (3 downto 0);
    end case;
  end process P_mux;
  
  mov_img_flag_o <= s_img_flag;

end rtl;
