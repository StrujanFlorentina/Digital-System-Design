library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity BCD is
    Port ( D: in  STD_LOGIC_VECTOR (15 downto 0);
           CLK: in  STD_LOGIC;
           CAT: out  STD_LOGIC_VECTOR (6 downto 0);	 --catode part; BCD 7 segment, am 7 segments
           AN: out  STD_LOGIC_VECTOR (3 downto 0));	 --anode part
end BCD;

architecture ARHBCD of BCD is
signal NR:std_logic_vector(15 downto 0):=x"0000";
signal MUX1:std_logic_vector(3 downto 0):="0000";
signal MUX2:std_logic_vector(3 downto 0):="0000";
signal D0 : std_logic_vector(3 downto 0):=D(15 downto 12);
signal D1 : std_logic_vector(3 downto 0):=D(11 downto 8);
signal D2 : std_logic_vector(3 downto 0):=D(7 downto 4);
signal D3 : std_logic_vector(3 downto 0):=D(3 downto 0); 
begin
process(CLK)
begin
	if CLK='1' and CLK'EVENT then	 --Clock divider
		NR<=NR+1;
	end if;
end process;  

process(NR,MUX2,D0,D1,D2,D3)
	begin
	case(NR(15 downto 14)) is
		when "00" => MUX1<=D3;
		when "01" => MUX1<=D2;
		when "10" => MUX1<=D1;
		when "11" => MUX1<=D0;
		when others => MUX1<="0000";
	end case;
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
   CAT<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "0100001" when "1101",   --d
         "0000110" when "1110",   --E
         "0001110" when "1111",   --F
         "1000000" when others;   --0

end ARHBCD;