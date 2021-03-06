------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvShiftRows.vhd
-- Date of creation:		19/11/2018
-- Date of modification:	19/11/2018
-- Description:			Inversion of the ShiftRows function
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

-- Declaration de l'entite InvShiftRows qui prend en entree une matrice 4x4 de bit8 et qui donne en sortie une matrice 4x4 de bit8
entity InvShiftRows is 
	port (
		invshiftrows_i : in type_state; -- matrice d'entree
		invshiftrows_o : out type_state -- matrice de sortie
	);
end entity InvShiftRows;

architecture InvShiftRows_arch of InvShiftRows is 
	begin
		invshiftrows_o(0) <= invshiftrows_i(0);
		invshiftrows_o(1) <= invshiftrows_i(1)(3)&invshiftrows_i(1)(0)&invshiftrows_i(1)(1)&invshiftrows_i(1)(2);
		invshiftrows_o(2) <= invshiftrows_i(2)(2)&invshiftrows_i(2)(3)&invshiftrows_i(2)(0)&invshiftrows_i(2)(1);
		invshiftrows_o(3) <= invshiftrows_i(3)(1)&invshiftrows_i(3)(2)&invshiftrows_i(3)(3)&invshiftrows_i(3)(0);
		
end architecture InvShiftRows_arch;
