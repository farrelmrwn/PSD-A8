library ieee;
use ieee.std_logic_1164.all;

--testbench for seven segment

entity sevseg_tb is
end entity;

architecture testbench of sevseg_tb is
    -- Instantiate the sevseg component
    component sevseg is
        port (
            sev_in   : in std_logic_vector(3 downto 0);
            sev_out : out std_logic_vector(6 downto 0)
        );
    end component;

    -- Clock period is 10 ns
    constant clk_period: time := 10 ns;
    signal sev_in   : std_logic_vector(3 downto 0);
    signal sev_out : std_logic_vector(6 downto 0);

begin
    -- Instantiate the sevseg component
    DUT: sevseg port map (
        sev_in => sev_in,
        sev_out => sev_out
    );

    -- Generate a clock signal with a period of 10 ns
    clk_gen: process
    begin
        sev_in <= "0000";
        wait for clk_period/2;
        sev_in <= "0001";
        wait for clk_period/2;
        sev_in <= "0010";
        wait for clk_period/2;
        sev_in <= "0011";
        wait for clk_period/2;
        sev_in <= "0100";
        wait for clk_period/2;
        sev_in <= "0101";
        wait for clk_period/2;
        sev_in <= "0110";
        wait for clk_period/2;
        sev_in <= "0111";
        wait for clk_period/2;
        sev_in <= "1000";
        wait for clk_period/2;
        sev_in <= "1001";
        wait for clk_period/2;
        sev_in <= "0000";
        wait for clk_period/2;
        sev_in <= "0001";
        wait for clk_period/2;
    end process;
end architecture;
