library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sign_extend is
    port(
        SE_in  : in std_logic_vector (8 downto 0);
        SE_out : out std_logic_vector (15 downto 0)    
    );
end sign_extend;

architecture Behavior of sign_extend is
begin
    process(SE_in)
    begin
        for i in 0 to 15 loop
            if i < 9 then
                SE_out(i) <= SE_in(i);
            else
                SE_out(i) <= SE_in(8);
            end if;
        end loop;
    end process;
end Behavior;
