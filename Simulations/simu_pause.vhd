
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity simu_pause is
--  Port ( );
end simu_pause;

architecture Behavioral of simu_pause is
signal Clk25, reset : std_logic := '0';
signal RAZ_TEMPO_PAUSE, UPDATE_TEMPO_PAUSE:  std_logic:='0';
signal FIN_TEMPO_PAUSE :  std_logic;
signal compteur : std_logic_vector(9 downto 0);
begin

Tempo: entity work.Tempo_Pause
       port map(clk25, reset,RAZ_TEMPO_PAUSE, UPDATE_TEMPO_PAUSE, FIN_TEMPO_PAUSE);

clk25 <= not clk25 after 1ns;
reset <= '1' after 30ns;
UPDATE_TEMPO_PAUSE <= '1' after 50ns, '0' after 150ns;
end Behavioral;
