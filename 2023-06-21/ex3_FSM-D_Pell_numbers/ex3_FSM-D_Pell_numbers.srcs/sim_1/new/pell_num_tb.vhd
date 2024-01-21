----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2024 12:18:39 PM
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
    component HLSM_pell_num is
        port(
            n :         in  std_logic_vector(2 downto 0);
            P :         out std_logic_vector(7 downto 0);   -- On 8 bits because P_7 = 169 (8th element) is: 2^7 < 169 < 2^8
            start :     in  std_logic;
            ready :     out  std_logic;
            
            -- debug
--            index_o :   out std_logic_vector(3 downto 0);
--            max     :   out std_logic_vector(3 downto 0);
            
            clk, rst :  in  std_logic        
        );
    end component;
    
    component FSMD_pell_num is
        port(
            n :         in  std_logic_vector(2 downto 0);
            P :         out std_logic_vector(7 downto 0);   -- On 8 bits because P_7 = 169 (8th element) is: 2^7 < 169 < 2^8
            start :     in  std_logic;
            ready :     out  std_logic;
            
            -- debug
--            index_o :   out std_logic_vector(3 downto 0);
--            max     :   out std_logic_vector(3 downto 0);
--            compute_o : out std_logic;
            
            clk, rst :  in  std_logic        
        );
    end component;
    
    signal n_s :            std_logic_vector(2 downto 0);
    signal P_s1, P_s2 :     std_logic_vector(7 downto 0);   
    signal start_s :        std_logic;
    signal ready_s1, ready_s2 : std_logic;
    signal clk_s, rst_s :   std_logic;
    
    
    --debug
    signal index_o : std_logic_vector(3 downto 0);
    signal max     : std_logic_vector(3 downto 0);
    signal compute_o : std_logic;            
    
    constant clk_period : time := 20ns;
    
begin
    
    uut0: HLSM_pell_num port map (n_s, P_s1, start_s, ready_s1, 
        --debug
--      index_o, max, 
        clk_s, rst_s);
        
    uut1: FSMD_pell_num port map (n_s, P_s2, start_s, ready_s2, 
        --debug
--      index_o, max, 
--      compute_o,
    
        clk_s, rst_s);
    
    process
    begin
        clk_s <= '0';
        wait for clk_period/2;
        clk_s <= '1';
        wait for clk_period/2;
    end process;
    
    
    process
    begin
        -- Init
        rst_s <= '1';
        n_s <= "111";
        start_s <= '0';
        wait for clk_period/4;
        rst_s <= '0';
        wait for clk_period;
        
        n_s <= "111";
        start_s <= '1';
        wait for clk_period;
        start_s <= '0';
        
        wait for clk_period * 11;
        
        n_s <= "100";
        start_s <= '1';
        wait for clk_period;
        start_s <= '0';
        
        wait for clk_period * 80;
        
        wait;
                    
    end process;
    
end Behavioral;
