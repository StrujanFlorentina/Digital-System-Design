library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity inmultire is
	port (	SEL, SEL1 : in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (7 downto 0);
	y: out std_logic_vector (15 downto 0));	
end entity;	

architecture multiplication of inmultire is 
begin				 
	process ( SEL , SEL1 , a , b )
variable r: std_logic_vector (7 downto 0);
variable z: std_logic_vector (15 downto 0);
variable k:integer;
 begin
	 if(SEL="10") then
		 if( SEL1="00") then					 --ambele numere pozitive
		   if(b /= "0000000000000000") then		  -- b diferit de 0
	 		z:= "0000000000000000";				  
			r := "00000000";
			for k in 1 to 128 loop		   
			if (r < b) then 	  
				z := z+a;  			   -- se aduna a de b-1 ori
				r := r + '1';		   -- se numara adunarile, apoi se compara cu b
				end if;
			end loop;  
			y<= z;
			else 
			y <="0000000000000000";
		   end if;	
		 end if;
		   if( SEL1="11") then					  --ambele numere negative
		   if(b /= "0000000000000000") then		  -- b diferit de 0
	 		z:= "0000000000000000";				  
			r := "00000000";
			for k in 1 to 128 loop		   
			if (r < b) then 	  
				z := z+a;  			   -- se aduna a de b-1 ori
				r := r + '1';		   -- se numara adunarile, apoi se compara cu b
				end if;
			end loop;  
			y <= z;  
			else 
			y <="0000000000000000";
		   end if; 
		   end if;
		   if( SEL1="10") then					  --primul nr negativ, al doilea pozitiv
		   if(b /= "0000000000000000") then		  -- b diferit de 0
	 		z:= "1000000000000000";				  
			r := "00000000";
			for k in 1 to 128 loop		   
			if (r < b) then 	  
				z := z+a;  			   -- se aduna a de b-1 ori
				r := r + '1';		   -- se numara adunarile, apoi se compara cu b
				end if;
			end loop;  
			y<= z;
			else 
			y <="0000000000000000";
		   end if; 
		   end if;
		   if( SEL1="01") then					  --primul nr pozitiv, al doilea negativ
		   if(b /= "0000000000000000") then		  -- b diferit de 0
	 		z:= "1000000000000000";				  
			r := "00000000";
			for k in 1 to 128 loop		   
			if (r < b) then 	  
				z := z+a;  			   -- se aduna a de b-1 ori
				r := r + '1';		   -- se numara adunarile, apoi se compara cu b
				end if;
			end loop;  
			y<= z;	
			else 
			y <="0000000000000000";
		   end if;   					
		end if;	
	end if;	
			
   end process;
end architecture;	