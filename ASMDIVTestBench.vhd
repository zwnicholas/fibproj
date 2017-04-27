library ieee;
use ieee.std_logic_1164.all;

entity ASMDIVTestBench is
end ASMDIVTestBench;


architecture SimulationProfile of ASMDIVTestBench is
component ASMDIV is
   port(a: in std_logic_vector(15 downto 0);
	     b: in std_logic_vector(4 downto 0);
		  start, clock, reset: in std_logic;
	     done: out std_logic;
		  q: out std_logic_vector(15 downto 0);
		  r: out std_logic_vector(4 downto 0));
end component;
signal a, q: std_logic_vector(15 downto 0);
signal b, r: std_logic_vector(4 downto 0);
signal start, clock, reset, done: std_logic;
constant HalfPeriod: time := 25 ns;
constant Period: time := 50 ns;
constant SixteenPeriods: time := 800 ns;

begin

dut: ASMDIV port map(
		  a=>a,b=>b,start=>start, clock=>clock, reset=>reset,
		  done=>done,q=>q,r=>r);

clockproc: process 
begin
clock<='0';
wait for HalfPeriod;
clock<='1';
wait for HalfPeriod;
end process clockproc;

process
begin
reset<='1';
wait for Period;
start <= '1';
reset<='0';
a<="1100000000001100";
b<="10011";
wait for SixteenPeriods;
wait for Period;
wait for Period;
wait for Period;
start<='0';
wait;
end process;


end SimulationProfile;