----------------------------------------------------------------------------------
-- Exam:        2023-01-23 
-- Exercise:    1: comb circuit
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

entity combCircuit is
    port(
        LUTin : in std_logic_vector(7 downto 0);
        LUTout : out std_logic_vector(7 downto 0)
    );
end combCircuit;

architecture Behavioral of combCircuit is
    
begin

    process(LUTin)
    begin
        case LUTin(7 downto 4) is
            when "0000" => LUTout(7 downto 4) <= "0001";
            when "0001" => LUTout(7 downto 4) <= "1011";    
            when "0010" => LUTout(7 downto 4) <= "1001";
            when "0011" => LUTout(7 downto 4) <= "1100";
            when "0100" => LUTout(7 downto 4) <= "1101";
            when "0101" => LUTout(7 downto 4) <= "0110";
            when "0110" => LUTout(7 downto 4) <= "1111";
            when "0111" => LUTout(7 downto 4) <= "0011";
            when "1000" => LUTout(7 downto 4) <= "1110";
            when "1001" => LUTout(7 downto 4) <= "1000";    
            when "1010" => LUTout(7 downto 4) <= "0111";
            when "1011" => LUTout(7 downto 4) <= "0100";
            when "1100" => LUTout(7 downto 4) <= "1010";
            when "1101" => LUTout(7 downto 4) <= "0010";
            when "1110" => LUTout(7 downto 4) <= "0101";
            when "1111" => LUTout(7 downto 4) <= "0000";            
        end case;
    
        case LUTin(3 downto 4) is
            when "0000" => LUTout(7 downto 4) <= "1111";
            when "0001" => LUTout(7 downto 4) <= "0000";    
            when "0010" => LUTout(7 downto 4) <= "1101";
            when "0011" => LUTout(7 downto 4) <= "1101";
            when "0100" => LUTout(7 downto 4) <= "1011";
            when "0101" => LUTout(7 downto 4) <= "1110";
            when "0110" => LUTout(7 downto 4) <= "0101";
            when "0111" => LUTout(7 downto 4) <= "1010";
            when "1000" => LUTout(7 downto 4) <= "1001";
            when "1001" => LUTout(7 downto 4) <= "1000";    
            when "1010" => LUTout(7 downto 4) <= "0010";
            when "1011" => LUTout(7 downto 4) <= "1100";
            when "1100" => LUTout(7 downto 4) <= "0001";
            when "1101" => LUTout(7 downto 4) <= "0011";
            when "1110" => LUTout(7 downto 4) <= "0100";
            when "1111" => LUTout(7 downto 4) <= "0110";                    
        end case;
 
    end process;
    
    

end Behavioral;
