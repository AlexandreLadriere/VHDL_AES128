------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvAddRoundKey.vhd
-- Date of creation:		19/11/2018
-- Date of modification:	19/11/2018
-- Description:			Inversion of the AddRoundKey function
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;
use source.all;

-- Declaration de l'entite InvAddRoundKey qui prend en entree une matrice 4x4 de bit8 de donnee et une matrice 4x4 de bit8 correspondant à la sous-clef, et qui donne en sortie une matrice du même type.
entity InvAddRoundKey is 
	port (
		invaddroundkey_i : in type_state; --matrice d'entree
		key_i : in type_state; --matrice clef
		invaddroundkey_o : out type_state --matrice de sortie
	);
end entity InvAddRoundKey;

architecture InvAddRoundKey_arch of InvAddRoundKey is
	begin
		ligne : for i in 0 to 3 generate
			colonne : for j in 0 to 3 generate
				invaddroundkey_o(i)(j) <= invaddroundkey_i(i)(j) xor key_i(i)(j);
			end generate colonne;
		end generate ligne;
end architecture InvAddRoundKey_arch;
