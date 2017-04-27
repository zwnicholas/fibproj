Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Entity fibmodule is
   port(FibCalcInit, FibRegEn, FibRegReset : in std_logic;
	     nCntrEn, nCntrReset : in std_logic;
		  clk: in std_logic;
		  Nk: in std_logic_vector(4 downto 0);
		  FibCalcDone: out std_logic;
	     Sum: buffer std_logic_vector(15 downto 0));
--		  FibOldOut, FibNewOut: out std_logic_vector(15 downto 0);
--		  nOut: out std_logic_vector(4 downto 0));
end fibmodule;

Architecture components of fibmodule is
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

component CMP5 is
 port(a, b: in std_logic_vector(4 downto 0);
      isEqual: out std_logic);
end component;

signal n: std_logic_vector(4 downto 0);
signal FibOld, FibNew, FibNewRegIn,FibAddOut,FibSumOut: std_logic_vector(15 downto 0);
begin
FibOldReg: genericReg 
					generic map(N => 16)
					port map(D=>FibNew,En=>FibRegEn,clk=>clk,Reset=>FibRegReset,Q=>FibOld);
FibNewReg: genericReg 
					generic map(N => 16)
					port map(D=>FibNewRegIn,En=>FibRegEn,clk=>clk,Reset=>FibRegReset,Q=>FibNew);
SumReg : genericReg 
					generic map(N => 16)
					port map(D=>FibSumOut,En=>FibRegEn,clk=>clk,Reset=>FibRegReset,Q=>Sum);
nCntr : GenericCounter
					port map(clk=>clk, Reset=>nCntrReset, En=>nCntrEn, Z=>n);
Comp  : CMP5   port map(a=>Nk, b=>n, isEqual=>FibCalcDone);
					
FibSumOut<=Sum+FibNew;
FibAddOut<=FibNew+FibOld;
with FibCalcInit  select
     FibNewRegIn<=
	      "0000000000000001" when '1',
	      FibAddOut when others;

--FibOldOut<=FibOld;
--FibNewOut<=FibNew;
--nOut<=n;
end architecture;