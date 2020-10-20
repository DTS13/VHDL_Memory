--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entities
entity Convert_HEX_7SEG is
    Port ( HEX : in STD_LOGIC_VECTOR (3 downto 0);
           Num_DISP : in STD_LOGIC_VECTOR (1 downto 0);
           SEL : out STD_LOGIC_VECTOR (3 downto 0);
           DISP : out STD_LOGIC_VECTOR (7 downto 0));
end Convert_HEX_7SEG;

architecture Behavioral of Convert_HEX_7SEG is
begin

process (HEX) is
begin
  case HEX is
    when "0000" => DISP <= "10000001";
    when "0001" => DISP <= "11110011";
    when "0010" => DISP <= "01001001";
    when "0011" => DISP <= "01100001";
    when "0100" => DISP <= "00110011";
    when "0101" => DISP <= "00100101";
    when "0110" => DISP <= "00000101";
    when "0111" => DISP <= "11110001";
    when "1000" => DISP <= "00000001";
    when "1001" => DISP <= "00110001";
    when "1010" => DISP <= "00010001";
    when "1011" => DISP <= "00000111";
    when "1100" => DISP <= "10001101";
    when "1101" => DISP <= "01000011";
    when "1110" => DISP <= "00001101";
    when "1111" => DISP <= "00011101";
    when others => DISP <= "11111111";
  end case;
end process;

process (Num_DISP) is
begin
  case Num_DISP is
    when "00" => SEL <= "1110";
    when "01" => SEL <= "1101";
    when "10" => SEL <= "0111";
    when others => SEL <= "0111";
  end case;
end process;

end Behavioral;