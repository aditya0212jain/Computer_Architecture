----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/01/2018 03:41:29 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( op1 : in STD_LOGIC_VECTOR (31 downto 0);
           op2 : in STD_LOGIC_VECTOR (31 downto 0);
           opc : in STD_LOGIC_VECTOR (3 downto 0);
           carry : in STD_LOGIC;
           set : in STD_LOGIC;
           op3 : out STD_LOGIC_VECTOR (31 downto 0);
           Z : out STD_LOGIC;
           N : out STD_LOGIC;
           C : out STD_LOGIC;
           V : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
signal o : std_logic_vector(31 downto 0);
signal c31 : std_logic;
signal c32 : std_logic;
begin
with opc select o
 <= op1 and op2 when "0000",
    op1 xor op2 when "0001", 
    op1 - op2 when "0010",
     op2 - op1 when "0011",
     op1 + op2 when "0100", --add
    op1 + op2 + carry when "0101",
     op1 + (not op2) + carry when "0110",
(not op1) + op2 + carry when "0111",
   op1 and op2 when "1000",
   op1 xor op2 when "1001",
   op1 - op2 when "1010",
op1 + op2 when "1011" ,
 op1 or op2 when "1100" ,
op2 when "1101" , --mov
 op1 and (not op2) when "1110" ,
not op2 when others ;
Z<=not( o(0)or o(1)or o(2) or  o(3)or o(4)or o(5) or o(6)or o(7)or o(8) or o(9)or o(10)or o(11) or o(12)or o(13)or o(14) or o(15)or o(16)or o(17) or  o(18)or o(19)or o(20) or o(21)or o(22)or o(23) or o(24)or o(25)or o(26) or o(27)or o(28)or o(29) or o(30) or o(31));
N<= o(31);
c31<= o(31) xor op1(31) xor op2(31);
c32<= (c31 and op1(31))or(c31 and op2(31))or(op2(31) and op1(31));
C<=c32;
V<=c31 xor c32;
op3 <= o;
end Behavioral;
