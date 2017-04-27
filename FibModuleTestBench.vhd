library ieee;
use ieee.std_logic_1164.all;

entity FibModuleTestBench is
end FibModuleTestBench;


architecture SimulationProfile of FibModuleTestBench is
  component FibModule is
  port(FibCalcInit, FibRegEn, FibRegReset : in std_logic;
	     nCntrEn, nCntrReset : in std_logic;
		  clk: in std_logic;
		  Nk: in std_logic_vector(4 downto 0);
		  FibCalcDone: out std_logic;
	     Sum: buffer std_logic_vector(15 downto 0));
--		  FibOldOut, FibNewOut: out std_logic_vector(15 downto 0);
--		  nOut: out std_logic_vector(4 downto 0);
  end component;

   signal FibCalcInit, FibRegEn, FibRegReset: std_logic;
   signal nCntrEn, nCntrReset: std_logic;
   signal clk: std_logic;
   signal Nk: std_logic_vector(4 downto 0);
   signal FibCalcDone: std_logic;
   signal Sum: std_logic_vector(15 downto 0);
   constant HalfPeriod: time := 25 ns;
   constant Period: time := 50 ns;
begin
dut: FibModule
      port map(FibCalcInit=>FibCalcInit, FibRegEn=>FibRegEn, FibRegReset=>FibRegReset,
		nCntrEn=>nCntrEn, nCntrReset=>nCntrReset,
		  clk=>clk,
		  Nk=>Nk, --nOut=>n,
		  FibCalcDone=>FibCalcDone,
	     Sum=>Sum);
		  --FibOldOut=>FibOld,FibNewOut=>FibNew);

process 
begin
clk<='0';
wait for HalfPeriod;
clk<='1';
wait for HalfPeriod;
end process;

process
begin
FibRegReset <= '1';
nCntrReset<='1';
wait for Period;
FibCalcInit <='1'; FibRegEn<='1'; FibRegReset<='0';
nCntrEn<='1'; nCntrReset<='0';
Nk<="10110";
wait for Period;
FibCalcInit<='0';
wait;
end process;
		  
end SimulationProfile;