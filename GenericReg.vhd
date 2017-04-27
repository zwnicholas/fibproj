Library ieee;
Use ieee.std_logic_1164.all;

entity genericReg is
	generic(N: natural := 5);
	port (				 D : in std_logic_vector(N-1 downto 0);
			En, clk, Reset: in std_logic;
							 Q: buffer std_logic_vector(N-1 downto 0) );
end genericReg;

architecture behavioral of genericReg is
begin
   process(clk, Reset) is
	begin
		if Reset='1' then
			Q <= (others => '0');
		elsif clk'event and clk='1' then
			if En='1' then
				Q <= D;
			else
				Q <= Q;
			end if;
		end if;
	end process;
end behavioral;
			
