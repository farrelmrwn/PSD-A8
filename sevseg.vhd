library ieee;
use ieee.std_logic_1164.all;

entity sevseg is
    port (
        sev_in   : in std_logic_vector(3 downto 0);
        sev_out : out std_logic_vector(6 downto 0)
    );
end entity;

architecture rtl of sevseg is

begin
    process (sev_in)
    begin
        case sev_in is
            when "0000" => sev_out <= "1111110";  -- 0
            when "0001" => sev_out <= "0110000";  -- 1
            when "0010" => sev_out <= "1101101";  -- 2
            when "0011" => sev_out <= "1111001";  -- 3
            when "0100" => sev_out <= "0110011";  -- 4
            when "0101" => sev_out <= "1011011";  -- 5
            when "0110" => sev_out <= "1011111";  -- 6
            when "0111" => sev_out <= "1110000";  -- 7
            when "1000" => sev_out <= "1111111";  -- 8
            when "1001" => sev_out <= "1111011";  -- 9
            when others =>
                null;
        end case;
        
    end process;

end architecture;
