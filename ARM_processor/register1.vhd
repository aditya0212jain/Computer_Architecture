----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 18:13:34
-- Design Name: 
-- Module Name: register1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register1 is
    Port ( inp : in STD_LOGIC;
           ena : in STD_LOGIC;
           clk : in std_logic;
           outp : out STD_LOGIC);
end register1;

architecture Behavioral of register1 is

begin
process(clk)
begin
if(clk='1' and clk'event)then
if(ena='1')then
outp<=inp;
end if;
end if;
end process;

end Behavioral;
