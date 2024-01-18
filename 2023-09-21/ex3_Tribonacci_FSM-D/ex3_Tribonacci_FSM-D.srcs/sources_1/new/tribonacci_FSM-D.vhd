----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2024 12:23:42 PM
-- Design Name: 
-- Module Name: tribonacci_HLSM - Behavioral
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

entity tribonacci_FSMD is
    port(
        n:          in  std_logic_vector(3 DOWNTO 0);
        P:          out std_logic_vector(11 DOWNTO 0);      -- TRIB_15 = 3136 -> next greater power of 2 is 2^12 = 4096 so on 12 bits
        
        -- debug
        --ind:        out std_logic_vector(3 DOWNTO 0);
        --tr_p, tr_pp, tr_ppp: out std_logic_vector(11 DOWNTO 0);
        
        start:      in  std_logic;
        ready:      out std_logic; 
        clk, rst:   in  std_logic
    );
end tribonacci_FSMD;

architecture Behavioral of tribonacci_FSMD is
    
    -- Control Registers
    type StateType is (idle, calc);
    signal state, nextState: StateType;
    
    -- Shared signals
    signal done : std_logic;
    signal compute : std_logic;
    
    -- Datapath registers
    signal index, nextIndex : unsigned(3 DOWNTO 0);
    signal trib, trib_p, trib_pp, trib_ppp : unsigned(11 DOWNTO 0);
    signal trib_next, trib_p_next, trib_pp_next, trib_ppp_next : unsigned(11 DOWNTO 0);
    --signal rdy, nextRdy : std_logic;
    
begin


CtrlReg: process(rst, clk)
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
    case state is
        when idle =>
            compute <= '0';
            if (start = '0') then
                nextState <= idle;
            else
                nextState <= calc;
            end if;           
        
        when calc =>
            compute <= '1';
            if (done = '0') then
                nextState <= calc;                
            else
                ready <= '1';
                nextState <= idle;
            end if;
            
        end case;    

end process CtrlCombLog;



DPReg: process(rst, clk)
begin
    if (rst = '1') then
        -- initial values
        trib_ppp <= (others=>'0');
        trib_pp <= (others=>'0');--"000000000001";         
        trib_p <= (others=>'0');--"000000000001";
        trib <= (others=>'0');
        index <= (others=>'0');


    elsif (rising_edge(clk)) then
        trib_ppp <= trib_ppp_next;
        trib_pp <= trib_pp_next;         
        trib_p <= trib_p_next;
        trib <= trib_next;
        index <= nextIndex;        

    end if;
            
end process DPReg;

DPCombLog: process(index, trib, trib_p, trib_pp, trib_ppp, compute)
begin
    if (compute = '1') then
        if (index = "0000") then
            trib_next <= (others=>'0');
            trib_p_next <= (others=>'0');
            trib_pp_next <= (others=>'0');
            trib_ppp_next <= (others=>'0');
        elsif (index = "0001") then
            trib_next <= "000000000001";
            trib_p_next <= trib;
            trib_pp_next <= (others=>'0');
            trib_ppp_next <= (others=>'0');
        elsif (index = "0010") then
            trib_next <= "000000000001";
            trib_p_next <= trib;
            trib_pp_next <= trib_p;
            trib_ppp_next <= (others=>'0');
        else
            trib_next <= trib_p + trib_pp + trib;
            trib_p_next <= trib;
            trib_pp_next <= trib_p;
            trib_ppp_next <= trib_pp;
        end if;
    
        if (index < unsigned(n)) then 
            nextIndex <= index + 1;
            done <= '0';
        else
           done <= '1';
           nextIndex <= "0000";
           
        end if;
        else
            done <= '0';
            trib_next <= trib;
            trib_p_next <= trib_p;
            trib_pp_next <= trib_pp;
            trib_ppp_next <= trib_ppp;
            nextIndex <= index;
    end if;     
    
    P <= std_logic_vector(trib);
    --debug
--    ind <= std_logic_vector(index);
--    tr_p <= std_logic_vector(trib_p);
--    tr_pp <= std_logic_vector(trib_pp);
--    tr_ppp <= std_logic_vector(trib_ppp);

end process DPCombLog;


end Behavioral;
