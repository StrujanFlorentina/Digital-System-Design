library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity scadere is
	port (SEL,SEL1: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (7 downto 0);
	y: out std_logic_vector (15 downto 0));	
end entity;	
	
architecture subtraction of scadere is  		   
begin		
	process(SEL,SEL1,a,b)  
	variable z: std_logic_vector(15 downto 0);
	begin		  
	if(SEL="01") then	 
		if(SEL1="00")then				
		  if(a<=b)then	
			  z := "1000000000000000";
			  z(7 downto 0) := b-a;		
		  else	
			  z := "0000000000000000";
			  z(7 downto 0) := a-b;
		  end if;
		end if;
		if(SEL1="11") then				
		  if(a<=b)	then
			  z := "0000000000000000";
			  z(7 downto 0) := b-a;		
		  else
			  z := "1000000000000000";
			  z(7 downto 0) := a-b;
		  end if;
		end if;
		if (SEL1="01") then
			z := "0000000000000000";
			z :=z+a+b;
		end if;
		if (SEL1="10") then
			z := "1000000000000000";
			z :=z+a+b;
		end if;
	end if;	 
	y <= z;
	end process;	
end architecture;			
	
	