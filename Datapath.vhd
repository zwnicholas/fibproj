Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_arith.all;

Entity Datapath is 
	Port (	   ROMen, RAMen, RAMrw, kCntrReset, kCntrEn : in std_logic;
												nCntrEn, nCntrReset : in std_logic;
																NkRegEn : in std_logic;
																clock   : in std_logic;
									 RAMAddrCntrL, RAMAddrCntrEn : in std_logic;
							FibCalcInit, FibRegEn, FibRegReset : in std_logic;
															  DivStart : in std_logic;
															  RAMInSel : in std_logic_vector(1 downto 0);
															 Q, R,Sum  : buffer std_logic_vector(15 downto 0);
															  -- Q & R are output from divider
											RAMOut					  : out std_logic_vector(15 downto 0 );
								LastAddr, FibCalcDone, DivDone  : out std_logic;
							kO: out std_logic_vector(5 downto 0);
							NkO:out std_logic_vector(4 downto 0) 	);
End Datapath;

Architecture behavioral of Datapath is										
component ROM5x64 is		
	port (address: in integer range 0 to 64;
				data: out std_logic_vector(4 downto 0));
end component;

component RAM16x192 is
	port (address: in std_logic_vector(7 downto 0);
			   data: in std_logic_vector(15 downto 0);
			WE, Clk: in std_logic; -- find out if we need clk or not
			   Qout: out std_logic_vector(15 downto 0));
end component;

component genericReg is
	generic(N: natural := 5);
	port (				 D : in std_logic_vector(N-1 downto 0);
			En, clk, Reset: in std_logic; -- do we need clk or not?
							 Q : out std_logic_vector(N-1 downto 0) );
end component;

component genericCounter is
	generic(N: natural := 5);
	port (clk, Reset, En : in std_logic;
								Z: out std_logic_vector(N-1 downto 0));
end component;

component CntrLoad8 is 
    port(en, load,clock: in std_logic;
	     d: in std_logic_vector(7 downto 0);
		  q: out std_logic_vector(7 downto 0));
end component;

component fibmodule is
   port(FibCalcInit, FibRegEn, FibRegReset : in std_logic;
	     nCntrEn, nCntrReset : in std_logic;
		  clk: in std_logic;
		  Nk: in std_logic_vector(4 downto 0);
		  FibCalcDone: out std_logic;
	     Sum: buffer std_logic_vector(15 downto 0));
--		  FibOldOut, FibNewOut: out std_logic_vector(15 downto 0);
--		  nOut: out std_logic_vector(4 downto 0));
end component;

component ASMDIV
   port(a: in std_logic_vector(15 downto 0);
	     b: in std_logic_vector(4 downto 0);
		  start, clock, reset: in std_logic;
	     done: out std_logic;
		  q: out std_logic_vector(15 downto 0);
		  r: out std_logic_vector(4 downto 0));
end component;

signal ROMQ, Nk: std_logic_vector(4 downto 0);
signal k: std_logic_vector(5 downto 0);
signal kROM: integer range 0 to 64;
signal RAMIn: std_logic_vector(15 downto 0);
signal RamAddr,RAMBaseAddr: std_logic_vector(7 downto 0);
-- don't forget RAM ALU input (O) and MUX21 fib input (0...01(16))

begin

kROM <= conv_integer(unsigned(k));

rom : ROM5x64 
      port map(address=>kROM,
				data=>ROMQ);
ram: RAM16x192
     port map(address=>RAMAddr,
			   data=>RAMIn,
			WE=>RAMrw, Clk=>clock,
			   Qout=>RAMOut);
NkReg : genericReg
     generic map(N => 5)
	  port map(D=>ROMQ,
			En=>NkRegEn, clk=>clock, Reset=>'0',
					 Q=>Nk);

kCntr : genericCounter
     generic map(N=>6)
	  port map(clk=>clock, Reset=>kCntrReset, En=>kCntrEn,
					Z=>k);

RAMAddrCntr : CntrLoad8
     port map(en=>RAMAddrCntrEn, load=>RamAddrCntrL,clock=>clock,
	     d=>RAMBaseAddr,
		  q=>RAMAddr);
		  
div : ASMDIV 
     port map(a=>Sum,
	     b=>Nk,
		  start=>DivStart, clock=>clock, reset=>'0',
	     done=>DivDone,
		  q=>Q,
		  r=>R(4 downto 0));
		  
fib: fibmodule
     port map(FibCalcInit=>FibCalcInit, FibRegEn=>FibRegEn, FibRegReset=>FibRegReset,
	     nCntrEn=>nCntrEn, nCntrReset=>nCntrReset,
		  clk=>clock,
		  Nk=>Nk,
		  FibCalcDone=>FibCalcDone,
	     Sum=>Sum);
R(15 downto 5) <= (others=>'0');

LastAddr<=k(5) AND k(4) AND k(3) and k(2) and k(1) and k(0);

with RamInSel select
   RAMIn <= Sum when "00",
				Q when "01",
				R when others;
				
RAMBaseAddr<=unsigned('0' & k & '0') + unsigned("00" & k);
      
end behavioral;