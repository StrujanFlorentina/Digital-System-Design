library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;  
	   
entity operations is
	port(	reset: in std_logic;
	sw: in std_logic_vector(15 downto 0);
	clk: in std_logic; 
	buton_unitati: in std_logic;
	buton_zeci: in std_logic;
	mycatod:out std_logic_vector(6 downto 0);
	myanod:out std_logic_vector(3 downto 0)); 	
end entity;	   

architecture operatii of operations is	 

component adunare is
	port (SEL, SEL1: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (7 downto 0); 
	y: out std_logic_vector (15 downto 0));	
end component;

component scadere is
	port (SEL, SEL1: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (7 downto 0);
	y: out std_logic_vector (15 downto 0));	
end component;	

component inmultire is
	port (SEL,SEL1: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (7 downto 0); 
	y: out std_logic_vector (15 downto 0));	
end component;

component impartire is
	port (SEL,SEL1: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (7 downto 0); 
	y: out std_logic_vector (15 downto 0));	
end component;

component multiplexor is
	port ( SEL: in std_logic_vector (1 downto 0);
	x,m,z,t: in std_logic_vector (15 downto 0);
	y: out std_logic_vector (15 downto 0));
end component;	  

component indata is 
	port(reset: in std_logic;
	sw: in std_logic_vector (15 downto 0);
	clk: in std_logic;
	buton_unitati,buton_zeci: in std_logic;
	o: out std_logic_vector(7 downto 0));
end component;	

component BCD is
    Port ( D: in  STD_LOGIC_VECTOR (15 downto 0);
           CLK: in  STD_LOGIC;
           CAT: out  STD_LOGIC_VECTOR (6 downto 0);	 
           AN: out  STD_LOGIC_VECTOR (3 downto 0));	 
end component;

signal y,y1,y2,y3,y4: std_logic_vector (15 downto 0);	
signal outputFromSwitch: std_logic_vector(7 downto 0);
signal t1: std_logic_vector (7 downto 0) := "00000000";
signal t2: std_logic_vector(7 downto 0):= "00000000";
signal afis: std_logic_vector(15 downto 0):= "0000000000000000";

begin	

	op_0 : indata port map (reset,sw, clk, buton_unitati,buton_zeci,outputFromSwitch);
	op_1 : adunare port map (sw(14 downto 13),sw(12 downto 11),t1,t2,y1); --14 si 13 sunt sel
	op_2 : scadere port map (sw(14 downto 13),sw(12 downto 11),t1,t2,y2);  --12 si 11 sunt selectia semnului, sel1
	op_3 : inmultire port map (sw(14 downto 13),sw(12 downto 11),t1,t2,y3);
	op_4 : impartire port map (sw(14 downto 13),sw(12 downto 11),t1,t2,y4);
	mux: multiplexor port map(sw(14 downto 13),y1,y2,y3,y4,y);	-- outputul fiecarei operatii va deveni input pentru multiplexor,in functie de sel devine output final
	
	print: BCD port map(afis,clk,mycatod,myanod);
process (sw) 
begin
    case sw(10) is --cu switchul 10 selectez daca introduc numarul 1 sau 2
        when '0' => t1<= outputFromSwitch;
        when '1' => t2<= outputFromSwitch;	
		when others => 
    end case;
end process;

process (sw)
begin
	case sw(15) is --15 e egalul operatiei
		when '0' => afis(7 downto 0) <= outputFromSwitch;
      when '1' => afis <= y;	
		when others => afis <= (others => '0');
    end case;
end process;


end operatii;	