------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			FSM_InvAES.vhd
-- Date of creation:		27/11/2018
-- Date of modification:	07/12/2018
-- Description:			FSM for InvAES
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity FSM_InvAES is 
	port (
		clock_i : in std_logic;
		resetb_i : in std_logic; -- reset etat bas
		round_i : in bit4; -- entree correspondant au compteur de round
		start_i : in std_logic;
		done_o : out std_logic; -- indique la fin du calcul
		enableCounter_o : out std_logic;
		enableInvMixColumns_o : out std_logic;
		enableOutput_o : out std_logic; -- autorise ou non l'envoie des données dechifree
		enableRoundcomputing_o : out std_logic; -- autorise ou non InvSubBytes et InvShiftRows
		getciphertext_o : out std_logic;
		resetCounter_o : out std_logic -- reset etat haut
	);
end entity FSM_InvAES;



architecture FSM_InvAES_Moore_arch of FSM_InvAES is
	-- definition du type enumere
	type state is (start, round10, middle_rounds, round0, end_decryption);
	-- definition des signaux
	signal etat_present : state;
	signal etat_futur : state;


	-- debut architecture
	begin
	
		seq_0 : process (clock_i, resetb_i)
		begin
			if resetb_i = '0' then
				etat_present <= start;
			elsif clock_i'event and clock_i = '1' then
				etat_present <= etat_futur;
			else
				etat_present <= etat_present;
			end if;
		end process seq_0;
		
		-- Enchainement des états
		c0 : process(etat_present, start_i, round_i)
		begin
			case etat_present is
				when start =>
					if start_i = '1' then
						etat_futur <= round10;
					else
						etat_futur <= start;
					end if;
				when round10 =>
					if round_i = "1010" then
						etat_futur <= middle_rounds;
					else
						etat_futur <= round10;
					end if;
				when middle_rounds =>
					if round_i = "0001" then
						etat_futur <= round0;
					else
						etat_futur <= middle_rounds;
					end if;
				when round0 =>
					if round_i = "0000" then
						etat_futur <= end_decryption;
					else
						etat_futur <= round0;
					end if;
				when end_decryption =>
					if start_i = '0' then
						etat_futur <= start; --ou round10 ?
					else
						etat_futur <= end_decryption;
					end if;
			end case;
		end process c0;
		
		-- definition des sorties
		c1 : process(etat_present)
		begin
			case etat_present is
				when start =>
					done_o <= '0';
					enableCounter_o <= '0';
					enableInvMixColumns_o <= '0';
					enableOutput_o <= '0';
					enableRoundComputing_o <= '0';
					getciphertext_o <= '0';
					resetCounter_o <= '1';	
				when round10 =>
					done_o <= '1';
					enableCounter_o <= '1';
					enableInvMixColumns_o <= '0';
					enableOutput_o <= '0';
					enableRoundComputing_o <= '0';
					getciphertext_o <= '1';
					resetCounter_o <= '0';	
				when middle_rounds =>
					done_o <= '1';
					enableCounter_o <= '1';
					enableInvMixColumns_o <= '1';
					enableOutput_o <= '0';
					enableRoundComputing_o <= '1';
					getciphertext_o <= '0';
					resetCounter_o <= '0';		
				when round0 =>
					done_o <= '1'; --
					enableCounter_o <= '0'; --
					enableInvMixColumns_o <= '0';
					enableOutput_o <= '0';
					enableRoundComputing_o <= '1';
					getciphertext_o <= '0';
					resetCounter_o <= '0';	
				when end_decryption =>
					done_o <= '0';
					enableCounter_o <= '0';
					enableInvMixColumns_o <= '0';
					enableOutput_o <= '1';
					enableRoundComputing_o <= '0';
					getciphertext_o <= '0';
					resetCounter_o <= '0';
			end case;
		end process c1;
end architecture FSM_InvAES_Moore_arch;
					
			
