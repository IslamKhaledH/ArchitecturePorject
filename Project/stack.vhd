Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity stack is
port(
		
		stack_address : in std_logic_vector(9 downto 0);
		stack_en,clk,stack_plus,stack_minus,Reset : in std_logic
      );
end stack;

Architecture arch_stack of stack is

	Component syncram is
		generic ( n : integer := 8);
			port ( 
					clk : in std_logic;
					we : in std_logic;
					address : in std_logic_vector(n-1 downto 0);
					datain : in std_logic_vector(15 downto 0);
					dataout : out std_logic_vector(15 downto 0)				
				  );
	end component;
	
	SIGNAL stack_address_signal : std_logic_vector(9 downto 0);
	SIGNAL stack_data : std_logic_vector(15 downto 0);
	SIGNAL stack_datain,stack_dataout : std_logic_vector(15 downto 0);
	
	
	Begin

		stack_output_plus_plus: syncram generic map (n =>10) port map (clk,'0',stack_address,"00000000",stack_data);              
		stack_input_minus_minus: syncram generic map (n =>10) port map (clk,stack_en,stack_address,stack_datain,stack_dataout);
		
		process(clk,stack_address,stack_address_signal)
		
		begin
			if(rising_edge(clk)) then
				 if stack_plus='1' then
					stack_address_signal <= stack_address;
					stack_address_signal <= std_logic_vector(unsigned(stack_address_signal)+1);
				 elsif stack_minus='1' then
					stack_address_signal <= stack_address;
					stack_address_signal <= std_logic_vector(unsigned(stack_address_signal)-1);
				 elsif Reset='1' then
					stack_address_signal <= (others => '0');
					--stack_address <= stack_address_signal;
				 end if;
			 
			end if;
		end process;
end arch_stack;