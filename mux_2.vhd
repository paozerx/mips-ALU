library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_2 is
    Port ( input_1 : in STD_LOGIC;
			  input_2 : in STD_LOGIC;
			  enable : in std_logic;
           output : out STD_LOGIC);
end mux_2;

architecture Behavioral of mux_2 is
begin
	process(input_1,input_2,enable)
	begin
		case enable is
			when '0' => 
				output <= input_1 ;
			when '1' => 
				output <= input_2;
		end case;
	end process;
end Behavioral;