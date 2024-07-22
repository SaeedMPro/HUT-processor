library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory is
    port(
        addr        : in std_logic_vector(15 downto 0); 
        instruction : out std_logic_vector(15 downto 0)  
    );
end instruction_memory;

architecture Behavioral of instruction_memory is
    type memory_array is array (0 to 15) of std_logic_vector(15 downto 0); 
	
	--initialize with some example
    signal memory : memory_array := (
        x"0000", x"1234", x"5678", x"9ABC", x"DEF0",
        others => x"0000"
    );
begin
    process(addr)
    begin
        instruction <= memory(to_integer(unsigned(addr)));
    end process;
end Behavioral;

