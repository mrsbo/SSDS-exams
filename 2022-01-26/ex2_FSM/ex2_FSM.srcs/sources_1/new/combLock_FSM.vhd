----------------------------------------------------------------------------------
-- Exam:        2022-01-26 
-- Exercise:    2: FSM
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity combLock_FSM is
    port(
        COMB1   : in    std_logic;
        COMB2   : in    std_logic;
        ENTER   : in    std_logic;
        RESET   : in    std_logic;
        CLK     : in    std_logic;
        UNLOCK  : out   std_logic;
        ERR     : out   std_logic
    );
end combLock_FSM;

architecture Behavioral of combLock_FSM is

type StateType is (idle, wait2comb, unlocked, error);
signal state, nextState : StateType;

begin

    StateProc : process(clk)
    begin
        if (rising_edge(clk)) then
            if (RESET = '1') then
                state <= idle;
            else
                state <= nextState;
            end if;
        end if;
    end process StateProc;

    CombLog : process(state, ENTER)
    begin       
        case state is
            when idle =>
                UNLOCK <= '0';
                ERR <= '0';
                if (ENTER = '1' and COMB1 = '1' and COMB2 = '0') then
                    nextState <= wait2comb;
                elsif (ENTER = '1') then
                    nextState <= error;
                else
                    nextState <= idle;
                end if;
                
            when wait2comb =>
                UNLOCK <= '0';
                ERR <= '0';
                if (ENTER = '1' and COMB1 = '0' and COMB2 = '1') then
                    nextState <= unlocked;
                elsif (ENTER = '1') then
                    nextState <= error;
                else
                    nextState <= wait2comb;
                end if;    
                
            when unlocked =>
                UNLOCK <= '1';
                ERR <= '0';
                nextState <= unlocked;
    
            when error =>
                UNLOCK <= '0';
                ERR <= '1';
                nextState <= error;               
        end case;        
    end process;
    
end Behavioral;
