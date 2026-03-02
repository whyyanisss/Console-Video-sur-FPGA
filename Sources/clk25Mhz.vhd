library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity ClkDiv is
Port ( Clk100 : in std_logic;
       Reset : in std_logic;
       Clk25 : out std_logic );
end ClkDiv;

architecture Behavioral of ClkDiv is
signal compteur : std_logic_vector(1 downto 0);
begin
process(Clk100, Reset) 
begin
        if Reset = '0' then
            compteur <= "00";
        else
            if rising_edge(Clk100) then
                compteur <= compteur +1;
            end if;
        end if;
end process;
Clk25 <= compteur(1);
end Behavioral;
