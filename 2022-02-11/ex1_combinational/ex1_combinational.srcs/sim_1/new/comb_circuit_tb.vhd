----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/19/2024 02:20:09 PM
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
    component comb_circuit is
        port(
            M : in  std_logic_vector(0 to 3);
            Z : out std_logic
        );
    end component;
    
    signal M_s  : std_logic_vector(0 to 3);
    signal Z_s1 : std_logic;
    signal Z_s2 : std_logic;
    constant clk_period : time := 20ns;
    
begin

    uut0: entity work.comb_circuit(ifelse_arch) port map(M_s, Z_s1);
    uut1: entity work.comb_circuit(case_arch) port map(M_s, Z_s2);
    

   process
   begin
       -- Setup
        M_s <= "0000";
        wait for clk_period;
       
        while(M_s < "1111") loop
            M_s <= std_logic_vector(unsigned(M_s) + 1);
            wait for clk_period;
        end loop;
       
        wait;
       
   end process;
        
end Behavioral;
