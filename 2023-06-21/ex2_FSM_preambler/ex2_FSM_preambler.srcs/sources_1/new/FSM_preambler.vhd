----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2024 11:08:01 AM
-- Design Name: 
-- Module Name: FSM_preambler - Behavioral
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

entity FSM_preambler is
    port(
        start :     in  std_logic;
        data_out :  out std_logic;
        clk, rst :  in  std_logic
     );
end FSM_preambler;

architecture Behavioral of FSM_preambler is

    type StateType is (idle, s1, s2, s3, s4, s5, s6, s7);
    signal state, nextState : StateType;
    
    --signal outReg, nextOutReg : std_logic;
    
begin

process(clk)
begin
    if (rising_edge(clk)) then
        if (rst = '1') then
            state <= idle;
            -- data_out <= '0';
        else
            case state is
                when idle =>
                    if (start = '0') then
                        state <= idle;
                        data_out <= '0';                     
                    else
                        state <= s1;
                        data_out <= '1';
                    end if;
                when s1 =>
                    state <= s2;
                    data_out <= '0'; 
                when s2 =>
                    state <= s3;
                    data_out <= '1';                                          
                when s3 =>
                    state <= s4;
                    data_out <= '0'; 
                when s4 =>
                    state <= s5;
                    data_out <= '1';    
                when s5 =>
                    state <= s6;
                    data_out <= '0'; 
                when s6 =>
                    state <= s7;
                    data_out <= '1';
                when s7 =>
                    state <= idle;
                    data_out <= '0';                                                                              
            end case;
        end if;
    end if;
end process;
                                
end Behavioral;
