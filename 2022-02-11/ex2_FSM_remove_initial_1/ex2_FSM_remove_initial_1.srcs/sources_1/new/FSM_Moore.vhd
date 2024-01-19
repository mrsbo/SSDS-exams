----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/19/2024 10:09:21 AM
-- Design Name: 
-- Module Name: FSM_Moore - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
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

entity FSM_Moore is
    port(
        X:  in  std_logic;
        Z:  out std_logic;
        clk, rst:   in  std_logic
    );
end FSM_Moore;

architecture Behavioral of FSM_Moore is
    type StateType is (S0, S1, S2);
    signal state, nextState : StateType;
begin

ClkProc: process(clk, rst)
begin
    -- Assuming asynchronous reset
    if (rst = '1') then
        state <= S0;    
    elsif (rising_edge(clk)) then
        state <= nextState;
    end if;
end process ClkProc;    


StateProc: process(state, X)
begin
    case state is
        when S0 =>
            if (X = '0') then
                nextState <= S0;
            else
                nextState <= S1;
            end if;
            Z <= '0';
        when S1 =>
            if (X = '0') then
                nextState <= S0;
            else
                nextState <= S2;
            end if;
            Z <= '0';
        when S2 =>
            if (X = '0') then
                nextState <= S0;
            else
                nextState <= S2;
            end if;
            Z <= '1';
    end case;                       

end process StateProc;


end Behavioral;
