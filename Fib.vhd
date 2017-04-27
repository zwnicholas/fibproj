Library ieee;
Use ieee.std_logic_1164.all;

Entity Fib is
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
End Fib;

Architecture behavioral of Fib is
	component Datapath is 
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
							kO: out std_logic_vector(5 downto 0)    ;
							NkO:out std_logic_vector(4 downto 0) 	);
											
	end component;	
	
	component ControlUnit is
	port(KCntrReset, ROMen, NcntrReset, NKRegEn, FibRegReset: out std_logic;
	     FibCalcInit, FibRegEn, nCntrEn, DivStart, RAMAddrCntrL: out std_logic;
		  RAMen, RAMrw,RAMAddrCntrEn, kCntrEn, DoneSig: out std_logic;
		  RAMInSel: out std_logic_vector(1 downto 0);
		 start, Reset, FibCalcDone, DivDone, LastAddr, Clock: in std_logic);
	end component;
	
signal ROMen, RAMen, RAMrw, kCntrReset, kCntrEn: std_logic;
signal							nCntrEn, nCntrReset :  std_logic;
signal											NkRegEn :  std_logic;
signal				  RAMAddrCntrL, RAMAddrCntrEn :  std_logic;
signal		FibCalcInit, FibRegEn, FibRegReset :  std_logic;
signal										  DivStart :  std_logic;
signal										  RAMInSel :  std_logic_vector(1 downto 0);
signal											  Q, R,Sum  :  std_logic_vector(15 downto 0);
signal			LastAddr, FibCalcDone, DivDone  : std_logic;
signal	k : std_logic_vector(5 downto 0);
signal Nk : std_logic_vector(4 downto 0);
	
begin	
dp : Datapath port map(ROMen=>ROMen, RAMen=>RAMen, RAMrw=>RAMrw, 
								kCntrReset=>kCntrReset, kCntrEn=>kCntrEn,
												nCntrEn=>nCntrEn, nCntrReset=>nCntrReset,
																NkRegEn=>NkRegEn,
																clock=>Clk,
									  RAMAddrCntrL=>RAMAddrCntrL, RAMAddrCntrEn=>RAMAddrCntrEn,
							FibCalcInit=>FibCalcInit, FibRegEn=>FibRegEn, FibRegReset=>FibRegReset,
															  DivStart=>DivStart,
															  RAMInSel=>RAMInSel,
															     Q=>Q, R=>R, Sum=>Sum,
															  -- Q & R are output from divider
											RAMOut=>RAMOut,
								LastAddr=>LastAddr, FibCalcDone=>FibCalcDone, DivDone=>DivDone,
								kO=>k, NkO=>Nk);

cu : ControlUnit port map(KCntrReset=>KCntrReset,ROMen=>ROMen, NcntrReset=>NcntrReset,
			NKRegEn=>NKRegEn, FibRegReset=>FibRegReset,
	     FibCalcInit=>FibCalcInit, FibRegEn=>FibRegEn, nCntrEn=>nCntrEn, DivStart=>DivStart,
		  RAMAddrCntrL=>RAMAddrCntrL,RAMen=>RAMen, RAMAddrCntrEn=>RAMAddrCntrEn, kCntrEn=>kCntrEn, DoneSig=>Done,
		  RAMInSel=>RAMInSel,RAMrw=>RAMrw,start=>start, Reset=>Reset, FibCalcDone=>FibCalcDone,
		  DivDone=>DivDone, LastAddr=>LastAddr, Clock=>Clk);

		  
ROMenO<=ROMen; RAMenO<=RAMen; RAMrwO<=RAMrw; kCntrResetO<=kCntrReset; kCntrEnO<=kCntrEn;
							nCntrEnO<=nCntrEn; nCntrResetO<=nCntrReset;
											NkRegEnO<=NkRegEn;
				  RAMAddrCntrLO<=RAMAddrCntrL; RAMAddrCntrEnO<=RAMAddrCntrEn;
		FibCalcInitO<=FibCalcInit; FibRegEnO<=FibRegEn; FibRegResetO<=FibRegReset;
										  DivStartO<=DivStart;
										  RAMInSelO<= RAMInSel;
											  QO<=Q; RO<=R; SumO<=Sum;
			LastAddrO<=LastAddr; FibCalcDoneO<=FibCalcDone; DivDoneO<=DivDone;		  

kO<=k;
NkO<=Nk;
			
end behavioral;
	