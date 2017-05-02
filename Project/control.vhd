Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity control_entity is
  port (
			op_code: in std_logic_vector(4 downto 0);
			pc_mux : out std_logic_vector(1 downto 0);
			pc_en : out std_logic; 
			inport_en : out std_logic; 
			outport_en : out std_logic; 
			reg_read : out std_logic; 
			reg_write : out std_logic; 
			mem_read : out std_logic; 
			mem_write : out std_logic; 
			write_data_reg_mux : out std_logic; 
			r1_load_mux : out std_logic;                 --deleted from desgin
			r2_shift_mux : out std_logic;
			r1_forward_mux : out std_logic;               --always 0 be 1 if only make forward so take signal from forward to mux to make it 1 
			r2_forward_mux : out std_logic; 				--always 0 be 1 if only make forward so take signal from forward to mux to make it 1 
			write_reg_mux : out std_logic;  
			write_back_mux : out std_logic_vector(1 downto 0);
			flags_en : out std_logic; 
			flags_rti_en : out std_logic; 
			alu_control : out std_logic;                 --change it according to alu control (3 bit ****)علي حسب شغلك   'musgi'
			mem_mux : out std_logic;  
			stack_plus : out std_logic;  
			stack_minus : out std_logic;  
			stack_en : out std_logic_vector(1 downto 0);
			
			n : in std_logic 
  );
end  control_entity;



Architecture arch_control_entity of control_entity is
	Begin
		
		
		pc_mux <=				"01" when op_code="10100" or  op_code="10101" or op_code="10110" or op_code="11000" or op_code="11001" or op_code="11010" or op_code="01100" or op_code="01101" else
								"10" when op_code="11110" else
								"11" when op_code="11111" else
								"00";
		
		
		inport_en <=			'1' when op_code="01111" else
								'0';
						
		outport_en <=			'1' when op_code="01110" else
								'0';
						
		reg_read <=				'1' when (op_code>="00001" and op_code<="01001") or (op_code>="10000" and op_code<="10011") or op_code="01100" or op_code="01110" or (op_code>="10100" and op_code<="11000") or op_code="11101" or op_code="11111" else
								'0';
					
		reg_write <=			'1' when (op_code>="00001" and op_code<="01001") or (op_code>="10000" and op_code<="10011") or op_code="01101" or op_code="01111" or op_code="11011" or op_code="11100" else
								'0';
						
		mem_read <=				'1' when op_code="01101" or op_code="11001" or op_code="11010" or op_code="11100" or op_code="11110" or op_code="11111" else
								'0';
						
		mem_write <=			'1' when op_code="01100" or op_code="11000" or op_code="11101" or op_code="11111" else
								'0';
						
		write_data_reg_mux <=	'1' when op_code="01111" else
								'0';
		
		r2_shift_mux <=			'1' when op_code="01000" or op_code="01001" else
								'0';
						
		r1_forward_mux <=		'0';
		
		r2_forward_mux <=		'0';
		
		write_reg_mux <=		'1' when op_code="00110" or op_code="00111" or (op_code>="01100" and op_code<="11000") or (op_code>="11011" and op_code<="11101") or op_code="11111" else
								'0';
			
		write_back_mux <=		"01" when (op_code>="01100" and op_code<="01110") or op_code="11100" else
								"10" when op_code="11011" else
								"00";
							
		flags_en <=			'1' when (op_code>="00010" and op_code<="00111") or (op_code>="10000" and op_code<="10011") or op_code="01010" or op_code="01011" or (op_code>="10100" and op_code<="10110") or op_code="11001" or op_code="11010" or op_code="11110" else
							'0';
						
		flags_rti_en <=		'1' when (op_code>="00010" and op_code<="00111") or (op_code>="10000" and op_code<="10011") or op_code="01010" or op_code="01011" or (op_code>="10100" and op_code<="10110") or op_code="11001" or op_code="11010" or op_code="11110" else
							'0';
						
		--alu_control <=		"0000" when()   --musgi
		
		
		mem_mux <=			'1' when (op_code>="01100" and op_code<="01110") or (op_code>="11000" and op_code<="11010") or op_code="11111" else
							'0';
						
		stack_plus <=		'1' when op_code="01101" or (op_code>="11001" and op_code<="11011") else
							'0';
		stack_minus <=		'1' when op_code="01100" or op_code="11111" else
							'0';
							
end arch_control_entity;