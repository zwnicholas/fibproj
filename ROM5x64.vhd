Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_arith.all;

Entity ROM5x64 is
	port (address: in std_logic_vector(5 downto 0);
				data: out std_logic_vector(4 downto 0));
end entity ROM5x64;

architecture behavioral of ROM5x64 is
	type rom_array is array (0 to 63) of
		std_logic_vector(4 downto 0);	
		--conv_std_logic_vector()
	signal rom: rom_array:=(0=>conv_std_logic_vector(18,5),
									1=>conv_std_logic_vector(11,5),
									2=>conv_std_logic_vector(18,5),
									3=>conv_std_logic_vector(14,5),
									4=>conv_std_logic_vector(2,5),
									5=>conv_std_logic_vector(16,5),
									6=>conv_std_logic_vector(1,5),
									7=>conv_std_logic_vector(7,5),
									8=>conv_std_logic_vector(4,5),
									9=>conv_std_logic_vector(2,5),
									10=>conv_std_logic_vector(9,5),
									11=>conv_std_logic_vector(8,5),
									12=>conv_std_logic_vector(17,5),
									13=>conv_std_logic_vector(4,5),
									14=>conv_std_logic_vector(8,5),
									15=>conv_std_logic_vector(5,5),
									16=>conv_std_logic_vector(21,5),
									17=>conv_std_logic_vector(11,5),
									18=>conv_std_logic_vector(3,5),
									19=>conv_std_logic_vector(1,5),
									20=>conv_std_logic_vector(22,5),
									21=>conv_std_logic_vector(9,5),
									22=>conv_std_logic_vector(6,5),
									23=>conv_std_logic_vector(12,5),
									24=>conv_std_logic_vector(5,5),
									25=>conv_std_logic_vector(7,5),
									26=>conv_std_logic_vector(1,5),
									27=>conv_std_logic_vector(22,5),
									28=>conv_std_logic_vector(4,5),
									29=>conv_std_logic_vector(22,5),
									30=>conv_std_logic_vector(22,5),
									31=>conv_std_logic_vector(19,5),
									32=>conv_std_logic_vector(11,5),
									33=>conv_std_logic_vector(15,5),
									34=>conv_std_logic_vector(8,5),
									35=>conv_std_logic_vector(10,5),
									36=>conv_std_logic_vector(8,5),
									37=>conv_std_logic_vector(9,5),
									38=>conv_std_logic_vector(14,5),
									39=>conv_std_logic_vector(11,5),
									40=>conv_std_logic_vector(8,5),
									41=>conv_std_logic_vector(22,5),
									42=>conv_std_logic_vector(16,5),
									43=>conv_std_logic_vector(2,5),
									44=>conv_std_logic_vector(1,5),
									45=>conv_std_logic_vector(22,5),
									46=>conv_std_logic_vector(5,5),
									47=>conv_std_logic_vector(21,5),
									48=>conv_std_logic_vector(8,5),
									49=>conv_std_logic_vector(7,5),
									50=>conv_std_logic_vector(20,5),
									51=>conv_std_logic_vector(7,5),
									52=>conv_std_logic_vector(14,5),
									53=>conv_std_logic_vector(3,5),
									54=>conv_std_logic_vector(19,5),
									55=>conv_std_logic_vector(18,5),
									56=>conv_std_logic_vector(7,5),
									57=>conv_std_logic_vector(17,5),
									58=>conv_std_logic_vector(17,5),
									59=>conv_std_logic_vector(8,5),
									60=>conv_std_logic_vector(16,5),
									61=>conv_std_logic_vector(16,5),
									62=>conv_std_logic_vector(5,5),
									63=>conv_std_logic_vector(4,5));							
									
begin
	data <= rom(conv_integer(unsigned(address)));

end behavioral;
		
