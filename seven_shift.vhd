library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity seven_shift is
    port (
        sevenShift_in  : in  std_logic_vector (8 downto 0);
        sevenShift_out : out std_logic_vector (15 downto 0)
    );
end seven_shift;

architecture Behavior of seven_shift is
begin
    process (sevenShift_in)
    begin
        -- Perform a left shift by seven positions
        sevenShift_out <= sevenShift_in(8 downto 0) & "0000000";
    end process;
end Behavior;

