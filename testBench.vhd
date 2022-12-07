library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testBench is

end entity;

generic(
		DATA_WIDTH 		:	natural := 8
	);
	

architecture behaviour of testBench is
	signal clk_tb			: std_logic := '0';
	signal reset_tb		: std_logic := '0';
	signal ReqLei_tb 		: std_logic := '0';
	signal AckES_tb 		: std_logic := '0';
	signal endereco_tb   : std_logic_vector((DATA_WIDTH - 1) downto 0) := "00000011";    --Endereço 3 = 00000001
	signal dado_tb 		: std_logic_vector((DATA_WIDTH - 1) downto 0);
	signal AckMem_tb 		: std_logic := '0';
	signal DadoPrt_tb 	: std_logic := '0';

	
component topo is
	port(
			clk          : in std_logic;
			reset	     	 : in	std_logic;
			ReqLei      	: in  std_logic;
			AckES        : in  std_logic;
			AckMem       : out std_logic;
			DadoPrt      : out std_logic;
			endereco     : in std_logic_vector((DATA_WIDTH - 1) downto 0);
			dado 			 : out std_logic_vector((DATA_WIDTH - 1) downto 0)
	);
end component topo;


begin
---------------------------------------------------------
inst_topo: topo 
	port map( 
		clk 		=> clk_tb,
		reset 	=> reset_tb,
		ReqLei 	=> ReqLei_tb,
		AckES 	=> AckES_tb,
		endereco => endereco_tb,
		dado 		=> dado_tb,
		AckMem 	=> AckMem_tb,
		DadoPrt 	=> DadoPrt_tb
	);
	
	clk_tb <= not clk_tb after 30 ns;		
---------------------------------------------------------
process is
	begin
		wait for 0 ns;
		reset_tb <= '0';
		
		wait for 10 ns;
		ReqLei_tb <= '1';
		
		wait for 50 ns;
		ReqLei_tb <= '0';
		
		wait for 40 ns;
		AckES_tb <= '1';
		
		wait for 50 ns;
		AckES_tb <= '0';
		
		wait;

end process;

end behaviour;