Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Memory is
PORT  ( Clk, rst, Mux_Selector, Memory_WriteEnable, Stack_WriteEnable, StackPushPop : in std_logic; --StackPushPop 0: psuh, 1: pop
		--FlagEnable : in std_logic;
	InputAddress, LoadAdress : in std_logic_vector(9 downto 0);
	DataIn : in std_logic_vector(15 downto 0);
	DataOut, M0, M1 : out std_logic_vector (15 downto 0);
	Flags_Z_In, Flags_NF_In, Flags_V_In, Flags_C_In : in std_logic;
	Flags_Z_Out, Flags_NF_Out, Flags_V_Out, Flags_C_Out : out std_logic;
	BranchOpCode_In : in std_logic_vector (4 downto 0);
	BranchR1_In : in std_logic_vector (15 downto 0);
	Branch_Out : out std_logic_vector (15 downto 0)
);
END Memory;

architecture arch_Memory of Memory is

Component syncram2 is
Generic ( n : integer := 8);
port ( clk,rst : in std_logic;
we, weStack, stackPushPop : in std_logic;
address : in std_logic_vector(n-1 downto 0);
datain : in std_logic_vector(15 downto 0);
dataout : out std_logic_vector(15 downto 0);
dataout0 : out std_logic_vector(15 downto 0);
dataout1 : out std_logic_vector(15 downto 0)
);
end component;

signal Address : std_logic_vector(9 downto 0);
signal DO,DO0,DO1 : std_logic_vector(15 downto 0);
signal dontCare1, dontCare2 : std_logic_vector (15 downto 0);

begin

Mem : syncram2 generic map(n=>10) port map(Clk, rst, Memory_WriteEnable, Stack_WriteEnable, StackPushPop, Address, datain,DO,DO0,DO1);


process (clk,rst)
begin

if rising_edge(clk) then
	if Mux_Selector = '0' then
		Address <= InputAddress;
	else
		Address <= LoadAdress;
	end if;

	DataOut <= DO;
	M0 <= DO0;
	M1 <= DO1;
	
	if BranchOpCode_In = "10100" and Flags_Z_In = '1' then --JZ Rdst
		Branch_Out <= BranchR1_In;
		Flags_Z_Out <= '0';
		
	elsif BranchOpCode_In = "10101" and Flags_NF_In = '1' then --JN Rdst
		Branch_Out <= BranchR1_In;
		Flags_NF_Out <= '0';
		
	elsif BranchOpCode_In = "10110" and Flags_C_In = '1' then --JC Rdst
		Branch_Out <= BranchR1_In;
		Flags_C_Out <= '0';
		
	elsif BranchOpCode_In = "10111" then			 --JMP Rdst	
		Branch_Out <= BranchR1_In;
		
	elsif BranchOpCode_In = "11001" then			--RET
		Branch_Out <= DO;
		
	elsif BranchOpCode_In = "11010" then			 --RTI --FLAGS RESTORED
		Branch_Out <= DO;
		Flags_Z_Out <= '0';
		Flags_NF_Out <= '0';
		Flags_C_Out <= '0';
		Flags_V_Out <= '0';
	else
		Flags_Z_Out <= Flags_Z_In;
		Flags_NF_Out <= Flags_NF_In;
		Flags_C_Out <= Flags_C_In;
		Flags_V_Out <= Flags_V_In;
	end if;
end if;

end process;
end architecture arch_Memory;