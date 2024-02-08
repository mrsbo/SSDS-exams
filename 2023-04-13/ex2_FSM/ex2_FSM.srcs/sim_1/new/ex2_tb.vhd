----------------------------------------------------------------------------------
-- Exam:        2023-04-13 
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

entity ex2_tb is
--  Port ( );
end ex2_tb;

architecture Behavioral of ex2_tb is

    component FSM_1p is
        Port (
            En : in std_logic;
            X : in std_logic;
            Z: out std_logic_vector(1 downto 0);
            clk, rst : in std_logic
         );
    end component;

    component FSM_2p is
        Port (
            En : in std_logic;
            X : in std_logic;
            Z: out std_logic_vector(1 downto 0);
            clk, rst : in std_logic
         );
    end component;

    signal En_s : std_logic;
    signal X_s : std_logic;
    signal Z_s0: std_logic_vector(1 downto 0);
    signal Z_s1: std_logic_vector(1 downto 0);
    signal clk_s , rst_s : std_logic;

    constant clk_period : time := 20ns;
    
    constant En_in   : std_logic_vector(0 to 17) := "001111111111111110";
    constant X_in  : std_logic_vector(0 to 17) := "010100011010011111";
    
begin
    
    uut0 : FSM_1p port map (En_s, X_s, Z_s0, clk_s, rst_s);   
    uut1 : FSM_2p port map (En_s, X_s, Z_s1, clk_s, rst_s);   
    
    process
    begin
        CLK_s <= '0';
        wait for (clk_period/2);
        CLK_s <= '1';
        wait for (clk_period/2);
    end process;  
    
    process
    begin
        En_s <= '0'; 
        X_s <= '0';
        rst_s <= '1';
        wait for (clk_period*2);
        wait for clk_period/4;
        rst_s <= '0';
        wait for clk_period;
        
        for i in 0 to 17 loop
            En_s <= En_in(i);
            X_s <= X_in(i);
            wait for clk_period;
        end loop;
        
        wait;
    end process;
    
end Behavioral;
