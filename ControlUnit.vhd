--Asm for final project.  Written by Matt Goralka with the help of Steven Leib and Zach Nicholas

library ieee;
use ieee.std_logic_1164.all;

ENTITY ControlUnit is
	port(KCntrReset, ROMen, NcntrReset, NKRegEn, FibRegReset: out std_logic;
	     FibCalcInit, FibRegEn, nCntrEn, DivStart, RAMAddrCntrL: out std_logic;
		  RAMen, RAMAddrCntrEn, kCntrEn, DoneSig: out std_logic;
		  RAMInSel: out std_logic_vector(1 downto 0);
		 start, Reset, FibCalcDone, DivDone, LastAddr, Clock: in std_logic);
		 
end ControlUnit;

Architecture behavior of ControlUnit is
type state_type is(ResetState, ROMRead, FibLoop, Divide, StrS, StrQ,
						StrR, Done);
						
		signal state: state_type;
		
		Begin
		FSM_transitions:Process(Reset, Clock)
	begin
			if Reset = '1' then
				state <= ResetState;
			Elsif(Clock'EVENT and Clock = '1') then
				case state is
					when ResetState =>
						if start ='1' then state <= ROMRead; ELSE state <= ResetState; END IF;
					when ROMRead =>
						state <= FibLoop;
					--when FibInit =>
						--state <= FibLoop;
					when FibLoop=>
						if FibCalcDone <= '0' then state <= FibLoop; else state <= Divide; End IF;
					when Divide =>
						if DivDone <= '0' then state <= Divide; else state <= StrS; end if;
					when StrS =>
						state <= StrQ;
					When StrQ =>
						state <= StrR;
					When StrR =>
						if LastAddr <= '0' then state <= ROMRead; else state <= Done; end if;
					when Done =>
						if Start = '0' then State <= ResetState; else State <= Done; end if;
				end case;
			end if;
		end process;
		
		FSM_outputs: PROCESS(state)
		Begin
			KCntrReset <= '0'; ROMen <= '0'; NcntrReset <= '0'; NKRegEn <= '0'; FibRegReset <= '0'; FibCalcInit <= '0';
			FibRegEn <= '0'; nCntrEn <= '0'; DivStart <= '0'; RAMAddrCntrL <= '0'; RAMinSel <= "00"; RAMen <= '0'; RAMAddrCntrEn <='0'; 
			KCntrEn <= '0'; DoneSig <= '0';
			Case state is
				when ResetState =>
					KCntrReset <= '1';
					NcntrReset <= '1';
					FibRegReset <= '1';
					DoneSig <= '0';
				when ROMRead =>
					ROMen <= '1';
					NKRegEn <= '1';
					FibCalcInit <= '1';
					FibRegEn <= '1';
					nCntrEn <= '1';
				when FibLoop =>
					FibRegEn <= '1';
					nCntrEn <= '1';
				when Divide =>
					DivStart <= '1';
					RAMAddrCntrL <= '1';
				when StrS =>
				   DivStart<='1';
					RAMinSEL <= "00";
					RAMen <= '1';
					RAMAddrCntrEn <= '1';
					
				when StrQ =>
				   DivStart<='1';
					RAMinSEL <= "01";
					RAMen <= '1';
					RAMAddrCntrEn <= '1';
				
				when StrR =>
					RAMinSEL <= "10";
					RAMen <= '1';
				   FibRegReset <= '1';
					nCntrReset <='1';
					kCntrEn<='1';
				when Done =>
					if start <= '0' then DoneSig <= '1'; end if;
			end case;
		end process;

end behavior;
			
						