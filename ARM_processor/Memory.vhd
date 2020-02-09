library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Memory is
    Port ( ra : in STD_LOGIC_VECTOR (31 downto 0);
           rd : out STD_LOGIC_VECTOR (31 downto 0);
           enable : in STD_LOGIC;
           wa : in STD_LOGIC_VECTOR(31 downto 0);
           wd : in STD_LOGIC_VECTOR(31 downto 0));
end Memory;

architecture Behavioral of Memory is
type Mem is array (10000 downto 0) of std_logic_vector(31 downto 0);
signal num : integer;
signal mun : integer;
signal Mem_signal : Mem;
begin
    num <= to_integer(unsigned(ra));
    rd <= Mem_signal(num);
process(enable)
begin
if(enable='1' and enable'event) then
mun <= to_integer(unsigned(wa));
Mem_signal(mun) <=wd;
end if;
end process;
end architecture;
