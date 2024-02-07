----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2024 11:13:00 AM
-- Design Name: 
-- Module Name: combCircuit - Behavioral
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

entity combCircuit is
    Port (
        X : in  std_logic_vector(3 downto 0);
        Y : out std_logic_vector(3 downto 0)
     );
end combCircuit;
    
architecture BehIfElse of combCircuit is
begin
    process(X)
    begin
        if (unsigned(X) >= 16 - 5) then
            Y <= std_logic_vector(unsigned(X) + 5 - 16);  
        else
            Y <= std_logic_vector(unsigned(X) + 5);            
        end if;
        
    end process;
 
end BehIfElse;


