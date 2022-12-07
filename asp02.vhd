--A memória foi feita utilizando um array de 16 posições, cada posição 
--contém um vetor de standard logic de 8 bits.

--O valor de cada palavra foi setado manualmente, sendo os mesmos aleatórios.

--Assim, foi criado um generic que contém os DATA WIDHT que seriam utilizados.

--Nas portas têm o endereço do dado (posição no vetor) e o próprio valor do dado.

--Assim, ao final, o dado recebe o valor que estava no array, por exemplo, foi pedido
-- o endereço 14, o dado recebe o valor "10010010".

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity asp02 is

	generic(
		DATA_WIDTH 		:	natural := 8;
		DATA_WIDTH_16	:	natural := 16
	);

	port(
		endereco	:	in std_logic_vector((DATA_WIDTH - 1) downto 0);
		dado 		:	out std_logic_vector((DATA_WIDTH - 1) downto 0)
	);
	
end entity;
			
architecture behaviour of asp02 is

	type rang_mem_array is array (integer range 0 to (DATA_WIDTH_16 - 1)) of std_logic_vector((DATA_WIDTH - 1) downto 0);
	signal rang_mem	:	rang_mem_array;

begin
	rang_mem (0)  <=	"11111111"; 
	rang_mem (1)  <=	"00100000";  
	rang_mem (2)  <=	"01000100"; 
	rang_mem (3)  <=	"00000001";   
	rang_mem (4)  <=	"00110000";  
	rang_mem (5)  <=	"00100001";   
	rang_mem (6)  <=	"00000010";   
	rang_mem (7)  <=	"10000000";  
	rang_mem (8)  <=	"00000100";   
	rang_mem (9)  <=	"10000001";   
	rang_mem (10) <=	"00101000";  
	rang_mem (11) <=	"00010001"; 
	rang_mem (12) <=	"01001001";  
	rang_mem (13) <=	"01010100";   
	rang_mem (14) <=	"10010010";   
	rang_mem (15) <=	"00010100"; 
	
	dado <= rang_mem(conv_integer(endereco));  
			
end behaviour;