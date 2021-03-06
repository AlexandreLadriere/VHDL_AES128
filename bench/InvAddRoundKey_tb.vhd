------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvAddRoundKey_tb.vhd
-- Date of creation:		19/11/2018
-- Date of modification:	19/11/2018
-- Description:			Test bench for th inversion of the SubBytes function
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvAddRoundKey_tb is
end entity InvAddRoundKey_tb;

architecture InvAddRoundKey_tb_arch of InvAddRoundKey_tb is 
	component InvAddRoundKey
		port (
			invaddroundkey_i : in type_state; --matrice d'entree
			key_i : in type_state; --matrice clef
			invaddroundkey_o : out type_state --matrice de sortie
		);
	end component;
	
	signal invaddroundkey_is : type_state := ((x"d6",x"4c",x"47",x"d7"),(x"ef",x"e8",x"6b",x"6a"),(x"a6",x"ef",x"95",x"cd"),(x"dc",x"d2",x"46",x"f0"));
	signal key_is : type_state:= ((x"d0", x"c9",x"e1",x"b6"),(x"14",x"ee",x"3f",x"63"),(x"f9",x"25",x"0c",x"0c"),(x"a8",x"89",x"c8",x"a6")); --input signal (key)
	signal invaddroundkey_os : type_state;
	
	begin
	-- Device Under State
	DUT : InvAddRoundKey
		port map (
			invaddroundkey_i => invaddroundkey_is,
			key_i => key_is,
			invaddroundkey_o => invaddroundkey_os
		);
end architecture InvAddRoundKey_tb_arch;
			
configuration InvAddRoundKey_tb_conf of InvAddRoundKey_tb is
	for InvAddRoundKey_tb_arch
		for DUT : InvAddRoundKey
			use entity source.InvAddRoundKey(InvAddRoundKey_arch);
		end for;
	end for;
end InvAddRoundKey_tb_conf;
