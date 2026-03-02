
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mode is
    Port (  clk25, reset : in std_logic;
            Pause_Rqt, Endframe, Lost, No_Brick : in std_logic; 
            Game_Lost, Brick_Win, Pause: out std_logic;
            perdu : in std_logic
    );
end Mode;

architecture Behavioral of Mode is
signal clk, RAZ : std_logic;
signal Timer_Lost_s :  std_logic_vector(5 downto 0);
signal RAZ_Tempo_Pause, Fin_Tempo_Pause :  std_logic;
signal Update_Tempo_Pause :  std_logic;
signal Load_Timer_Lost :  std_logic;
signal Update_Timer_Lost :  std_logic;
begin

MAE_Mode : entity work.MAE_mode
           port map(clk25, reset, Fin_Tempo_Pause, Pause_Rqt ,Endframe ,Lost,No_Brick, 
           Timer_Lost_s, RAZ_Tempo_Pause, Update_Tempo_Pause, Load_Timer_Lost, Update_Timer_Lost,
           Pause, Brick_Win, perdu);
           
Tempo_Pause: entity work.Tempo_Pause
             port map(clk25, reset, RAZ_Tempo_Pause,Update_Tempo_Pause, Fin_Tempo_Pause);

Timer_Lost:  entity work.Timer_Lost
             port map(clk25, reset, Load_Timer_Lost, Update_Timer_Lost, Game_Lost, Timer_Lost_s );

end Behavioral;
