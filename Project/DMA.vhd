Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity DMA is
PORT  ( Clk,Mux_Selector, Memory_WriteEnable : in std_logic;
	InputAddress, LoadAdress : in std_logic_vector(9 downto 0);
	DataIn : in std_logic_vector(15 downto 0);
	DataOut, M0, M1 : out std_logic_vector (15 downto 0);
	Flags_In : in std_logic_vector(3 downto 0);
	Flags_Out : out std_logic_vector(3 downto 0)
);
END DMA;

architecture MyDMA of DMA is

Component syncram is
Generic (n : integer := 8);
port ( clk : in std_logic;
we : in std_logic;
address : in std_logic_vector(n-1 downto 0);
datain : in std_logic_vector(15 downto 0);
dataout : out std_logic_vector(15 downto 0);
dataout0 : out std_logic_vector(15 downto 0);
dataout1 : out std_logic_vector(15 downto 0) 
);
end Component syncram;

signal Address : std_logic_vector(9 downto 0);
signal DI :std_logic_vector(15 downto 0);
signal DO,DO0,DO1 : std_logic_vector(15 downto 0);
signal dontCare1, dontCare2 : std_logic_vector (15 downto 0);

begin
Mem : syncram generic map(n=>10) port map(Clk, Memory_WriteEnable, Address,DI,DO,DO0,DO1);

Address <= InputAddress when Mux_Selector = '0' else
			LoadAdress;
			
Flags_Out <= Flags_In;
			

DataOut <= DO;
M0 <= DO0;
M1 <= DO1;


end architecture MyDMA;