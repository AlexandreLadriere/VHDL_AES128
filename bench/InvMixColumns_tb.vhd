------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvMixColumns_tb.vhd
-- Date of creation:		21/11/2018
-- Date of modification:	21/11/2018
-- Description:			Test bench for theInversion of the MixColumns function
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvMixColumns_tb is 
end entity InvMixColumns_tb;

architecture InvMixColumns_tb_arch of InvMixColumns_tb is
	component InvMixColumns
		port (
			invmixcolumns_i : in type_state;
			invmixcolumns_o : out type_state
		);
	end component InvMixColumns;
	
	signal invmixcolumns_is : type_state := ((x"09",x"7e",x"ed",x"8f"),(x"37",x"99",x"74",x"a1"),(x"9f",x"01",x"ad",x"10"),(x"a4",x"c7",x"f8",x"a4"));
	signal invmixcolumns_os : type_state;
	
	begin
	-- Device Under Test
	DUT : InvMixColumns
		port map (
			invmixcolumns_i => invmixcolumns_is,
			invmixcolumns_o => invmixcolumns_os
		);
end architecture InvMixColumns_tb_arch;

configuration InvMixColumns_tb_conf of InvMixColumns_tb is
	for InvMixColumns_tb_arch
		for DUT : InvMixColumns
			use entity source.InvMixColumns(InvMixColumns_arch);
		end for;
	end for;
end InvMixColumns_tb_conf;
