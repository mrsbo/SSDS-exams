----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2024 10:57:58 AM
-- Design Name: 
-- Module Name: BCD-8421_conv - DF_whenelse
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

entity BCDto8421_conv is
    port(
        BCD:    in  std_logic_vector(3 downto 0);
        o:      out std_logic_vector(3 downto 0)
    );
end BCDto8421_conv;

architecture DF_whenelse of BCDto8421_conv is

begin
    o <=    "0000" when BCD = "0000" else
            "0111" when BCD = "0001" else
            "0110" when BCD = "0010" else
            "0101" when BCD = "0011" else
            "0100" when BCD = "0100" else
            "1011" when BCD = "0101" else
            "1010" when BCD = "0110" else
            "1001" when BCD = "0111" else
            "1000" when BCD = "1000" else
            "1111" when BCD = "1001";
                                                            
end DF_whenelse;

architecture DF_withselect of BCDto8421_conv is

begin
    with BCD select o <=
        "0000" when "0000",
        "0111" when "0001",
        "0110" when "0010",
        "0101" when "0011",
        "0100" when "0100",
        "1011" when "0101",
        "1010" when "0110",
        "1001" when "0111",
        "1000" when "1000",
        "1111" when "1001";
                                                            
end DF_withselect;

