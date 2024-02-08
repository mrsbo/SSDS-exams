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
            a, b :  in  std_logic_vector(7 downto 0);
            z :     out std_logic_vector(15 downto 0);
            start : in  std_logic;
            ready : out std_logic;
            clk, rst : in std_logic
            );    
    end component;
    
    component FSMD is
        port(
            a, b :  in  std_logic_vector(7 downto 0);
            z :     out std_logic_vector(15 downto 0);
            start : in  std_logic;
            ready : out std_logic;
            clk, rst : in std_logic
            );              
    end component;
    
    signal a_s : std_logic_vector(7 downto 0);
    signal b_s : std_logic_vector(7 downto 0);
    signal start_s : std_logic;
    
    signal z_s0 : std_logic_vector(15 downto 0);
    signal z_s1 : std_logic_vector(15 downto 0);
    signal ready_s0 : std_logic;
    signal ready_s1 : std_logic;
    signal clk_s, rst_s : std_logic;       
    
    constant clk_period : time := 20 ns;
    

begin
    HLSM_UUT: HLSM port map(a_s, b_s, z_s0, start_s, ready_s0, clk_s, rst_s);
    FSMD_UUT: FSMD port map(a_s, b_s, z_s1, start_s, ready_s1, clk_s, rst_s);
    
    process
    begin
        clk_s <= '0';
        wait for (clk_period/2);
        clk_s <= '1';
        wait for (clk_period/2);
    end process;
    
    
    process
    begin
        A_s <= (others => '0');  
        B_s <= (others => '0'); 
        start_s <= '0';
        rst_s <= '1';
        
        wait for (clk_period/4);
        rst_s <= '0';
        wait for clk_period;
        
        a_s <= std_logic_vector(to_signed(-7, 8));
        b_s <= std_logic_vector(to_signed(5, 8));
        start_s <= '1';
        wait for clk_period;
        start_s <= '0';
                
        wait;
    end process;        
        

end Behavioral;