--------------------------------------------------------------------------------
-- Engineer:      Berger Jonas
-- Create Date:   19/03/2019
-- Design Name:   Cosine Modulator
-- Project Name:  Cosine_Modulator
-- Revision:      V0.1
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- File I/O
USE ieee.std_logic_textio.all;
USE std.textio.all;
 
ENTITY CosineMod_TB IS
END CosineMod_TB;
 
ARCHITECTURE behavior OF CosineMod_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CosineMod
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ce : IN  std_logic;
         phase : IN  std_logic_vector(7 downto 0);
         S90 : IN  std_logic;
         data_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ce : std_logic := '0';
   signal phase : std_logic_vector(7 downto 0) := (others => '0');
   signal S90 : std_logic := '0';

   --Outputs
   signal data_out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 us; -- 10 MHz
  constant ce_period : time := 20 us;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: CosineMod PORT MAP (
          clk => clk,
          rst => rst,
          ce => ce,
          phase => phase,
          S90 => S90,
          data_out => data_out
        );

   -- Clock process
   clk_p: process
   begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
   end process;
  
  -- CE process
   ce_p: process
   begin
    ce <= '0';
    wait for ce_period/4;
    ce <= '1';
    wait for ce_period/4;
   end process;

   -- Phase Process
  phase_p: process
  begin
     for i in 16#00# to 16#FF# loop -- hex2int-Syntax is used: base#value#
      wait until clk'event and clk = '0';
       phase <= std_logic_vector(to_unsigned(i,8)); -- 8 bits -> 7 downto 0
    end loop;
    wait;
  end process;
  
  -- Write File Process
  writeFile_p : process
    -- Create ISE Output-File in MATLAB Directory:
    file OutputFile : TEXT open WRITE_MODE is "./MATLAB/ise_output_file.txt";
    variable LineBuffer : LINE;
  begin
    wait until rising_edge(ce);
      write(LineBuffer, data_out);
      writeline(OutputFile, LineBuffer);
  end process;

   -- concurrent Statements:
  rst <= '0', '1' after 3 us, '0' after 7 us;
  S90 <= '0';
  
END;
