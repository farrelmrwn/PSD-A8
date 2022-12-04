LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

--seven segment display 00, 05, 10, 15, 20

ENTITY sevseg IS
    PORT (
        clk : IN STD_LOGIC;
        data : out STD_LOGIC_VECTOR(3 DOWNTO 0);
        seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        digital_sel : OUT STD_LOGIC
    );
END sevseg;

ARCHITECTURE rtl OF sevseg IS
    SIGNAL counter : NATURAL RANGE 0 TO 10 := 0;
    SIGNAL data_number : NATURAL RANGE 0 TO 4 := 0;
BEGIN

    PROCESS (data_number)
    BEGIN
        CASE data_number IS
            WHEN 0 => data <= "1110"; --0
            WHEN 1 => data <= "0110"; --5
            WHEN 2 => data <= "1101"; --10
            WHEN 3 => data <= "1111"; --15
            WHEN 4 => data <= "0111"; --20
            WHEN OTHERS => data <= "0000";
        END CASE;
    END PROCESS;

    process (data_number)
    begin
        case data_number is
            when 0 => counter <= 1;
            when 1 => counter <= 2;
            when 2 => counter <= 3;
            when 3 => counter <= 4;
            when 4 => counter <= 5;
            when others => counter <= 0;
        end case;
    end process;

    PROCESS (counter)
    BEGIN
        case counter is
            when 0 => seg <= "1000000";
            when 1 => seg <= "1111001";
            when 2 => seg <= "0100100";
            when 3 => seg <= "0110000";
            when 4 => seg <= "0011001";
            when 5 => seg <= "0010010";
            when 6 => seg <= "0000010";
            when 7 => seg <= "1111000";
            when 8 => seg <= "0000000";
            when 9 => seg <= "0010000";
            when 10 => seg <= "0000001";
            when OTHERS => seg <= "1111111";
        end case;
    END PROCESS;
END rtl;