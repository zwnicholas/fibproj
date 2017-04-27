Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

entity CntrLoad8 is
   port(en, load,clock: in std_logic;
	     d: in std_logic_vector(7 downto 0);
		  q: buffer std_logic_vector(7 downto 0));
end CntrLoad8;

architecture procArch of CntrLoad8 is
begin
process(clock)
begin
if clock'event and clock='1' then
   if load = '1' then
	   q<=d;
	elsif en = '1' then
	   q<=q+1;
	else
	   q<=q;
	end if;
end if;
end process;
end procArch;