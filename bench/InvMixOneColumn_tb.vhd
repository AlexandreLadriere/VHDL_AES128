------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvMixOneColumn.vhd
-- Date of creation:		21/11/2018
-- Date of modification:	21/11/2018
-- Description:			Test bench for the inversion of the MixColumns function for one columns
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvMixOneColumn_tb is
end entity InvMixOneColumn_tb;

architecture InvMixOneColumn_tb_arch of InvMixOneColumn_tb is
	component InvMixOneColumn
		port (
			column_i : in column_state; -- colonne d'entree
			column_o : out column_state -- colonne de sortie
		);
	end component;
	
	signal column_is : column_state := (x"37", x"cf", x"02", x"3e");
	signal column_os : column_state;
	
	begin
	-- Device Under Test
	DUT : InvMixOneColumn
		port map (
			column_i => column_is,
			column_o => column_os
		);
end architecture InvMixOneColumn_tb_arch;

configuration InvMixOneColumn_tb_conf of InvMixOneColumn_tb is
	for InvMixOneColumn_tb_arch
		for DUT : InvMixOneColumn
			use entity source.InvMixOneColumn(InvMixOneColumn_arch);
		end for;
	end for;
end InvMixOneColumn_tb_conf;

