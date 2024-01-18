----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2024 10:49:34 AM
-- Design Name: 
-- Module Name: therm2bin - Behavioral
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

entity therm2bin is
  port (
    X: in std_logic_vector(6 DOWNTO 0);
    Z: out std_logic_vector(2 DOWNTO 0)
    );
end therm2bin;

architecture behav_ifelse of therm2bin is
begin

    process(X)
    begin
        if X(6) = '1' then
            Z <= "111";
        elsif X(5) = '1' then
            Z <= "110";
        elsif X(4) = '1' then
            Z <= "101";
        elsif X(3) = '1' then
            Z <= "100";
        elsif X(2) = '1' then
            Z <= "011";
        elsif X(1) = '1' then
            Z <= "010";   
        elsif X(0) = '1' then
                Z <= "001";                     
    else
            Z <= "000";
        end if;
        
    end process;    

end behav_ifelse;

architecture behav_case of therm2bin is
begin

    process(X)
    begin
        case X is
           when "1111111" =>
                Z <= "111";
           when "0111111" =>
                Z <= "110";
           when "0011111" =>
                Z <= "101";
           when "0001111" =>
                Z <= "100";                
           when "0000111" =>
                Z <= "011";
            when "0000011" =>
                Z <= "010";
            when "0000001" =>
                Z <= "001";  
            when others =>
                Z <= "000";           
        end case;
        
    end process;    

end behav_case;