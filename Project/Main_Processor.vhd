library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Main_Processor is 
		port(
				CLK : in std_logic;
				RESET,enable : in std_logic;
				INPORT : in std_logic_vector(15 downto 0) --
				
				
				
				);
end Main_Processor;

architecture Main_Processor_arch of Main_Processor is
--------------------------------------------------------------------------------------------------------

	component MUX_Fetch is
		port( 
	Sel: in std_logic_vector (1 downto 0);--input from control unit
			
	PC2: in std_logic_vector(15 downto 0 ); --address to jump to from BRANCH
	PC3: in std_logic_vector(15 downto 0 ); --address from memory[0]
	PC4: in std_logic_vector(15 downto 0 ); --address from memory[1]
	CLK: in std_logic;
	Out_instruction: out std_logic_vector(15 downto 0 );
	InPort: in std_logic_vector(15 downto 0);
	OutPort: out std_logic_vector(15 downto 0);
	RESET: in std_logic
			);
	end component;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	component fetch_Buffer is
	Generic ( n : integer := 16);
		port ( 
				Clk : in std_logic;
				Rst : in std_logic;
				--enable : in std_logic;
				
				inport_en_input : in std_logic_vector(15 downto 0); --??????????????	
				instruction_input :in std_logic_vector(15 downto 0);
				
				inport_en_output : out std_logic_vector(15 downto 0); --??????????????
				instruction_output :out std_logic_vector(15 downto 0);
				
				OPcode: out std_logic_vector(4 downto 0 ); 
				R1: out std_logic_vector(2 downto 0 ); --addres of reg1
				R2: out std_logic_vector(2 downto 0 ); --addres of reg2
				Rout: out std_logic_vector(2 downto 0 ); --for write back
				R_shift: out std_logic_vector(3 downto 0 );
				LDD_Memory: out std_logic_vector(9 downto 0 ); --load value from memory to register
				LDM_immediate: out std_logic_vector(15 downto 0 ) 
			);
		end component;
		
------------------------------------------------------------------------------------------------------------------------------------
		component Execution IS
			port(
				Clk,Rst,enable : in std_logic;
				OpCode : in  std_logic_vector(4 downto 0);
				R1_Reg1,R2_Reg1,ROut_Alu1,ROut_Mem1: in std_logic_vector(2 downto 0);
				--R1_address,R2_address: in std_logic_vector(2 downto 0);
				R1_dec: in  std_logic_vector(15 downto 0);
				R2_dec: in  std_logic_vector(15 downto 0);
				n : in std_logic_vector (3 downto 0);
				--R1_Reg,R2_Reg,ROut_Alu,ROut_Mem: in std_logic_vector(2 downto 0);
				Alu_Output1 , Meomry_Output1: in std_logic_vector(15 downto 0);
				
				Execution_Output: out std_logic_vector(15 downto 0);
				--WriteBackSignal : in std_logic;
				Z_F: out std_logic;
				NF_F: out std_logic;
				V_F: out std_logic;
				C_F: out std_logic
			);
		end component;
		
		
		
------------------------------------------------------------------------------------------------------------------------------------	
		component ALU is
			  port (
				Clk,Rst,enable : in std_logic;
				OpCode : in  std_logic_vector(4 downto 0);
				R1: in  std_logic_vector(15 downto 0);
				R2: in  std_logic_vector(15 downto 0);
				Output: out std_logic_vector(15 downto 0);
				n : in std_logic_vector (3 downto 0);
				Z_F: out std_logic;
				NF_F: out std_logic;
				v_F: out std_logic;
				C_F: out std_logic
				);
		end  component;

---------------------------------------------------------------------------------------------------------------------------

		component Forwarding IS
			port(
				R1_Reg,R2_Reg,ROut_Alu,ROut_Mem: in std_logic_vector(2 downto 0);
				R1,R2: out std_logic_vector(15 downto 0);    --out to handle hazard
				R1_Mux,R2_Mux : out std_logic;               --out of mux
				Alu_Output , Meomry_Output: in std_logic_vector(15 downto 0)
				--WriteBackSignal : in std_logic
				);
		end component;
		
		
		
----------------------------------------------------------------------------------------------------------------------------		
		
component Decode_Buffer is 
	
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
end component;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
component REG is
Generic ( n : integer := 16);
		port( 
				Clock,Reset : in std_logic;
				d : in std_logic_vector(n-1 downto 0);
				R1_Out, R2_Out : out std_logic_vector(15 downto 0);
				w_en : in std_logic ;--write enable
				Rout,R1,R2 : in std_logic_vector(2 downto 0);--
				
				input_port : in std_logic_vector(15 downto 0);
				wrt_data_reg_mux : in std_logic;
				
				--------------------------------------------------------
				Shift_Mux : in std_logic;
	OPcode_in: in std_logic_vector(4 downto 0 );
							OPcode_out: out std_logic_vector(4 downto 0 )
			);
	end component;
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Fetch signals
	signal Sel_signal:  std_logic_vector (1 downto 0);
	signal PC2_signal:  std_logic_vector(15 downto 0 );
	signal PC3_signal:  std_logic_vector(15 downto 0 ); 
	signal PC4_signal:  std_logic_vector(15 downto 0 ); 
	signal Out_instruction_signal:  std_logic_vector(15 downto 0 );
	signal OutPort_signal:  std_logic_vector(15 downto 0);
