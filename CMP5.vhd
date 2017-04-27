library ieee;
Use ieee.std_logic_1164.all;

entity CMP5 is
 port(a, b: in std_logic_vector(4 downto 0);
      isEqual: out std_logic);
end CMP5;

architecture gates of CMP5 is
signal temp: std_logic_vector(4 downto 0);
begin
temp<= NOT(a XOR b);
isEqual<= temp(4) AND temp(3) and temp(2) AND temp(1) AND temp(0);
end gates;