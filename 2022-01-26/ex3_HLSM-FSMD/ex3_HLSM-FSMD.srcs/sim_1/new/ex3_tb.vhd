----------------------------------------------------------------------------------
-- Exam:        2022-01-26 
-- Exercise:    3: testbench
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

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is

    component HLSM is
        port(
            X :     in  std_logic_vector(7 downto 0);
            Y :     in  std_logic_vector(7 downto 0);
            start : in  std_logic;        
            q :     out std_logic_vector(7 downto 0);  -- Quotient: max value is divisor / 1
            r :     out std_logic_vector(7 downto 0);  -- Residue: max value is dividend - 1
            ready : out std_logic;
            clk, rst : in std_logic
        );
    end component;
    
    component FSMD is
        port(
            X :     in  std_logic_vector(7 downto 0);
            Y :     in  std_logic_vector(7 downto 0);
            start : in  std_logic;        
            q :     out std_logic_vector(7 downto 0);  -- Quotient: max value is divisor / 1
            r :     out std_logic_vector(7 downto 0);  -- Residue: max value is dividend - 1
            ready : out std_logic;
            clk, rst : in std_logic
        );
    end component;
    
    signal X_s :      std_logic_vector(7 downto 0);
    signal Y_s :      std_logic_vector(7 downto 0);
    signal start_s :  std_logic;        
    
    signal q_s0 :      std_logic_vector(7 downto 0);  -- Quotient: max value is divisor / 1
    signal r_s0 :      std_logic_vector(7 downto 0);  -- Residue: max value is dividend - 1
    signal ready_s0 :  std_logic;
    
    signal q_s1 :      std_logic_vector(7 downto 0);  -- Quotient: max value is divisor / 1
    signal r_s1 :      std_logic_vector(7 downto 0);  -- Residue: max value is dividend - 1
    signal ready_s1 :  std_logic;
    
    signal clk_s, rst_s : std_logic;
    
    constant clk_period : time := 20ns;
    
begin
    HLSM_UUT: HLSM port map(X_s, Y_s, start_s, q_s0, r_s0, ready_s0, clk_s, rst_s);
    FSMD_UUT: FSMD port map(X_s, Y_s, start_s, q_s1, r_s1, ready_s1, clk_s, rst_s);
    
    process
    begin
        CLK_s <= '0';
        wait for (clk_period/2);
        CLK_s <= '1';
        wait for (clk_period/2);
    end process;
    
    
    process
    begin
        X_s <= (others => '0');  
        Y_s <= (others => '0'); 
        start_s <= '0';
        rst_s <= '1';
        
        wait for (clk_period/4);
        rst_s <= '0';
        wait for clk_period;
        
        X_s <= std_logic_vector(to_unsigned(93, 8));
        Y_s <= std_logic_vector(to_unsigned(17, 8));
        
        wait for clk_period;
        start_s <= '1';
        wait for clk_period;
        start_s <= '0';
        
        wait for clk_period*10;

    
    
    
        wait;
    end process;
    
    
    
end Behavioral;
