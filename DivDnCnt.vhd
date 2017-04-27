library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity DivDnCnt is
   port(d : in std_logic_vector(3 downto 0);
	     count: buffer std_logic_vector(3 downto 0);
		  load, en, clock: in std_logic);
end DivDnCnt;

architecture behavioral of DivDnCnt is
begin
process(clock) is
begin
   if clock'event and clock = '1' then
	   if load = '1' then
		   count<=d;
		elsif en = '1' then
		   count<= count - 1;
		end if;
	end if;
end process;
end behavioral;