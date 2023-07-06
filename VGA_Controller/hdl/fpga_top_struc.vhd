-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         fpga_top_struc
-- FILENAME:       fpga_top_struc.vhd
-- ARCHITECTURE:   struc
-- ENGINEER:       Jonas Berger
-- DATE:           19.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture struc of the VGA Controller
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 19.09.2022
-- ADDITIONAL
-- COMMENTS:       -
-------------------------------------------------------------------------------

architecture struc of fpga_top is
  
  signal s_clk25 : std_logic;  -- 25 MHz clock as pixel enable
  signal s_locked : std_logic; -- tells if PLL is ready
  
  signal s_pb_sync       : std_logic_vector (3 downto 0);
  signal s_sw_sync       : std_logic_vector (3 downto 0);
  signal s_rgb_patgen1   : std_logic_vector(11 downto 0);
  signal s_rgb_patgen2   : std_logic_vector(11 downto 0);
  signal s_rgb_rom1      : std_logic_vector(11 downto 0);
  signal s_rgb_rom2      : std_logic_vector(11 downto 0);
  signal s_rgb_vga_cntrl : std_logic_vector(11 downto 0);
  
  signal s_hpos          : std_logic_vector (9 downto 0);
  signal s_vpos          : std_logic_vector (9 downto 0);
  
  signal s_rom1_addr     : std_logic_vector(16 downto 0);
  signal s_rom1_data     : std_logic_vector(11 downto 0);
  signal s_rom2_addr     : std_logic_vector(13 downto 0);
  signal s_rom2_data     : std_logic_vector(11 downto 0);
  
  signal s_mov_img_flag  : std_logic;
  
  -- uC signals
  signal s_p1_o : std_logic_vector(7 downto 0); -- 8-bit port P1 of mc8051
  signal s_p2_o : std_logic_vector(7 downto 0); -- 8-bit port P2 of mc8051

  signal s_sync_locked : std_logic_vector(2 downto 0); -- sync shift register

  signal s_reset_8051 : std_logic; -- high-active reset for mc8051

