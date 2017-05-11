library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Mem_WB_Buffer is 
	Generic ( n : integer := 16);
		port(
				Clk : in std_logic;
				Rst : in std_logic;
				enable : in std_logic;
				
				--Input
				pc_mux_input : in std_logic_vector(1 downto 0);
				outport_en_input : in std_logic; 
				reg_write_input : in std_logic; 
				write_data_reg_mux_input : in std_logic; 
				write_back_mux_input : in std_logic_vector(1 downto 0);				
				flags_en_input : in std_logic; 

				--Output
				pc_mux_output : out std_logic_vector(1 downto 0);
				outport_en_output : out std_logic; 
				reg_write_output : out std_logic; 
				write_data_reg_mux_output : out std_logic; 
				write_back_mux_output : out std_logic_vector(1 downto 0);				
				flags_en_output : out std_logic
				);
end Mem_WB_Buffer;

architecture arch_Mem_WB_Buffer of Mem_WB_Buffer is
	component Regis is
		port( 
				Clk,Rst,enable : in std_logic;
				d : in std_logic;
				q : out std_logic
			);
		end component;

	component nreg is
	Generic ( n : integer := 16);
		port( 
				Clk,Rst,enable : in std_logic;
				d : in std_logic_vector(n-1 downto 0);
				q : out std_logic_vector(n-1 downto 0)
			);
	end component;

	
	begin

	pc_mux_map : nreg generic map (n=>2)port map(Clk,Rst,enable,pc_mux_input,pc_mux_output);
	outport_en_map : Regis port map(Clk,Rst,enable,outport_en_input,outport_en_output);
	reg_write_map : Regis port map(Clk,Rst,enable,reg_write_input,reg_write_output);
	write_data_reg_mux_map : Regis port map(Clk,Rst,enable,write_data_reg_mux_input,write_data_reg_mux_output); 
	write_back_mux_map : nreg generic map (n=>1)port map(Clk,Rst,enable,write_back_mux_input,write_back_mux_output);			
	flags_en_map : Regis port map(Clk,Rst,enable,flags_en_input,flags_en_output);
	
	

end arch_Mem_WB_Buffer; 
