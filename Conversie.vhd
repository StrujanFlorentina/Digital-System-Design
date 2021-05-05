library ieee;
use ieee.std_logic_1164.all;

entity conversie is
	port(A: in integer;
	B: out std_logic_vector(3 downto 0));
end conversie;

architecture binar of conversie is
begin	
	process(A)
	begin
		case A is
			when 0 => B<="0000";
		when 1 => B<="0001";
		when 2 => B<="0010";
		when 3 => B<="0011";
		when 4 => B<="0100";
		when 5 => B<="0101";
		when 6 => B<="0110";
		when 7 => B<="0111";
		when 8 => B<="1000";
		when 9 => B<="1001";
		when others => B<="0000";
	end case;  
	end process;
end binar;

	
	