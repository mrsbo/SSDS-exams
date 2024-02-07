----------------------------------------------------------------------------------
-- Exam:        2022-01-26 
-- Exercise:    2: FSM
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
    component combLock_FSM is
        port(
            COMB1   : in    std_logic;
            COMB2   : in    std_logic;
            ENTER   : in    std_logic;
            RESET   : in    std_logic;
            CLK     : in    std_logic;
            UNLOCK  : out   std_logic;
            ERR     : out   std_logic 
        );
    end component;
    
    component combLock_FSM_verilog is
        port(
            COMB1   : in    std_logic;
            COMB2   : in    std_logic;
            ENTER   : in    std_logic;
            RESET   : in    std_logic;
            CLK     : in    std_logic;
            UNLOCK  : out   std_logic;
            ERR     : out   std_logic 
        );
    end component;
    
    
    signal COMB1_s   : std_logic;
    signal COMB2_s   : std_logic;
    signal ENTER_s   : std_logic;
    signal RESET_s   : std_logic;
    signal CLK_s     : std_logic;
    signal UNLOCK_s0  : std_logic;
    signal ERR_s0     : std_logic;
    signal UNLOCK_s1  : std_logic;
    signal ERR_s1     : std_logic; 
    
    constant clk_period : time := 20ns;
    
begin
    
    uut0 : combLock_FSM port map ( COMB1_s, COMB2_s, ENTER_s, RESET_s, CLK_s, UNLOCK_s0, ERR_s0);   
    uut1 : combLock_FSM_verilog port map ( COMB1_s, COMB2_s, ENTER_s, RESET_s, CLK_s, UNLOCK_s1, ERR_s1);   
    
    process
    begin
        CLK_s <= '0';
        wait for (clk_period/2);
        CLK_s <= '1';
        wait for (clk_period/2);
    end process;
    
    
    process
    begin
        COMB1_s <= '0';
        COMB2_s <= '0';
        ENTER_s <= '0';
        RESET_s <= '1';
        
        wait for (clk_period*3)/4;
        RESET_s <= '0';
        wait for clk_period;
        
        -- Comb1
        COMB1_s <= '1';
        wait for clk_period;
        ENTER_s <= '1';
        wait for clk_period;
        ENTER_s <= '0';
        wait for clk_period;
        COMB1_s <= '0';
        wait for clk_period;
        
        -- Comb2
        COMB2_s <= '1';
        wait for clk_period;
        ENTER_s <= '1';
        wait for clk_period;
        ENTER_s <= '0';
        wait for clk_period;
        COMB2_s <= '0';
        wait for clk_period*3;
        
        RESET_s <= '1';        
        wait for clk_period;
        RESET_s <= '0';
        wait for clk_period;
        
        -- Force error
        -- Comb2
        COMB2_s <= '1';
        wait for clk_period;
        ENTER_s <= '1';
        wait for clk_period;
        ENTER_s <= '0';
        wait for clk_period;
        COMB2_s <= '0';
        wait for clk_period*3;
        
        RESET_s <= '1';        
        wait for clk_period;
        RESET_s <= '0';
        wait for clk_period;
        
        wait;
    end process;
    
end Behavioral;
