library ieee;
use ieee.std_logic_1164.all;

entity brojke is
    port (
    bb_left, bb_right, bb_up, bb_down, bb_center: in std_logic;
    bb_code: out std_logic_vector(7 downto 0)
 );
end brojke;

architecture behavioral of brojke is

    signal btns: std_logic_vector(4 downto 0);

begin

    btns <= bb_down & bb_left & bb_center & bb_up & bb_right;

    with btns select
    bb_code <=
        "00000000" when "00000", -- ASCII NULL
	"00000000" when "10000", -- ASCII NULL
	"00110011" when "01000", -- ASCII 3
	"00110110" when "00100", -- ASCII 6
	"00110101" when "00010", -- ASCII 5
	"00110011" when "00001", -- ASCII 3
	"00110001" when "11000", -- ASCII 1
	"00110100" when "10100", -- ASCII 4
	"00110111" when "10010", -- ASCII 7
	"00110011" when "10001", -- ASCII 3
        "--------" when others ; -- don`t care

end;
