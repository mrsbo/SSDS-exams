----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/20/2024 03:38:00 PM
-- Design Name: 
-- Module Name: RAM_eraser_tb - Behavioral
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

entity RAM_eraser_tb is
--  Port ( );
end RAM_eraser_tb;

architecture Behavioral of RAM_eraser_tb is

    component HLSM_RAM_eraser is
        port(
            Addr:       in  std_logic_vector(9 downto 0);
            Go:         in  std_logic;
            Finish:     out std_logic;
            clk, rst:   in std_logic
        );
    end component;   
    
    signal Addr_s:       std_logic_vector(9 downto 0);
    signal Go_s:         std_logic;
    signal Finish_s:     std_logic;
    signal clk_s, rst_s:   std_logic;

    constant clk_period : time := 20ns;

begin
    uut : HLSM_RAM_eraser port map (Addr_s, Go_s, Finish_s, clk_s, rst_s);
    
    process
    begin
        clk_s <= '0';
        wait for clk_period/2;
        clk_s <= '1';
        wait for clk_period/2;
    end process;
    
    
    process
    begin
        rst_s <= '1';
        Go_s <= '0';
        Addr_s <= (others=>'0');
        wait for clk_period/4;
        rst_s <= '0';
        wait for clk_period;
        
        Addr_s <= "0000000000";
        Go_s <= '1';
        wait for clk_period;
        Go_s <= '0';
        wait for clk_period;
        Addr_s <= "0000000100";
        Go_s <= '1';
        wait for clk_period;
        Go_s <= '0';
        wait for clk_period;
    
        wait;
    end process;
end Behavioral;
