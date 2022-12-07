--Topo feito

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity topo is

	generic(
		DATA_WIDTH 		:	natural := 8
	);
	
	port (
		clk		:	in std_logic;
		reset		:	in std_logic;
		ReqLei	:	in std_logic;
		ACKes		:	in std_logic;
		ACKmem	: 	out std_logic;
		DadoPrt	: 	out std_logic;
		endereco	:	in std_logic_vector((DATA_WIDTH - 1) downto 0);
		dado		:	out std_logic_vector((DATA_WIDTH - 1) downto 0)
	);
	
end entity;

architecture behaviour of topo is

signal reg_Endereco 				: 	std_logic_vector((DATA_WIDTH - 1) downto 0);
signal reg_Dado 					: 	std_logic_vector((DATA_WIDTH - 1) downto 0);
signal EndBarramentoIN 			: 	std_logic;   --endereço de entrada
signal EndBarramentoOUT			: 	std_logic;   --dado de saida

component asp02 is 
	port(
		endereco	:	in std_logic_vector((DATA_WIDTH - 1) downto 0);
		dado		:	out std_logic_vector((DATA_WIDTH - 1) downto 0) 
	);
end component asp02;

component PC is
	port(
		clk						:  in std_logic;
		reset						:	in std_logic;
		ReqLei					:	in std_logic;
		ACKes						:	in std_logic;
		ACKmem					:	out std_logic;
		DadoPrt					:	out std_logic;
		EndBarramentoIN		:	out std_logic;
		EndBarramentoOUT		:	out std_logic --Dado de saida 
	);
end component PC;

begin

	process(clk) is
	begin
		if (rising_edge(clk)) then	
			if (EndBarramentoIN = '1') then       --Se barramento de entrada ativo (endereço de entrada)
				reg_Endereco <= endereco;          --Registrador de endereço recebe o endereço
			end if;
			
			if (EndBarramentoOUT = '1') then      --Se barramento de saida ativo (dado de saida)
				dado <= reg_Dado;                  -- Dado recebe o valor que está no registrador de dado
			end if;
		end if;
	end process;

inst_PC: PC
	port map(
		clk 					=> clk,
		reset 				=> reset,
		ReqLei 				=> ReqLei,
		ACKes 				=> ACKes,
		ACKmem 				=> ACKmem,
		DadoPrt 				=> DadoPrt,
		EndBarramentoIN 	=> EndBarramentoIN,
		EndBarramentoOUT 	=> EndBarramentoOUT
	);
	
inst_asp02: asp02
	port map(
		endereco => Reg_Endereco,
		dado => Reg_Dado
	);
	
end behaviour;	
	