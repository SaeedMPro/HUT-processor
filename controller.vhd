library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controller is
    port(
        op_code 	: in  std_logic_vector(2 downto 0);
        pc_sel      : out std_logic;
        we_pc       : out std_logic;
        we_reg      : out std_logic;
        we_mem      : out std_logic;
        alu_sel_a   : out std_logic_vector(1 downto 0);
        alu_sel_b   : out std_logic_vector(1 downto 0);
        alu_opr     : out std_logic;
        wd_sel      : out std_logic_vector(1 downto 0);
        wr_sel      : out std_logic
    );
end controller;

architecture Behavioral of controller is
begin

    process(op_code)
    begin

            case op_code is
                -- NEG: rA <- 2's Complement (rB)
                when "000" =>
                    pc_sel   <= '0';
                    we_pc    <= '1';
                    we_reg   <= '1';
                    we_mem   <= '0';
                    alu_sel_a <= "01";
                    alu_sel_b <= "00";
                    alu_opr  <= '0';
                    wd_sel   <= "10";
                    wr_sel   <= '1';

                -- SBR: rB(Imm) <- '1'
                when "001" =>
                    pc_sel   <= '0';
                    we_pc    <= '1';
                    we_reg   <= '1';
                    we_mem   <= '0';
                    alu_sel_a <= "00";
                    alu_sel_b <= "01";
                    alu_opr  <= '1';
                    wd_sel   <= "10";
                    wr_sel   <= '0';

                -- OR: rA <- [rB OR Z.F.(Imm)]
                when "010" =>
                    pc_sel   <= '0';
                    we_pc    <= '1';
                    we_reg   <= '1';
                    we_mem   <= '0';
                    alu_sel_a <= "10";
                    alu_sel_b <= "11";
                    alu_opr  <= '1';
                    wd_sel   <= "10";
                    wr_sel   <= '1';

                -- RJMP: PC <- 2*[PC + rA + S.E.(Imm)]
                when "011" =>
                    pc_sel   <= '1';
                    we_pc    <= '1';
                    we_reg   <= '0';
                    we_mem   <= '0';
                    alu_sel_a <= "10";
                    alu_sel_b <= "10";
                    alu_opr  <= '0';
                    wd_sel   <= "00";
                    wr_sel   <= '1';

                -- LUI: rA <- Imm * 128
                when "100" =>
                    pc_sel   <= '0';
                    we_pc    <= '1';
                    we_reg   <= '1';
                    we_mem   <= '0';
                    alu_sel_a <= "00";
                    alu_sel_b <= "11";
                    alu_opr  <= '0';
                    wd_sel   <= "01";
                    wr_sel   <= '0';

                -- LDI: rA <- Mem[2*Z.F.(Imm)]
                when "101" =>
                    pc_sel   <= '0';
                    we_pc    <= '1';
                    we_reg   <= '1';
                    we_mem   <= '0';
                    alu_sel_a <= "00";
                    alu_sel_b <= "11";
                    alu_opr  <= '0';
                    wd_sel   <= "00";
                    wr_sel   <= '0';

                -- STI: Mem[2*Z.F.(Imm)] <- rA
                when "110" =>
                    pc_sel   <= '0';
                    we_pc    <= '1';
                    we_reg   <= '0';
                    we_mem   <= '1';
                    alu_sel_a <= "00";
                    alu_sel_b <= "11";
                    alu_opr  <= '0';
                    wd_sel   <= "00";
                    wr_sel   <= '0';

                when others =>
                    pc_sel   <= '0';
                    we_pc    <= '0';
                    we_reg   <= '0';
                    we_mem   <= '0';
                    alu_sel_a <= "00";
                    alu_sel_b <= "00";
                    alu_opr  <= '0';
                    wd_sel   <= "00";
                    wr_sel   <= '0';

            end case;
    end process;
end Behavioral;