begin
  -- PLL which generates the pixel sync clock:
  i_prescaler : prescaler
    port map (
      clk_in1  => clk_i,        -- PLL clock input,  100 MHz
      clk_out1 => s_clk25,      -- PLL clock output,  25 MHz
      reset    => reset_i,      -- PLL high-active reset input 
      locked   => s_locked      -- use "PLL locked" signal as reset signal for remaining logic
    );
  
  -- Generates reset signal for the mc8051:
  -- Synchronizes signal "locked" from the PLL to the 25 MHz domain
  -- and deasserts mc8051 reset at the falling clock edge  
  P_reset_generator : process (reset_i, s_clk25)
  begin
    if reset_i = '1' then
      s_reset_8051 <= '1';
      s_sync_locked <= (others => '0');
    elsif s_clk25'event and s_clk25='0' then
      s_sync_locked(0) <= s_locked;
      s_sync_locked(1) <= s_sync_locked(0);
      s_sync_locked(2) <= s_sync_locked(1);
        
      if (s_sync_locked(1)='1') and (s_sync_locked(2)='0') then
        s_reset_8051 <= '0';
      end if;
    end if;  
  end process P_reset_generator;
   
  -- instantiation of the vga control unit:
  i_vga_cntrl : vga_cntrl
    port map (
      clk_i    => s_clk25,
      px_en_i  => s_locked,
      reset_i  => reset_i,
      red_i    => s_rgb_vga_cntrl(11 downto 8),
      green_i  => s_rgb_vga_cntrl (7 downto 4),
      blue_i   => s_rgb_vga_cntrl (3 downto 0),
      hpos_o   => s_hpos,
      vpos_o   => s_vpos,
      red_o    => red_o,
      green_o  => green_o,
      blue_o   => blue_o,
      h_sync_o => h_sync_o,
      v_sync_o => v_sync_o
    );
    
  i_io_logic : io_logic
    generic map (
      G_BTN_CNT => 4,
      G_SW_CNT  => 4
    )
    port map (
      clk_i     => s_clk25,
      reset_i   => reset_i,
      pb_i      => pb_i,
      sw_i      => sw_i,
      pb_sync_o => s_pb_sync,
      sw_sync_o => s_sw_sync
    );
  
  i_src_mux : src_mux
    port map (
      sw_sync_i       => s_sw_sync(2 downto 0),
      mov_img_flag_i  => s_mov_img_flag,
      rgb_patgen1_i   => s_rgb_patgen1,
      rgb_patgen2_i   => s_rgb_patgen2,
      rgb_rom1_i      => s_rgb_rom1,
      rgb_rom2_i      => s_rgb_rom2,
      rgb_vga_cntrl_o => s_rgb_vga_cntrl
    );
    
  i_patgen1 : patgen1
    generic map (
      G_SCREEN_WIDTH => 1920,
      G_COL_CNT      => 4
    )
    port map (
      clk_i   => s_clk25,
      reset_i => reset_i,
      hpos_i  => s_hpos,
      red_o   => s_rgb_patgen1(11 downto 8),
      green_o => s_rgb_patgen1 (7 downto 4),
      blue_o  => s_rgb_patgen1 (3 downto 0)
    );
  
  i_patgen2 : patgen2
    generic map (
      G_SCREEN_WIDTH  => 640,
      G_SCREEN_HEIGHT => 480
    )
    port map (
      clk_i   => s_clk25,
      reset_i => reset_i,
      hpos_i  => s_hpos,
      vpos_i  => s_vpos,
      red_o   => s_rgb_patgen2(11 downto 8),
      green_o => s_rgb_patgen2 (7 downto 4),
      blue_o  => s_rgb_patgen2 (3 downto 0)
    );
  
  -- instantiation of the generated ROM1:
  -- 768000x12bit ROM
  i_rom1 : rom1
    port map (
      clka  => s_clk25,
      addra => s_rom1_addr,
      douta => s_rom1_data
    );
  
  -- instantiation of the generated ROM2:
  -- 10000x12bit ROM
  i_rom2 : rom2
    port map (
      clka  => s_clk25,
      addra => s_rom2_addr,
      douta => s_rom2_data
    );
  
  i_rom1_cntrl : rom1_cntrl
    generic map (
      G_SCREEN_WIDTH => 1920
    )
    port map (
      clk_i      => s_clk25,
      reset_i    => reset_i,
      hpos_i     => s_hpos,
      vpos_i     => s_vpos,
      rom_data_i => s_rom1_data,
      rom_addr_o => s_rom1_addr,
      red_o      => s_rgb_rom1(11 downto 8),
      green_o    => s_rgb_rom1 (7 downto 4),
      blue_o     => s_rgb_rom1 (3 downto 0)
    );
  
  i_rom2_cntrl : rom2_cntrl
    generic map (
      G_SCREEN_WIDTH  => 1920,
      G_SCREEN_HEIGHT => 1080
    )
    port map (
      clk_i      => s_clk25,
      reset_i    => reset_i,
      hpos_i     => s_hpos,
      vpos_i     => s_vpos,
      rom_data_i => s_rom2_data,
      uC_i       => s_p1_o,
      sw_i       => s_sw_sync(3),
      pb_i       => s_pb_sync,
      rom_addr_o => s_rom2_addr,
      red_o      => s_rgb_rom2(11 downto 8),
      green_o    => s_rgb_rom2 (7 downto 4),
      blue_o     => s_rgb_rom2 (3 downto 0),
      mov_img_flag_o => s_mov_img_flag
    );
    
  -- instantiation of the mc8051 IP core:
  i_mc8051_top : mc8051_top
    port map (
      reset     => s_reset_8051,
      int0_i    => (others => '1'), -- not used in this design
      int1_i    => (others => '1'), -- not used in this design
      all_t0_i  => (others => '0'), -- not used in this design
      all_t1_i  => (others => '0'), -- not used in this design
      all_rxd_i => (others => '0'), -- not used in this design
      all_rxd_o => open,            -- not used in this design
      all_txd_o => open,            -- not used in this design  
      clk       => s_clk25,
      p0_i      => (others => '0'), -- not used in this design
      p1_i      => (others => '0'), -- not used in this design
      p2_i      => (others => '0'), -- not used in this design
      p3_i      => (others => '0'), -- not used in this design
      p0_o      => open,            -- not used in this design
      p1_o      => s_p1_o,          -- gives direction of movable image
      p2_o      => s_p2_o,          -- toggles leds
      p3_o      => open,            -- not used in this design
      test_o    => open             -- not used in this design
      );

  -- Assign uC output to board-leds:
  led_o <= s_p2_o;

end struc;