library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simu_mode is
--  Port ( );
end simu_mode;

architecture Behavioral of simu_mode is
signal clk25, reset :  std_logic := '0';
signal Pause_Rqt, Endframe, Lost, No_Brick :  std_logic; 
signal Game_Lost, Brick_Win, Pause:  std_logic;
signal perdu :  std_logic;

begin

Mode : entity work.Mode
       port map(clk25, reset, Pause_Rqt, Endframe, Lost, No_Brick, 
       Game_Lost, Brick_Win, Pause, perdu);

clk25 <= not clk25 after 5ns;
reset <= '1' after 20ns;
Pause_Rqt <= '0', '1' after 50ns, '0' after 60ns;

Endframe <= clk25;
Lost <= '1';

No_Brick <= '0';
perdu <= '0';
end Behavioral;
