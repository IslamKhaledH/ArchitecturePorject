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
			reg_write : out std_logic; 
			mem_write : out std_logic; 
			write_data_reg_mux : out std_logic; 
			Shift_Mux : out std_logic;                   -- to know if make shift or not
			
			
			write_back_mux : out std_logic_vector(1 downto 0);
			int_flags_en : out std_logic;                  --  int to take flags from meomry to alu
			alu_control : out std_logic_vector(4 downto 0);                 --change it according to alu control (3 bit ****)علي حسب شغلك   'musgi'
			mem_mux : out std_logic;
			
			 Stack_WriteEnable_control, StackPushPop_control: out std_logic
			 -- FlagEnable : in std_logic;
			
			
			
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
					
		reg_write <=			'1' when (op_code_signal>="00001" and op_code_signal<="01001") or (op_code_signal>="10000" and op_code_signal<="10011") or op_code_signal="01101" or op_code_signal="01111" or op_code_signal="11011" or op_code_signal="11100" else
								'0';
						
						
		mem_write <=			'1' when op_code_signal="01100" or op_code_signal="11000" or op_code_signal="11101" or op_code_signal="11111" else
								'0';
						
		write_data_reg_mux <=	'1' when op_code_signal="01111" else
								'0';
		
		Shift_Mux <='1' when op_code_signal="01000" or op_code_signal="01001" else '0';
		
								
		
		
			
		write_back_mux <=		"01" when (op_code_signal>="01100" and op_code_signal<="01110") or op_code_signal="11100" else
								"10" when op_code_signal="11011" else
								"00";
							
		int_flags_en <=			'1' when (op_code_signal>="00010" and op_code_signal<="00111") or (op_code_signal>="10000" and op_code_signal<="10011") or op_code_signal="01010" or op_code_signal="01011" or (op_code_signal>="10100" and op_code_signal<="10110") or op_code_signal="11001" or op_code_signal="11010" or op_code_signal="11110" else
							'0';
						
						
		alu_control <=		"00000" when op_code="00000" else
							"00001" when op_code="00001" else
							"00010" when op_code="00010" else
							"00011" when op_code="00011"else
							"00100" when op_code="00100"else
							"00101" when op_code="00101"else
							"00111" when op_code="00111"else
							"01000" when op_code="01000"else
							"01001" when op_code="01001"else
							"01010" when op_code="01010"else
							"01011" when op_code="01011"else
							"01100" when op_code="01100"else
							"01101" when op_code="01101"else
							"01110" when op_code="01110"else
							"01111" when op_code="01111"else
							"10000" when op_code="10000"else
							"10001" when op_code="10001"else
							"10010" when op_code="10010"else
							"10011" when op_code="10011"else
							"10100" when op_code="10100"else
							"10101" when op_code="10101"else
							"10110" when op_code="10110"else
							"10111" when op_code="10111"else
							"11000" when op_code="11000"else
							"11001" when op_code="11001"else
							"11010" when op_code="11010"else
							"11011" when op_code="11011"else
							"11100" when op_code="11100"else
							"11101" when op_code="11101"else
							"11110" when op_code="11110"else
							"11111" when op_code="11111";
							
							
							
							
		
		
		mem_mux <=			'1' when (op_code_signal>="01100" and op_code_signal<="01110") or (op_code_signal>="11000" and op_code_signal<="11010") or op_code_signal="11111" else
							'0';
		
		Stack_WriteEnable_control <= 	'1' when op_code_signal="01100" or op_code_signal="01101"  or op_code_signal="11000" or op_code_signal="11001" or op_code_signal="11010" else
										'0';
		
		StackPushPop_control <= 	    '1' when   op_code_signal="01101"  or op_code_signal="11001" or op_code_signal="11010" else
										'0';
		
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--enable_LoadStore<='1' when op_code_signal="11011"  or  op_code_signal= "11100"  or op_code_signal="11101";--el mafrood trgo zero b3d one cycle 

end arch_control_entity;