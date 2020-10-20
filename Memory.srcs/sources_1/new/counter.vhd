--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entities
entity count1 is
    Port ( clkin2 : in STD_LOGIC;
           BCDout2 : out STD_LOGIC_VECTOR (1 downto 0) := "00");
end count1;

architecture Behavior of count1 is

-- signals
signal sBCDout2: STD_LOGIC_VECTOR (1 downto 0) := "00";

begin

-- process for clkin2
    process(clkin2) begin
        IF (clkin2'EVENT AND clkin2 ='1') THEN
            sBCDout2 <= sBCDout2 + 1;
        END IF;
        BCDout2 <= sBCDout2;
    end process;

end Behavior;