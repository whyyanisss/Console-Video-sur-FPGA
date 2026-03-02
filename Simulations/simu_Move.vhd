library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simu_Move is
--  Port ( );
end simu_Move;

architecture Behavioral of simu_Move is
signal clk25, reset:  std_logic := '0';
signal QA, QB :  std_logic:= '0';
signal Rot_left, Rot_right : std_logic;
begin

Move: entity work.Move
      port map(clk25, reset, QA,QB,Rot_left, Rot_right);

clk25 <= not clk25 after 5ns;
reset <= '1' after 20ns;
QA <= '1' after 50ns, '0' after 100ns, '1' after 180ns, '0' after 250ns;
QB <= '1' after 80ns, '0' after 120ns, '1' after 170ns, '0' after 240ns;
end Behavioral;
