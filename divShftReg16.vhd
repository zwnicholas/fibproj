library ieee;
use ieee.std_logic_1164.all;

entity divShftReg16 is
	port(d : in std_logic_vector(15 downto 0);
		  clock, load, shift, serialIn: in std_logic;
		  serialOut: out std_logic;
		  q : buffer std_logic_vector(15 downto 0));
end divShftReg16;

architecture procArch of divShftReg16 is
begin
   process (clock) is
	begin
	   if clock'event and clock = '1' then
		   if load = '1' then
			   q <= d;
			elsif shift = '1' then
		      serialOut <= q(15);
				q<=q(14 downto 0) & serialIn;
			end if;
		end if;
	end process;
end procArch;