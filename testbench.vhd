library ieee;
use ieee.std_logic_1164.all;

entity testbench is 
end testbench;

architecture SimulationProfile of testbench is

component fib is
	Port (Start, Reset, Clk	: in std_logic;
							RAMout: out std_logic_vector(15 downto 0);	
							Done : out std_logic;
							 ROMenO, RAMenO, RAMrwO, kCntrResetO, kCntrEnO: out std_logic;
							nCntrEnO, nCntrResetO :  out std_logic;
											NkRegEnO :  out std_logic;
				  RAMAddrCntrLO, RAMAddrCntrEnO : out std_logic;
		FibCalcInitO, FibRegEnO, FibRegResetO :  out std_logic;
										  DivStartO :  out std_logic;
										  RAMInSelO :  out std_logic_vector(1 downto 0);
											  QO, RO, SumO  :  out std_logic_vector(15 downto 0);
			LastAddrO, FibCalcDoneO, DivDoneO  :  out std_logic;
			kO: out std_logic_vector(5 downto 0);
			NkO:out std_logic_vector(4 downto 0) 	
			);
end component;

signal Start, Reset, Clk : std_logic;
signal RAMout : std_logic_vector(15 downto 0);
signal Done : std_logic;

signal ROMen, RAMen, RAMrw, kCntrReset, kCntrEn: std_logic;
signal							nCntrEn, nCntrReset :  std_logic;
signal											NkRegEn :  std_logic;
signal				  RAMAddrCntrL, RAMAddrCntrEn :  std_logic;
signal		FibCalcInit, FibRegEn, FibRegReset :  std_logic;
signal										  DivStart :  std_logic;
signal										  RAMInSel :  std_logic_vector(1 downto 0);
signal											  Q, R, Sum  :  std_logic_vector(15 downto 0);
signal			LastAddr, FibCalcDone, DivDone  : std_logic;
signal			k:  std_logic_vector(5 downto 0);
signal			Nk: std_logic_vector(4 downto 0) ;

constant HalfPeriod: time := 25 ns;


begin
dut : fib
		port map(Start=>Start, Reset=>Reset, Clk=>Clk, RAMout=>RAMout, Done=>Done,
		ROMenO=>ROMen, RAMenO=>RAMen, RAMrwO=>RAMrw , kCntrResetO=>kCntrReset , kCntrEnO=>kCntrEn ,
							nCntrEnO=>nCntrEn , nCntrResetO=>nCntrReset ,
											NkRegEnO=>NkRegEn ,
				  RAMAddrCntrLO=>RAMAddrCntrL , RAMAddrCntrEnO=>RAMAddrCntrEn ,
		FibCalcInitO=>FibCalcInit , FibRegEnO=>FibRegEn , FibRegResetO=>FibRegReset ,
										  DivStartO=>DivStart ,
										  RAMInSelO=>RAMInSel ,
											  QO=>Q , RO=>R, SumO=>Sum,
			LastAddrO=>LastAddr, FibCalcDoneO=>FibCalcDone, DivDoneO=>DivDone,
					kO=>k, NkO=>Nk
		);

process 
begin 
clk<='0';
wait for HalfPeriod;
clk<='1';
wait for HalfPeriod;
end process;

process
begin
reset<='1';
wait for 50 ns;
reset<='0';
start<='1';
wait;
end process;





end SimulationProfile;