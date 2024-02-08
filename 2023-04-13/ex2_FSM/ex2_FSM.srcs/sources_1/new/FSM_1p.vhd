----------------------------------------------------------------------------------
-- Exam:        2023-04-13 
-- Exercise:    2: VHDL FSM
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

entity FSM_1p is
    Port (
        En : in std_logic;
        X : in std_logic;
        Z: out std_logic_vector(1 downto 0);
        clk, rst : in std_logic
     );
end FSM_1p;

architecture Behavioral of FSM_1p is
    
    type StateType is (disabled, p0, p1, p1p1);
    signal state, nextState : StateType;
    
begin
    process(clk, En, X, state)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                state <= disabled;
            else
                state <= nextState;
            end if;
        end if;
        
        --Z <= "00";
        case state is
            when disabled =>
                if (En = '0') then
                    nextState <= disabled;
                    Z <= "00";
                elsif (X = '0') then
                    nextState <= p0;
                    Z <= "00";
                else
                    nextState <= p1;
                    Z <= "00";
                end if;
                
            when p0 =>
                if (En = '0') then
                    nextState <= disabled;
                    Z <= "00";
                elsif (X = '0') then
                    nextState <= p0;
                    Z <= "01";
                else
                    nextState <= p1;
                    Z <= "00";
                end if;
            when p1 =>
                if (En = '0') then
                    nextState <= disabled;
                    Z <= "00";
                elsif (X = '0') then
                    nextState <= p0;
                    Z <= "00";
                else
                    nextState <= p1p1;
                    Z <= "00";
                end if;
            when p1p1 =>
                if (En = '0') then
                    nextState <= disabled;
                    Z <= "00";
                elsif (X = '0') then
                    nextState <= p0;
                    Z <= "00";
                else
                    nextState <= p1p1;
                    Z <= "10";
                end if;
        end case;  
    end process;

end Behavioral;
