library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity FSMDispenser is
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
end entity;

architecture rtl of FSMDispenser is
    component sevseg IS
    port (
        sev_in   : in std_logic_vector(3 downto 0);
        sev_out : out std_logic_vector(6 downto 0)
    );
end component;

type state_type is (idle, pepsi, coke, small, medium, big, guest, member,money_0, money_5, money_10, money_15, money_20, check, dispense);
signal current_state,next_state : state_type;
signal disp_in1 : std_logic_vector(3 downto 0);
signal disp_in2 : std_logic_vector(3 downto 0);
signal accumulate : std_logic_vector(4 downto 0);
signal price : std_logic_vector(4 downto 0);

begin

    SevsegPortPuluhan : sevseg port map (
        disp_in1, display1
    );
    SevsegPortSatuan : sevseg port map (
        disp_in2, display2
    );
    
process (clk, reset)    
begin
    if (reset = '1') then
        current_state <= idle;
    elsif (rising_edge(clk)) then
        current_state <= next_state;
    end if;
end process;

process (current_state, accumulate, price, drink, size, account, money, sensor, done)
begin
    case current_state is
        when idle =>
            sodaOut <= '0';
            kembali <= '0';
            change <= "00000";
            disp_in1 <=  "0000";
            disp_in2 <= "0000";
            if (drink = '1') then
                next_state <= coke;
            elsif (drink = '0') then
                next_state <= pepsi;
            else
                next_state <= idle;
            end if;
        when pepsi =>
            disp_in1 <= "0101";
            if (drink = '1') then
                next_state <= coke;
            end if;
            if(size = "00") then
                next_state <= small;
            elsif (size = "01") then
                next_state <= medium;
            elsif (size = "10") then
                next_state <= big;
            else
                next_state <= pepsi;
            end if;
        when coke =>
            disp_in1 <= "0001";
            disp_in2 <= "0000";
            if (drink = '0') then
                next_state <= pepsi;
            end if;
            if(size = "00") then
                next_state <= small;
            elsif (size = "01") then
                next_state <= medium;
            elsif (size = "10") then
                next_state <= big;
            else
                next_state <= coke;
            end if;
        when small =>
            if (drink = '1') then
                disp_in1 <= "0001";
                disp_in2 <= "0000";
                price <= "01010";
                if (account = '1') then
                    next_state <= member;
                elsif (account = '0') then
                    next_state <= guest;
                else
                    next_state <= small;
                end if;
            elsif (drink = '0') then
                disp_in1 <= "0101";
                price <= "00101";
                if (account = '1') then
                    next_state <= member;
                elsif (account = '0') then
                    next_state <= guest;
                else
                    next_state <= small;
                end if;
            end if;
        when medium =>
            if (drink = '1') then
                disp_in1 <= "0001";
                disp_in2 <= "0101";
                price <= "01111";
                if (account = '1') then
                    next_state <= member;
                elsif (account = '0') then
                    next_state <= guest;
                else
                    next_state <= medium;
                end if;
            elsif (drink = '0') then
                disp_in1 <= "0001";
                disp_in2 <= "0000";
                price <= "01010";
                if (account = '1') then
                    next_state <= member;
                elsif (account = '0') then
                    next_state <= guest;
                else
                    next_state <= medium;
                end if;
            end if;
        when big =>
            if (drink = '1') then
                disp_in1 <= "0010";
                disp_in2 <= "0000";
                price <= "10100";
                if (account = '1') then
                    next_state <= member;
                elsif (account = '0') then
                    next_state <= guest;
                else
                    next_state <= big;
                end if;
            elsif (drink = '0') then
                disp_in1 <= "0001";
                disp_in2 <= "0101";
                price <= "01111";
                if (account = '1') then
                    next_state <= member;
                elsif (account = '0') then
                    next_state <= guest;
                else
                    next_state <= big;
                end if;
            end if;
        when guest =>
            if (size = "00") then
                if (drink = '1') then
                    disp_in1 <= "0001";
                    disp_in2 <= "0000";
                elsif (drink = '0')then
                    disp_in1 <= "0101";
                end if;
            elsif (size = "01") then
                if (drink = '1') then
                    disp_in1 <= "0001";
                    disp_in2 <= "0101";
                elsif (drink = '0')then
                    disp_in1 <= "0001";
                    disp_in2 <= "0000";
                end if;
            elsif (size = "10") then
                if (drink = '1') then
                    disp_in1 <= "0010";
                    disp_in2 <= "0000";
                elsif (drink = '0')then
                    disp_in1 <= "0001";
                    disp_in2 <= "0101";
                end if;
            else
                next_state <= guest;
            end if;
            if (sensor = '1') then
                next_state <= money_0;
            else
                next_state <= guest;
            end if;
        when member =>
            if (size = "00") then
                if (drink = '1') then
                    disp_in1 <= "0001";
                    disp_in2 <= "0000";
                    next_state <= dispense;
                elsif (drink = '0')then
                    disp_in1 <= "0101";
                    next_state <= dispense;
                end if;
            elsif (size = "01") then
                if (drink = '1') then
                    disp_in1 <= "0001";
                    disp_in2 <= "0101";
                    next_state <= dispense;
                elsif (drink = '0')then
                    disp_in1 <= "0001";
                    disp_in2 <= "0000";
                    next_state <= dispense;
                end if;
            elsif (size = "10") then
                if (drink = '1') then
                    disp_in1 <= "0010";
                    disp_in2 <= "0000";
                    next_state <= dispense;
                elsif (drink = '0')then
                    disp_in1 <= "0001";
                    disp_in2 <= "0101";
                    next_state <= dispense;
                end if;
            else
                next_state <= member;
            end if;
        when money_0 =>
            if (money = "0101") then
                next_state <= money_5;
            elsif(money = "1010") then
                next_state <= money_10;
            else
                next_state <= money_0;
            end if;
        when money_5 => 
            accumulate <= "00101";
            if (done = '1') then
                next_state <= check;
            else
                if (money = "0101") then
                    next_state <= money_10;
                elsif(money = "1010") then
                    next_state <= money_15;
                else
                    next_state <= money_5;
                end if;
            end if;
        when money_10 =>
            accumulate <= "01010";
            if (done = '1') then
                next_state <= check;
            else
                if (money = "0101") then
                    next_state <= money_15;
                elsif (money = "1010") then
                    next_state <= money_20;
                else
                    next_state <= money_10;
                end if;
            end if;
        when money_15 =>
            accumulate <= "01111";
            if (done = '1') then
                next_state <= check;
            else
                if (money = "0101") then
                    next_state <= money_20;
                else
                    next_state <= money_15;
                end if;
            end if;
        when money_20 =>
            accumulate <= "10100";
            if (done = '1') then
                next_state <= check;
            else
                next_state <= money_20;
            end if;
        when check =>
            if (accumulate > price) then
                change <= accumulate - price;
                next_state <= dispense;
            else
                next_state <= money_5;
            end if;
        when dispense =>
            if (account = '1') then
                sodaOut <= '1';
                kembali <= '0';
                if (done = '0') then
                    next_state <= idle;
                else
                    next_state <= dispense;
                end if;
            else
                sodaOut <= '1';
                if (accumulate > price) then
                    kembali <= '1';
                else
                    kembali <= '0';
                end if;
                if (done = '0') then
                    next_state <= idle;
                else
                    next_state <= dispense;
                end if;
            end if;
        when others =>
            null;
    end case;
end process;
end architecture;
