----------------------------------------------------------------------------------
-- Exam:        2023-04-13 
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
        a, b :  in  std_logic_vector(7 downto 0);
        z :     out std_logic_vector(15 downto 0);
        start : in  std_logic;
        ready : out std_logic;
        clk, rst : in std_logic
        );
end HLSM;

architecture Behavioral of HLSM is

-- States definition
type StateType is (idle, calc);
signal state, nextState : StateType;

-- DP side signals
signal res, nextRes : signed(15 downto 0);
signal cnt, nextCnt : signed(7 downto 0);
signal initialA, initialB : signed(7 downto 0);


begin

    StateReg: process(clk, rst)
    begin
        if (rst = '1') then
            state <= idle;
            res <= (others => '0');
            cnt <= (others => '0');
        elsif (rising_edge(clk)) then
            state <= nextState;
            res <= nextRes;
            cnt <= nextCnt;
        end if;
    end process StateReg;
    
    CombLog: process(state, a, b, start, res, cnt)
    begin
        ready <= '0'; 
        nextCnt <= cnt;
        nextRes <= res;
        
        case state is
            when idle =>
                if (start = '1') then
                    nextState <= calc;
                    initialA <= signed(a); 
                    initialB <= signed(b); 
                    if (signed(b) < 0) then
                        nextCnt <=  - signed(b);
                    else 
                        nextCnt <= signed(b);
                    end if;
                else
                    nextState <= idle;
                end if;
            
            when calc =>
                if (cnt = 0) then
                    -- Finished
                    if (initialB < 0) then
                        nextRes <= - res;   -- If B was negative, invert final sign
                    end if;
                    ready <= '1';
                    nextState <= idle;
                   
                else
                    nextRes <= res + initialA;
                    nextCnt <= cnt -1;
                    nextState <= calc;
                end if;
        end case;             
    end process CombLog;
    
    z <= std_logic_vector(res);

end Behavioral;
