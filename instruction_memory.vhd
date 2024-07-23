library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_memory is
    port(
        read_address : in std_logic_vector (15 downto 0);
        instruction  : out std_logic_vector (15 downto 0)
    );
end instruction_memory;

architecture behavioral of instruction_memory is
    type memory_array is array (0 to 15) of std_logic_vector(15 downto 0);
   
    signal memory : memory_array := (
        x"0000", x"1234", x"5678", x"9ABC",
        x"DEF0", x"1111", x"2222", x"3333",
        x"4444", x"5555", x"6666", x"7777",
        x"8888", x"9999", x"AAAA", x"BBBB"
    );
begin
    process(read_address)
    begin
        instruction <= memory(to_integer(unsigned(read_address(3 downto 0))));
    end process;
end behavioral;

