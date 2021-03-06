Library ieee;
Use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

ENTITY Execution IS
port(
		Clk,Rst,enable : in std_logic;
		OpCode : in  std_logic_vector(4 downto 0);
		R1_Reg1,R2_Reg1,ROut_Alu1,ROut_Mem1: in std_logic_vector(2 downto 0);
		
		R1_dec: in  std_logic_vector(15 downto 0);
		R2_dec: in  std_logic_vector(15 downto 0);
		n : in std_logic_vector (3 downto 0);
		
		Alu_Output_exe , Meomry_Output_exe: in std_logic_vector(15 downto 0);
		
		Execution_Output: out std_logic_vector(15 downto 0);
		
		Z_F: out std_logic;
		NF_F: out std_logic;
		V_F: out std_logic;
		C_F: out std_logic
	);
END Execution;

Architecture archi of Execution is
	component ALU is
	  port (
		Clk,Rst,enable : in std_logic;
		OpCode : in  std_logic_vector(4 downto 0);
		R1: in  std_logic_vector(15 downto 0);
		R2: in  std_logic_vector(15 downto 0);
		Output: out std_logic_vector(15 downto 0);
		n : in std_logic_vector (3 downto 0);
		Z: out std_logic;
		NF: out std_logic;
		v: out std_logic;
		C: out std_logic
		);
	end  component;



	component Forwarding IS
	port(
			R1_Reg,R2_Reg,ROut_Alu,ROut_Mem: in std_logic_vector(2 downto 0);
			R1,R2: out std_logic_vector(15 downto 0);
			R1_Mux,R2_Mux : out std_logic;
			Alu_Output , Meomry_Output: in std_logic_vector(15 downto 0)
			--Alu_Output1 , Meomry_Output1: out std_logic_vector(15 downto 0);
			--WriteBackSignal : in std_logic
		
		);
	END component;

	signal R1_Forward_out_signal,R2_Forward_out_signal : std_logic_vector(15 downto 0);
	signal R1_signal,R2_signal : std_logic_vector(15 downto 0);
	
	signal R1_Mux_signal,R2_Mux_signal : std_logic; 
	signal Execution_Output_signal : std_logic_vector(15 downto 0);  --ALU output
	signal Z_signal,NF_signal,V_signal,C_signal : std_logic;   --flags
	begin

		forward_map: Forwarding port map(R1_Reg1,R2_Reg1,ROut_Alu1,ROut_Mem1,R1_Forward_out_signal,R2_Forward_out_signal,R1_Mux_signal,R2_Mux_signal,Alu_Output_exe , Meomry_Output_exe);
		Alu_map: ALU port map(Clk,Rst,enable,OpCode,R1_signal,R2_signal,Execution_Output_signal,n, Z_signal,NF_signal,V_signal,C_signal);


		R1_signal <= 	R1_Forward_out_signal when R1_Mux_signal = '1' else
						R1_dec when R1_Mux_signal = '0';
			  

		R2_signal <= 	R2_Forward_out_signal when R2_Mux_signal = '1' else
						R2_dec when R2_Mux_signal = '0';
				

		Execution_Output <= Execution_Output_signal;
		Z_F <= Z_signal;
		NF_F <= NF_signal;
		V_F <= V_signal;
		C_F <= C_signal;


end archi; 