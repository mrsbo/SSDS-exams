----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2024 12:50:37 PM
-- Design Name: 
-- Module Name: FSMD_pell_num - Behavioral
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

entity FSMD_pell_num is
    port(
    n :         in  std_logic_vector(2 downto 0);
    P :         out std_logic_vector(7 downto 0);   -- On 8 bits because P_7 = 169 (8th element) is: 2^7 < 169 < 2^8
    start :     in  std_logic;     
    ready :     out  std_logic;
    
    -- debug
--        index_o :   out std_logic_vector(3 downto 0);
--        max     :   out std_logic_vector(3 downto 0);
--        compute_o : out std_logic;
    
    clk, rst :  in  std_logic        
);
end FSMD_pell_num;


architecture Behavioral of FSMD_pell_num is
    -- Control State signals
    type StateType is (idle, calc);
    signal state, nextState : StateType;
    
    -- Shared signals
    -- DP   ->  Ctrl
    signal done : std_logic;
    -- Ctrl ->  DP
    signal compute : std_logic;
    signal storeN  : std_logic;
            
    -- DP Register signals
    signal regP, nextRegP, regP_b, nextRegP_b : unsigned(7 downto 0);
    
    signal index, nextIndex : unsigned(3 downto 0);     -- One more bit than n to avoid overflow
    signal maxIndex : unsigned(3 downto 0); -- One more bit than n to avoid overflow
    
begin

---------------------------------
-- Control    
---------------------------------
CtrlReg : process(clk, rst)
begin
    -- Async reset
    if (rst = '1') then
        state   <= idle;               
    elsif (rising_edge(clk)) then
        state   <= nextState;
    end if;        
end process CtrlReg;

CtrlCombLog : process(state, done, start)
begin     
    ready <= '0';
    compute <= '0';
    storeN <= '0';
    
    case state is
        when idle =>
            if (start = '0') then
                nextState <= idle;
            else
                nextState <= calc;
                compute <= '1';
                storeN <= '1';
            end if;
            
        when calc =>
            if (done = '0') then
                nextState <= calc;
                compute <= '1';
            else
                ready <= '1';
                nextState <= idle;
            end if;           
    end case;                
    
end process CtrlCombLog;
    
---------------------------------
-- DataPath    
---------------------------------
DPreg : process(clk, rst)
begin
    -- Async reset
    if (rst = '1') then
        regP    <= (others=>'0');
        regP_b  <= (others=>'0');
        index <= (others=>'0');
        
    elsif (rising_edge(clk)) then
        regP    <= nextRegP;
        regP_b  <= nextRegP_b;
        index <= nextIndex;
    end if;        
end process DPreg;


DPCombLog : process(compute, regP, regP_b, index, storeN)
begin
    nextRegP <= regP;
    nextRegP_b <= regP_b;

    if (storeN = '1') then
        -- Store current value of n
        maxIndex <= '0' & unsigned(n);
        nextIndex <= (others => '0');
        done <= '0';
                
    elsif (compute = '1') then
    -- Calculate (starting one cycle after storing n)
        if (index <= maxIndex) then           
            if (index = 0) then
                nextRegP    <= (others=>'0');
                nextRegP_b  <= (others=>'0');      
            elsif (index = 1) then
                nextRegP    <= "00000001";
                nextRegP_b  <= (others=>'0');                     
            else
                nextRegP    <= regP + regP + regP_b;
                nextRegP_b  <= regP;
            end if;
            nextIndex <= index + 1;
            done <= '0';
        else
            done <= '1';
        end if;  
    end if;            
    
    P <= std_logic_vector(regP);
    --debug
--    index_o <= std_logic_vector(index);
--    max <= std_logic_vector(maxIndex);
--    compute_o <= compute;
end process DPCombLog;


end Behavioral;
