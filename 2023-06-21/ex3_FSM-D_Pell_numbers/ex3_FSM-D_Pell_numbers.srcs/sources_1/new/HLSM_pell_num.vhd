----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2024 11:50:11 AM
-- Design Name: 
-- Module Name: HLSM_pell_num - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HLSM_pell_num is
    port(
        n :         in  std_logic_vector(2 downto 0);
        P :         out std_logic_vector(7 downto 0);   -- On 8 bits because P_7 = 169 (8th element) is: 2^7 < 169 < 2^8
        start :     in  std_logic;     
        ready :     out  std_logic;
        
        -- debug
--        index_o :   out std_logic_vector(3 downto 0);
--        max     :   out std_logic_vector(3 downto 0);
        
        clk, rst :  in  std_logic        
    );
end HLSM_pell_num;

architecture Behavioral of HLSM_pell_num is

    -- States
    type StateType is (idle, calc);
    signal state, nextState : StateType;
    
    -- Register signals
    signal regP, nextRegP, regP_b, nextRegP_b : unsigned(7 downto 0);
    
    signal index, nextIndex : unsigned(3 downto 0);     -- One more bit than n to avoid overflow
    
    signal maxIndex : unsigned(3 downto 0); -- One more bit than n to avoid overflow
    
begin
    
StateReg : process(clk, rst)
begin
    -- Async reset
    if (rst = '1') then
        state   <= idle;
        regP    <= (others=>'0');
        regP_b  <= (others=>'0');
        index <= (others=>'0');
        
    elsif (rising_edge(clk)) then
        state   <= nextState;
        regP    <= nextRegP;
        regP_b  <= nextRegP_b;
        index <= nextIndex;
    end if;        
    end process StateReg;


CombLog : process(state, regP, regP_b, start, index, n)
begin
    nextRegP <= regP;
    nextRegP_b <= regP_b;
    nextIndex <= index;
    
    ready <= '0';
    
    case state is
        when idle =>
            if (start = '0') then
                nextState <= idle;
                maxIndex <= (others=>'0');
            else
                nextState <= calc;
                maxIndex <= '0' & unsigned(n);
                nextIndex <= (others=>'0');
            end if;
            
        when calc =>

            if (index <= maxIndex) then
                -- calc
                if (index = 0) then
                    nextRegP    <= (others=>'0');
                    nextRegP_b  <= (others=>'0');
                        
                elsif (index = 1) then
                    nextRegP    <= "00000001";
                    nextRegP_b  <= (others=>'0');
                                        
                else
                    
                    nextRegP    <= regP + regP + regP_b;
                    nextRegP_b  <= regP;
                    --nextRegP_bb <= regP_b;
                end if;
                nextIndex <= index + 1;
                nextState <= calc;
            else
                -- stop
                --nextIndex <= (others=>'0');
                ready <= '1';
                nextState <= idle;
            end if;            
    end case;                

end process CombLog;

    P <= std_logic_vector(regP);
    --debug
--    index_o <= std_logic_vector(index);
--    max <= std_logic_vector(maxIndex);
end Behavioral;
