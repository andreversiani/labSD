# Modifique a linha abaixo para o caminho do seu computador onde se encontra os seus arquivos fonte a serem compilados e simulados.
cd C:\Users\UFMG\Documents\UFMG\LSD\ERE\LSD1
ghdl -a reservatorio.vhd
ghdl -a --ieee=synopsys reservatorio2_tb.vhd
ghdl -e --ieee=synopsys reservatorio2_tb
ghdl -r --ieee=synopsys reservatorio2_tb
:Done
