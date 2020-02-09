library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registerA is
    Port ( inp : in STD_LOGIC_VECTOR (31 downto 0);
           outp : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in std_logic;
           enable : in STD_LOGIC);
end registerA;

architecture Behavioral of registerA is
begin
process(clk)
begin
if(clk='1' and clk'event)then
if(enable='1') then 
outp <= inp;
end if;
end if;
end process;
end architecture;
