----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2018 05:38:00 PM
-- Design Name: 
-- Module Name: integratedDataPath - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
--use UNISIM.VComponents.all;

entity integratedDataPath is
 Port ( clk : in std_logic;
        reset : in std_logic;
        IorD : in std_logic;
        RdW : IN STD_LOGIC;
        PW : in std_logic;
        MR : in std_logic;
        MW : in std_logic;
        MW1 : in std_logic;
        MLA : in std_logic;
        IW : in std_logic;
        DW : in std_logic;
        M2R : in std_logic;
        BW : in std_logic;
        Rsrc : in std_logic_vector(1 downto 0);
        RW : in std_logic;
        AW : in std_logic;
        Asrc1 : in std_logic;
        RD1 : IN STD_LOGIC;
        BL : in std_logic_vector(1 downto 0);
        Asrc2 : in std_logic_vector(1 downto 0);
        ReW : in std_logic;
        FSet : in std_logic;
        Shift_Custom,SW : in std_logic;
        Multiply_or_not :in std_logic;
        Type_control : in std_logic_vector(2 downto 0);
        OpcControl : in std_logic_vector(3 downto 0);
        SDPI : in std_logic;
        MU : in std_logic;
        Z : out std_logic;
        V : out std_logic;
        C : out std_logic;
        N : out std_logic
         );
end integratedDataPath;

architecture Behavioral of integratedDataPath is

