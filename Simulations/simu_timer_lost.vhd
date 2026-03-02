library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simu_timer_lost is
--  Port ( );
end simu_timer_lost;

architecture Behavioral of simu_timer_lost is
signal Clk25, reset,Load_Timer_Lost, Update_Timer_Lost : std_logic:= '0';
signal Game_Lost : std_logic;
signal Timer_Lost : std_logic_vector(5 downto 0);
begin

TML: entity work.Timer_Lost
      port map(clk25,reset, Load_Timer_Lost, Update_Timer_Lost, Game_Lost, Timer_Lost);

clk25 <= not clk25 after 5ns;
reset <= '1' after 20ns;
Load_Timer_Lost <= '1' after 30ns, '0' after 38ns;
Update_Timer_Lost <= '1' after 30ns, '0' after 670ns ;

end Behavioral;