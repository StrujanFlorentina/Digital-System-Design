library ieee;
use ieee.std_logic_1164.all;
 
entity VHDL_Code_Debounce is
Port (
DATA: in std_logic;
CLK : in std_logic;
OP_DATA : out std_logic);
end VHDL_Code_Debounce ;
 
architecture Behavioral of VHDL_Code_Debounce is
 
Signal OP1, OP2, OP3: std_logic;
 
begin 
	Process(CLK)
	begin
	if rising_edge(CLK) then				 --front crescator

		OP1 <= DATA;
		OP2 <= OP1;
		OP3 <= OP2;
 
end if;
 
end process;
 
	OP_DATA <= OP1 and OP2 and OP3;
 
end Behavioral;