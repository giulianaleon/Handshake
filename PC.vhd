library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PC is

	generic(
		DATA_WIDTH 		:	natural := 8
	);

	port(
		clk						:  in std_logic;    
		reset						:	in std_logic;
		ReqLei					:	in std_logic;   
		ACKes						:	in std_logic;
		ACKmem					:	out std_logic;
		DadoPrt					:	out std_logic;
		EndBarramentoIN		:	out std_logic;   --ENDEREÇO DE ENTRADA
		EndBarramentoOUT		:	out std_logic    --DADO DE SAIDA 
	);
	
end entity;	

architecture RTL of PC is

	type estados is (s0,s1,s2,s3);
	signal state :	estados;
	
begin

	process (clk, reset)   
	begin
	
		if reset = '1' then     
			state <= s0;
			
			elsif (rising_edge(clk)) then     
			--else	                               
				case state is
					when s0 => 
						if ReqLei = '1' then
							state <= s1;
						else	
							state <= s0;
						end if;
					when s1 => 
						if ReqLei = '1' then
							state <= s1;
						else 
							state <= s2;
						end if;
					when s2 =>
						if ACKes = '1' then
							state <= s3;
						else	
							state <= s2;
						end if;
					when s3 =>
							state <= s0;
				end case;
			end if;
	end process;
	
	process (state)
	begin
	
		case state is 
			when s0 => 
				ACKmem <= '0';
				DadoPrt <= '0';
				EndBarramentoIN <= '0';
				EndBarramentoOUT <= '0';
			when s1 =>
				ACKmem <= '1';
				DadoPrt <= '0';
				EndBarramentoIN <= '1';
				EndBarramentoOUT <= '0';
			when s2 =>
				ACKmem <= '0';
				DadoPrt <= '1';
				EndBarramentoIN <= '0';
				EndBarramentoOUT <= '1';
			when s3 =>
				ACKmem <= '0';
				DadoPrt <= '0';
				EndBarramentoIN <= '0';
				EndBarramentoOUT <= '0';
		end case;
	end process;
end rtl;
