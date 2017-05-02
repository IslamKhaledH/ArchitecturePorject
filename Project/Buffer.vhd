Library ieee;
Use ieee.std_logic_1164.all;

Entity Regis is
port( Clk,Rst,enable : in std_logic;
d : in std_logic;
q : out std_logic);
end Regis;

Architecture Regis_function of Regis is
begin
Process (Clk,Rst)
begin
if Rst = '1' then
q <= '0';
elsif clk'event and clk = '1' then   
	if (enable = '1') then          
 	    q <= d;
 end if;
end if;
end process;
end Regis_function;

