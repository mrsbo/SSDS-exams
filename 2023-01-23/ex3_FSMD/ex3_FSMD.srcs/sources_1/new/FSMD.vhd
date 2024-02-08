----------------------------------------------------------------------------------
-- Exam:        2023-01-23 
-- Exercise:    3: FSM-D
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

entity FSMD is
    port(
        a : in std_logic_vector(7 downto 0);
        b : in std_logic_vector(7 downto 0);
        start : in std_logic;
        lcm : out std_logic_vector(15 downto 0);
        ready : out std_logic;
        clk, rst : in std_logic);       
end FSMD;

architecture Behavioral of FSMD is
    -- Controller signals
    type StateType is (idle, calc);
    signal state, nextState : StateType;
    
    -- Shared signals
    -- DP input contorl signals (from Controller)
    signal acquire : std_logic;
    signal calculate : std_logic;     -- Memory var set to 1 from start trigger to ready output
    
    -- DP output contorl signals (to Controller)
    signal done : std_logic;
    
    -- DP singals    
    signal m, nextM, n, nextN : unsigned(15 downto 0);
    signal initialA, initialB : unsigned(7 downto 0);
    
    
begin
    -- Controller
    CtrlReg: process(clk, rst)
    begin
        if (rst = '1') then
            state <= idle;           
        elsif (rising_edge(clk)) then
            state <= nextState;
        end if;
    end process CtrlReg;
        
    CtrlCombLog: process(state, start, done)
    begin
        acquire <= '0';
        ready <= '0';
        calculate <= '0';    
        case state is
            when idle => 
                if (start = '1') then
                    acquire <= '1';                    
                    nextState <= calc;
                else  
                    nextState <= idle;  
                end if;
                                
            when calc => 
                calculate <= '1';
                if (done = '1') then
                   ready <= '1';
                   nextState <= idle;
                else                      
                    nextState <= calc;  
                end if;
            end case;
        end process CtrlCombLog;                
            
    -- DP             
    DPReg: process(clk, rst)
    begin
        if (rst = '1') then            
            m <= (others => '0');
            n <= (others => '0');
        elsif (rising_edge(clk)) then
            m <= nextM;
            n <= nextN;
        end if;
    end process DPReg;
        
    process(acquire, m, n)
    begin
        done <= '0';
        nextM <= m;
        nextN <= n;
        
        if (acquire = '1') then
            initialA <= unsigned(a);
            initialB <= unsigned(b);
            nextM <= unsigned("00000000" & a);
            nextN <= unsigned("00000000" & b);  
        end if;
        
        if (calculate = '1') then
            if (m = n) then
                done <= '1';
            elsif (m < n) then
                nextM <= m + initialA;
            else
                nextN <= n + initialB;
            end if;
        end if;
        
        lcm <= std_logic_vector(m);
                    
        end process;                
            
        lcm <= std_logic_vector(m);                
                                
end Behavioral;
