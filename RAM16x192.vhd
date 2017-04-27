Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM16x192 is
	port (address: in std_logic_vector(7 downto 0);
			   data: in std_logic_vector(15 downto 0);
				  WE, En: in std_logic; 
			   Qout: out std_logic_vector(15 downto 0));
end RAM16x192;

architecture RTL of RAM16x192 is
	type ram_array is array (0 to 2**8 - 1) of
		std_logic_vector(15 downto 0);
	signal MEM: ram_array;

begin
	p0: process(WE, En, data, address) is
	begin
	  if En='1' then
			if WE='0' then -- write signal is active low
				MEM(to_integer(unsigned(address)))<=Data;
			else Qout<=MEM(to_integer(unsigned(address)));
			end if;
		end if;
	end process p0;
end architecture RTL;