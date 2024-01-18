----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2024 11:26:51 AM
-- Design Name: 
-- Module Name: medianFilterFSM - Behavioral
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

entity medianFilterFSM is
    port(
        X:          in  std_logic;
        Z:          out std_logic;
        clk, rst:   in  std_logic
    );
end medianFilterFSM;

architecture Behavioral of medianFilterFSM is

    type StateType is (initX, init0, init1, pp0p0, pp0p1, pp1p0, pp1p1);
    signal state : StateType;

begin

stateReg: process(clk, rst)
begin
    if (rst = '1') then
        state <= initX;
    else
        if (rising_edge(clk)) then
            case state is
                when initX =>
                    Z <= 'X';
                    if (X = '1') then
                        state <= init1;
                    else
                        state <= init0;
                    end if;
                 when init0 =>
                    Z <= 'X';
                    if (X = '1') then
                     state <= pp0p1;
                    else
                     state <= pp0p0;
                    end if;
                when init1 =>
                    Z <= 'X';
                    if (X = '1') then
                        state <= pp1p1;
                    else
                        state <= pp1p0;
                    end if;
                when pp0p0 =>
                    Z <= '0';
                    if (X = '1') then
                        state <= pp0p1;
                    else
                        state <= pp0p0;
                    end if;
                    
                when pp0p1 =>
                    Z <= '0';
                    if (X = '1') then
                        state <= pp1p1;
                    else
                        -- Lone 1 case
                        --state <= pp1p0;   -- This would be for no filter, just 2 cycle delay
                        state <= pp0p0;     -- clean the lone 1
                    end if;
                when pp1p0 =>
                    Z <= '1';
                    if (X = '1') then
                        state <= pp0p1;
                    else
                        state <= pp0p0;
                    end if;
                    
                when pp1p1 =>
                    Z <= '1';
                    if (X = '1') then
                        state <= pp1p1;
                    else
                        state <= pp1p0;
                    end if;                 
                
            end case;
        end if;
     end if;
end process stateReg;

   


end Behavioral;
