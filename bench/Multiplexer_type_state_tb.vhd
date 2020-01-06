------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			Multiplexer_type_state.vhd
-- Date of creation:		11/12/2018
-- Date of modification:	11/12/2018
-- Description:			Multiplexer for InvAESRound component (type_sate)
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity Multiplexer_type_state_tb is
end entity Multiplexer_type_state_tb;

architecture Multiplexer_type_state_tb_arch of Multiplexer_type_state_tb is
	component Multiplexer_type_state
		port (
			enable_i : in std_logic; -- variable permettant de choisir la sortie
			choix0_i : in type_state; -- matrice qui sera en sortie si enable = 0
			choix1_i : in type_state; -- matrice qui sera en sortie si enable ='1'
			resultat_o : out type_state
		);
	end component Multiplexer_type_state;
	
	signal choix0_is : type_state := ((x"09",x"7e",x"ed",x"8f"),(x"37",x"99",x"74",x"a1"),(x"9f",x"01",x"ad",x"10"),(x"a4",x"c7",x"f8",x"a4"));
	signal choix1_is : type_state := ((x"06",x"85",x"a6",x"61"),(x"fb",x"06",x"54",x"09"),(x"5f",x"ca",x"99",x"c1"),(x"74",x"5b",x"8e",x"56"));
	signal enable_is : std_logic;
	signal resultat_os : type_state;
	
	begin
	
	DUT : Multiplexer_type_state port map (
		enable_i => enable_is,
		choix0_i => choix0_is,
		choix1_i => choix1_is,
		resultat_o => resultat_os
	);
	
enable_is <= '0';
end architecture Multiplexer_type_state_tb_arch;

configuration Multiplexer_type_state_tb_conf of Multiplexer_type_state_tb is
	for Multiplexer_type_state_tb_arch
		for DUT : Multiplexer_type_state
			use entity source.Multiplexer_type_state(Multiplexer_type_state_arch);
		end for;
	end for;
end Multiplexer_type_state_tb_conf;
