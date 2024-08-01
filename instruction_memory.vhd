library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all;

entity instruction_memory is
	port (
		read_address: in std_logic_vector (15 downto 0);
		instruction : out std_logic_vector (15 downto 0)
	);
end instruction_memory;


architecture behavioral of instruction_memory is	  

    type mem_array is array(0 to 15) of std_logic_vector (15 downto 0);
    signal data_mem: mem_array := (
        "0000000000000000", -- initialize data memory
        "0000000000000000", -- mem 1
        "0000000000000000",
        "0000000000000000",
        "0000000000000000",
        "0000000000000000",
        "0000000000000000",
        "0000000000000000",
        "0000000000000000",
        "0000000000000000", 
        "0000000000000000", -- mem 10 
        "0000000000000000", 
        "0000000000000000",
        "0000000000000000",
        "0000000000000000",
        "0000000000000000"
    );

    begin

    -- reading the instructions from file into memory
    process
        file file_pointer : text;
        variable line_content : string(1 to 16);
        variable line_num : line;
        variable i: integer := 0;
        variable j : integer := 0;
        variable char : character:='0'; 
    
        begin
        	file_open(file_pointer, "instructions.txt", READ_MODE); 
        	while not endfile(file_pointer) loop
            	readline(file_pointer,line_num); 
            	read(line_num,line_content);
            	for j in 1 to 16 loop        
                	char := line_content(j);
                	if(char = '0') then
                    	data_mem(i)(16-j) <= '0';
                	else
                    	data_mem(i)(16-j) <= '1';
                	end if; 
            	end loop;
            	i := i + 1;
        	end loop;
			file_close(file_pointer); 
        wait; 
    end process;

    -- Since the registers are in multiples of 2 bytes, we can ignore the last one bits
    process(read_address)
    begin
        instruction <= data_mem(to_integer(unsigned(read_address(3 downto 1))));
    end process;

end behavioral;
