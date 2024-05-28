library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity morse is
    port(
	clk, rst, l, r: in std_logic;
	m: out std_logic
    );
end morse;

architecture moore of morse is
    constant s0: std_logic_vector(3 downto 0) := "0000";
    constant s1: std_logic_vector(3 downto 0) := "0001";
    constant s2: std_logic_vector(3 downto 0) := "0010";
    constant s3: std_logic_vector(3 downto 0) := "0011";
    constant s4: std_logic_vector(3 downto 0) := "0100";
    constant s5: std_logic_vector(3 downto 0) := "0101";
    constant s6: std_logic_vector(3 downto 0) := "0110";
    constant s7: std_logic_vector(3 downto 0) := "0111";
    constant s8: std_logic_vector(3 downto 0) := "1000";

    signal R_state: std_logic_vector(3 downto 0);
    signal R_timer: std_logic_vector(1 downto 0);

    signal new_state: std_logic_vector(3 downto 0);
    signal state_we: std_logic;

begin
    -- Timer, FSM state registers
    process(clk, rst)
    begin
	if rst = '1' then
	    R_state <= (others => '0');
	    R_timer <= (others => '0');
	elsif rising_edge(clk) then
	    if state_we = '1' then
		R_state <= new_state;
		R_timer <= (others => '0');
	    else
		R_timer <= std_logic_vector(signed(R_timer) + 1);
	    end if;
	end if;
    end process;

    -- FSM combinatorial logic: "X" = Morse _.._
    process(R_state, R_timer, l)
    begin
	-- Defaults, overriden later by case / when sections when appropriate
	new_state <= std_logic_vector(signed(R_state) + 1);
	state_we <= '1';

	-- Moore FSM: ASCII "X" = Morse -..-
	case R_state is
	when s0 =>
	    m <= '0';
	    if l = '0' then
		new_state <= s0;
	    end if;
	when s1 | s7 =>
	    m <= '1';
	    if R_timer(1) = '0' then
		state_we <= '0';
	    end if;
	when s2 | s4 | s6 =>
	    m <= '0';
	when s3 | s5 =>
	    m <= '1';
	when s8 =>
	    m <= '0';
	    new_state <= s0;
	    if R_timer = "00" then
		state_we <= '0';
	    end if;
	when others =>
	    m <= '0';
	    -- new_state <= s0;
	    state_we <= '0';
	end case;
    end process;
end moore;
