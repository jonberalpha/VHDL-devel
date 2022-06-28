----------------------------------------------------------------------------------
-- Create Date:    03/25/2019 
-- Design Name:    SOC Sinusgenerator
-- Module Name:    Attn_n3db - Behavioral 
-- Target Devices: XC3S100E-5CP132
-- Tool versions:  WEBPACK 14.7
-- Description:    n 3dB Signal Attenuator used in Projekt SOC_Sin_Gen
--
-- Dependencies: 
--
-- Revision:     V1.0 
-- Additional Comments: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Attn_n3dB is
    Generic ( N : natural := 16
             --Tdd : time := 10 ns
            );
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
           Attn : in std_logic_vector (2 downto 0);
           Din : in  std_logic_vector (N-1 downto 0);
           Rdy : out  STD_LOGIC;
           DOut : out  std_logic_vector (N-1 downto 0));
end Attn_n3dB;

architecture Behavioral of Attn_n3dB is

  type Attn_Mult_Type is array(0 to 7) of unsigned(N-1 downto 0);  -- Typedefinition Attenuation Array
  constant Attn_Value : Attn_Mult_Type := (                    -- Attenuation for (
    x"7FFF", x"5A82", x"4000", x"2D41",                        -- 0dB, 3db, 6dB, 9dB,
    x"2000", x"16A1", x"1000", x"0B50");                       -- 12dB, 15db, 18dB, 21dB)   

  -- Signal definitions
  signal Idx : integer range 0 to N;                           -- Index of Attenuation Value 
  signal AttReg : unsigned (N-1 downto 0);                     -- Attentuation Register
  Signal DataReg : signed (N-1 downto 0);                      -- Data Register
  signal Product : signed (N-1 downto 0);                      -- Product Register

begin
   multP: process ( Rst, Clk )
   begin
     if Rst = '0' then
        Rdy <= '1';                                            -- Initialize Signals and Ports
        Idx <= 0;
        AttReg <= (others => '0');
        Product <= (others => '0');
     elsif clk'event and clk = '0' then                        -- On neg. edge of Clk
        if Idx = 0 and Ce = '1' then                           -- Setup new Din Value on CE = 1
           AttReg <= Attn_Value(to_integer(unsigned(Attn)));   -- Load attenuation register with Attn_Value(Attn)
           DataReg <= signed(Din);                             -- Load input data to data register
           Idx <= N;                                           -- Set Index count attenuation value
           Product <= (others => '0');                         -- Clear product register
           Rdy <= '0';                                         -- Clear ready signal
        elsif Idx > 0 then                                     -- if register loaded
           if AttReg(Idx-1) = '1' then                         -- and attenuation register with index is hight 
              Product <= Product + DataReg;                    -- Add data register to product register
           end if;
           DataReg <= DataReg(N-1) & DataReg(N-1 downto 1);    -- Arithmetic shift Data Register 1 bit right 
           Idx <= Idx - 1;                                     -- Decrement index 
        else                                                   -- If index zero 
           DOut <= std_logic_vector(Product);                  -- Set output value
           Rdy <= '1';                                         -- Set ready signal
        end if;
     end if;
   end process multP;

end Behavioral;
