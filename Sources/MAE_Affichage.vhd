library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MAE_Affichage is
  Port (    clk25, reset : in std_logic;
            pause, stop , game_type, t_10s, t_30s : in std_logic;
            perdu  : out std_logic;
            time_second : in integer;
            nb_points : in std_logic_vector(6 downto 0);
            Affiche : out std_logic_vector(6 downto 0);
            nom_jeu : out std_logic;
            tp, RAZ : out std_logic  -- 0 si temps , 1 si points
            );
end MAE_Affichage;

architecture Behavioral of MAE_Affichage is
type state is (S0,S1,S2,S3,S4);
signal EF,EP : state := S0;
begin
process(clk25, reset)
begin
    if reset = '0' then EP <= S0;
    elsif rising_edge(clk25) then
        EP <= EF;
    end if;
end process;

process(EP,stop, game_type, t_10s, t_30s )
begin
    case EP is
    when S0 => EF <= S0;
        if pause = '0' then EF <= S1; end if;
    when S1 => EF <= S1;
        if t_10s = '1' then EF <= S2; end if;
    when S2 => EF <= S2;
        if t_30s = '1' then EF <= S3; end if;
    when S3 => EF <= S3;
        if time_second /= 0 and t_10s = '1' then EF <= S2;
        elsif time_second = 0 then EF <= S4;
        end if;
    when S4 => EF <= S0;
    end case;
end process;

process(EP)
begin 
    perdu <= '0';
    RAZ <= '0';
    Affiche <= (others => '0');
    nom_jeu <= '0';
    tp <= '0';
    case EP is 
    when S0 => RAZ <= '1'; 
    when S1 => nom_jeu <= '1';
    when S2 => Affiche <= std_logic_vector(to_unsigned(time_second, 7)); tp <= '0';
    when S3 => Affiche <= nb_points; tp <= '1';
    when S4 => perdu <= '1';
    end case;
end process;
end Behavioral;
