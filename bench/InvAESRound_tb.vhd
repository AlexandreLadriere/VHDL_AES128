------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvAESRound_tb.vhd
-- Date of creation:		05/12/2018
-- Date of modification:	08/12/2018
-- Description:			Itest bench for the nvAESRound component
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvAESRound_tb is
end entity InvAESRound_tb;

architecture InvAESRound_tb_arch of InvAESRound_tb is

	component InvAESRound 
		port (
			clock_i : in std_logic;
			currentkey_i : in bit128;
			currenttext_i : in bit128;
			enableInvMixColumns_i : in std_logic;
			enableRoundComputing_i : in std_logic;
			resetb_i : in std_logic; -- reset etat bas
			data_o : out bit128
		);
	end component;
		
	signal currentkey_is, currenttext_is : bit128;
	signal enableInvMixColumns_is, enableRoundComputing_is, resetb_is : std_logic;
	signal clock_is : std_logic := '0';
	signal data_os : bit128;
	
	begin
		DUT : InvAESRound port map (
			clock_i => clock_is,
			currentkey_i => currentkey_is,
			currenttext_i => currenttext_is,
			enableInvMixColumns_i => enableInvMixColumns_is,
			enableRoundComputing_i => enableRoundComputing_is,
			resetb_i => resetb_is,
			data_o => data_os
		);
		
-- test pour round 10 (sans InvMixColumns et Roundcomputing) et 9 (avec InvMixColumns et Roundcomputing)		
enableInvMixColumns_is <= '0', '1' after 200 ns, '0' after 250 ns;
enableRoundComputing_is <= '0', '1' after 200 ns, '0' after 250 ns;
resetb_is <= '1','0' after 5 ns, '1' after 15 ns;
clock_is <= not clock_is after 25 ns;
currentkey_is <= x"d014f9a8c9ee2589e13f0cc8b6630ca6", x"ac7766f319fadc2128d12941575c006e" after 180 ns;
currenttext_is <= x"d6efa6dc4ce8efd2476b9546d76acdf0", x"06fb5f748506ca5ba654998e6109c156" after 180 ns;

end architecture InvAESRound_tb_arch;


configuration InvAESRound_tb_conf of InvAESRound_tb is
	for InvAESRound_tb_arch
		for DUT : InvAESRound
			use configuration source.InvAESRound_conf;
		end for;
	end for;
end InvAESRound_tb_conf;	