--fetch_Buffer signals
	signal instruction_output_signal:  std_logic_vector(15 downto 0 );
	signal inport_en_output_signal:std_logic_vector(15 downto 0 );
	signal	OPcode_signal:  std_logic_vector(4 downto 0 ); 
	signal	R1_signal: std_logic_vector(2 downto 0 ); --addres of reg1
	signal	R2_signal:  std_logic_vector(2 downto 0 ); --addres of reg2
	signal	Rout_signal:  std_logic_vector(2 downto 0 ); --for write back
	signal R_shift_signal: std_logic_vector(3 downto 0 );
	signal	LDD_Memory_signal:  std_logic_vector(9 downto 0 ); --load value from memory to register
	signal	LDM_immediate_signal:  std_logic_vector(15 downto 0 );

--Decoder signals
	signal R1_Out_signal, R2_Out_signal :  std_logic_vector(15 downto 0);
	signal write_enable :  std_logic;
	signal datavsinport :  std_logic;
	signal	Shift_Mux :  std_logic;
	signal OPcode_signal1:  std_logic_vector(4 downto 0 );

--decode Buffer signals
	signal R1_out_signal1 : std_logic_vector(15 downto 0 ); 
	signal	R2_out_signal1 : std_logic_vector(15 downto 0 ); 
	signal	Rout_out_signal1 :  std_logic_vector(2 downto 0 ); 
	signal R_shift_out_signal:  std_logic_vector(3 downto 0 ); 
	signal OPcode_signal2:  std_logic_vector(4 downto 0 );
	signal R1_signal2:  std_logic_vector(2 downto 0 ); 
	signal R2_signal2:  std_logic_vector(2 downto 0 ); 
	signal ROut_Alu_signal:  std_logic_vector(2 downto 0 );   --R_out_ALu address
	signal ROut_Mem_signal:  std_logic_vector(2 downto 0 );    --R_out_Mem addres
	

--Execution signals 
	signal Output_signal: std_logic_vector(15 downto 0);
	signal Z_signal:  std_logic;
	signal NF_signal:  std_logic;
	signal v_signal:  std_logic;
	signal C_signal: std_logic;
	signal Execution_Output_signal : std_logic_vector(15 downto 0);
	signal Meomrey_Output_signal : std_logic_vector(15 downto 0);

	begin
	

		
--Comments :1)sel should be entered by control unit
			--2)what reset do ?
	FETCH :	 MUX_Fetch generic map (n=>16)port map(Sel_signal,PC2_signal,PC3_signal,PC4_signal,CLK,Out_instruction_signal,INPORT,OutPort_signal,RESET);
	BUFFER1: fetch_Buffer generic map (n =>16) port map (CLK,RESET,OutPort_signal,Out_instruction_signal,inport_en_output_signal,instruction_output_signal,OPcode_signal,R1_signal,R2_signal,Rout_signal,R_shift_signal,LDD_Memory_signal,LDM_immediate_signal);
	Decoder: REG generic map (n=>16)port map(CLK,RESET,"1111000011110000",R1_Out_signal,R2_Out_signal,write_enable,Rout_signal,R1_signal,R2_signal,inport_en_output_signal,datavsinport,Shift_Mux,OPcode_signal,OPcode_signal1);
	Buffer2 : Decode_Buffer port map(CLK,RESET,R1_Out_signal,R2_Out_signal,Rout_signal,R1_out_signal1,R2_out_signal1,Rout_out_signal1,R_shift_signal,R_shift_out_signal,OPcode_signal1,OPcode_signal2,R1_signal,R2_signal,R1_signal2,R2_signal2);	
	--ALU1: ALU port map(CLK,RESET,'1',OPcode_signal2,R1_out_signal1,R2_out_signal1,Output_signal, R_shift_out_signal,ZF_signal,N_signal,v_signal,C_signal);	
	Execute : Execution port map(CLK,RESET,enable,OPcode_signal2,R1_signal2,R2_signal2,ROut_Alu_signal,ROut_Mem_signal,R1_out_signal1,R2_Out_signal,R_shift_out_signal,Execution_Output_signal,Meomrey_Output_signal,Execution_Output_signal,Z_signal,NF_signal,v_signal,C_signal);
	
	--  Buffer3:
--  Memory:
--	Buffer4:
--  WB:
end Main_Processor_arch;

