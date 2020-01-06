------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			Counter_tb.vhd
-- Date of creation:		30/11/2018
-- Date of modification:	08/12/2018
-- Description:			TestBench for the Counter
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity Counter_tb is
end entity Counter_tb;

architecture Counter_tb_arch of Counter_tb is
	component Counter 
		port (
			reset_i : in std_logic; -- reset etat haut
			ce_i : in std_logic; --clock enable
			clock_i : in std_logic;
			cpt_o : out bit4
		);
	end component;
	
	signal reset_is, ce_is : std_logic;
	signal cpt_os : bit4;
	signal clock_is : std_logic := '0';
	
	begin 
		DUT : Counter
		port map (
			reset_i => reset_is,
			ce_i => ce_is,
			clock_i => clock_is,
			cpt_o => cpt_os
		);
	
	
clock_is <= not clock_is after 50 ns;
reset_is <= '0', '1' after 60 ns, '0' after 80 ns, '1' after 1210 ns, '0' after 1230 ns;
ce_is <= '1';

	
	
end architecture Counter_tb_arch;

configuration Counter_tb_conf of Counter_tb is
	for Counter_tb_arch
		for DUT : Counter
			use entity source.Counter(Counter_arch);
		end for;
	end for;
end Counter_tb_conf;
