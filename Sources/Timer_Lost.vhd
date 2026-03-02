library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
entity Timer_Lost is
    Port (  Clk25, reset : in std_logic;
            Load_Timer_Lost, Update_Timer_Lost: in std_logic;
            Game_Lost : out std_logic;
            Timer_Lost : out std_logic_vector(5 downto 0));
end Timer_Lost;

architecture Behavioral of Timer_Lost is
signal compteur : std_logic_vector(5 downto 0):= (others => '0');
begin
process(clk25, reset)
begin
    if reset = '0' then compteur <= (others => '0');
    elsif rising_edge(clk25) then
        if Load_Timer_Lost = '1' then compteur <= (others => '1'); 
        elsif Update_Timer_Lost = '1' then 
        if compteur>0 then compteur <= compteur -1; 
        else compteur <= (others => '0');end if;
        end if;
    end if;
end process;
Game_Lost <= '1' when compteur > 0 else '0';
Timer_Lost <= compteur;
end Behavioral;
