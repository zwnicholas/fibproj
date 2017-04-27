library ieee;
use ieee.std_logic_1164.all;

--ASMDIV divides a 16 bit number by a 5 bit number, for LabFinal ECE368
entity ASMDIV is
   port(a: in std_logic_vector(15 downto 0);
	     b: in std_logic_vector(4 downto 0);
		  start, clock, reset: in std_logic;
	     done: out std_logic;
		  q: out std_logic_vector(15 downto 0);
		  r: out std_logic_vector(4 downto 0));
end ASMDIV;


architecture topLevel of ASMDIV is
   component ASMDIVDP is 
	   port(ain: in std_logic_vector(15 downto 0);
	     bin: in std_logic_vector(4 downto 0);
		  clock, QShift, RLoad, RRes, AShift, ALoad, CntEn, CntLoad: in std_logic;
	     z: out std_logic;
		  rOut: buffer std_logic_vector(4 downto 0);
		  q: out std_logic_vector(15 downto 0));
	end component;
	component ASMDIVCU is
	   port(start, reset, z, clock: in std_logic;
	     done, AShift, ALoad, RLoad, RRes, QShift, CntLoad, CntEn: out std_logic);
   end component;
   signal zsig: std_logic;
	signal AShiftSig, ALoadSig, RLoadSig, RResSig, QShiftSig, CntLoadSig, CntEnSig: std_logic;
begin
dp: ASMDIVDP port map(ain=>a, bin=>b,clock=>clock, QShift=>QShiftSig, RLoad=>RLoadSig, 
                      RRes=>RResSig, AShift=>AShiftSig, ALoad=>ALoadSig, CntEn=>CntEnSig, 
							 CntLoad=>CntLoadSig,z=>zsig,rOut=>r,q=>q);
cu: ASMDIVCU port map(start=>start, reset=>reset, z=>zsig, clock=>clock,
	     done=>done, AShift=>AShiftSig, ALoad=>ALoadSig, RLoad=>RLoadSig, 
		  RRes=>RResSig, QShift=>QShiftSig, CntLoad=>CntLoadSig, CntEn=>CntEnSig);
end topLevel;