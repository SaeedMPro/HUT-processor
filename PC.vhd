library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC is
    port(
        clk         : in std_logic;
        reset       : in std_logic;
        PC_write    : in std_logic;                  
        PC_in       : in std_logic_vector(15 downto 0);  
        PC_out      : out std_logic_vector(15 downto 0)  
    );
end PC;

architecture Behavior of PC is
    signal PC_reg : std_logic_vector(15 downto 0) := (others => '0');  
begin
    process(clk, reset)
    begin
        if reset = '1' then
            PC_reg <= (others => '0'); 
        elsif rising_edge(clk) then
            if PC_write = '1' then
                PC_reg <= PC_in; 
            else
                PC_reg <= PC_reg; 
            end if;
        end if;
    end process;

    PC_out <= PC_reg;
end Behavior;

