library ieee;
use ieee.std_logic_1164.all;

entity FSMDispenser_tb is
end entity;

architecture tb of FSMDispenser_tb is

    component FSMDispenser is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            drink : in std_logic;
            account : in std_logic;
            done : in std_logic;
            money : in std_logic_vector(3 downto 0);
            size : in std_logic_vector(1 downto 0);
            sensor : in std_logic;
            sodaOut : out std_logic;
            change : out std_logic_vector(4 downto 0);
            kembali : out std_logic;
            display1 : out std_logic_vector(6 downto 0);
            display2 : out std_logic_vector(6 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal drink : std_logic := '0';
    signal account : std_logic := '0';
    signal done : std_logic := '0';
    signal money : std_logic_vector(3 downto 0) := (others => '0');
    signal size : std_logic_vector(1 downto 0) := (others => '0');
    signal sensor : std_logic := '0';
    signal sodaOut : std_logic;
    signal change : std_logic_vector(4 downto 0);
    signal kembali : std_logic;
    signal display1 : std_logic_vector(6 downto 0);
    signal display2 : std_logic_vector(6 downto 0);
begin
    DUT: FSMDispenser
        port map (
            clk => clk,
            reset => reset,
            drink => drink,
            account => account,
            done => done,
            money => money,
            size => size,
            sensor => sensor,
            sodaOut => sodaOut,
            change => change,
            kembali => kembali,
            display1 => display1,
            display2 => display2
        );
    clk_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;
    test_vector_1: process is
    begin
        reset <= '0';
        wait for 20 ns;
        drink <= '0';
        wait for 20 ns;
        size <= "00";
        wait for 20 ns;
        account <= '0';
        wait for 20 ns;
        sensor <= '1';
        wait for 20 ns;
        money <= "1010";
        wait for 20 ns;
        done <= '1';
        wait for 100 ns;
        assert sodaOut = '1'
            report "Test vector 1 failed: sodaOut"
            severity failure;
        assert change = "00101"
            report "Test vector 1 failed: change"
            severity failure;
        assert kembali = '1'
            report "Test vector 1 failed: kembali "
            severity failure;
        reset <= '1';
    end process;
end architecture;
