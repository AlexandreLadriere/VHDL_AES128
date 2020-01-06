------------------------------------------------------------------------------------------------
-- Author:			Alexandre LADRIERE
-- Name:			RTL_REG.vhd
-- Date of creation:		29/11/2018
-- Date of modification:	07/12/2018
-- Description:			Implementation of a Register
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library AESLibrary;
use AESLibrary.state_definition_package.all;
library source;

entity RTL_REG is
	port (
		clockREG_i : in std_logic;
		resetbREG_i : in std_logic;
		enableREG_i : in std_logic;
		D_i : in bit128;
		Q_o : out bit128
	);
end entity RTL_REG;

architecture RTL_REG_arch of RTL_REG is

	signal Q_os : bit128;
	signal inter_s : bit128;
	
	begin
		seq_0 : process(clockREG_i, resetbREG_i, inter_s) 
			begin
				if resetbREG_i = '0' then
					Q_os <= (others => '0');
				elsif clockREG_i'event and clockREG_i = '1' then
					Q_os <= inter_s;
				else
					Q_os <= Q_os;
				end if;
		end process seq_0;
		
		seq_1 : process(Q_os, D_i, enableREG_i)
			begin
				if enableREG_i = '1' then
					inter_s <= D_i;
				else
					inter_s <= Q_os;
				end if;
		end process seq_1;
		
		Q_o <= Q_os;
		
end architecture RTL_REG_arch;

