-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         rom1_cntrl
-- FILENAME:       rom1_cntrl_rtl.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           01.10.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture rtl of the ROM 1 Control Unit
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 01.10.2022
-- ADDITIONAL
-- COMMENTS:       -
-------------------------------------------------------------------------------

architecture rtl of rom1_cntrl is

  constant C_ROM_SIZE     : natural := 76800; 
  constant C_ROM_ADDR_MAX : std_logic_vector(16 downto 0) := std_logic_vector(to_unsigned(C_ROM_SIZE-1,17));
  constant C_IMG_WIDTH    : natural := 320;
  constant C_IMG_HEIGHT   : natural := 240;
  
  signal s_last_hpos : std_logic_vector(9 downto 0);
  
  signal s_imgQ1_counter : unsigned (16 downto 0);
  signal s_imgQ2_counter : unsigned (16 downto 0);
  signal s_imgQ3_counter : unsigned (16 downto 0);
  signal s_imgQ4_counter : unsigned (16 downto 0);
  
begin
  
  P_ROM1_read_process: process(clk_i, reset_i)
  begin
    if clk_i'event and clk_i = '1' then
      if reset_i = '1' then                  -- syncr. reset for BLOCK ROM
        s_imgQ1_counter <= (others => '0');
        s_imgQ2_counter <= (others => '0');
        s_imgQ3_counter <= (others => '0');
        s_imgQ4_counter <= (others => '0');
        s_last_hpos <= (others => '1');
        rom_addr_o <= (others => '0');
      else
        if s_last_hpos /= hpos_i then
          -- Reset all counter
          if hpos_i = b"00000_00000" and vpos_i = b"00000_00000" then
            s_imgQ1_counter <= (others => '0');
            s_imgQ2_counter <= (others => '0');
            s_imgQ3_counter <= (others => '0');
            s_imgQ4_counter <= (others => '0');
            rom_addr_o <= (others => '0');
          elsif unsigned(hpos_i) < C_IMG_WIDTH then
            -- 1.Quadrant/left up
            if unsigned(vpos_i) < C_IMG_HEIGHT then
              s_imgQ1_counter <= s_imgQ1_counter + 1;
              if s_imgQ1_counter >= C_ROM_SIZE-1 then
                rom_addr_o <= C_ROM_ADDR_MAX;
              else
                rom_addr_o <= std_logic_vector(s_imgQ1_counter + 1);
              end if;
            -- 3.Quadrant/left down
            else
              s_imgQ2_counter <= s_imgQ2_counter + 1;
              if s_imgQ2_counter >= C_ROM_SIZE-1 then
                rom_addr_o <= C_ROM_ADDR_MAX;
              else
                rom_addr_o <= std_logic_vector(s_imgQ2_counter + 1);
              end if;
            end if;
          else
            -- 2.Quadrant/right up
            if unsigned(vpos_i) < C_IMG_HEIGHT then
              s_imgQ3_counter <= s_imgQ3_counter + 1;
              if s_imgQ3_counter >= C_ROM_SIZE-1 then
                rom_addr_o <= C_ROM_ADDR_MAX;
              else
                rom_addr_o <= std_logic_vector(s_imgQ3_counter + 1);
              end if;
            -- 4.Quadrant/right down
            else
              s_imgQ4_counter <= s_imgQ4_counter + 1;
              if s_imgQ4_counter >= C_ROM_SIZE-1 then
                rom_addr_o <= C_ROM_ADDR_MAX;
              else
                rom_addr_o <= std_logic_vector(s_imgQ4_counter + 1);
              end if;
            end if;
          end if;
        end if;
        s_last_hpos <= hpos_i; -- store last pixel position
      end if;
    end if;
  end process P_ROM1_read_process;
  
  -- Concurrent Statements: input get assigned to output
  red_o   <= rom_data_i(11 downto 8);
  green_o <= rom_data_i(7 downto 4);
  blue_o  <= rom_data_i(3 downto 0);

end rtl;
