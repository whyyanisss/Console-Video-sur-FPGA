library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pong_pack.ALL;

entity timer_points is
Port (      clk100, clk25, reset, pause : in std_logic;
            game_type : in std_logic;
            brick_bounce : in tableau;
            Affiche : out std_logic_vector(6 downto 0);
            nom_jeu : out std_logic ;
            tp : out std_logic;  -- 0 si temps , 1 si points
            perdu : out std_logic
            );
end timer_points;

architecture Behavioral of timer_points is
signal clk20, t_10s, t_30s, stop, RAZ :  std_logic;
signal time_second :  integer;
signal nb_points : std_logic_vector(6 downto 0);
begin
Diviseur: entity work.clk20Hz 
          port map(Clk100, reset, clk20);
          
MAE : entity work.MAE_Affichage 
      port map (clk25, reset, pause,stop, game_type, t_10s,t_30s, perdu, time_second, nb_points, Affiche, nom_jeu, tp, RAZ);

timer : entity work.Timer_10s_30s
        port map(clk20, reset, RAZ, stop , t_10s, t_30s, time_second );
        
Points_count: entity work.Point_counter
              port map(clk100, reset, game_type, stop, brick_bounce, nb_points);
end Behavioral;
