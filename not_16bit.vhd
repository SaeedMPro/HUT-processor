library IEEE;
use IEEE.std_logic_1164.all;

entity not_16bit is
    port(
        NOT_in  : in  std_logic_vector(15 downto 0);
        NOT_out : out std_logic_vector(15 downto 0)
    );
end not_16bit;

architecture Behavior of not_16bit is
begin
    process(NOT_in)
    begin
        NOT_out <= not NOT_in;
    end process;
end Behavior;

