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


entity Multiplexer_type_state is
	port (
		enable_i : in std_logic; -- variable permettant de choisir la sortie
		choix0_i : in type_state; -- matrice qui sera en sortie si enable = 0
		choix1_i : in type_state; -- matrice qui sera en sortie si enable ='1'
		resultat_o : out type_state
	);
end entity Multiplexer_type_state;

architecture Mutliplexer_type_state_arch of Multiplexer_type_state is
	begin
		seq0 : process(enable_i, choix0_i, choix1_i)
		begin
			if enable_i = '1' then
				resultat_o <= choix1_i;
			else
				resultat_o <= choix0_i;
			end if;
		end process seq0;
end architecture Mutliplexer_type_state_arch;


