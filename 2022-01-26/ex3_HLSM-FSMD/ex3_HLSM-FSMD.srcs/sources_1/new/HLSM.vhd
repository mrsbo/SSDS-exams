----------------------------------------------------------------------------------
-- Exam:        2022-01-26 
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
        X :     in  std_logic_vector(7 downto 0);
        Y :     in  std_logic_vector(7 downto 0);
        start : in  std_logic;        
        q :     out std_logic_vector(7 downto 0);  -- Quotient: max value is divisor / 1
        r :     out std_logic_vector(7 downto 0);  -- Residue: max value is dividend - 1
        ready : out std_logic;
        clk, rst : in std_logic
    );
end HLSM;

architecture Behavioral of HLSM is

    type StateType is (idle, sub);
    signal state, nextState : StateType;
    
    signal divisor, dividend, quotient : unsigned(7 downto 0);
    signal nextDividend, nextQuotient : unsigned(7 downto 0);

begin

    StateProc: process(clk, rst)
    begin
        if (rst = '1') then
            state <= idle;
            quotient <= (others => '0');
            dividend <= (others => '0');
            
        elsif (rising_edge(clk)) then
            state <= nextState;
            quotient <= nextQuotient;
            dividend <= nextDividend;
        end if;
        
    end process StateProc;
    
    
    CombLogProc: process(state, start, dividend, quotient)
    begin
        case state is
            when idle =>
                ready <= '0';
                if (start = '1') then
                    nextState <= sub;
                    -- Store inputs
                    nextQuotient <= (others => '0');
                    nextDividend <= unsigned(X);
                    divisor <= unsigned(Y);
                    
                else
                    nextState <= idle;
                end if;
                    
            
            when sub =>
                ready <= '0';
                if (dividend >= divisor) then
                    nextDividend <= dividend - divisor;
                    nextQuotient <= quotient + 1;                    
                    nextState <= sub;
                else
                    nextState <= idle;
                    ready <= '1';       -- Changed here to trigger at the same time as the result
                end if;
                
            end case;           
            
    
    end process CombLogProc;
    
    q <= std_logic_vector(quotient);
    r <= std_logic_vector(dividend);

end Behavioral;
