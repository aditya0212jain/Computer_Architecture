----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.03.2018 15:14:42
-- Design Name: 
-- Module Name: BCtrl - Behavioral
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

entity BCtrl is
    Port ( clk : in STD_LOGIC;
           Z : in STD_LOGIC;
           C : in STD_LOGIC;
           N : in STD_LOGIC;
           V : in STD_LOGIC;
           ins : in STD_LOGIC_VECTOR (3 downto 0);
           p : out STD_LOGIC);
end BCtrl;
architecture Behavioral of BCtrl is

begin

with ins select p<=
    Z when "0000",
    not Z WHEN "0001",
    C WHEN "0010",
    NOT C WHEN "0011",
    N WHEN "0100",
    NOT N WHEN "0101",
    V WHEN "0110",
    NOT V WHEN "0111",
    C AND (NOT Z) WHEN "1000",
    (NOT C) OR Z WHEN "1001",
    N XNOR Z WHEN "1010",
    N XOR Z WHEN "1011",
    (NOT Z) AND (N XNOR V) WHEN "1100",
    Z OR (N XOR V) WHEN "1101",
    '1' WHEN OTHERS;

end Behavioral;
