----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2024 12:59:43 PM
-- Design Name: 
-- Module Name: testbench - Behavioral
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

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is

    component tribonacci_HLSM is
    port(
        n:          in  std_logic_vector(3 DOWNTO 0);
        P:          out std_logic_vector(11 DOWNTO 0);      -- TRIB_15 = 3136 -> next greater power of 2 is 2^12 = 4096 so on 12 bits
        
        --debug
        --ind:        out std_logic_vector(3 DOWNTO 0);
        --tr_p, tr_pp, tr_ppp: out std_logic_vector(11 DOWNTO 0);
        
        start:      in  std_logic;
        ready:      out std_logic; 
        clk, rst:   in  std_logic
    );
end component;
    signal n_s:             std_logic_vector(3 DOWNTO 0);
    signal P_s:             std_logic_vector(11 DOWNTO 0);      
    signal start_s:         std_logic;
    signal ready_s:         std_logic;
    signal clk_s, rst_s:    std_logic;
    
    --debug
    --signal ind_s: std_logic_vector(3 DOWNTO 0);
    --signal tr_p_s, tr_pp_s, tr_ppp_s: std_logic_vector(11 DOWNTO 0);
    
    constant clk_period : time := 20ns;
        
begin
    myTRIB0 : tribonacci_HLSM port map (n_s, P_s, 
    --debug
    --ind_s, tr_p_s, tr_pp_s, tr_ppp_s,
    
    start_s, ready_s, clk_s, rst_s);
    
    ClkProc: process
    begin
        clk_s <= '0';
        wait for (clk_period/2);
        clk_s <= '1';
        wait for (clk_period/2);
    end process ClkProc;

    VectorProc: process
    begin
        -- Init
        rst_s <= '1';
        n_s <= "0000";
        start_s <= '0';
        wait for (clk_period/4);
        
        rst_s <= '0';
        n_s <= "1000";
        start_s <= '1';
        wait for (clk_period);
        start_s <= '0';
        wait for (11* clk_period);
        
--        n_s <= "0000";
--        start_s <= '1';
--        wait for (clk_period);
--        start_s <= '0';
--        wait for (8* clk_period);
        
--        n_s <= "0001";
--        start_s <= '1';
--        wait for (clk_period);
--        start_s <= '0';
--        wait for (8* clk_period);
        
--        n_s <= "0010";
--        start_s <= '1';
--        wait for (clk_period);
--        start_s <= '0';
--        wait for (8* clk_period);
        
--        n_s <= "0011";
--        start_s <= '1';
--        wait for (clk_period);
--        start_s <= '0';
--        wait for (10* clk_period);        
        
--        n_s <= "0100";
--        start_s <= '1';
--        wait for (clk_period);
--        start_s <= '0';
--        wait for (10* clk_period);
        
        n_s <= "1111";
        start_s <= '1';
        wait for (clk_period);
        start_s <= '0';
        wait for (20* clk_period);
        
        wait;
        
    end process VectorProc;
end Behavioral;
