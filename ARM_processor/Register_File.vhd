----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2018 03:13:49 PM
-- Design Name: 
-- Module Name: Register_File - Behavioral
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

entity Register_File is
    Port ( wd : in STD_LOGIC_VECTOR (31 downto 0);
           ra1 : in STD_LOGIC_VECTOR (3 downto 0);
           ra2 : in STD_LOGIC_VECTOR (3 downto 0);
           wa : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           maintain : in STD_LOGIC;
           reset : in STD_LOGIC;
           write_enable : in STD_LOGIC;
           out1 : out STD_LOGIC_VECTOR (31 downto 0);
           out2 : out STD_LOGIC_VECTOR (31 downto 0);
           pc_in : in STD_LOGIC_VECTOR (31 DOWNTO 0);
           pc_out : out STD_LOGIC_VECTOR(31 DOWNTO 0);
           PW : IN STD_LOGIC);
end Register_File;

architecture Behavioral of Register_File is
signal r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15 : STD_LOGIC_VECTOR(31 downto 0); 
begin
process(clk)
begin
if(reset = '1') then
pc_out <= "00000000000000000000000000000000";
out1 <= "00000000000000000000000000000000";
out2 <= "00000000000000000000000000000000";
r0 <= "00000000000000000000000000000000";
r1 <= "00000000000000000000000000000000";
r2 <= "00000000000000000000000000000000";
r3 <= "00000000000000000000000000000000";
r4 <= "00000000000000000000000000000000";
r5 <= "00000000000000000000000000000000";
r6 <= "00000000000000000000000000000000";
r7 <= "00000000000000000000000000000000";                                          
r8 <= "00000000000000000000000000000000";
r9 <= "00000000000000000000000000000000";
r10 <= "00000000000000000000000000000000";
r12 <= "00000000000000000000000000000000";
r11<= "00000000000000000000000000000000";
r13 <= "00000000000000000000000000000000";
r14 <= "00000000000000000000000000000000";
r15 <= "00000000000000000000000000000000";
elsif( clk = '1' and clk'event) then
IF(PW='1') THEN
pc_out<=pc_in;end if;
if(write_enable='1')then
case wa is
when "0000" => r0 <= wd;
when "0001" => r1 <= wd;
when "0010" => r2 <= wd;
when "0011" => r3 <= wd;
when "0100" => r4 <= wd;                        
when "0101" => r5 <= wd;
when "0110" => r6 <= wd;
when "0111" => r7 <= wd;
when "1000" => r8 <= wd;
when "1001" => r9 <= wd;
when "1010" => r10 <= wd;                        
when "1011" => r11 <= wd;
when "1100" => r12 <= wd;
when "1101" => r13 <= wd;
when "1110" => r14 <= wd;
when others => r15 <= wd;
end case;
end if;
case ra1 is
when "0000" => out1 <= r0;
when "0001" => out1 <= r1;
when "0010" => out1 <= r2;
when "0011" => out1 <= r3;
when "0100" => out1 <= r4;                        
when "0101" => out1 <= r5;
when "0110" => out1 <= r6;
when "0111" => out1 <= r7;
when "1000" => out1 <= r8;
when "1001" => out1 <= r9;
when "1010" => out1 <= r10;                        
when "1011" => out1 <= r11;
when "1100" => out1 <= r12;
when "1101" => out1 <= r13;
when "1110" => out1 <= r14;
when others => out1 <= r15;
end case;
case ra2 is
when "0000" => out2 <= r0;
when "0001" => out2 <= r1;
when "0010" => out2 <= r2;
when "0011" => out2 <= r3;
when "0100" => out2 <= r4;                        
when "0101" => out2 <= r5;
when "0110" => out2 <= r6;
when "0111" => out2 <= r7;
when "1000" => out2 <= r8;
when "1001" => out2 <= r9;
when "1010" => out2 <= r10;                        
when "1011" => out2 <= r11;
when "1100" => out2 <= r12;
when "1101" => out2 <= r13;
when "1110" => out2 <= r14;
when others => out2 <= r15;
end case;
end if;
end process;
end Behavioral;
