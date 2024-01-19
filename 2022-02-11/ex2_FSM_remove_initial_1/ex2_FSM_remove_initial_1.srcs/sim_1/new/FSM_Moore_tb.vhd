----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/19/2024 10:16:50 AM
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
    component FSM_Moore is
        port(
            X:  in  std_logic;
            Z:  out std_logic;
            clk, rst:   in  std_logic
        );
    end component;
    
    signal X_s, Z_s, clk_s, rst_s : std_logic;
    constant clk_period : time := 20ns;
    
begin
    myFSM : FSM_Moore port map (X_s, Z_s, clk_s, rst_s);
    
    ClkProc : process
    begin
        clk_s <= '0';
        wait for clk_period/2;
        clk_s <= '1';
        wait for clk_period/2;
    end process ClkProc;
    
    VectorProc : process
    begin
        -- Setup
        rst_s <= '1';
        X_s <= '0';
        wait for clk_period/4;
        wait for clk_period;
        rst_s <= '0';
        
        wait for clk_period;
        
        X_s <= '1';
        wait for clk_period;
        X_s <= '0';
        wait for clk_period;
        X_s <= '1';
        wait for clk_period;
        X_s <= '1';
        wait for clk_period;
        X_s <= '0';
        wait for clk_period;
        X_s <= '1';
        wait for clk_period;
        X_s <= '0';
        wait for clk_period;
        X_s <= '1';
        wait for clk_period;
        X_s <= '1';
        wait for clk_period;
        X_s <= '1';
        wait for clk_period;
        X_s <= '1';
        wait for clk_period;
        X_s <= '0';
        wait for clk_period;
        X_s <= '0';
        wait for clk_period;
        X_s <= '0';
        wait for clk_period;
        X_s <= '1';
        wait for clk_period;        
    
    wait;
    end process VectorProc;
    
end Behavioral;
