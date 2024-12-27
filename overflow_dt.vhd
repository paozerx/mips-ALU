library ieee;
use ieee.std_logic_1164.all;

entity overflow_dt is
port( a, b, sum : in std_logic;
      overflow: out std_logic);
end overflow_dt;

architecture data_flow of overflow_dt is
begin

	overflow <= (a and b and (not sum)) or ((not a) and (not b) and sum);
	
end data_flow;
