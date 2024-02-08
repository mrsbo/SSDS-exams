----------------------------------------------------------------------------------
-- Exam:        2023-01-23 
-- Exercise:    3: HLSM
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HLSM is
    port(
        a : in std_logic_vector(7 downto 0);
        b : in std_logic_vector(7 downto 0);
        start : in std_logic;
        lcm : out std_logic_vector(15 downto 0);
        ready : out std_logic;
        clk, rst : in std_logic);       
end HLSM;

architecture Behavioral of HLSM is
    
    type StateType is (idle, calc);
    signal state, nextState : StateType;
    
    signal m, nextM, n, nextN : unsigned(15 downto 0);
    signal initialA, initialB : unsigned(7 downto 0);
    
begin
    
    process(clk, rst)
    begin
        if (rst = '1') then
            state <= idle;
            m <= (others => '0');
            n <= (others => '0');
        elsif (rising_edge(clk)) then
            state <= nextState;
            m <= nextM;
            n <= nextN;
        end if;
    end process;
        
    process(state, start, m, n)
    begin
        nextM <= m;
        nextN <= n;
        ready <= '0';
        
        case state is
            when idle => 
                if (start = '1') then
                    initialA <= unsigned(a);
                    initialB <= unsigned(b);
                    nextM <= unsigned("00000000" & a);
                    nextN <= unsigned("00000000" & b);  
                    nextState <= calc;
                else  
                    nextState <= idle;  
                end if;
                
                
            when calc => 
                if (m = n) then
                   ready <= '1';
                   nextState <= idle;
                elsif (m < n) then
                    nextM <= m + initialA;
                    nextState <= calc;
                else    
                    nextN <= n + initialB;
                    nextState <= calc;  
                end if;
            end case;
        end process;                
            
        lcm <= std_logic_vector(m);                
                                
end Behavioral;
