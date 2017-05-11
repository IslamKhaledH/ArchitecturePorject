Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity control_entity is
  port (
			op_code: in std_logic_vector(4 downto 0);

			
			nop_enable:in std_logic;  --nop operation enable for load & store
			
			pc_mux : out std_logic_vector(1 downto 0);
			inport_en : out std_logic; 
			outport_en : out std_logic; 
			reg_read : out std_logic; 
			reg_write : out std_logic; 
			mem_read : out std_logic; 
			mem_write : out std_logic; 
			write_data_reg_mux : out std_logic; 
			Shift_Mux : out std_logic;
			r2_shift_mux : out std_logic;
			r1_forward_mux : out std_logic;               --always 0 be 1 if only make forward so take signal from forward to mux to make it 1 
			r2_forward_mux : out std_logic; 				--always 0 be 1 if only make forward so take signal from forward to mux to make it 1 
			 
			
			write_back_mux : out std_logic_vector(1 downto 0);
			flags_en : out std_logic; 
			flags_rti_en : out std_logic; 
			alu_control : out std_logic;                 --change it according to alu control (3 bit ****)علي حسب شغلك   'musgi'
			mem_mux : out std_logic;  
			stack_plus : out std_logic;  
			stack_minus : out std_logic;  
			stack_en : out std_logic_vector(1 downto 0)
			
			
  );
end  control_entity;



Architecture arch_control_entity of control_entity is

	signal op_code_signal : std_logic_vector(4 downto 0);


	Begin
	
		op_code_signal<="00000" when nop_enable='1' else
						op_code;
		
		
		
		pc_mux <=				"01" when op_code_signal="10100" or  op_code_signal="10101" or op_code_signal="10110" or op_code_signal="11000" or op_code_signal="11001" or op_code_signal="11010" or op_code_signal="01100" or op_code_signal="01101" else
								"10" when op_code_signal="11110" else
								"11" when op_code_signal="11111" else
								"00";
		
		
		inport_en <=			'1' when op_code_signal="01111" else
								'0';
						
		outport_en <=			'1' when op_code_signal="01110" else
								'0';
						
		reg_read <=				'1' when (op_code_signal>="00001" and op_code_signal<="01001") or (op_code_signal>="10000" and op_code_signal<="10011") or op_code_signal="01100" or op_code_signal="01110" or (op_code_signal>="10100" and op_code_signal<="11000") or op_code_signal="11101" or op_code_signal="11111" else
								'0';
					
		reg_write <=			'1' when (op_code_signal>="00001" and op_code_signal<="01001") or (op_code_signal>="10000" and op_code_signal<="10011") or op_code_signal="01101" or op_code_signal="01111" or op_code_signal="11011" or op_code_signal="11100" else
								'0';
						
		mem_read <=				'1' when op_code_signal="01101" or op_code_signal="11001" or op_code_signal="11010" or op_code_signal="11100" or op_code_signal="11110" or op_code_signal="11111" else
								'0';
						
		mem_write <=			'1' when op_code_signal="01100" or op_code_signal="11000" or op_code_signal="11101" or op_code_signal="11111" else
								'0';
						
		write_data_reg_mux <=	'1' when op_code_signal="01111" else
								'0';
		
		Shift_Mux <='1' when op_code_signal="01000" or op_code_signal="01001" else '0';
		
		
		r2_shift_mux <=			'1' when op_code_signal="01000" or op_code_signal="01001" else
								'0';
						
		r1_forward_mux <=		'0';
		
		r2_forward_mux <=		'0';
		
	--	write_reg_mux <=		'1' when op_code_signal="00110" or op_code_signal="00111" or (op_code_signal>="01100" and op_code_signal<="11000") or (op_code_signal>="11011" and op_code_signal<="11101") or op_code_signal="11111" else
						--		'0';
			
		write_back_mux <=		"01" when (op_code_signal>="01100" and op_code_signal<="01110") or op_code_signal="11100" else
								"10" when op_code_signal="11011" else
								"00";
							
		flags_en <=			'1' when (op_code_signal>="00010" and op_code_signal<="00111") or (op_code_signal>="10000" and op_code_signal<="10011") or op_code_signal="01010" or op_code_signal="01011" or (op_code_signal>="10100" and op_code_signal<="10110") or op_code_signal="11001" or op_code_signal="11010" or op_code_signal="11110" else
							'0';
						
		flags_rti_en <=		'1' when (op_code_signal>="00010" and op_code_signal<="00111") or (op_code_signal>="10000" and op_code_signal<="10011") or op_code_signal="01010" or op_code_signal="01011" or (op_code_signal>="10100" and op_code_signal<="10110") or op_code_signal="11001" or op_code_signal="11010" or op_code_signal="11110" else
							'0';
						
		--alu_control <=		"0000" when()   --musgi
		
		
		mem_mux <=			'1' when (op_code_signal>="01100" and op_code_signal<="01110") or (op_code_signal>="11000" and op_code_signal<="11010") or op_code_signal="11111" else
							'0';
						
		stack_plus <=		'1' when op_code_signal="01101" or (op_code_signal>="11001" and op_code_signal<="11011") else
							'0';
		stack_minus <=		'1' when op_code_signal="01100" or op_code_signal="11111" else
							'0';
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--enable_LoadStore<='1' when op_code_signal="11011"  or  op_code_signal= "11100"  or op_code_signal="11101";--el mafrood trgo zero b3d one cycle 

end arch_control_entity;