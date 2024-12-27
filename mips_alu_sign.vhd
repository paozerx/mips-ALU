library ieee;
use ieee.std_logic_1164.all;

entity mip_alu_sign is
port( a, b,a_inv,b_inv,less : in std_logic;
		c_in	  : in std_logic;
		operator: in std_logic_vector(3 downto 0);
		c_out : out std_logic;
		overflow, set : out std_logic;
      result: out std_logic);
end mip_alu_sign;

architecture Behavioral of mip_alu_sign is
signal sum1 : std_logic;
signal a_x : std_logic;
signal b_x : std_logic;
signal sum_or : std_logic;
signal sum_and : std_logic;
signal sum_nor : std_logic;

begin
	mux2a: 			entity work.mux_2(Behavioral)
									port map(
										input_1 => a,
										input_2 => not(A),
										enable => a_inv,
										output => a_x);
	mux2b: 			entity work.mux_2(Behavioral)
									port map(
										input_1 => b,
										input_2 => not(b),
										enable => b_inv,
										output => b_x);
										
	process (a)
		begin
			if a = '0' and b = '1' then
				set <= '1';
			else
				set <= '0';
			end if;
		end process;
	
	sum_or <= a_x or b_x;
	sum_and <= a_x and b_x;
	sum_nor <= not(a_x or b_x);
	
	
	fulladder: 			entity work.full_adder(data_flow)
									port map(
										a => a_x,
										b => b_x,
										c_in => c_in,
										c_out => c_out,
										sum => sum1);
	overflow_dt: 			entity work.overflow_dt(data_flow)
									port map(
										a => a_x,
										b => b_x,
										sum => sum1,
										overflow => overflow);
	mux_result: 			entity work.mux_6(Behavioral)
									port map(
										input_1 => sum_and,
										input_2 => sum_or,
										input_3 => sum1,
										input_4 => sum1,
										input_5 => less,
										input_6 => sum_nor,
										enable => operator,
										output => result);


	
	  

end Behavioral;
