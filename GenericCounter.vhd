Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

entity genericCounter is
	generic(N: natural := 5);
	port (clk, Reset, En : in std_logic;
								Z: out std_logic_vector(N-1 downto 0));
end genericCounter;

architecture behavioral of genericCounter is
	signal count: std_logic_vector(N-1 downto 0);
begin
	process(clk, Reset)
	begin
		if Reset ='1' then
			count <= (others=>'0');
		elsif (clk'event and clk='1') then
			if En='1' then
				count <= count + 1;
			else
				count <= count;
			end if;
		end if;
	end process;
	Z <= count;
end behavioral;