Library ieee;
Use ieee.std_logic_1164.all;

Entity ROM5x64 is
	port (address: in integer range 0 to 64;
				data: out std_logic_vector(4 downto 0));
end entity ROM5x64;

architecture behavioral of ROM5x64 is
	type rom_array is array (0 to 64) of
		std_logic_vector(4 downto 0);	
	signal rom: rom_array:=(others=>"00100");
--	:= 0=>"11100",
--	   1=>"01011",
		
begin
	data <= rom(address);

end behavioral;
		
