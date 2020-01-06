------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvSBox_tb.vhd
-- Date of creation:		14/11/2018
-- Date of modification:	14/11/2018
-- Description:			Test bench for the Inversion of the S-Box
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

-- entite vide
entity InvSBox_tb is
end entity InvSBox_tb;

architecture InvSBox_tb_arch of InvSBox_tb is 
	
	component InvSBox
		port(
			invsbox_i : in bit8;
			invsbox_o : out bit8
		);
	end component;
	
	-- defiition des signaux 
	signal invsbox_is : bit8; -- input signal
	signal invsbox_os : bit8; -- output signal
	
	begin
	-- Device Under Test
	DUT : InvSBox 
		port map (
			invsbox_i => invsbox_is,
			invsbox_o => invsbox_os
		);
		
		P0 : process
		variable cpt_v : bit8 := "00000000"; --permettra de tester toutes les valeurs
		begin
			wait for 200 ns; -- on testera toutes les 200ns la valeur cpt_v incrementee
			if cpt_v="11111111" then
				cpt_v := "00000000";
			else
				cpt_v := std_logic_vector(cpt_v+1);
			end if;
			invsbox_is <= std_logic_vector(cpt_v);
		end process P0;
end architecture InvSBox_tb_arch;

-- configuration
configuration InvSBox_tb_conf of InvSBox_tb is
	for InvSBox_tb_arch
		for DUT : InvSBox
			use entity source.InvSBox(InvSBox_arch);
		end for;
	end for;
end InvSBox_tb_conf;

			
		
		
		
