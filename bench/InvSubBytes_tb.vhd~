------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvSubBytes.vhd
-- Date of creation:		14/11/2018
-- Date of modification:	14/11/2018
-- Description:			Test bench for th inversion of the SubBytes function
------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

-- entite vide
entity InvSubBytes_tb is
end entity InvSubBytes_tb;

architecture InvSubBytes_tb_arch of InvSubBytes_tb is

	component InvSubBytes
		port (
			invsubbytes_i : in type_state;
			invsubbytes_o : out type_state
		);
	end component;
	
	-- definition des signaux
	signal invsubbytes_is : type_state := ((x"06", x"09", x"99", x"5b"),(x"85", x"fb", x"c1", x"8e"),(x"a6", x"06", x"5f", x"56"),(x"61", x"54", x"ca", x"74")); -- input signal (matrice de 128 bits). Test avec la matrice donnee dans le sujet (On doit retrouver le resultat de AddRoundKey du round 0: (79 1b 66 62 47 8e b7 c8 8b 81 7c e4 65 aa 6f 03)
	signal invsubbytes_os : type_state; -- output signal (matrice de 128 bits)
	
	begin
	-- Device Under Test
	DUT : InvSubBytes
		port map (
			invsubbytes_i => invsubbytes_is,
			invsubbytes_o => invsubbytes_os
		);
		
	--P0 : process
	--begin
		--wait for 200 ns;
	--end process P0;
end architecture InvSubBytes_tb_arch;
		
-- configuration
configuration InvSubBytes_tb_conf of InvSubBytes_tb is
	for InvSubBytes_tb_arch
		for DUT : InvSubBytes
			use configuration source.InvSubBytes_conf;
		end for;
	end for;
end InvSubBytes_tb_conf;
	
