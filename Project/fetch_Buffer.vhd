
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
				LDM_immediate: out std_logic_vector(15 downto 0 ) --load immediate value from user to register
			
				
				
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
			end if;

	end process;
		
		
end fetch_Buffer_arch;
