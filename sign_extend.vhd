library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sign_extend is
    generic(n : natural := 1);
    port(
        SE_in  : in std_logic_vector (n-1 downto 0);
        SE_out : out std_logic_vector (15 downto 0)    
    );
end sign_extend;

architecture Behavior of sign_extend is
begin
    process(SE_in)
    begin
        for i in 0 to 15 loop
            if i < n then
                SE_out(i) <= SE_in(i);
            else
                SE_out(i) <= SE_in(n-1);
            end if;
        end loop;
    end process;
end Behavior;
