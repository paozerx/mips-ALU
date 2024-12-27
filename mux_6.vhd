library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_6 is
    Port ( input_1 : in STD_LOGIC;
			  input_2 : in STD_LOGIC;
			  input_3 : in STD_LOGIC;
			  input_4 : in STD_LOGIC;
			  input_5 : in STD_LOGIC;
			  input_6 : in STD_LOGIC;
			  enable : in STD_LOGIC_VECTOR(3 downto 0);
           output : out STD_LOGIC);
end mux_6;

architecture Behavioral of mux_6 is
begin
	process(input_1,input_2,input_3,input_4,enable)
	begin
		case enable is
			when "0000" => 
				output <= input_1 ;
			when "0001" => 
				output <= input_2;
			when "0010" => 
				output <= input_3 ;
			when "0110" => 
				output <= input_4;
			when "0111" => 
				output <= input_5 ;
			when "1100" => 
				output <= input_6;
			when others =>
				output <= '0';
		end case;
	end process;
end Behavioral;