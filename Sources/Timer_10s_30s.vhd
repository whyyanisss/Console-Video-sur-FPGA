library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity Timer_10s_30s is
    Port (  clk20, reset, RAZ : in std_logic;
            stop : out std_logic;
            t_10s, t_30s : out std_logic;
            time_second : out integer
       );
end Timer_10s_30s;

architecture Behavioral of Timer_10s_30s is
signal timer120 : integer range 0 to 120 := 120;
signal timer1s : integer range 0 to 20 := 0;
signal timer30 : integer range 0 to 600 := 0;

begin
process(clk20,reset)
begin
        if reset = '0' then timer120 <= 120; timer30 <= 0; stop <= '0';
        elsif( rising_edge(clk20)) then
            if RAZ = '1' then timer120 <= 120; timer30 <= 0; stop <= '0';
            elsif RAZ = '0' then
            timer1s <= timer1s +1;

            if timer120 = 0 then 
                stop <= '1';
                timer120 <= 120; 
            else 
                if timer1s = 20 then timer1s <= 0; 
                timer120 <= timer120 -1;
                end if;
            end if;
            
            timer30 <= timer30 +1;
            case timer30 is
            when 300  => t_10s <= '1'; 
            when 600 => t_30s <= '1'; timer30 <= 0;
            when others => t_10s <= '0'; 
                           t_30s <= '0';
            end case;
            end if;
        end if;
end process;
time_second <= timer120;
end Behavioral;
