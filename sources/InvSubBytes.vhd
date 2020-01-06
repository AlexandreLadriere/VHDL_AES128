------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvSubBytes.vhd
-- Date of creation:		14/11/2018
-- Date of modification:	14/11/2018
-- Description:			Inversion of the SubBytes function
------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

-- declaration de l'entite InvSubBytes. Elle prend en entree une matrice 4x4 (128bits) et donne en sortit une matrice 4x4 (128bits)
entity InvSubBytes is
	port (
		invsubbytes_i : in type_state;
		invsubbytes_o : out type_state
	);
end entity InvSubBytes;


-- architecture de l'entite InvSubBytes
architecture InvSubBytes_arch of InvSubBytes is
	-- composants
	component InvSBox
		port (
			invsbox_i : in bit8;
			invsbox_o : out bit8
		);
	end component;
	
	begin
		ligne : for i in 0 to 3 generate -- "generate" car instanciation d'un tableau de 16 composants SBox
			colonne : for j in 0 to 3 generate
				matrice : InvSBox 
					port map(
						invsbox_i => invsubbytes_i(i)(j),
						invsbox_o => invsubbytes_o(i)(j)
					);
			end generate colonne;
		end generate ligne;
end InvSubBytes_arch;

-- configuration
configuration InvSubBytes_conf of InvSubBytes is
for InvSubBytes_arch
	for ligne
		for colonne
			for matrice : InvSBox
				use entity source.InvSBox(InvSBox_arch);
			end for;
		end for;
	end for;
end for;
end InvSubBytes_conf; 
					
