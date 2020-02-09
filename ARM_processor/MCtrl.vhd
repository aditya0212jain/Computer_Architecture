----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.03.2018 15:14:42
-- Design Name: 
-- Module Name: MCtrl - Behavioral
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

entity MCtrl is
    Port ( clk : in STD_LOGIC;
           ins: in STD_LOGIC_VECTOR(27 downto 20);
           p: in std_logic;
           Rsrc: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
           PW : OUT STD_LOGIC;
           MW : OUT STD_LOGIC;
           MR : OUT STD_LOGIC;
           MW1 : OUT STD_LOGIC;
           IW : OUT STD_LOGIC;
           DW : OUT STD_LOGIC;
          BW : OUT STD_LOGIC;                     
           RW : OUT STD_LOGIC;
           AW : OUT STD_LOGIC;
           ReW : OUT STD_LOGIC;
           FSET : OUT STD_LOGIC;
           RDW : OUT STD_LOGIC;
           MLA : OUT STD_LOGIC;
           rD1 : OUT STD_LOGIC;
           IORD : OUT STD_LOGIC;
           M2R : OUT STD_LOGIC;
           ASRC : OUT STD_LOGIC;
           BL : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
           ASRC2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
           SHIFT_CUSTOM : OUT STD_LOGIC;
           MON : OUT STD_LOGIC;
           MU : OUT STD_LOGIC;
           SW : OUT STD_LOGIC;
           SDPI : out std_logic;
           TYPE_CONTROL : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
           
           );
end MCtrl;

architecture Behavioral of MCtrl is
TYPE state_type IS (fetch,RdAB,DPShiftI,DPrdRs,DPShiftR,DParith,DPWrD,DT1,DT1S,DT1L1,DT1L2,DT0,DTORd,DT0S,DT0L1,DT0L2,B,BL1,dpwRf,m,mult,mulw1,mulw2,DT0RD,DPI);
SIGNAL state : state_type;
begin
PROCESS(CLK)
BEGIN
IF(CLK='1' AND CLK'EVENT) THEN
CASE state is
when fetch => 
state <= RdAB;
           Rsrc <= "00";
PW <= '1';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '1';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <='0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
ASRC <= '0';
BL <= "00";
ASRC2 <= "01";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when rdAB => 
state <= RdAB;
Rsrc <= "00";
PW <= '0';
MW <= '0';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '1';                     
RW <= '0';
AW <='1';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
ASRC <= '0';
BL <= "00";
ASRC2 <= "01";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when B => 
state <= RdAB;
Rsrc <= "00";
PW <= '1';
MW <= '0';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <='0';
ReW <='1';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
ASRC <= '0';
BL <= "00";
ASRC2 <= "11";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when BL1 => 
state <= RdAB;
Rsrc <= "00";
PW <= '0';
MW <= '0';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '1';
AW <='0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
ASRC <= '0';
BL <= "10";
ASRC2 <= "01";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DPShiftI => 
state <= RdAB;
Rsrc <= "00";
PW <= '0';
MW <= '0';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <='0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
ASRC <= '0';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '1';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DParith => 
state <= RdAB;
           Rsrc <= "00";
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <='1';
ReW <= p;
FSET <= p;
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
ASRC <= '1';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '1';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DPWrF => 
state <= RdAB;
Rsrc <= "00";
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= p;                     
RW <= '1';
AW <='0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
ASRC <= '0';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DPrdRs => 
state <= RdAB;
Rsrc <= "10";
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <='0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '1';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
ASRC <= '0';
BL <= "00";
ASRC2 <= "01";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;


when DPShiftR => 
state <= RdAB;
Rsrc <= "00";
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <='0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
ASRC <= '0';
BL <= "00";
ASRC2 <= "01";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '1';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when M => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <='1';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '1';
rD1 <= '1';
IORD <= '0';
M2R <= '0';
Rsrc <= "10";
ASRC <= '0';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when Mult => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '1';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <='0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
Rsrc <= "00";
ASRC <= '0';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '1';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when Mulw1 => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <='0';
ReW <='1';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
Rsrc <= "00";
ASRC <= '0';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '1';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when Mulw2 => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= p;
AW <='0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
Rsrc <= "00";
ASRC <= '0';
BL <= "01";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DT1 => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '1';                     
RW <= '0';
AW <= '0';
ReW <='1';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
Rsrc <= "01";
ASRC <= '1';
BL <= "00";
ASRC2 <= "10";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DT1S => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <= '0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '1';
M2R <= '0';
Rsrc <= "00";
ASRC <= '0';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "01";
SDPI <= '0' ;

when DT1L1 => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '1';
DW <= '1';
BW <= '0';                     
RW <= '0';
AW <= '0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '1';
M2R <= '0';
Rsrc <= "00";
ASRC <= '0';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DT1L2 => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '1';
AW <= '0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
Rsrc <= "00";
ASRC <= '0';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DT0 => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <= '0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
Rsrc <= "00";
ASRC <= '0';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '1';
MON <= '0';
MU <= '0';
SW <= '1';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DT0RD => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '1';                     
RW <= '0';
AW <= '0';
ReW <='1';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
Rsrc <= "01";
ASRC <= '1';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DT0S => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '1';
AW <= '0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '1';
M2R <= '1';
Rsrc <= "00";
ASRC <= '0';
BL <= "01";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DT0L1 => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '1';
BW <= '0';                     
RW <= '0';
AW <= '0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '1';
M2R <= '1';
Rsrc <= "00";
ASRC <= '0';
BL <= "01";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DT0L1 => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '1';
BW <= '0';                     
RW <= '0';
AW <= '0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '1';
M2R <= '0';
Rsrc <= "00";
ASRC <= '0';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '0';
TYPE_CONTROL <= "00";
SDPI <= '0' ;

when DPI => 
state <= RdAB;
PW <= '0';
MW <= '1';
MR <= '0';
MW1 <= '0';
IW <= '0';
DW <= '0';
BW <= '0';                     
RW <= '0';
AW <= '0';
ReW <='0';
FSET <= '0';
RDW <= '0';
MLA <= '0';
rD1 <= '0';
IORD <= '0';
M2R <= '0';
Rsrc <= "00";
ASRC <= '0';
BL <= "00";
ASRC2 <= "00";
SHIFT_CUSTOM <= '0';
MON <= '0';
MU <= '0';
SW <= '1';
TYPE_CONTROL <= "00";
SDPI <= '1' ;

end case;
end if;
end process;
end Behavioral;
