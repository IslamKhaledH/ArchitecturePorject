Library ieee;
Use ieee.std_logic_1164.all;

Entity REG is
	Generic ( n : integer := 16);
		port( 
				Clock,Reset: in std_logic;
				d : in std_logic_vector(n-1 downto 0);
				R1_Out, R2_Out : out std_logic_vector(15 downto 0);
				w_en : in std_logic ;--write enable
				Rout,R1,R2 : in std_logic_vector(2 downto 0);--
				
				input_port : in std_logic_vector(15 downto 0);
				wrt_data_reg_mux : in std_logic;
				
				--------------------------------------------------------
				Shift_Mux : in std_logic;--control unit
				OPcode_in: in std_logic_vector(4 downto 0 );
				OPcode_out: out std_logic_vector(4 downto 0 )
				);
end REG;

Architecture REG_arc of REG is


	component my_nDFF is
Generic ( n : integer := 16);
port( Clk,Rst : in std_logic; 
d : in std_logic_vector(n-1 downto 0);
q : out std_logic_vector(n-1 downto 0);
enable:in std_logic
);
	end component;
	
	signal d1,d2,d3,d4,d5,d6 : std_logic_vector(15 downto 0);
	signal q1,q2,q3,q4,q5,q6: std_logic_vector(15 downto 0);
	
	
begin
		R11: my_nDFF generic map (n=>16)port map(Clock,Reset,d1,q1,'1');
		R21: my_nDFF generic map (n=>16)port map(Clock,Reset,d2,q2,'1');
		R31: my_nDFF generic map (n=>16)port map(Clock,Reset,d3,q3,'1');
		R41: my_nDFF generic map (n=>16)port map(Clock,Reset,d4,q4,'1');
		R51: my_nDFF generic map (n=>16)port map(Clock,Reset,d5,q5,'1');
		R61: my_nDFF generic map (n=>16)port map(Clock,Reset,d6,q6,'1');
		
		
		
--WRITE BACK CLOCK NOT HANDELED		
		
Process(Clock,Reset,w_en,Rout,R1,R2,d,wrt_data_reg_mux,Shift_Mux,input_port,OPcode_in)
begin
	
				if Reset = '1' then
					d1 <= (others=>'0'); 
					d2 <= (others=>'0'); 
					d3 <= (others=>'0'); 
					d4 <= (others=>'0');
					d5 <= (others=>'0');
					d6 <= (others=>'0');
	
				elsif  Reset = '0' then

				if 	Clock='1' then 
				OPcode_out<=OPcode_in;

					if w_en = '1' then
							if wrt_data_reg_mux ='0' then
										if Shift_Mux = '0' then 
												if Rout = "000" then
													d1 <= d;
												elsif Rout = "001" then
													d2 <= d;
												elsif Rout = "010" then
													d3 <= d;
												elsif Rout = "011" then
													d4 <= d;
												elsif Rout = "100" then
													d5 <=d;
												elsif Rout = "101"then
													d6 <=d;
												end if;
									
										elsif Shift_Mux='1' then
												if R1 = "000" then
														d1 <= d;
													elsif R1 = "001" then
														d2 <= d;
													elsif R1 = "010" then
														d3 <= d;
													elsif R1 = "011" then
														d4 <= d;
													elsif R1 = "100" then
														d5 <=d;
													elsif R1 = "101"then
														d6 <=d;
													end if;
										end if;
			
							elsif wrt_data_reg_mux ='1' then 
								if Rout = "000" then
									d1 <= input_port;
								elsif Rout = "001" then
									d2 <= input_port;
								elsif Rout = "010" then
									d3 <= input_port;
								elsif Rout = "011" then
									d4 <= input_port;
								elsif Rout = "100" then
									d5 <= input_port;
								elsif Rout = "101"then
									d6 <= input_port;
								end if;	
							end if;
					end if;
				elsif Clock='0' then

							if R1 = "000" then R1_Out <= q1;
							elsif R1 = "001" then R1_Out <= q2;
							elsif R1 = "010" then R1_Out <= q3;
							elsif R1 = "011" then R1_Out <= q4;
							elsif R1 = "100" then R1_Out <= q5;
							elsif R1 = "101" then R1_Out <= q6;
							
							
							end if;

							if R2 = "000" then R2_Out <= q1;
							elsif R2 = "001" then R2_Out <= q2;
							elsif R2 = "010" then R2_Out <= q3;
							elsif R2 = "011" then R2_Out <=q4 ;
							elsif R2 = "100" then R2_Out <= q5;
							elsif R2 = "101" then R2_Out <= q6;
					
						    end if;
			
                end if;
				end if;
	end process;
			
	

	
end REG_arc;



