----------------------------------------------------------------------------------
-- Exam:        2023-01-23 
-- Exercise:    2: testbench
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
    component Mealy_vhdl is
        port(
             F, B , ok : in std_logic;
             TL :   out std_logic_vector(1 downto 0);
             clk, rst : in std_logic    
        );
    end component;
    
    component Mealy_verilog is
        port(
             F, B , ok : in std_logic;
             TL :   out std_logic_vector(1 downto 0);
             clk, rst : in std_logic    
        );
    end component;

    signal F_s, B_s , ok_s : std_logic;
    signal TL_s0 :  std_logic_vector(1 downto 0);
    signal TL_s1 :  std_logic_vector(1 downto 0);
    signal clk_s, rst_s : std_logic;
    
    constant clk_period : time := 20 ns;

begin

    uut0 : Mealy_vhdl port map (F_s, B_s, ok_s, TL_s0, clk_s, rst_s);
    uut1 : Mealy_verilog port map (F_s, B_s, ok_s, TL_s1, clk_s, rst_s);

    process
    begin
        CLK_s <= '0';
        wait for (clk_period/2);
        CLK_s <= '1';
        wait for (clk_period/2);
    end process;
    
    process
    begin
        F_s <= '0';
        B_s <= '1';
        ok_s <= '0';
        rst_s <= '1';
        wait for clk_period/4;
        
        rst_s <= '0';
        wait for clk_period;
                
        F_s <= '1';        
        wait for clk_period*2;
        
        ok_s <= '1'; 
        wait for clk_period;
        
        ok_s <= '0';
        F_s <= '0';
           
        wait for clk_period;
        
        B_s <= '0';          
        wait for clk_period;
        
        B_s <= '1';
        wait for clk_period*4; 
        
        
        ---               
                
        F_s <= '1';        
        wait for clk_period*2;
        
        ok_s <= '1'; 
        wait for clk_period;
        
        ok_s <= '0';
        F_s <= '0';          
        wait for clk_period;
        
        B_s <= '0';          
        wait for clk_period;
        
        B_s <= '1';
        F_s <= '1';
        wait for clk_period;  
        
        
        wait;
    end process;

end Behavioral;
