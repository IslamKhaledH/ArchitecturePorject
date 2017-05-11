Library ieee;
Use ieee.std_logic_1164.all;
 
ENTITY my_nadder IS
PORT    (a, b : in std_logic_vector(15 downto 0) ;
	s : out std_logic_vector(15 downto 0);
	cout : out std_logic);
END my_nadder;

Architecture a_my_nadder of my_nadder is
Component my_adder is
port( a,b,cin: in std_logic; s,cout : out std_logic);
end component;
signal temp : std_logic_vector(15 downto 0);
begin
f0 : my_adder port map(a(0),b(0),'0',s(0),temp(0));
loop1: for i in 1 to 15 generate
fx: my_adder port map(a(i),b(i),temp(i-1),s(i),temp(i));
end generate;
cout <= temp(15);
end a_my_nadder;
