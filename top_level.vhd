library ieee;
use ieee.std_logic_1164.all;
entity top_level is
generic ( N : integer := 32 );
port( a, b : in std_logic_vector(N-1 downto 0);
        M,a_inv,b_inv     : in std_logic;
        operator: in std_logic_vector(3 downto 0);
        c_out : buffer std_logic;
        Over_flow,zero : out std_logic;
        result: out std_logic_vector(N-1 downto 0) );
end top_level;

architecture Behavioral of top_level is
    component mip_alu
        port( a, b,a_inv,b_inv,less, c_in: in std_logic;
              operator: in std_logic_vector(3 downto 0);
              c_out, result  : out std_logic);
    end component;
    
    signal x : std_logic_vector(N downto 0);
    signal set_x : std_logic;
    signal result_x : std_logic_vector(N-1 downto 0);
    signal zero_x : std_logic;
    
begin
    x(0) <= M;
         
    alu: for i in 0 to N-1 generate
        L0: if i = 0 generate
            FA_i: entity WORK.mip_alu(data_flow)
                port map (c_in => x(0), a => a(i), b => b(i),a_inv => a_inv ,b_inv => b_inv,
                         less => set_x, operator => operator, c_out => x(i+1),
                         result => result_x(i));
        end generate;
        
        L1: if i > 0 and i < (N-1) generate
            FA_i: entity WORK.mip_alu(data_flow)
                port map (c_in => x(i), a => a(i), b => b(i),a_inv => a_inv ,b_inv => b_inv,
                         less => '0', operator => operator,c_out => x(i+1), 
                         result => result_x(i));
        end generate;
        
        L2: if i = (N-1) generate
            FA_i: entity WORK.mip_alu_sign(Behavioral)
                port map (c_in => x(i), a => a(i), b => b(i),a_inv => a_inv ,b_inv => b_inv,
                         less => '0',operator => operator,c_out => c_out,
                         overflow => Over_flow ,set => set_x ,result => result_x(i));
        end generate;
    end generate;


    process(result_x)
        variable temp : std_logic;
    begin
        temp := '0';
        for i in result_x'range loop
            temp := temp or result_x(i);
        end loop;
        zero_x <= not temp;
    end process;

    zero <= zero_x;
    result <= result_x;
    
end Behavioral;