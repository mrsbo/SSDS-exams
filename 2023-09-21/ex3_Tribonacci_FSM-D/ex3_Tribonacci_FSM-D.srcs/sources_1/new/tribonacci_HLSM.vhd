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

entity tribonacci_HLSM is
    port(
        n:          in  std_logic_vector(3 DOWNTO 0);
        P:          out std_logic_vector(11 DOWNTO 0);      -- TRIB_15 = 3136 -> next greater power of 2 is 2^12 = 4096 so on 12 bits
        
        --ind:        out std_logic_vector(3 DOWNTO 0);
        --tr_p, tr_pp, tr_ppp: out std_logic_vector(11 DOWNTO 0);
        
        start:      in  std_logic;
        ready:      out std_logic; 
        clk, rst:   in  std_logic
    );
end tribonacci_HLSM;

architecture Behavioral of tribonacci_HLSM is

    type StateType is (idle, calc);
    signal state, nextState: StateType;
    
    signal index, nextIndex : unsigned(3 DOWNTO 0);
    signal trib, trib_p, trib_pp, trib_ppp : unsigned(11 DOWNTO 0);
    signal trib_next, trib_p_next, trib_pp_next, trib_ppp_next : unsigned(11 DOWNTO 0);
    signal rdy, nextRdy : std_logic;
    
begin

ClkProc: process(rst, clk)
begin
    if (rst = '1') then
        -- initial values
        trib_ppp <= (others=>'0');
        trib_pp <= (others=>'0');--"000000000001";         
        trib_p <= (others=>'0');--"000000000001";
        trib <= (others=>'0');
        index <= (others=>'0');
        rdy <= '0';
        state <= idle;
    elsif (rising_edge(clk)) then
        trib_ppp <= trib_ppp_next;
        trib_pp <= trib_pp_next;         
        trib_p <= trib_p_next;
        trib <= trib_next;
        index <= nextIndex;        
        state <= nextState;
        rdy <= nextRdy;
    end if;
            
end process ClkProc;

StateReg: process(trib_ppp, trib_pp, trib_p, trib, state, start, index, n)
begin
    trib_next <= trib;
    trib_p_next <= trib_p;
    trib_pp_next <= trib_pp;
    trib_ppp_next <= trib_ppp;
    nextRdy <= '0';
    
    case state is
        when idle =>
            if (start = '0') then
                nextState <= idle;
                nextIndex <= (others=>'0');
                --nextRdy <= '0';
            else
                nextState <= calc;
                nextIndex <= "0000";
                    --nextIndex <= "0011";
                --end if;
            end if;           
        
        when calc =>
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
                nextState <= calc;                
                nextIndex <= index + 1;
            else
                nextRdy <= '1';
                nextState <= idle;
            end if;
        end case;     
     
end process StateReg;

P <= std_logic_vector(trib);

ready <= rdy;

--debug
--ind <= std_logic_vector(index);
--tr_p <= std_logic_vector(trib_p);
--tr_pp <= std_logic_vector(trib_pp);
--tr_ppp <= std_logic_vector(trib_ppp);
    


end Behavioral;
