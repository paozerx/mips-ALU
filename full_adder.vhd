library ieee;
use ieee.std_logic_1164.all;

entity full_adder is 
	port(
		a, b, c_in : in std_logic;
		c_out, sum : out std_logic
	);
end full_adder;

architecture data_flow of full_adder is
begin  
	c_out <= ((a xor b) and c_in) or (a and b);
	sum <= (a xor b) xor c_in;
end data_flow;