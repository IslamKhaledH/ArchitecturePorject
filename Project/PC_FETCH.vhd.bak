
library  ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;
 
entity PC is 
port (

	counter: in std_logic_vector(15 downto 0 ); --
	
	new_counter: out std_logic_vector(15 downto 0 );
	CLK: in std_logic;
	RESET: in std_logic
);
end entity PC;




architecture PC_Arch of PC is 


begin 

--------------------------------------
 
--set0: syncram generic map (n =>16) port map (CLK,'0',new_count,"0000000000000000",copied_data); --clk,enable,(address to WRITE in),data to write, outputdata from selected address


process(CLK,RESET)
begin
if RESET='1' then new_counter<="0000000000000000" ; --RESET PC
end if;

if RESET='0' and CLK='1' then

new_counter <= std_logic_vector(unsigned(counter)+1);

end if;

------------------------------------------------

end process;

end architecture PC_Arch;