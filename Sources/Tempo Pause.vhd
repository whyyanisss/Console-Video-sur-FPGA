library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
entity Tempo_Pause is
    Port ( Clk25, reset : in std_logic;
            RAZ_TEMPO_PAUSE, UPDATE_TEMPO_PAUSE: in std_logic;
            FIN_TEMPO_PAUSE : out std_logic);
end Tempo_Pause;

architecture Behavioral of Tempo_Pause is
signal compteur : std_logic_vector(9 downto 0):= (others => '0');
begin
process(clk25, reset)
begin
    if reset = '0' then compteur <= (others => '0');
    elsif rising_edge(clk25) then
        if RAZ_TEMPO_PAUSE = '1' then compteur <= (others => '0'); 
        elsif UPDATE_TEMPO_PAUSE = '1' then compteur <= compteur +1;
        else compteur <= compteur;
        end if;
    end if;
end process;
FIN_TEMPO_PAUSE <= '1' when compteur = "1111111111" else '0';
end Behavioral;
