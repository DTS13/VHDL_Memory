library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- entity
entity main is
    Port ( DATAin : in STD_LOGIC_VECTOR (7 downto 0);
           Address : in STD_LOGIC_VECTOR (3 downto 0);
           DATAout : out STD_LOGIC_VECTOR (7 downto 0);
           CE, WR, CLK : in STD_LOGIC;
           SELb : out STD_LOGIC_VECTOR (3 downto 0);
           DISPb : out STD_LOGIC_VECTOR (7 downto 0));
end main;

architecture Behavioral of main is

-- components
component Convert_HEX_7SEG is
    Port ( HEX : in STD_LOGIC_VECTOR (3 downto 0);
           Num_DISP : in STD_LOGIC_VECTOR (1 downto 0);
           SEL : out STD_LOGIC_VECTOR (3 downto 0);
           DISP : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component count1 is
    Port ( clkin2 : in STD_LOGIC;
           BCDout2 : out STD_LOGIC_VECTOR (1 downto 0) := "00");
end component;

component clock1 is
    Port ( clkin : in STD_LOGIC;
           clkout : out STD_LOGIC := '0');
end component;

-- constants
constant ADDR_WIDTH : integer := 4; 
constant DATA_WIDTH : integer := 8;

-- types
type ram_type is array (2**ADDR_WIDTH - 1 downto 0) of STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);

-- signals
signal RAM: ram_type;

--intermediate connections (wires)
signal sHEX: STD_LOGIC_VECTOR (7 DOWNTO 0);
signal sHEX1, sHEX2, sHEXo: STD_LOGIC_VECTOR (3 DOWNTO 0);
signal sNum_DISP: STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
signal sSelect: STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
signal clk_clk: STD_LOGIC;

begin

process (CLK, Address) begin
    if (CLK'event and CLK='1') then
       if (CE='1') then
          if (WR='1') then
             RAM(conv_integer(Address)) <= DATAin;
          else
             DATAout <= RAM(conv_integer(Address));
          end if;
          sHEX <= RAM(conv_integer(Address));    
          sHEX2 <= sHEX(7 downto 4);
          sHEX1 <= sHEX(3 downto 0);
       else
          DATAout <= (others => 'Z');
          sHEX2 <= "0000";
          sHEX1 <= "0000";
       end if;
    end if;
end process;

RAM(conv_integer("0000")) <= "00000101";
RAM(conv_integer("0001")) <= "00001000";
RAM(conv_integer("0010")) <= "00100010";
RAM(conv_integer("0011")) <= "00010100";
RAM(conv_integer("0100")) <= "00010000";

ck1: clock1 port map(CLK, clk_clk);
ct1: count1 port map(clk_clk, sSelect);

process (sSelect, sHEX1, sHEX2, Address) begin
    if (sSelect="00") then
       sHEXo <= sHEX1;
    elsif (sSelect="01") then
       sHEXo <= sHEX2;
    elsif (sSelect="10") then
       sHEXo <= Address;
    else
       sHEXo <= Address;
    end if;
end process;

dp1: Convert_HEX_7SEG port map( sHEXo, sSelect, SELb, DISPb);

end Behavioral;