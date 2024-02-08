----------------------------------------------------------------------------------
-- Exam:        2023-04-13 
-- Exercise:    3: FSMD
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
        a, b :  in  std_logic_vector(7 downto 0);
        z :     out std_logic_vector(15 downto 0);
        start : in  std_logic;
        ready : out std_logic;
        clk, rst : in std_logic
        );
end FSMD;

architecture Behavioral of FSMD is

-- States definition
type StateType is (idle, calc);
signal state, nextState : StateType;

-- Shared signals
-- DP input control signals
signal acquire : std_logic;
signal calculate : std_logic;

-- DP output control signals
signal done : std_logic;

-- DP side signals
signal res, nextRes : signed(15 downto 0);
signal cnt, nextCnt : signed(7 downto 0);
signal initialA, initialB : signed(7 downto 0);


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
        ready <= '0'; 
        acquire <= '0';
        calculate <= '0';
        
        case state is
            when idle =>
                if (start = '1') then
                    acquire <= '1';  
                    calculate <= '1';
                    nextState <= calc;
                else
                    nextState <= idle;
                end if;
            
            when calc =>
                if (done = '1') then
                    nextState <= idle;
                    ready <= '1';                                        
                else
                    nextState <= calc;
                    calculate <= '1';   

                end if;
        end case;             
    end process CtrlCombLog;
    
    
    -- DP
    DPReg: process(clk, rst)
    begin
        if (rst = '1') then
            res <= (others => '0');
            cnt <= (others => '0');
        elsif (rising_edge(clk)) then
            res <= nextRes;
            cnt <= nextCnt;
        end if;
    end process DPReg;
    
    DPCombLog: process(acquire, calculate, res, cnt)
    begin
        nextCnt <= cnt;
        nextRes <= res;
        --done <= '0';
        
        if (acquire = '1') then
            initialA <= signed(a); 
            initialB <= signed(b); 
            if (signed(b) < 0) then
                nextCnt <= - signed(b);
            else 
                nextCnt <= signed(b);
            end if;
            --done <= '0';
        end if; 
        
        if (calculate = '1' and acquire = '0') then
            if (cnt = 0) then
                -- Finished
                if (initialB < 0) then
                    nextRes <= - res;   -- If B was negative, invert final sign
                end if;
                done <= '1';
               
            else
                done <= '0';
                nextRes <= res + initialA;
                nextCnt <= cnt -1;
            end if;
        end if;
        
        z <= std_logic_vector(res);
                       
    end process DPCombLog;
end Behavioral;