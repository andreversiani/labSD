library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;
use IEEE.numeric_std.all;
use ieee.std_logic_textio.all;

entity reservatorio2_tb is
end reservatorio2_tb;

architecture bench of reservatorio2_tb is

  component reservatorio is
  port ( 	A, B     : in std_logic_vector(3 downto 0);
          onoff    : in std_logic;
          out_1    : out std_logic_vector(3 downto 0));
  end component;

  signal A, B: std_logic_vector(3 downto 0);
  signal onoff: std_logic;
  signal out_1: std_logic_vector(3 downto 0);

  signal flag_read_data  	: std_logic:='0';
  signal flag_write      	: std_logic:='0';

  file arquivo_entrada : text open read_mode is "datain1.txt";
  file arquivo_expected_output : text open read_mode is "expected_dataout.txt";
  file arquivo_saida1   : text open write_mode is "dataout1.txt";
  file arquivo_saida2   : text open write_mode is "dataout2.txt";

  constant OFFSET     	  : time := 10 ns;
  constant OFFSET_WRITE   : time := 13 ns;
  constant MEIO_OFFSET    : time := 5 ns;

  constant aux_string1	: string := "ERROR";
  constant aux_string2	: string := "ok";

  begin
    instancia : reservatorio port map (A => A, B => B, onoff => onoff, out_1 => out_1);
                                                                                                                                       
      --process para ler os arquivos
      read_and_write_files:
        process    
            variable row1, row2         : line;
            variable in_A, in_B     : std_logic_vector (3 downto 0); 
            variable space          : character;
            variable in_onoff       : std_logic; 
            variable saida_aux      : std_logic_vector (3 downto 0):=(others => '0');

            begin
                readline(arquivo_entrada,row1);
                writeline(arquivo_saida1,row2);
                wait for OFFSET_WRITE;
                while not endfile(arquivo_entrada) loop
                    wait for (MEIO_OFFSET);
                    readline(arquivo_entrada,row1);
                    read(row1, in_a);
                    read(row1, space);
                    read(row1, in_b);
                    read(row1, space);
                    read(row1, in_onoff);
                    
                    A <= in_a;
                    B <= in_b;
                    onoff <= in_onoff;
        
                    saida_aux := out_1;
        
                    write(row2, saida_aux);
                    writeline(arquivo_saida1,row2);
        
                    wait for (MEIO_OFFSET);
                end loop;
                file_close(arquivo_entrada);
                file_close(arquivo_saida1);
                wait;
            end process read_and_write_files;

            assertions_from_files: 
                process
                variable expected_out, out_2 : std_logic_vector(3 downto 0);
                variable row3, row4  : line;

                begin
                wait for OFFSET_WRITE;
                    readline(arquivo_expected_output,row3);
                    while not endfile(arquivo_expected_output) loop
                            wait for(MEIO_OFFSET);    
                            readline(arquivo_expected_output,row3);
                            read(row3, expected_out);

                            out_2 := out_1;
                            if(expected_out /= out_2) then
                                assert false report aux_string1 severity note;
                                
                                write(row4, aux_string1);
                                writeline(arquivo_saida2,row4);
                        
                            else
                                assert false report aux_string2 severity note;
                                
                                write(row4, aux_string2);
                                writeline(arquivo_saida2,row4);
                            end if;
                        wait for(MEIO_OFFSET);
                    end loop;
                    file_close(arquivo_expected_output);
                    file_close(arquivo_saida2);
                    wait;
                end process assertions_from_files;         
end;
