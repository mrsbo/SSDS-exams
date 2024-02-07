----------------------------------------------------------------------------------
-- Exam:        2023-01-23 
-- Exercise:    2: VHDL FSM
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

entity Mealy_vhdl is
    port(
         F, B , ok : in std_logic;
         TL :   out std_logic_vector(1 downto 0);
         clk, rst : in std_logic    
    );
end Mealy_vhdl;

architecture Behavioral of Mealy_vhdl is
    type StateType is (off, car_waiting, go, crossing);
    signal state, nextState : StateType;
    
begin

    process(clk, rst)
    begin
        if (rst = '1') then
           state <= off;
        elsif (rising_edge(clk)) then
            state <= nextState;
        end if;
    end process;

    process(state, F, B, ok)
    begin
        --TL <= "00";
        case state is
            when off =>
                if (F = '1') then
                    nextState <= car_waiting;
                    TL <= "10";
                else
                    nextState <= off;
                    TL <= "00";
                end if;
            
            when car_waiting =>
                if (ok = '1') then
                    nextState <= go;
                    TL <= "01";
                else
                    nextState <= car_waiting;
                    TL <= "10";
                end if;
            
            when go =>
                if (B = '0') then
                    nextState <= crossing;
                    TL <= "10";
                else
                    nextState <= go;
                    TL <= "01";
                end if;
                        
            when crossing =>
            if (B = '1' and F = '1') then
                nextState <= car_waiting;
                TL <= "10";
            elsif (B = '1' and F = '0') then
                nextState <= off;
                TL <= "00";                
            else
                nextState <= crossing;
                TL <= "10";
            end if;
        end case;
                        
    end process;


end Behavioral;
