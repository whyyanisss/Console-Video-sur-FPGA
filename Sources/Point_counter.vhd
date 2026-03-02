library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pong_pack.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Point_counter is
    Port (
        clk100, reset : in std_logic;
        game_type     : in std_logic;
        stop          : in std_logic;
        brick_bounce  : in tableau;
        nb_points     : out std_logic_vector(6 downto 0)
    );
end Point_counter;

architecture Behavioral of Point_counter is
    signal counter : integer := 0;
begin

process(clk100, reset)
    variable sum : integer := 0;
begin
    if reset = '0' then
        counter <= 0;

    elsif rising_edge(clk100) then
        
        if stop = '0' and game_type = '0' then
            -- Recompter toutes les briques activées
            sum := 0; 
            for i in 0 to 1 loop
                for j in 0 to 8 loop
                    if brick_bounce(i)(j) = '1' then
                        sum := sum + 1;
                    end if;
                end loop;
            end loop;
            counter <= sum;

        end if;

    end if;
end process;

nb_points <= std_logic_vector(to_unsigned(counter, 7));

end Behavioral;