component design_1_wrapper Port (
            BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_clk : in STD_LOGIC;
    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_en : in STD_LOGIC;
    BRAM_PORTA_rst : in std_logic;
    BRAM_PORTA_we : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
 end component;

component ALU Port ( op1 : in STD_LOGIC_VECTOR (31 downto 0);
           op2 : in STD_LOGIC_VECTOR (31 downto 0);
           opc : in STD_LOGIC_VECTOR (3 downto 0);
           carry : in STD_LOGIC;
           set : in STD_LOGIC;
           op3 : out STD_LOGIC_VECTOR (31 downto 0);
           Z : out STD_LOGIC;
           N : out STD_LOGIC;
           C : out STD_LOGIC;
           V : out STD_LOGIC);
end component;
component PM_path  Port ( procin : in STD_LOGIC_VECTOR (31 downto 0);
          memin : in STD_LOGIC_VECTOR (31 downto 0);
          typ : in STD_LOGIC_VECTOR (2 downto 0);
          procout : out STD_LOGIC_VECTOR (31 downto 0);
          memout : out STD_LOGIC_VECTOR (31 downto 0);
          byte_off : in STD_LOGIC_VECTOR (1 downto 0);
          mwes : out STD_LOGIC_VECTOR(3 downto 0));
          end component;
component Register_File
    Port ( wd : in STD_LOGIC_VECTOR (31 downto 0);
           ra1 : in STD_LOGIC_VECTOR (3 downto 0);
           ra2 : in STD_LOGIC_VECTOR (3 downto 0);
           wa : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           maintain : in std_logic;
           reset : in STD_LOGIC;
           write_enable : in STD_LOGIC;
           out1 : out STD_LOGIC_VECTOR (31 downto 0);
           out2 : out STD_LOGIC_VECTOR (31 downto 0);
           pc_in : in  std_logic_vector(31 downto 0);
           pc_out : out std_logic_vector(31 downto 0);
           PW : in STD_LOGIC);
end component;
component register1
   Port ( inp : in std_logic;
          ena : in std_logic;
          clk : in std_logic;
          outp : out std_logic );
          end component;
component registerA
    Port ( inp : in STD_LOGIC_VECTOR (31 downto 0);
          clk : in std_logic;
           enable : in STD_LOGIC;
           outp : out STD_LOGIC_VECTOR (31 downto 0));
end component;
component Shifter IS
    Port(
    I : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    Cin : IN STD_LOGIC:='0';
    C : OUT STD_LOGIC;
    shiftType : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    shiftAmount : IN Unsigned(31 DOWNTO 0)
    );
           end component;
component multiplier Port ( op1 : in STD_LOGIC_VECTOR (31 downto 0);
                      op2 : in STD_LOGIC_VECTOR (31 downto 0);
                      op3 : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal Rn,Rd,Rm,Rs,Rd2 : std_logic_vector (3 downto 0);
signal F : std_logic_vector(1 downto 0);
signal S : std_logic;
signal I : std_logic;
signal Cond : std_logic_vector(3 downto 0);
signal shift,Imm : std_logic_vector(7 downto 0);
signal rot : std_logic_vector(3 downto 0);
signal operand1,operand2,operand3,operand4,op1a,op2a,op1b,op2b,op3f,op3,pct,opmo,opmul,opmo1 : std_logic_vector(31 downto 0);
signal junk4:std_logic_vector(3 downto 0) := "0000";
signal junk32: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal junk1,N1,Z1,V1,C1: std_logic;
signal write,Zflag,Cflag,Vflag,Nflag : std_logic;
signal pc_temp: std_logic_vector(31 downto 0) := (others => '0');
signal ins: std_logic_vector(31 downto 0);
signal insi: std_logic_vector(31 downto 0);
signal inso: std_logic_vector(31 downto 0);
signal ofs: std_logic_vector(23 downto 0);
signal sh: std_logic_vector(11 downto 0);
signal shx: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal s2x,s2x2: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal shift_amount : std_logic_vector(4 downto 0);
signal shift_out,SO1,operand5,operand6 ,opm ,pm_memout : std_logic_vector(31 downto 0);
signal mwes_signal,mwes_signal1 :std_logic_vector(3 downto 0);
signal nayasignal : std_logic_vector(31 downto 0);
signal Cshift : std_logic;
signal shift_type_input : std_logic_vector(1 downto 0);
signal insdpi,s_input,s_amount,ins32,insdpi1,insdpi2 : std_logic_vector(31 downto 0);
begin
--Main starting

F <= ins(27 downto 26); -- F=00 for dp instruction , 01 for dt instruction, 10 for branch
WITH RD1 SELECT Rn <= ins(19 downto 16) WHEN '0', ins(15 downto 12) when others;
Rd <= ins(15 downto 12);
Cond <= ins(31 downto 28);
sh <= ins(11 downto 0);
ofs <= ins(23 downto 0);
shx(11 downto 0)<= sh;
s2x2(25 downto 2)<=ofs;
s2x<=
s2x2+"00000000000000000000000000000100";
        RC: registerA Port Map(inp=> operand2,enable=>MLA,outp=>operand4,clk => clk);
        IR: registerA Port Map(inp=> insi,enable=>'1',outp=>ins,clk => clk);
        DR: registerA Port Map(inp=> insi,enable=>DW,outp=>inso,clk => clk);
        AR: registerA Port Map(inp=> operand1,enable=>AW,outp=>op1a,clk => clk);
        BR: registerA Port Map(inp=> operand2,enable=>BW,outp=>op2a,clk => clk);
        
        with RdW SELECT mwes_signal1 <=
        mwes_signal when '1',
        "0000" when others;
        
        with Asrc1 select op1b <=
        op1a when '1',
        pc_temp when others;
        
        with Asrc2 select op2b <=
        operand6 when "00",
        "00000000000000000000000000000100" when "01",
        shx when "10",
        s2x when others;
        
        with BL select Rd2 <=
        Rd when "00",
        ins(19 downto 16) when "01",
        "1110" when others;
        
insdpi <= "000000000000000000000000" & ins(7 downto 0);

insdpi1 <= "0000000000000000000000000000" & ins(11 downto 8);

insdpi2(31 downto 1) <= insdpi1(30 downto 0);
insdpi2(0) <= '0';

     V <= V1;
     C <= C1;
     Z <= Z1;
     N <= N1;
ZR: register1 port MAP(inp=> Zflag, ena=> Fset, outp=> Z1,clk => clk);
CR: register1 port MAP(inp=> Cflag, ena=> Fset, outp=> C1,clk => clk);
VR: register1 port MAP(inp=> Vflag, ena=> Fset, outp=> V1,clk => clk);
NR: register1 port MAP(inp=> Nflag, ena=> Fset, outp=> N1,clk => clk);
ALU1: ALU port MAP (op1 => op1b, op2 => op2b,opc => OpcControl,carry => C1, set => S,op3 =>operand3,Z =>Zflag,N =>Nflag,C =>Cflag,V =>Vflag);
MUL1: multiplier port MAP (op1 => opmul, op2=>op2a, op3=>opmo);
RES: registerA port MAP (inp=>operand3,enable=>ReW,outp=>op3f,clk => clk);
MUS: registerA port MAP (inp=>opmo,enable=>MW1,outp=>opmo1,clk => clk);
SW1: registerA port MAP (inp=>SHIFT_OUT,enable=>SW,outp=>SO1,clk => clk);
Write1:  Register_File port map (wd => op3,ra1 => Rn,pc_in=>operand3,pc_out=>pc_temp,PW=>PW,ra2 => Rm,wa => Rd2,clk =>clk,maintain=>'1',reset =>reset,write_enable =>'1',out1 =>operand1,out2 =>operand2);
Shifter1: shifter port map (I => s_input,shiftType => shift_type_input,shiftAmount => unsigned(s_amount),Cin => C1, Output => shift_out,C => Cshift );
Memory1: design_1_wrapper port map (BRAM_PORTA_addr => pct , BRAM_PORTA_din => pm_memout, BRAM_PORTA_clk => clk,BRAM_PORTA_dout => insi,BRAM_PORTA_rst => MR , BRAM_PORTA_en => MW , BRAM_PORTA_we => mwes_signal1 );
PMPath: PM_path port map(procin => op2a,memin =>inso,typ =>type_control,procout =>opm,memout => pm_memout,byte_off => ins(1 DOWNTO 0),mwes => mwes_signal);

with Shift_Custom select operand5 <=
    op2a when '0',
    SO1 when others;
    
with SDPI select shift_type_input <=
    ins(6 downto 5) when '0',
    "11" when others;
    
with SDPI select s_input <=
    insdpi when '1',
    op2a when others;
    
with SDPI select s_amount <=
    nayasignal when '0',
    insdpi2 when others;

with ins(4) select shift_amount <=
    operand4(4 downto 0) when '0',
    ins(11 downto 7) when others;

with Rsrc select Rm <=
    ins(3 downto 0) when "00",
    ins(15 downto 12) when "01",
    ins(11 downto 8) when others;
    

nayasignal <= "000000000000000000000000000" & shift_amount;

with MU select opmul <= 
   operand4 when '1',
   "00000000000000000000000000000001" when others;

with Multiply_or_not select operand6 <=
    operand5 when '0',
    opmo1 when others;

with M2R select op3 <=
     op3f when '0',
     opm when others;

with IorD select pct <=
     op3f when '1',
     pc_temp when others;

end Behavioral;