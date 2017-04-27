library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divAdd6 is
   port(a, b: in std_logic_vector(5 downto 0);
	     cin : in std_logic;
		  cout: out std_logic;
		  sum : out std_logic_vector(5 downto 0));
end divAdd6;

architecture behavioral of divAdd6 is
signal awide, bwide, sumwide: std_logic_vector(7 downto 0);
begin
   awide<='0' & a & cin;
	bwide<= '0' & b & '1';
	sumwide<= awide + bwide;
	cout<=sumwide(7);
	sum<=sumwide(6 downto 1);
end behavioral;