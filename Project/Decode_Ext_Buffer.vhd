library ieee;
use ieee.std_logic_1164.all;


entity D_E_Buffer is 
	Generic ( n : integer := 16);
		port(
				Clk : in std_logic;
				Rst : in std_logic;
				enable : in std_logic;
				--pc_mux : in std_logic_vector(1 downto 0);
				outport_en_input : in std_logic; 
				reg_write_input : in std_logic; 
				mem_read_input : in std_logic; 
				mem_write_input : in std_logic; 
				write_data_reg_mux_input : in std_logic; 
				--r1_load_mux : in std_logic;                 --deleted from desgin
				r2_shift_mux_input : in std_logic;
				r1_forward_mux_input : in std_logic;               --always 0 be 1 if only make forward so take signal from forward to mux to make it 1 
				r2_forward_mux_input : in std_logic; 				--always 0 be 1 if only make forward so take signal from forward to mux to make it 1 
				write_reg_mux_input : in std_logic;  
				write_back_mux_input : in std_logic_vector(1 downto 0);
				
				flags_en_input : in std_logic; 
				flags_rti_en_input : in std_logic; 
				alu_control_input : in std_logic;                 --change it according to alu control (3 bit ****)علي حسب شغلك   'musgi'
				mem_mux_input : in std_logic;  
				--stack_plus : in std_logic;  
				--stack_minus : in std_logic;  
				--stack_en : in std_logic_vector(1 downto 0);
				
				--load_value_15_0 : in std_logic_vector(15 downto 0); --jump from fetch to ext (without decode)
				load_store_address_input : in std_logic_vector(15 downto 0);
				
				--n : in std_logic 
				
				
				
				--pc_mux : out std_logic_vector(1 downto 0);
				outport_en_output : out std_logic; 
				reg_write_output : out std_logic; 
				mem_read_output : out std_logic; 
				mem_write_output : out std_logic; 
				write_data_reg_mux_output : out std_logic; 
				--r1_load_mux : out std_logic;                 --deleted from desgin
				r2_shift_mux_output : out std_logic;
				r1_forward_mux_output : out std_logic;               --always 0 be 1 if only make forward so take signal from forward to mux to make it 1 
				r2_forward_mux_output : out std_logic; 				--always 0 be 1 if only make forward so take signal from forward to mux to make it 1 
				write_reg_mux_output : out std_logic;  
				write_back_mux_output: out std_logic_vector(1 downto 0);
				
				flags_en_output : out std_logic; 
				flags_rti_en_output : out std_logic; 
				alu_control_output : out std_logic;                 --change it according to alu control (3 bit ****)علي حسب شغلك   'musgi'
				mem_mux_output : out std_logic;  
				--stack_plus : out std_logic;  
				--stack_minus : out std_logic;  
				--stack_en : out std_logic_vector(1 downto 0);
				
				--load_value_15_0 : in std_logic_vector(15 downto 0); --jump from fetch to ext (without decode)
				--load_store_address_output : out std_logic_vector(15 downto 0)
				
				--n : in std_logic 

				);
end D_E_Buffer;

architecture arch_D_E_Buffer of D_E_Buffer is
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
	reg_write_map : 			Regis port map(Clk,Rst,enable,reg_write_input,reg_write_output);
	mem_read_map : 				Regis port map(Clk,Rst,enable,mem_read_input,mem_read_output);
	mem_write_map : 			Regis port map(Clk,Rst,enable,mem_write_input,mem_write_output);
	write_data_reg_mux_map : 	Regis port map(Clk,Rst,enable,write_data_reg_mux_input,write_data_reg_mux_output);
	r2_shift_mux_map : 			Regis port map(Clk,Rst,enable,r2_shift_mux_input,r2_shift_mux_output);
	r1_forward_mux_map : 		Regis port map(Clk,Rst,enable,r1_forward_mux_input,r1_forward_mux_output);
	r2_forward_mux_map :		 Regis port map(Clk,Rst,enable,r2_forward_mux_input,r2_forward_mux_output);
	write_reg_mux_map : 		Regis port map(Clk,Rst,enable,write_reg_mux_input,write_reg_mux_output);
	write_back_mux_map : 		nreg generic map (n=>16)port map(Clk,Rst,enable,write_back_mux_input,write_back_mux_output);
	flags_en_map : 				Regis port map(Clk,Rst,enable,flags_en_input,flags_en_output);
	flags_rti_en_map : 			Regis port map(Clk,Rst,enable,flags_rti_en_input,flags_rti_en_output);
	alu_control_map : 			Regis port map(Clk,Rst,enable,alu_control_input,alu_control_output);
	mem_mux_map : 				Regis port map(Clk,Rst,enable,mem_mux_input,mem_mux_output);
	--load_store_address_map : 	nreg generic map (n=>16)port map(Clk,Rst,enable,load_store_address_input,load_store_address_output);
	
	
	
	

end arch_D_E_Buffer; 
