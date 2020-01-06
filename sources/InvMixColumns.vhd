------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvMixColumns.vhd
-- Date of creation:		21/11/2018
-- Date of modification:	21/11/2018
-- Description:			Inversion of the MixColumns function
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvMixColumns is
	port (
		invmixcolumns_i : in type_state;
		invmixcolumns_o : out type_state
	);
end entity InvMixColumns;

architecture InvMixColumns_arch of InvMixColumns is
	component InvMixOneColumn
		port (
			column_i : in column_state; -- colonne d'entree
			column_o : out column_state -- colonne de sortie
		);
	end component InvMixOneColumn;
	
	signal column1_is, column2_is, column3_is, column4_is : column_state; -- colonne intermediare d'input pour bien avoir des colonnes en entree de InvMixOneColumn (invmixcolumns_i est une matrice de ligne et non de colonnes)
	signal column1_os, column2_os, column3_os, column4_os : column_state; -- colonne intermediare d'output pour bien avoir des colonnes en sortie de InvMixOneColumn (invmixcolumns_o est une matrice de ligne et non de colonnes)
	
begin
	-- remplissage de la premiere colonne
	column1_is(0) <= invmixcolumns_i(0)(0);
	column1_is(1) <= invmixcolumns_i(1)(0);
	column1_is(2) <= invmixcolumns_i(2)(0);
	column1_is(3) <= invmixcolumns_i(3)(0);
	-- remplissage de la deuxieme colonne
	column2_is(0) <= invmixcolumns_i(0)(1);
	column2_is(1) <= invmixcolumns_i(1)(1);
	column2_is(2) <= invmixcolumns_i(2)(1);
	column2_is(3) <= invmixcolumns_i(3)(1);
	-- remplissage de la troisieme colonne
	column3_is(0) <= invmixcolumns_i(0)(2);
	column3_is(1) <= invmixcolumns_i(1)(2);
	column3_is(2) <= invmixcolumns_i(2)(2);
	column3_is(3) <= invmixcolumns_i(3)(2);
	-- remplissage de la quatrieme colonne
	column4_is(0) <= invmixcolumns_i(0)(3);
	column4_is(1) <= invmixcolumns_i(1)(3);
	column4_is(2) <= invmixcolumns_i(2)(3);
	column4_is(3) <= invmixcolumns_i(3)(3);
	
	-- on iinstancie 4 composants
	Col1 : InvMixOneColumn
		port map (
			column_i => column1_is,
			column_o => column1_os
		);
		
	Col2 : InvMixOneColumn
		port map (
			column_i => column2_is,
			column_o => column2_os
		);
	
	Col3 : InvMixOneColumn
		port map (
			column_i => column3_is,
			column_o => column3_os
		);
	
	Col4 : InvMixOneColumn
		port map (
			column_i => column4_is,
			column_o => column4_os
		);
		
	-- remplissage de la premiere ligne de la matrice de sortie
	invmixcolumns_o(0)(0) <= column1_os(0);
	invmixcolumns_o(0)(1) <= column2_os(0);
	invmixcolumns_o(0)(2) <= column3_os(0);
	invmixcolumns_o(0)(3) <= column4_os(0);
	-- remplissage de la deuxieme ligne de la matrice de sortie
	invmixcolumns_o(1)(0) <= column1_os(1);
	invmixcolumns_o(1)(1) <= column2_os(1);
	invmixcolumns_o(1)(2) <= column3_os(1);
	invmixcolumns_o(1)(3) <= column4_os(1);
	-- remplissage de la troisieme ligne de la matrice de sortie
	invmixcolumns_o(2)(0) <= column1_os(2);
	invmixcolumns_o(2)(1) <= column2_os(2);
	invmixcolumns_o(2)(2) <= column3_os(2);
	invmixcolumns_o(2)(3) <= column4_os(2);
	-- remplissage de la quantrieme ligne de la matrice de sortie
	invmixcolumns_o(3)(0) <= column1_os(3);
	invmixcolumns_o(3)(1) <= column2_os(3);
	invmixcolumns_o(3)(2) <= column3_os(3);
	invmixcolumns_o(3)(3) <= column4_os(3);
	
end architecture InvMixColumns_arch;

configuration InvMixColumns_conf of InvMixColumns is
	for InvMixColumns_arch
		for all : InvMixOneColumn
			use entity source.InvMixOneColumn(InvMixOneColumn_arch);
		end for;
	end for;
end InvMixColumns_conf;

