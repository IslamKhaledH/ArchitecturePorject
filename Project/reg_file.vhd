Library ieee;
Use ieee.std_logic_1164.all;

Entity REG is
	Generic ( n : integer := 16);
		port( 
				Clk,Rst : in std_logic;
				d : in std_logic_vector(n-1 downto 0);
				q : out std_logic_vector(n-1 downto 0);
				port1_data, port2_data : out std_logic_vector(16 downto 0);
				w_en : in std_logic ;
				w_sel,port1_sel,port2_sel : in std_logic_vector(2 downto 0);
				
				input_port : in std_logic_vector(15 downto 0);
				wrt_data_reg_mux : in std_logic;
				
				stack_en : in std_logic_vector(1 downto 0);
				stack_plus : in std_logic;
				stack_minus : in std_logic;
				stack_counter : in std_logic_vector(9 downto 0);
				
				load_value_15_0 : in std_logic_vector(15 downto 0)
				
			);
end REG;

Architecture REG_arc of REG is
	Component nreg is
		port( 
				Clk,Rst : in std_logic;
				d : in std_logic_vector(n-1 downto 0);
				q : out std_logic_vector(n-1 downto 0)
			
				
		
			);	
	end component;
	
	signal d1,d2,d3,d4,d5,d6,d7,d8 : std_logic_vector(15 downto 0);
	signal q1,q2,q3,q4,q5,q6,q7,q8 : std_logic_vector(15 downto 0);
	signal stack_en_signa1,stack_plus_signal,stack_minus_signal,e4 : std_logic_vector(7 downto 0);
	
	
begin
		R1: nreg port map (clk, RST, d1,q1);
		R2: nreg port map (clk, RST, d2,q2);
		R3: nreg port map (clk, RST, d3,q3);
		R4: nreg port map (clk, RST, d4,q4);
		R5: nreg port map (clk, RST, d5,q5);
		R6: nreg port map (clk, RST, d6,q6);
		--R7: nreg port map (clk, RST, d7,q7);
		
		
		
Process(Clk,Rst,w_en,w_sel,Port1_sel,Port2_sel,d)
begin
				if Rst = '1' then
					d1 <= (others=>'0'); 
					d2 <= (others=>'0'); 
					d3 <= (others=>'0'); 
					d4 <= (others=>'0');
					d5 <= (others=>'0');
					d6 <= (others=>'0');
					d7 <= (others=>'0');
					d8 <= (others=>'0');
					
					
					
				end if;

				if w_en = '1' then
					if wrt_data_reg_mux ='0' then
						if w_sel = "000" then
							d1 <= d;
						elsif w_sel = "001" then
							d2 <= d;
						elsif w_sel = "010" then
							d3 <= d;
						elsif w_sel = "011" then
							d4 <= d;
						elsif w_sel = "100" then
							d5 <=d;
						elsif w_sel = "101"then
							d6 <=d;
						--elsif w_sel= "110" then
							--d7 <=d;
						end if;
					elsif wrt_data_reg_mux ='1' then 
						if w_sel = "000" then
							d1 <= input_port;
						elsif w_sel = "001" then
							d2 <= input_port;
						elsif w_sel = "010" then
							d3 <= input_port;
						elsif w_sel = "011" then
							d4 <= input_port;
						elseif w_sel = "100" then
							d5 <= input_port;
						elsif w_sel = "101"then
							d6 <= input_port;
						--elsif w_sel= "110" then
							--d7 <=input_port;
						end if;
						
						
						
					--elsif stack_en='01' then
						--	d7 <= d;
							
					
				--	elsif stack_en='10' then
					--		 <= d7;
							
							
					end if;
				end if;

				if Port1_sel = "000" then Port1_data <= q1;
				elsif Port1_sel = "001" then Port1_data <= q2;
				elsif Port1_sel = "010" then Port1_data <= q3;
				elsif Port1_sel = "011" then Port1_data <= q4;
				elsif Port1_sel = "100" then Port1_data <= q5;
				elsif Port1_sel = "101" then Port1_data <= q6;
				--elsif Port1_sel = "110" then Port1_data <= q7;
				
				end if;

				if Port2_sel = "000" then Port2_data <= q1;
				elsif Port2_sel = "001" then Port2_data <= q2;
				elsif Port2_sel = "010" then Port2_data <= q3;
				elsif Port2_sel = "011" then Port2_data <=q4 ;
				elsif Port1_sel = "100" then Port1_data <= q5;
				elsif Port1_sel = "101" then Port1_data <= q6;
				--elsif Port1_sel = "110" then Port1_data <= q7;
				
				
				end if;
	end process;
			
	

	
end REG_arc;
