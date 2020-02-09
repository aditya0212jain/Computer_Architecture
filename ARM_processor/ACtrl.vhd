----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.03.2018 15:14:42
-- Design Name: 
-- Module Name: ACtrl - Behavioral
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

entity ACtrl is
    Port ( clk : in STD_LOGIC;
           ins : in STD_LOGIC_VECTOR (3 downto 0);
           state : in STD_LOGIC_VECTOR (3 downto 0);
           opc : out STD_LOGIC_VECTOR (3 downto 0));
end ACtrl;

architecture Behavioral of ACtrl is

begin


end Behavioral;
