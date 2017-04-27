library ieee;
use ieee.std_logic_1164.all;

entity DivReg6 is
  port (d : in std_logic_vector(5 downto 0);
        reset, load, clock: in std_logic;
		  q : out std_logic_vector(5 downto 0));
end DivReg6;


architecture processArch of DivReg6 is
begin
  process (clock, reset) is
  begin
     if reset = '1' then
	     q <= "000000";
	  elsif clock'event and clock = '1' then
	     if load = '1' then
		      q <= d;
	     end if;
	  end if;
  end process;



end processArch;