library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;


entity Mem_WB_Buffer is 
		port(
				Clk : in std_logic;
				Rst : in std_logic;
				enable : in std_logic;
				pc_mux_input : in std_logic_vector(1 downto 0);
				
				
				outport_en_input : in std_logic; 
				 
				reg_write_input : in std_logic;
				
				write_data_reg_mux_input : in std_logic; 
				write_back_mux_input : in std_logic_vector(1 downto 0);
				LDM_immediate_input : in std_logic_vector(15 downto 0);
--------------------------------------------------------------------------------------------------------------------
				pc_mux_output : out std_logic_vector(1 downto 0);
				
				
				outport_en_output : out std_logic; 
				reg_write_output : out std_logic;
				
				write_data_reg_mux_output : out std_logic; 
				write_back_mux_output: out std_logic_vector(1 downto 0);
				LDM_immediate_output : out std_logic_vector(15 downto 0);
				--R1_address_in3,R2_address_in3: in std_logic_vector(2 downto 0 );
				--R1_address_out3,R2_address_out3: out std_logic_vector(2 downto 0 );
				Rout_in2: out std_logic_vector(2 downto 0 );
				Rout_out2: out std_logic_vector(2 downto 0 )
				
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
				
		pc_mux_map : 				nreg generic map (n=>2)port map(Clk,Rst,enable,pc_mux_input,pc_mux_output);
		
		outport_en_map :	 		Regis port map(Clk,Rst,enable,outport_en_input,outport_en_output);
		reg_write_map : 			Regis port map(Clk,Rst,enable,reg_write_input,reg_write_output);
		
		write_data_reg_mux_map : 	Regis port map(Clk,Rst,enable,write_data_reg_mux_input,write_data_reg_mux_output);
		write_back_mux_map : 		nreg generic map (n=>16)port map(Clk,Rst,enable,write_back_mux_input,write_back_mux_output);
		LDM_immediate_map : 	nreg generic map (n=>16)port map(Clk,Rst,enable,LDM_immediate_input,LDM_immediate_output);
		
	
	
	
	

end arch_Mem_WB_Buffer; 

