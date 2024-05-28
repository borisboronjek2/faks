library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity count is
    port (
	clk_25m: in std_logic;
	btn_up, btn_right: in std_logic;
	led: out std_logic_vector(7 downto 0)
    );
end count;

architecture x of count is
    signal R: std_logic_vector(7 downto 0);
    signal clk_key: std_logic;
    signal reset: std_logic;

begin
    reset <= btn_right;
    process(clk_key)
    begin
	if reset = '1' and rising_edge(clk_key) then
	    R <= "00000000";
	elsif rising_edge(clk_key) and R = "01001001" then
	    R <= x"00";
	elsif rising_edge(clk_key) then
	    R <= R + '1';
	end if;
    end process;
    led <= R;
    I_debouncer: entity work.debouncer port map (
    clk => clk_25m, key => btn_up, debounced => clk_key
);
end x;