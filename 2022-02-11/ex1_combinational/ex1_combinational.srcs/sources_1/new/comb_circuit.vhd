----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/19/2024 01:55:31 PM
-- Design Name: 
-- Module Name: comb_circuit - Behavioral
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

entity comb_circuit is
    port(
        M : in  std_logic_vector(0 to 3);
        Z : out std_logic
    );
end comb_circuit;

architecture ifelse_arch of comb_circuit is
    
begin
    process(M)
    begin
        if ((M = "0000") OR (M = "1111")) then
            Z <= 'X';    
        elsif ((M(0) XOR M(1) XOR M(2) XOR M(3)) = '1') then    -- odd
            Z <= '1';   
        else
            Z <= '0';   
        end if;
    end process;

end ifelse_arch;

architecture case_arch of comb_circuit is
    
begin
    process(M)
    begin
        case M is
            when "0000" | "1111" =>
                Z <= 'X';  
            when "0001" | "0010" | "0100" | "1000" | "0111" | "1011" | "1101" | "1110" =>
                Z <= '1';
            when others =>
                Z <= '0';       
        end case;
    end process;

end case_arch;
