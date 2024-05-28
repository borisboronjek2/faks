library ieee;
use ieee.std_logic_1164.all;

entity slova is
    port (
        btn_left, btn_right, btn_up, btn_down, btn_center: in std_logic;
	rs232_tx: out std_logic;
	clk_25m: in std_logic;
        led: out std_logic_vector(7 downto 0);
	sw: in std_logic_vector (3 downto 0)
    );
end slova;


architecture behavioral of slova is
    signal code: std_logic_vector(7 downto 0);
    signal btns: std_logic_vector(4 downto 0);
    signal a: std_logic_vector (7 downto 0);
    signal b: std_logic_vector (7 downto 0);

begin

    btns <= btn_down & btn_left & btn_center & btn_up & btn_right;
    
    with btns select
    a <=
        "00000000" when "00000", -- ASCII NULL
        "00000000" when "10000", -- ASCII NULL
	"01000010" when "01000", -- ASCII B
	"01101111" when "00100", -- ASCII o
	"01110010" when "00010", -- ASCII r
	"01101001" when "00001", -- ASCII i
	"01000010" when "11000", -- ASCII B
	"01101111" when "10100", -- ASCII o
	"01110010" when "10010", -- ASCII r
	"01101111" when "10001", -- ASCII o
	"--------" when others; -- Don`t care
	
    with sw(0) select
    code <= 
         a when '0',
	 b when '1';
	 
    led <= code;

    serializer: entity serial_tx port map (
	clk => clk_25m, byte_in => code, ser_out => rs232_tx
    );
    
    modul_brojke: entity brojke port map (
        bb_down => btn_down, bb_left => btn_left, bb_center => btn_center, bb_up => btn_up, bb_right => btn_right, bb_code => b
    );
end;
