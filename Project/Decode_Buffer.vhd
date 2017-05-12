
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Decode_Buffer is 
	
		port(
				Clk : in std_logic;
				Rst : in std_logic;
				
				R1_in: in std_logic_vector(15 downto 0 ); --addres of reg1
				R2_in: in std_logic_vector(15 downto 0 ); --addres of reg2
				Rout_in: in std_logic_vector(2 downto 0 ); --for write back
				R1_out: out std_logic_vector(15 downto 0 ); --addres of reg1
				R2_out: out std_logic_vector(15 downto 0 ); --addres of reg2
				Rout_out: out std_logic_vector(2 downto 0 ); --for write back
			
				R_shift_in:in std_logic_vector(3 downto 0 );
				R_shift_out:out std_logic_vector(3 downto 0 );
				
				
				OPcode_in: in std_logic_vector(4 downto 0 );
				OPcode_out: out std_logic_vector(4 downto 0 );
				
				R1_address_in,R2_address_in: in std_logic_vector(2 downto 0 );
				R1_address_out,R2_address_out: out std_logic_vector(2 downto 0 )

				
				
				);
end Decode_Buffer;

architecture Decode_Buffer_arch of Decode_Buffer is
	

	begin
--call control unit
		
		
		process(clk) is
		begin
			if (rising_edge(clk)) then 
				
					R1_out<=R1_in;
					R2_out<=R2_in;
					OPcode_out<=OPcode_in;
				Rout_out<=Rout_in;
				R_shift_out<=R_shift_in;
				R1_address_out<=R1_address_in;
				R2_address_out<=R2_address_in;
				
			
			end if;

	end process;
		
		
end Decode_Buffer_arch;

