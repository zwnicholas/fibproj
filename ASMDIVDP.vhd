library ieee;
use ieee.std_logic_1164.all;

--ASMDIV divides a 16 bit number by a 5 bit number, for LabFinal ECE368
entity ASMDIVDP is
   port(ain: in std_logic_vector(15 downto 0);
	     bin: in std_logic_vector(4 downto 0);
		  clock, QShift, RLoad, RRes, AShift, ALoad, CntEn, CntLoad: in std_logic;
	     z: buffer std_logic;
		  rOut: out std_logic_vector(4 downto 0);
		  q: buffer std_logic_vector(15 downto 0));
end ASMDIVDP;


architecture components of ASMDIVDP is
component divReg6 is
      port (d : in std_logic_vector(5 downto 0);
        reset, load, clock: in std_logic;
		  q : out std_logic_vector(5 downto 0));
   end component;
	component divShftReg16 is
	   port(d : in std_logic_vector(15 downto 0);
		  clock, load, shift, serialIn: in std_logic;
		  serialOut: out std_logic;
		  q : buffer std_logic_vector(15 downto 0));
   end component;
	component divAdd6 is
	   port(a, b: in std_logic_vector(5 downto 0);
	     cin : in std_logic;
		  cout: out std_logic;
		  sum : out std_logic_vector(5 downto 0));
    end component;
	 component DIVFF is
	 port (D, Clk, R: in STD_LOGIC;
			Q : out STD_LOGIC);
	 end component;
	 component DivDnCnt is 
	 port (d : in std_logic_vector(3 downto 0);
	     count: buffer std_logic_vector(3 downto 0);
		  load, en, clock: in std_logic);
	 end component;
	 signal cout, aSerialOut: std_logic;
	 signal RRegIn: std_logic_vector(5 downto 0);
	 signal BInv : std_logic_vector(4 downto 0);
	 signal AddOut, r: std_logic_vector(5 downto 0);
	 signal CntOut: std_logic_vector(3 downto 0);
	 signal bparam: std_logic_vector(5 downto 0);
	 
begin

bparam <= '1' & BInv;

   RReg : divReg6 port map(d=>RRegIn,
        reset=>RRes, load=>RLoad, clock=>clock, q=>R);
	AReg : divShftReg16 port map(d=>ain, clock=>clock, load=>ALoad, 
	                            shift=>AShift, serialIn=>'0', serialOut=>ASerialOut, q(15)=>RRegIn(0));
   QReg : divShftReg16 port map(d=>"0000000000000000",clock=>clock, load=>'0', shift=>QShift, 
	                             serialIn=>Cout, q=>Q);
	DivCntr: DivDnCnt port map(d=>"1111", count=>CntOut, load=>CntLoad, en=>CntEn, 
	                           clock=>clock);
	Adder: divAdd6 port map(a=>R, b=>bparam, cin=>'1', cout=>cout, sum=>AddOut);
	BInv<= not Bin;
	with cout select 
	   RRegIn(5 downto 1) <=
		    AddOut(4 downto 0) when '1',
			 R(4 downto 0) when others;
	z<=NOT(CntOut(3) OR CntOut(2) OR CntOut(1) OR CntOut(0));
	rout<=r(5 downto 1);
end components;