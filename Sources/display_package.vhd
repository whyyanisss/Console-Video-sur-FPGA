-- Nom du fichier : display_package.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package display_package is

    -- DÉCLARATION DU COMPOSANT
    component Decoder_7Segment_BCD
        Port ( 
            bcd_in : in  STD_LOGIC_VECTOR(3 downto 0);
            segments : out STD_LOGIC_VECTOR(6 downto 0) -- ORDRE: G F E D C B A
        );
    end component;
    
end package display_package;

-- ******************************************************
-- IMPLÉMENTATION DE L'ENTITÉ DU DÉCODEUR (Doit être dans le même fichier pour simplifier)
-- ******************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_7Segment_BCD is
    Port ( 
        bcd_in : in  STD_LOGIC_VECTOR(3 downto 0);
        segments : out STD_LOGIC_VECTOR(6 downto 0) -- ORDRE: G F E D C B A
    );
end Decoder_7Segment_BCD;

architecture Behavioral of Decoder_7Segment_BCD is
begin
    -- Logique combinatoire (Actif Bas: '0' = allumé, '1' = éteint)
    -- VECTEUR : G F E D C B A (Segments 6 à 0)
    with bcd_in select
        segments <= 
        "1000000" when "0000", -- 0
        "1111001" when "0001", -- 1
        "0100100" when "0010", -- 2
        "0110000" when "0011", -- 3
        "0011001" when "0100", -- 4
        "0010010" when "0101", -- 5 
        "0000010" when "0110", -- 6
        "1111000" when "0111", -- 7
        "0000000" when "1000", -- 8
        "0010000" when "1001", -- 9
        "1111111" when others; -- Éteint
end Behavioral;