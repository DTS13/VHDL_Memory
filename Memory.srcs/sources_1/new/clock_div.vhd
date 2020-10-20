--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entities
entity clock1 is
    Port ( clkin : in STD_LOGIC;
           clkout : out STD_LOGIC := '0');
end clock1;

architecture Behavior of clock1 is

-- signals
signal clk_enable_200kHz  : std_logic;
signal clk_enable_counter : std_logic_vector(15 downto 0);

begin

--Create the clock enable:
process (clkin) begin
  if(rising_edge(clkin)) then
    clk_enable_counter <= clk_enable_counter + 1;
    if(clk_enable_counter = "1111111111111111") then --cuenta un numero
      clk_enable_200kHz <= '1';
    else
      clk_enable_200kHz <= '0';
    end if;
  end if;
end process;

--Slow process:
process (clkin) begin
  if(rising_edge(clkin)) then
    if(clk_enable_200kHz = '1') then
      clkout <= '1';
    else
      clkout <= '0';
    end if;
  end if;
end process;

end Behavior;
