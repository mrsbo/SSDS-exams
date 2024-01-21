----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2024 11:24:40 AM
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
    
    component FSM_preambler is
        port(
            start :     in  std_logic;
            data_out :  out std_logic;
            clk, rst :  in  std_logic
         );
    end component;
    
    signal start_s, data_out_s1, clk_s, rst_s : std_logic;
    signal data_out_s2 : std_logic;
    constant clk_period : time := 20ns;
    
begin
    uut0: entity work.FSM_preambler(beh_1proc) port map (start_s, data_out_s1, clk_s, rst_s);
    uut1: entity work.FSM_preambler(beh_2proc) port map (start_s, data_out_s2, clk_s, rst_s);
    
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
        start_s <= '0';
        wait for clk_period/4;
        rst_s <= '0';
        wait for clk_period;
        
        -- Start
        start_s <= '1';
        wait for clk_period;
        start_s <= '0';
        
        wait for clk_period*10;
        
        wait;
        
    end process;

end Behavioral;
