library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is 
    port(
        clk      : in std_logic;
        MEM_we   : in std_logic;
        MEM_adr  : in std_logic_vector(15 downto 0);
        MEM_din  : in std_logic_vector(15 downto 0);
        MEM_dout : out std_logic_vector(15 downto 0)
    );
end entity;

architecture behavioral of data_memory is
    type ram_type is array (0 to 15) of std_logic_vector(15 downto 0);    
    signal my_ram : ram_type := (
        "0000000000000000",  -- default values
        "0000000000000001",
        "0000000000000010",
        "0000000000000011",
        "0000000000000100",
        "0000000000000101",
        "0000000000000110",
        "0000000000000111",
        "0000000000001000",
        "0000000000001001",
        "0000000000001010",
        "0000000000001011",
        "0000000000001100",
        "0000000000001101",
        "0000000000001110",
        "0000000000001111"
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if MEM_we = '1' then
                my_ram(to_integer(unsigned(MEM_adr))) <= MEM_din;
            end if;
        end if;
    end process;

    MEM_dout <= my_ram(to_integer(unsigned(MEM_adr)));
end architecture;

