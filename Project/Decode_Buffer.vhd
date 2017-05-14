
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
				R1_address_out,R2_address_out: out std_logic_vector(2 downto 0 );
				
				
				pc_mux_input : in std_logic_vector(1 downto 0);
				outport_en_input : in std_logic; 
				reg_write_input : in std_logic; 
				mem_write_input : in std_logic; 
				write_data_reg_mux_input : in std_logic; 
				write_back_mux_input : in std_logic_vector(1 downto 0);
				int_flags_en_input : in std_logic;                  --  int to take flags from meomry to alu
				alu_control_input : in std_logic_vector(4 downto 0);                 --change it according to alu control (3 bit ****)??? ??? ????   'musgi'
				mem_mux_input : in std_logic;
				
				
				pc_mux_output : out std_logic_vector(1 downto 0);
				outport_en_output : out std_logic; 
				reg_write_output : out std_logic; 
				mem_write_output : out std_logic; 
				write_data_reg_mux_output : out std_logic; 
				                  -- to know if make shift or not
				write_back_mux_output : out std_logic_vector(1 downto 0);
				int_flags_en_output : out std_logic;                  --  int to take flags from meomry to alu
				alu_control_output : out std_logic_vector(4 downto 0);                 --change it according to alu control (3 bit ****)??? ??? ????   'musgi'
				mem_mux_output : out std_logic;
				
				Stack_WriteEnable_input, StackPushPop_signal_input : in std_logic;
				Stack_WriteEnable_output, StackPushPop_output : out std_logic

				
				
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
				
				pc_mux_output <= pc_mux_input;
				outport_en_output <=outport_en_input;
				reg_write_output <=reg_write_input;
				mem_write_output <= mem_write_input; 
				write_data_reg_mux_output <= write_data_reg_mux_input;
				
				write_back_mux_output <= write_back_mux_input;
				int_flags_en_output <= int_flags_en_input;               --  int to take flags from meomry to alu
				alu_control_output <= alu_control_input;                --change it according to alu control (3 bit ****)??? ??? ????   'musgi'
				mem_mux_output <= mem_mux_input;
				
				
				
			
			end if;

	end process;
		
		
end Decode_Buffer_arch;


