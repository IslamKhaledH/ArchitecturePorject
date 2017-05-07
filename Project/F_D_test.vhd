library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Ext_Mem_Buffer is 
	Generic ( n : integer := 16);
		port(
				Clk : in std_logic;
				Rst : in std_logic;
				enable : in std_logic;
				
				inport_en_input : in std_logic_vector(15 downto 0); --??????????????
				
				instruction_input :in std_logic_vector(15 downto 0);
				
				
				
				inport_en_output : out std_logic_vector(15 downto 0); --??????????????
				
				instruction_output :out std_logic_vector(15 downto 0);
				
				
				
				--OPcode: out std_logic_vector(4 downto 0 ); 
				--R1: out std_logic_vector(2 downto 0 ); --addres of reg1
				--R2: out std_logic_vector(2 downto 0 ); --addres of reg2
				--Rout: out std_logic_vector(2 downto 0 ); --for write back
				--LDD_Memory: out std_logic_vector(9 downto 0 ); --load value from memory to register
				--LDM_immediate: out std_logic_vector(15 downto 0 ); --load immediate value from user to register
				--input_port : in std_logic_vector(15 downto 0 )
				
				
				);
end Ext_Mem_Buffer;

architecture arch_Ext_Mem_Buffer of Ext_Mem_Buffer is
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
	
   
	signal input_port_signal : std_logic_vector(15 downto 0);
	signal LDD_Memory_signal :  std_logic_vector(9 downto 0 ); --load value from memory to register
	signal LDM_immediate_signal :  std_logic_vector(15 downto 0 ); --load value from memory to register
	signal LDD_Memory_signal_output :  std_logic_vector(9 downto 0 ); --load value from memory to register
	signal LDM_immediate_signal_output :  std_logic_vector(15 downto 0 ); --load value from memory to register
	signal OPcode: std_logic_vector(4 downto 0 ); 
	signal OPcode_nop: std_logic_vector(4 downto 0 ); 
	signal R1: std_logic_vector(2 downto 0 ); --addres of reg1
	signal R2:  std_logic_vector(2 downto 0 ); --addres of reg2
	signal Rout: std_logic_vector(2 downto 0 ); --for write back
	signal en_signal: std_logic;
	signal en_signal_nop: std_logic;
	
	

	begin
	
		
				
		
		

		inport_en_map :	 nreg generic map (n=>16)port map(Clk,Rst,en_signal,inport_en_input,inport_en_output);
		--instruction_map :	nreg generic map (n=>16)port map(Clk,Rst,en_signal,instruction_input,instruction_output);
		
		op_code_map :	nreg generic map (n=>5)port map(Clk,Rst,en_signal,instruction_input(15 downto 11),OPcode);
		R1_map :	nreg generic map (n=>3)port map(Clk,Rst,en_signal,instruction_input(10 downto 8),R1);
		R2_map :	nreg generic map (n=>3)port map(Clk,Rst,en_signal,instruction_input(7 downto 5),R2);
		Rout_map :	nreg generic map (n=>3)port map(Clk,Rst,en_signal,instruction_input(4 downto 2),Rout);
		
		LDM_map :	nreg generic map (n=>16)port map(Clk,Rst,en_signal,LDM_immediate_signal,LDM_immediate_signal_output);
		LDD_map :	nreg generic map (n=>10)port map(Clk,Rst,en_signal,LDD_Memory_signal,LDD_Memory_signal_output);
		
		
		
---------for LDM   LDD   and store
		op_code_map :	nreg generic map (n=>5)port map(Clk,Rst,en_signal_nop,"00000",OPcode);

		
		
		process(clk) is
		begin
			if (rising_edge(clk) or falling_edge(clk)) and instruction_input(15 downto 11)="11011" then
				OPcode_nop <= "00000";
				en_signal <='0';
				en_signal_nop <='1';
				LDM_immediate_signal<=instruction_input(15 downto 0);
			elsif (rising_edge(clk) or falling_edge(clk)) and (instruction_input(15 downto 11)>="11100" and instruction_input(15 downto 11)<="11101") then
				OPcode_nop <= "00000";
				en_signal <='0';
				en_signal_nop <='1';
				LDD_Memory_signal<=instruction_input(15 downto 6);
			else
				en_signal <='1';
				en_signal_nop <='0';
			end if;

	end process;
		
		
		

		

end arch_Ext_Mem_Buffer;
