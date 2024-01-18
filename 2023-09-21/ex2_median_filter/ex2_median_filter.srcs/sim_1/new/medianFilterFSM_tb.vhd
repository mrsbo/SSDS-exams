----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2024 11:43:25 AM
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
    component medianFilterFSM is
        port(
            X:          in  std_logic;
            Z:          out std_logic;
            clk, rst:   in  std_logic
        );
    end component;
    
    signal X_s:   std_logic;
    signal Z_s:   std_logic;
    signal clk_s, rst_s: std_logic;
    
    constant ClockPeriod : time := 20 ns;
    
begin
 
     myMF : medianFilterFSM port map (X => X_s, Z => Z_s, clk => clk_s, rst => rst_s);
    
ClockProc: process
begin
    clk_s <= '0';
    wait for (ClockPeriod/2);
    clk_s <= '1';
    wait for (ClockPeriod/2);
    
end process ClockProc;

VectorProc : process
begin
    -- Init
    X_s <= '0';
    rst_s <= '1';
    wait for (ClockPeriod /4);
    
    -- Release reset
    rst_s <= '0';
   
    -- Start Sequence
    X_s <= '1';
    wait for (ClockPeriod);
    
    X_s <= '0';
    wait for (ClockPeriod);
    
    X_s <= '1';
    wait for (ClockPeriod);
    
    X_s <= '1';
    wait for (ClockPeriod);
    
    X_s <= '0';
    wait for (ClockPeriod);
    
    X_s <= '1';
    wait for (ClockPeriod);
    
    X_s <= '0';
    wait for (ClockPeriod);
    
    X_s <= '1';
    wait for (ClockPeriod);
        
    X_s <= '1';
    wait for (ClockPeriod);
    
    X_s <= '1';
    wait for (ClockPeriod);
    
    X_s <= '0';
    wait for (ClockPeriod);
    
    X_s <= '1';
    wait for (ClockPeriod);
    
    X_s <= '0';
    wait for (ClockPeriod);
    
    X_s <= '1';
    wait for (ClockPeriod); 
    
    X_s <= '0';
    wait for (ClockPeriod);
    
    X_s <= '1';
    wait; 
    
end process VectorProc;

end Behavioral;
