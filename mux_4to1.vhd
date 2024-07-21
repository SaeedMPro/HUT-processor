library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_4to1 is
    port(
        mux4to1_in0 : in std_logic_vector (15 downto 0);
        mux4to1_in1 : in std_logic_vector (15 downto 0);
        mux4to1_in2 : in std_logic_vector (15 downto 0);
        mux4to1_in3 : in std_logic_vector (15 downto 0);
        mux4to1_sel : in std_logic_vector (1 downto 0);  
        mux4to1_out : out std_logic_vector (15 downto 0)
    );
end mux_4to1;

architecture Behavior of mux_4to1 is
begin
    process(mux4to1_in0, mux4to1_in1, mux4to1_in2, mux4to1_in3, mux4to1_sel)
    begin
        case mux4to1_sel is
            when "00" =>
                mux4to1_out <= mux4to1_in0;
            when "01" =>
                mux4to1_out <= mux4to1_in1;
            when "10" =>
                mux4to1_out <= mux4to1_in2;
            when "11" =>
                mux4to1_out <= mux4to1_in3;
            when others =>
                null;
        end case;
    end process;
end Behavior;

