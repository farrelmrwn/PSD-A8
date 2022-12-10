library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity adder is
    port (
        --input
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        --input carry
        c_in : IN STD_LOGIC;
        --output
        sum : OUT STD_LOGIC;
        c_out : OUT STD_LOGIC
        
    );
end entity adder;

architecture rtl of adder is

begin

    c_out <= (a AND b) OR (c_in AND (a XOR b));
    sum <= a XOR b XOR c_in;

end architecture;
