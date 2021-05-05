library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity BCD is
    Port ( D: in  STD_LOGIC_VECTOR (15 downto 0);
           CLK: in  STD_LOGIC;
           CAT: out  STD_LOGIC_VECTOR (6 downto 0);	 
           AN: out  STD_LOGIC_VECTOR (3 downto 0));	 
end BCD;

architecture ARHBCD of BCD is
signal NR:std_logic_vector(15 downto 0):=x"0000";
signal MUX1:std_logic_vector(3 downto 0);
signal MUX2:std_logic_vector(3 downto 0);
signal numar,sute,zeci,unitati: integer;
signal semn : std_logic_vector(3 downto 0);	 
signal sute1 , zeci1 , unitati1: std_logic_vector(3 downto 0);
component conversie is
	port(A: in integer;
	B: out std_logic_vector(3 downto 0));
end	component;
begin		
process(CLK)
begin
	if CLK='1' and CLK'EVENT then	 --Divizor de frecventa
		NR<=NR+1;
	end if;
end process;   

process(D)
begin
	numar<= conv_integer(D(14 downto 0));
	sute<= numar/100;
	zeci<=(numar -sute*100)/10;
	unitati<=numar - sute*100 - zeci*10; 
	if (D(15)='1') then
		semn<="1010";
		else 
		semn<="0000";
	end if;
end process;

a: conversie port map (sute, sute1);
b: conversie port map (zeci, zeci1);
c: conversie port map (unitati, unitati1);

process(NR,MUX2,semn,sute,zeci,unitati)
	begin
	if (sute > 9) then
	case(NR(15 downto 14)) is
		when "00" => MUX1<="1110";
		when "01" => MUX1<="1101";
		when "10" => MUX1<="1100";
		when "11" => MUX1<="1011";
		when others => MUX1<="0000";
	end case;
	else
	case(NR(15 downto 14)) is
		when "00" => MUX1<=unitati1;
		when "01" => MUX1<=zeci1;
		when "10" => MUX1<=sute1;
		when "11" => MUX1<=semn;
		when others => MUX1<="0000";
	end case;
	end if;
end process;
	process(NR,MUX2) 
	begin
	case(NR(15 downto 14)) is
		when "00" => MUX2<="1110";
		when "01" => MUX2<="1101";
		when "10" => MUX2<="1011";
		when "11" => MUX2<="0111";
		when others => MUX2<="0000";
	end case;
    AN<=MUX2;
	end process;
with MUX1 select
   CAT<= "1000000" when "0000",   --0
			"1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0111111" when "1010",   --semnul minus
			"0001110" when "1011",   --F
			"0001000" when "1100",   --A
			"1111001" when "1101",   --I
			"1000111" when "1110",   --L
         "1000000" when others;   --0

end ARHBCD;