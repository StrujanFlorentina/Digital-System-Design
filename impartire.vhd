library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity impartire is
	port (	SEL,SEL1: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (7 downto 0);
	y: out std_logic_vector (15 downto 0));	
end entity;	

architecture division of impartire is 
begin				 
	process(SEL,SEL1,a,b)
variable cat: std_logic_vector (15 downto 0);
variable z: std_logic_vector (15 downto 0);
variable k:integer;
 begin
	 if(SEL="11") then 	   
		 if(SEL1="00") then
		  if(b /= "0000000000000000") then		  -- daca b e diferit de 0
	 		z:= "0000000000000000";				  	  -- cat si z sunt 0
			cat := "0000000000000000";
			z := z+a;
			for k in 1 to 128 loop		   -- scadem z repetat cat timp z e mai mare sau egal cu b
			if (z >= b) then 	  
				z := z-b;  
				cat := cat + '1';		   -- numaram scaderile
				end if;
			end loop;  	  
			y<= cat;         -- restul este incarcat in primii 8 biti ai outputului
		  else
			y <="1111111111111111";			-- afisam FAIL
		end if;	
		end if;
		if(SEL1="01") then
		  if(b /= "0000000000000000") then		  -- daca b e diferit de 0
	 		z:= "0000000000000000";				  	  --z e 0 
			cat := "1000000000000000";           -- numerele de sens opusa rezulta un cat negativ
			z := z+a;
			for k in 1 to 128 loop		   -- scadem z repetat 
			if (z >= b) then 	  
				z := z-b;  
				cat := cat + '1';		   -- numaram scaderile
				end if;
			end loop;  																
			y<= cat;         
		  else
			y <="1111111111111111";			-- afisam FAIL
		end if;	
		end if;
		if(SEL1="10") then
		  if(b /= "0000000000000000") then		  
	 		z:= "0000000000000000";				  	  
			cat := "1000000000000000";	
			z := z+a;
			for k in 1 to 128 loop		   
			if (z >= b) then 	  
				z := z-b;  
				cat := cat + '1';		  
				end if;
			end loop;  															   
			y<= cat;         
		  else
			y <="1111111111111111";			
		end if;	   
		end if;
		if(SEL1="11") then
		  if(b /= "0000000000000000") then		  
	 		z:= "0000000000000000";				  	  
			cat := "0000000000000000"; 
			z := z+a;
			for k in 1 to 128 loop		   
			if (z >= b) then 	  
				z := z-b;  
				cat := cat + '1';		   
				end if;
			end loop;  									   
			y<= cat;      
		  else
			y <="1111111111111111";			
		end if;
		if (a<b) then						   -- daca a < b atunci catul este 0
			y<= "0000000000000000";
		end if;	 
		end if;
	end if;			
   end process;
end architecture;	