library ieee;
use ieee.std_logic_1164.all;

entity ASMDIVCU is
   port(start, reset, z, clock: in std_logic;
	     done, AShift, ALoad, RLoad, RRes, QShift, CntLoad, CntEn: out std_logic);
end ASMDIVCU;

architecture twoProc of ASMDIVCU is
type divState_t is (DivRes, DivInit, DivMain, DivDone);
signal divState: divState_t;
begin
--next state process
next_state_proc: process (clock, reset) is
begin
if reset = '1' then
   divState<=DivRes;
elsif clock'event and clock = '1' then
   case divState is 
      when DivRes => 
		   if start ='1' then
		      divState<=DivInit;
			else
			   divState<=DivRes;
			end if;
		when DivInit =>
		     divState <=DivMain;
	   when DivMain=>
		   if z = '1' then
			  divState <= divDone;
			else
			  divState <= divMain;
			end if;
		when DivDone=>
		   if start = '1' then
			  divState<=DivDone;
			else
			  divState<=DivRes;
         end if;
		when others=>
		    divState<=DivRes;
	end case;
end if;
end process next_state_proc;
--output generation process
output_gen: process(divState) is
begin

   case divState is
	   when DivRes=>
		      done<='0';
	         AShift<='0'; 
	         ALoad<='1'; 
	         RLoad<='0'; 
	         RRes<='1'; 
	         QShift<='0';
	         CntLoad<='1';
	         CntEn<='0';
	   when DivInit =>
		      done<='0';
	         AShift<='1'; 
	         ALoad<='0'; 
	         RLoad<='1'; 
	         RRes<='0'; 
	         QShift<='0';
	         CntLoad<='0';
	         CntEn<='0';
	   when DivMain =>
		      done<='0';
	         AShift<='1'; 
	         ALoad<='0'; 
	         RLoad<='1'; 
	         RRes<='0'; 
	         QShift<='1';
	         CntLoad<='0';
	         CntEn<='1';
		when DivDone=>
		      done<='1';
	         AShift<='0'; 
	         ALoad<='0'; 
	         RLoad<='0'; 
	         RRes<='0'; 
	         QShift<='0';
	         CntLoad<='0';
	         CntEn<='0';
	end case;

end process output_gen;


end twoProc;