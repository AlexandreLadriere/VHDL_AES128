------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvMixOneColumn.vhd
-- Date of creation:		21/11/2018
-- Date of modification:	21/11/2018
-- Description:			Inversion of the MixColumns function for one columns
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

-- Declaration de l'entite InvMixOneColumn qui prend en entree une colonne (column_state) et qui retourne une colonne (column_state)
entity InvMixOneColumn is 
	port (
		column_i : in column_state; -- colonne d'entree
		column_o : out column_state -- colonne de sortie
	);
end entity InvMixOneColumn;

architecture InvMixOneColumn_arch of InvMixOneColumn is
	-- Signaux
	signal Col2_s : column_state; -- resultat de la multiplication par 2
	signal Col4_s : column_state; -- resultat de la multiplication par 4
	signal Col8_s : column_state; -- resultat de la multiplication par 8
	
	signal Col9_s : column_state; -- resultat de la multiplication par 9
	signal Col11_s : column_state; -- resultat de la multiplication par 11
	signal Col13_s : column_state; -- resultat de la multiplication par 13
	signal Col14_s : column_state; -- resultat de la multiplication par 14
	
	
	begin
	
		-- On fait un xor avec "OOO1 1011" mais de manière générale, en utilisant column_i(i)(7) pour le 1
		-- multiplication par 2
		mul2 : for i in 0 to 3 generate
			Col2_s(i) <= (column_i(i)(6 downto 0) & '0') xor ("000" & column_i(i)(7) & column_i(i)(7) & '0' & column_i(i)(7) & column_i(i)(7));
		end generate mul2;
		
		-- multiplication par 4
		mul4 : for i in 0 to 3 generate
			Col4_s(i) <= (Col2_s(i)(6 downto 0) & '0') xor ("000" & Col2_s(i)(7) & Col2_s(i)(7) & '0' & Col2_s(i)(7) & Col2_s(i)(7));
		end generate mul4;
		
		-- multiplication par 8
		mul8 : for i in 0 to 3 generate
			Col8_s(i) <= (Col4_s(i)(6 downto 0) & '0') xor ("000" & Col4_s(i)(7) & Col4_s(i)(7) & '0' & Col4_s(i)(7) & Col4_s(i)(7));
		end generate mul8;
		
		-- Pour les opérations suivantes, les xor "00011011" sont inutiles
		-- multiplication par 9 = 8 xor 1
		mul9 : for i in 0 to 3 generate
			Col9_s(i) <= Col8_s(i) xor column_i(i);
		end generate mul9;
		
		-- multiplication par 11 = 8 xor 2 xor 1 = 9 xor 2
		mul11 : for i in 0 to 3 generate
			Col11_s(i) <= Col8_s(i) xor Col2_s(i) xor column_i(i);
		end generate mul11;
		
		-- multiplication par 13 = 8 xor 4 xor 1 = 11 xor 2
		mul13 : for i in 0 to 3 generate
			Col13_s(i) <= Col8_s(i) xor Col4_s(i) xor column_i(i);
		end generate mul13;
		
		-- multiplication par 14 = 8 xor 4 xor 2 = 13 xor 1
		mul14 : for i in 0 to 3 generate
			Col14_s(i) <= Col8_s(i) xor Col4_s(i) xor Col2_s(i);
		end generate mul14;
		
		-- produit final
		column_o(0) <= (Col14_s(0) xor Col11_s(1)) xor (Col13_s(2) xor Col9_s(3));
		column_o(1) <= (Col9_s(0) xor Col14_s(1)) xor (Col11_s(2) xor Col13_s(3));
		column_o(2) <= (Col13_s(0) xor Col9_s(1)) xor (Col14_s(2) xor Col11_s(3));
		column_o(3) <= (Col11_s(0) xor Col13_s(1)) xor (Col9_s(2) xor Col14_s(3));
		
end architecture InvMixOneColumn_arch;
