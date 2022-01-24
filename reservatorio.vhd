-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity reservatorio is
port ( 	A, B     : in std_logic_vector(3 downto 0);
        onoff    : in std_logic;
        out_1    : out std_logic_vector(3 downto 0)
     );
end reservatorio;

architecture behavioral of reservatorio is
 	begin
        comp_process: process(A, B, onoff) is
            begin
                if(onoff = '0') then 
                   out_1 <= "0000"; --sistema desligado
                else
                     if(B>A) then
                        out_1 <= "1001"; -- nivel do reservatorio maior que o valor de ref
                     elsif(B=A) then
                        out_1 <= "1010"; -- nivel do reservatorio igual ao valor de ref
                     else
                        out_1 <= "1100"; -- nivel do reservatorio menor que o valor de ref
                     end if;
                end if;
        end process comp_process;
end behavioral;
