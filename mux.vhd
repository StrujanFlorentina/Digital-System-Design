library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity multiplexor is
	port ( SEL: in std_logic_vector (1 downto 0);
	x,m,z,t: in std_logic_vector (15 downto 0);
	y: out std_logic_vector (15 downto 0));
end multiplexor;

architecture mux of multiplexor is
begin
	process(SEL,x,m,z,t)
	begin
		case SEL is
			when "00" => y <= x;
			when "01" => y <= m;
			when "10" => y <= z;
			when "11" => y <= t;
			when others =>
		end case;
	end process;
end architecture;	