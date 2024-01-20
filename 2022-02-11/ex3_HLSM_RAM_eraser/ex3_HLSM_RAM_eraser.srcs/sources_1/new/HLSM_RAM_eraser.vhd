----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/20/2024 02:49:20 PM
-- Design Name: 
-- Module Name: HLSM_RAM_eraser - Behavioral
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

entity HLSM_RAM_eraser is
    port(
        Addr:       in  std_logic_vector(9 downto 0);
        Go:         in  std_logic;
        Finish:     out std_logic;
        clk, rst:   in std_logic
    );
end HLSM_RAM_eraser;

architecture Behavioral of HLSM_RAM_eraser is
    
    -- Memory
    type RAMtype is array (0 to 1024) of std_logic_vector(15 downto 0);
    signal RAM: RAMtype;
    

    
    -- States
    type StateType is (idle, waitGo, clear);
    signal state, nextState : StateType;
    
    -- Regs
    signal startAddress, endAddress : std_logic_vector(9 downto 0);
    --signal nextStartAddress, nextEndAddress : std_logic_vector(9 downto 0);       
    
    signal currAddress, nextCurrAddress : std_logic_vector(9 downto 0);
     
    
begin
    
    StateReg: process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                state <= idle;
                currAddress <= (others => '0');
            else
                state <= nextState;
                currAddress <= nextCurrAddress;
            end if;
        end if;
    end process StateReg;
    
    CombLog: process(Addr, Go, state, currAddress)
    begin
        nextCurrAddress <= currAddress;
        Finish <= '0';
        case state is
            when idle =>
                if (Go = '1') then  --Maybe use falling edge to ensure is not left to 1?
                    nextState <= waitGo;
                    startAddress <= Addr;
                else
                    nextState <= idle;
                    startAddress <= (others => '0');
                    endAddress <= (others => '0');
                end if;
            
            when waitGo =>
                if (Go = '1') then  --Maybe use falling edge to ensure is not left to 1?   
                    nextState <= clear;
                    endAddress <= Addr;
                else
                    nextState <= waitGo;
                    endAddress <= (others => '0');
                    nextCurrAddress <= startAddress;        -- init curr address
                end if;
            
            when clear =>
                if (currAddress > endAddress) then
                    nextState <= idle;
                    Finish <= '1';
                else
                    nextState <= clear;
                    -- Increment address index
                    nextCurrAddress <= std_logic_vector(unsigned(currAddress) + 1);
                    --clear memory cell by using currAddress as index
                    RAM(to_integer(unsigned(currAddress))) <= (others=>'0');
                end if;
        end case;        

    end process CombLog;
                

end Behavioral;
