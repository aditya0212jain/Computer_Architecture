----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2018 03:40:41 PM
-- Design Name: 
-- Module Name: PM_path - Behavioral
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

entity PM_path is
    Port ( procin : in STD_LOGIC_VECTOR (31 downto 0);
           memin : in STD_LOGIC_VECTOR (31 downto 0);
           typ : in STD_LOGIC_VECTOR (2 downto 0);
           procout : out STD_LOGIC_VECTOR (31 downto 0);
           memout : out STD_LOGIC_VECTOR (31 downto 0);
           byte_off : in STD_LOGIC_VECTOR (1 downto 0);
           mwes : out STD_LOGIC_VECTOR(3 downto 0));
end PM_path;

architecture Behavioral of PM_path is

begin
process(procin,memin,typ,byte_off)
begin
case typ is
when "000" => procout <= memin;
when "001" => memout <= procin;
when "010" => case byte_off is
              when "00" => mwes<="0011"; procout(15 downto 0)<=memin(15 downto 0);procout(31 downto 16) <="0000000000000000";
              when "01" => mwes<="0110"; procout(15 downto 0)<=memin(23 downto 8);procout(31 downto 16) <="0000000000000000";
              when "10" => mwes<="1100"; procout(15 downto 0)<=memin(31 downto 16);procout(31 downto 16) <="0000000000000000";
              when others => mwes<="1001"; procout(7 downto 0)<=memin(31 downto 24);procout(15 downto 8)<=memin(7 downto 0);procout(31 downto 16) <="0000000000000000";
              end case;
when "011" => case byte_off is
              when "00" => mwes<="0001"; procout(7 downto 0)<=memin(7 downto 0);procout(31 downto 8) <="000000000000000000000000";
              when "01" => mwes<="0010"; procout(7 downto 0)<=memin(15 downto 8);procout(31 downto 8) <="000000000000000000000000";
              when "10" => mwes<="0100"; procout(7 downto 0)<=memin(23 downto 16);procout(31 downto 8) <="000000000000000000000000";
              when others => mwes<="1000"; procout(7 downto 0)<=memin(31 downto 24);procout(31 downto 8) <="000000000000000000000000";
              end case;
when "100" => case byte_off is
              when "00" => mwes<="0011"; procout(15 downto 0)<=memin(15 downto 0);for i in 0 to 15 loop procout(16+i)<=memin(15); end loop;
              when "01" => mwes<="0110"; procout(15 downto 0)<=memin(23 downto 8);for i in 0 to 15 loop procout(16+i)<=memin(23); end loop;
              when "10" => mwes<="1100"; procout(15 downto 0)<=memin(31 downto 16);for i in 0 to 15 loop procout(16+i)<=memin(31); end loop;
              when others => mwes<="1001"; procout(7 downto 0)<=memin(31 downto 24);procout(15 downto 8)<=memin(7 downto 0);for i in 0 to 15 loop procout(16+i)<=memin(7); end loop;
              end case;
when "101" => case byte_off is
              when "00" => mwes<="0001"; procout(7 downto 0)<=memin(7 downto 0);for i in 0 to 23 loop procout(8+i)<=memin(7); end loop;
              when "01" => mwes<="0010"; procout(7 downto 0)<=memin(15 downto 8);for i in 0 to 23 loop procout(8+i)<=memin(15); end loop;
              when "10" => mwes<="0100"; procout(7 downto 0)<=memin(23 downto 16);for i in 0 to 23 loop procout(8+i)<=memin(23); end loop;
              when others => mwes<="1000"; procout(7 downto 0)<=memin(31 downto 24);for i in 0 to 23 loop procout(8+i)<=memin(31); end loop;
              end case;
when "110" => case byte_off is
              when "00" => mwes<="0011"; memout(15 downto 0)<=procin(15 downto 0);
              when "01" => mwes<="0110"; memout(23 downto 8)<=procin(15 downto 0);
              when "10" => mwes<="1100"; memout(31 downto 16)<=procin(15 downto 0);
              when others => mwes<="1001"; memout(7 downto 0)<=procin(15 downto 8);memout(31 downto 24)<=procin(7 downto 0);
              end case;
when others => case byte_off is
              when "00" => mwes<="0011"; memout(7 downto 0)<=procin(7 downto 0);
              when "01" => mwes<="0110"; memout(15 downto 8)<=procin(7 downto 0);
              when "10" => mwes<="1100"; memout(23 downto 16)<=procin(7 downto 0);
              when others => mwes<="1001"; memout(31 downto 24)<=procin(7 downto 0);
              
              end case;
end case;
end process;
end Behavioral;
