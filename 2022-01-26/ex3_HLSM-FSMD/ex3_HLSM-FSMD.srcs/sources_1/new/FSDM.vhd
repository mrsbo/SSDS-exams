----------------------------------------------------------------------------------
-- Exam:        2022-01-26 
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
        X :     in  std_logic_vector(7 downto 0);
        Y :     in  std_logic_vector(7 downto 0);
        start : in  std_logic;        
        q :     out std_logic_vector(7 downto 0);  -- Quotient: max value is divisor / 1
        r :     out std_logic_vector(7 downto 0);  -- Residue: max value is dividend - 1
        ready : out std_logic;
        clk, rst : in std_logic
    );
end FSMD;

architecture Behavioral of FSMD is
    
    -- Controller signals
    type StateType is (idle, sub);
    signal state, nextState : StateType;
    
    -- Shared signals
    -- Controller -> DP control inputs 
    signal acquire : std_logic;
    -- DP control outputs -> Controller
    signal result_rdy : std_logic;
    
    -- DP signals
    signal dividing : std_logic;
    signal divisor, dividend, quotient : unsigned(7 downto 0);
    signal nextDividend, nextQuotient : unsigned(7 downto 0);

begin

-- States
CtrlReg: process(clk, rst)
    begin
        if (rst = '1') then
            state <= idle;
        elsif (rising_edge(clk)) then
            state <= nextState;
        end if;
       
    end process CtrlReg;

CtrlCombLog: process(state, start, result_rdy)
    begin
    ready <= '0';
    acquire <= '0'; 
    
    case state is
        when idle =>
            if (start = '1') then
                nextState <= sub;
                acquire <= '1';            
            else
                nextState <= idle;
            end if;

        when sub =>
            if (result_rdy = '1') then
                nextState <= idle;
                ready <= '1';
            else
                nextState <= sub;  

            end if;
  
    end case;           
    end process CtrlCombLog;

-- DP
    DPreg: process(clk, rst)
    begin
        if (rst = '1') then
            quotient <= (others => '0');
            dividend <= (others => '0');
            --result_rdy <= '0';
            
        elsif (rising_edge(clk)) then
            quotient <= nextQuotient;
            dividend <= nextDividend;
            --result_rdy <= nextResult_rdy;
        end if;
        
    end process DPreg;
    
    DPcombLog: process(acquire, dividend, quotient)
    begin
    
        if (acquire = '1') then
            nextQuotient <= (others => '0');
            nextDividend <= unsigned(X);
            divisor <= unsigned(Y);
            dividing <= '1';
            result_rdy <= '0';
        end if;
        
        if (dividing = '1') then
            if (dividend >= divisor) then
                nextDividend <= dividend - divisor;
                nextQuotient <= quotient + 1;                    
            else
                dividing <= '0';
                result_rdy <= '1';                
            end if;
        end if;

        q <= std_logic_vector(quotient);
        r <= std_logic_vector(dividend);                               
            
    end process DPcombLog;

end Behavioral;
