library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity syncram2 is
Generic ( n : integer := 8);
port ( clk,rst : in std_logic;
we, weStack, stackPushPop : in std_logic;
address : in std_logic_vector(n-1 downto 0);
datain : in std_logic_vector(15 downto 0);
dataout : out std_logic_vector(15 downto 0);
dataout0 : out std_logic_vector(15 downto 0);
dataout1 : out std_logic_vector(15 downto 0)
);
end entity syncram2;

architecture syncrama2 of syncram2 is
type ram_type is array (0 to (2**n)-1) of std_logic_vector(15 downto 0);
signal ram : ram_type;
signal stackAdress : std_logic_vector(9 downto 0);

begin
process(clk,datain,rst) is
begin
if rst = '1' then
	stackAdress <= "1111111111";
end if;

if rising_edge(clk) then
    if we = '1' then
	ram(to_integer(unsigned(address))) <= datain;
    --end if;
	elsif weStack = '1' then
		if stackPushPop = '0' then--push
			ram(to_integer(unsigned(stackAdress))) <= datain;
			stackAdress <= std_logic_vector(unsigned(stackAdress)-1);
		else -- pop
			stackAdress <= std_logic_vector(unsigned(stackAdress)+1);
			ram(to_integer(unsigned(stackAdress))) <= datain;
		end if;
    end if;
end if;
end process;

dataout <= 	ram(to_integer(unsigned(stackAdress))) when weStack = '1' and stackPushPop = '1' else
			ram(to_integer(unsigned(address)));
			
dataout0 <= ram(0);
dataout1 <= ram(1);

end architecture syncrama2;