Library ieee;
Use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

ENTITY AddSubIncDec IS
port(
	R1,R2: in std_logic_vector(15 downto 0);
	OutPut : out std_logic_vector(15 downto 0); 
	OpCode :in std_logic_vector(4 downto 0);
	--Z: out std_logic;
	--V: out std_logic;
	C: out std_logic
	--N: out std_logic
	);
END AddSubIncDec;

Architecture archi of AddSubIncDec is
Component my_nadder is
PORT    (a, b : in std_logic_vector(15 downto 0) ;
	s : out std_logic_vector(15 downto 0);
	cout : out std_logic);
end component;

signal tmpR1 : std_logic_vector(15 downto 0);
signal tmpR2 : std_logic_vector(15 downto 0);
signal TempOut : std_logic_vector(15 downto 0);
begin
tmpR1 <= R1 ;
		 
tmpR2 <= R2   when OpCode = "00010" else
		-R2   when OpCode = "00011" else 
		"0000000000000001"   when OpCode = "10010" else 
		(others => '1')      when OpCode = "10011";
         
		 
F : my_nadder port map(tmpR1,tmpR2,TempOut,C);
OutPut <= TempOut;
end archi;