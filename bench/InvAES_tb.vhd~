------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			InvAES_tb.vhd
-- Date of creation:		07/12/2018
-- Date of modification:	08/12/2018
-- Description:			test bench for the InvAES component
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity InvAES_tb is
end entity InvAES_tb;

architecture InvAES_tb_arch of InvAES_tb is
	
	-- composants
	component InvAES is 
		port (
			start_i : in std_logic;
			clock_i : in std_logic;
			reset_i : in std_logic; -- reset etat haut
			data_i : in bit128;
			data_o : out bit128;
			aes_on_o : out std_logic
		);
	end component;
	
	
	-- signaux
	signal start_is : std_logic;
	signal clock_is : std_logic := '0';
	signal reset_is : std_logic;
	signal data_is : bit128;
	signal data_os : bit128;
	signal aes_on_os : std_logic;
	
	
	-- debut architecture
	begin
		
		DUT : InvAES port map (
			start_i => start_is,
			clock_i => clock_is,
			reset_i => reset_is,
			data_i => data_is,
			data_o => data_os,
			aes_on_o => aes_on_os
		);	
		
-- attribution valeurs signaux		
start_is <= '0', '1' after 60 ns, '0' after 85 ns, '1' after 560 ns, '0' after 585 ns;
clock_is <= not clock_is after 10 ns;
reset_is <= '0', '1' after 10 ns, '0' after 35 ns;
data_is <= x"d6efa6dc4ce8efd2476b9546d76acdf0", x"d7ca070cc0d3ce1e3943287756404506" after 500 ns;

end architecture InvAES_tb_arch;


-- configuration
configuration InvAES_tb_conf of InvAES_tb is
	for InvAES_tb_arch
		for DUT : InvAES
			use configuration source.InvAES_conf;
		end for;
	end for;
end InvAES_tb_conf;

