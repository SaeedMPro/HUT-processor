library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity register_file is
    port(
        clk, rst, RE_we     : in std_logic;
        RF_read, RF_adr_w   : in std_logic_vector (3 downto 0);
        RF_wd               : in std_logic_vector (15 downto 0);
        RF_out              : out std_logic_vector (15 downto 0)
    );
end register_file;

architecture Behavioral of register_file is

    component decoder_4to16 is
        port(
            DEC_in    : in std_logic_vector (3 downto 0);
            DEC_en    : in std_logic;
            DEC_out   : out std_logic_vector (15 downto 0)
        );
    end component;

    component mux_16to1 is
        port(
            mux16to1_in0  : in std_logic_vector (15 downto 0);
            mux16to1_in1  : in std_logic_vector (15 downto 0);
            mux16to1_in2  : in std_logic_vector (15 downto 0);
            mux16to1_in3  : in std_logic_vector (15 downto 0);
            mux16to1_in4  : in std_logic_vector (15 downto 0);
            mux16to1_in5  : in std_logic_vector (15 downto 0);
            mux16to1_in6  : in std_logic_vector (15 downto 0);
            mux16to1_in7  : in std_logic_vector (15 downto 0);
            mux16to1_in8  : in std_logic_vector (15 downto 0);
            mux16to1_in9  : in std_logic_vector (15 downto 0);
            mux16to1_in10 : in std_logic_vector (15 downto 0);
            mux16to1_in11 : in std_logic_vector (15 downto 0);
            mux16to1_in12 : in std_logic_vector (15 downto 0);
            mux16to1_in13 : in std_logic_vector (15 downto 0);
            mux16to1_in14 : in std_logic_vector (15 downto 0);
            mux16to1_in15 : in std_logic_vector (15 downto 0);
            mux16to1_sel  : in std_logic_vector (3 downto 0);  
            mux16to1_out  : out std_logic_vector (15 downto 0)
        );
    end component;

    signal we_signals  : std_logic_vector(15 downto 0);
    type reg_array is array (0 to 15) of std_logic_vector(15 downto 0);
    signal reg_outputs : reg_array := (
        x"0001", x"0002", x"0003", x"0003",
        x"0004", x"0005", x"0006", x"0004",
        x"0008", x"0009", x"000A", x"000B",
        x"000C", x"000D", x"000E", x"000F"
    );
begin
    
    process(clk, rst)
    begin
        if rst = '1' then
            reg_outputs <= (
                x"0001", x"0002", x"0003", x"0003",
                x"0004", x"0005", x"0006", x"0004",
                x"0008", x"0009", x"000A", x"000B",
                x"000C", x"000D", x"000E", x"000F"
            );
        elsif rising_edge(clk) then
            for i in 0 to 15 loop
                if we_signals(i) = '1' then
                    reg_outputs(i) <= RF_wd;
                end if;
            end loop;
        end if;
    end process;
    
    --write enable signals
    decoder_inst : decoder_4to16
        port map (
            DEC_in => RF_adr_w,
            DEC_en => RE_we,
            DEC_out => we_signals
        );

    --select the output
    mux_inst : mux_16to1
        port map (
            mux16to1_in0 => reg_outputs(0),
            mux16to1_in1 => reg_outputs(1),
            mux16to1_in2 => reg_outputs(2),
            mux16to1_in3 => reg_outputs(3),
            mux16to1_in4 => reg_outputs(4),
            mux16to1_in5 => reg_outputs(5),
            mux16to1_in6 => reg_outputs(6),
            mux16to1_in7 => reg_outputs(7),
            mux16to1_in8 => reg_outputs(8),
            mux16to1_in9 => reg_outputs(9),
            mux16to1_in10 => reg_outputs(10),
            mux16to1_in11 => reg_outputs(11),
            mux16to1_in12 => reg_outputs(12),
            mux16to1_in13 => reg_outputs(13),
            mux16to1_in14 => reg_outputs(14),
            mux16to1_in15 => reg_outputs(15),
            mux16to1_sel => RF_read,
            mux16to1_out => RF_out
        );

end Behavioral;
