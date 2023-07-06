-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         src_mux
-- FILENAME:       src_mux_rtl.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           27.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture rtl of the Source Multiplexer
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 27.09.2022
-- ADDITIONAL
-- COMMENTS:       -
-------------------------------------------------------------------------------

architecture rtl of src_mux is

  signal s_selmsb : std_logic;
  signal s_selvec : std_logic_vector(1 downto 0);

begin

  -- concurrent statements: split select lines in extra signals
  s_selmsb <= sw_sync_i(2); -- MSB of switches decides if the moving image is shown
  s_selvec <= sw_sync_i(1 downto 0); -- The two LSB bits decide wich of the other sources gets chosen
  
  -- mux process which decides what rgb_signal should be shown on display (also make simultainously display of rom2 and any other possible)
  P_mux : process(s_selmsb, s_selvec, mov_img_flag_i, rgb_rom1_i, rgb_rom2_i, rgb_patgen1_i, rgb_patgen2_i)
  begin
    if s_selmsb = '1' and mov_img_flag_i = '1' then
      rgb_vga_cntrl_o <= rgb_rom2_i;
    else
      if s_selvec = "00" then
        rgb_vga_cntrl_o <= rgb_patgen1_i;
      elsif s_selvec = "10" then
        rgb_vga_cntrl_o <= rgb_patgen2_i;
      else
        rgb_vga_cntrl_o <= rgb_rom1_i;
      end if;
    end if;
  end process P_mux;

end rtl;
