
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity fetch_Buffer is 
	Generic ( n : integer := 16);
		port(
				Clk : in std_logic;
				Rst : in std_logic;
				
				
				inport_en_input : in std_logic_vector(15 downto 0); --
				instruction_input :in std_logic_vector(15 downto 0);
				
				inport_en_output : out std_logic_vector(15 downto 0); --
				instruction_output :out std_logic_vector(15 downto 0);
				
				OPcode: out std_logic_vector(4 downto 0 ); 
				R1: out std_logic_vector(2 downto 0 ); --addres of reg1
				R2: out std_logic_vector(2 downto 0 ); --addres of reg2
				Rout: out std_logic_vector(2 downto 0 ); --for write back
				R_shift: out std_logic_vector(3 downto 0 );
				LDD_Memory: out std_logic_vector(9 downto 0 ); --load value from memory to register
				LDM_immediate: out std_logic_vector(15 downto 0 ) ;--load immediate value from user to register
				
				
				
				
				
				pc_mux_input : in std_logic_vector(1 downto 0);
				--outport_en_input : in std_logic; 
				--reg_write_input : in std_logic; 
				--mem_write_input : in std_logic; 
				--write_data_reg_mux_input : in std_logic; 
				--Shift_Mux_input : in std_logic;                   -- to know if make shift or not
				--write_back_mux_input : in std_logic_vector(1 downto 0);
				--int_flags_en_input : in std_logic;                  --  int to take flags from meomry to alu
				--alu_control_input : in std_logic_vector(4 downto 0);                 --change it according to alu control (3 bit ****)??? ??? ????   'musgi'
				--mem_mux_input : in std_logic;
				
				
				pc_mux_output : out std_logic_vector(1 downto 0)
				--outport_en_output : out std_logic; 
				--reg_write_output : out std_logic; 
				--mem_write_output : out std_logic; 
				--write_data_reg_mux_output : out std_logic; 
				--Shift_Mux_output : out std_logic;                   -- to know if make shift or not
				--write_back_mux_output : out std_logic_vector(1 downto 0);
				--int_flags_en_output : out std_logic;                  --  int to take flags from meomry to alu
				--alu_control_output : out std_logic_vector(4 downto 0);                 --change it according to alu control (3 bit ****)??? ??? ????   'musgi'
				--mem_mux_output : out std_logic
				
				
				);
end fetch_Buffer;

architecture fetch_Buffer_arch of fetch_Buffer is
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
	
   
	signal LDD_Memory_signal :  std_logic_vector(9 downto 0 ); --load value from memory to register
	signal LDM_immediate_signal :  std_logic_vector(15 downto 0 ); --load value from memory to register

	signal OPcode_nop: std_logic_vector(4 downto 0 ); 
	
	signal en_signal_nop: std_logic;
	
	

	begin
	inport_en_output<=inport_en_input;
--call control unit
		
		
		process(clk) is
		begin
			if (rising_edge(clk)) and instruction_input(15 downto 11)="11011" then 
				OPcode_nop <= "00000";
				en_signal_nop <='1';
				LDM_immediate<=instruction_input(15 downto 0);
			elsif (rising_edge(clk) ) and ((instruction_input(15 downto 11))="11100" or instruction_input(15 downto 11)="11101") then
				OPcode_nop <= "00000";
				en_signal_nop <='1';--send to control unit
				LDD_Memory<=instruction_input(15 downto 6);
			
			elsif (rising_edge(clk)) then 
				en_signal_nop <='0';
				
				instruction_output<=instruction_input;
				OPcode<=instruction_input(15 downto 11);
				R1<=instruction_input(10 downto 8);
				R2<=instruction_input(7 downto 5);
				R_shift<=instruction_input(7 downto 4);
				Rout<=instruction_input(4 downto 2);
				
				
				pc_mux_output <= pc_mux_input;
				--outport_en_output <=outport_en_input;
				--reg_write_output <=reg_write_input;
				--mem_write_output <= mem_write_input; 
				--write_data_reg_mux_output <= write_data_reg_mux_input;
				--Shift_Mux_output <= Shift_Mux_input;
				--write_back_mux_output <= write_back_mux_input;
				--int_flags_en_output <= int_flags_en_input;               --  int to take flags from meomry to alu
				--alu_control_output <= alu_control_input;                --change it according to alu control (3 bit ****)??? ??? ????   'musgi'
				--mem_mux_output <= mem_mux_input;
			end if;

	end process;
		
		
end fetch_Buffer_arch;

