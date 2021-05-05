library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity indata is 
	port(sw: in std_logic_vector(15 downto 0);
	clk: in std_logic;
	buton_unitati: in std_logic;
	buton_zeci: in std_logic;
	reset: in std_logic;
	o: out std_logic_vector(7 downto 0));
end indata;

architecture intrari of indata is

component VHDL_Code_Debounce is
	Port (
	DATA: in std_logic;
	CLK : in std_logic;
	OP_DATA : out std_logic);
end component;

signal aux,aux1: std_logic_vector(3 downto 0);	
signal buton_unitati_rezolvat: std_logic;
signal buton_zeci_rezolvat: std_logic;
signal reset_rezolvat: std_logic;
begin
operatie_1: VHDL_Code_Debounce  port map (buton_unitati,clk,buton_unitati_rezolvat);
operatie_2: VHDL_Code_Debounce  port map (buton_zeci,clk,buton_zeci_rezolvat);
resetul: VHDL_Code_Debounce  port map (reset,clk,reset_rezolvat);
process(buton_unitati_rezolvat,sw,reset_rezolvat)
	begin
	if rising_edge(reset_rezolvat) then
		aux1<="0000";
		end if;
	if rising_edge(buton_unitati_rezolvat) then
	   	case sw(9 downto 0) is
            when "1000000000" => aux1 <="0000"; -- 0
            when "0100000000" => aux1 <="0001"; -- 1
            when "0010000000" => aux1 <="0010"; -- 2
            when "0001000000" => aux1 <="0011"; -- 3
            when "0000100000" => aux1 <="0100"; -- 4
            when "0000010000" => aux1 <="0101"; -- 5
            when "0000001000" => aux1 <="0110"; -- 6
            when "0000000100" => aux1 <="0111"; -- 7
            when "0000000010" => aux1 <="1000"; -- 8
            when "0000000001" => aux1 <="1001"; -- 9
            when others =>
            end case; 	
	end if;
end process;

process(buton_zeci_rezolvat,sw,reset_rezolvat)
	begin
	if rising_edge(reset_rezolvat) then
		aux<="0000";
		end if;
	if rising_edge(buton_zeci_rezolvat) then
        case sw(9 downto 0) is
                when "1000000000" => aux <="0000"; -- 0
                when "0100000000" => aux <="0001"; -- 1
                when "0010000000" => aux <="0010"; -- 2
                when "0001000000" => aux <="0011"; -- 3
                when "0000100000" => aux <="0100"; -- 4
                when "0000010000" => aux <="0101"; -- 5
                when "0000001000" => aux <="0110"; -- 6
                when "0000000100" => aux <="0111"; -- 7
                when "0000000010" => aux <="1000"; -- 8
                when "0000000001" => aux <="1001"; -- 9
                when others =>
                end case; 	
		end if;
end process;

	

o<="00000000"+ aux*"1010" + aux1; 

end architecture;