library ieee;
use ieee.std_logic_1164.all;


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

	outport_en_map :	 		Regis port map(Clk,Rst,enable,outport_en_input,outport_en_output);
	--reg_write_map : 			Regis port map(Clk,Rst,enable,reg_write_input,reg_write_output);
	mem_read_map : 				Regis port map(Clk,Rst,enable,mem_read_input,mem_read_output);
	mem_write_map : 			Regis port map(Clk,Rst,enable,mem_write_input,mem_write_output);
	write_data_reg_mux_map : 	Regis port map(Clk,Rst,enable,write_data_reg_mux_input,write_data_reg_mux_output);
	--r2_shift_mux_map : 			Regis port map(Clk,Rst,enable,r2_shift_mux_input,r2_shift_mux_output);
	--r1_forward_mux_map : 		Regis port map(Clk,Rst,enable,r1_forward_mux_input,r1_forward_mux_output);
	--r2_forward_mux_map :		 Regis port map(Clk,Rst,enable,r2_forward_mux_input,r2_forward_mux_output);
	--write_reg_mux_map : 		Regis port map(Clk,Rst,enable,write_reg_mux_input,write_reg_mux_output);
	write_back_mux_map : 		nreg generic map (n=>16)port map(Clk,Rst,enable,write_back_mux_input,write_back_mux_output);
	--flags_en_map : 				Regis port map(Clk,Rst,enable,flags_en_input,flags_en_output);
	flags_rti_en_map : 			Regis port map(Clk,Rst,enable,flags_rti_en_input,flags_rti_en_output);
	--alu_control_map : 			Regis port map(Clk,Rst,enable,alu_control_input,alu_control_output);
	mem_mux_map : 				Regis port map(Clk,Rst,enable,mem_mux_input,mem_mux_output);
	load_store_address_map : 	nreg generic map (n=>16)port map(Clk,Rst,enable,load_store_address_input,load_store_address_output);
	
	
	
	

end arch_Mem_WB_Buffer; 
