library IEEE;
library UNISIM;
use UNISIM.Vcomponents.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.CONV_STD_LOGIC_VECTOR;
use IEEE.NUMERIC_STD.ALL;

ENTITY Shifter IS
    Port(
    I : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    Cin : IN STD_LOGIC:='0';
    C : OUT STD_LOGIC;
    shiftType : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    shiftAmount : IN Unsigned(31 DOWNTO 0)
    );
END Shifter;
    
ARCHITECTURE Behavioral OF Shifter IS
SIGNAL one : Unsigned(31 DOWNTO 0):="00000000000000000000000000000001";

BEGIN

WITH shiftType select
    Output <= STD_LOGIC_VECTOR(shift_left(unsigned(I), to_integer(shiftAmount))) WHEN "00",
              STD_LOGIC_VECTOR(shift_right(unsigned(I), to_integer(shiftAmount))) WHEN "01",
              STD_LOGIC_VECTOR(shift_right(signed(I), to_integer(shiftAmount))) WHEN "10",
              STD_LOGIC_VECTOR(rotate_right(unsigned(I), to_integer(shiftAmount))) WHEN "11",
              I WHEN OTHERS;
    C <= I(31 - to_integer(shiftAmount)) WHEN (NOT(shiftAmount = "00") AND shiftType = "00") ELSE
         I(to_integer(shiftAmount) -1) WHEN (NOT(shiftAmount = "00") AND (shiftType = "01" OR shiftType = "10" OR shiftType = "11")) ELSE
         Cin WHEN shiftAmount = "00";
         
END Behavioral;
