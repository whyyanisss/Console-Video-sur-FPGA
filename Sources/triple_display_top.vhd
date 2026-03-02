-- Nom du fichier : triple_display_top.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;     -- Crucial pour les maths (division/modulo)
use work.display_package.ALL; -- Importe le composant Décodeur

entity Afficheur_Triple_Seg is
    Port ( 
        data_in_7bit : in  STD_LOGIC_VECTOR(6 downto 0); -- Ton entrée (ex: Score/Temps)
        
        -- Sorties 7 segments
        S2_seg : out STD_LOGIC_VECTOR(6 downto 0); -- Centaines (S2)
        S1_seg : out STD_LOGIC_VECTOR(6 downto 0); -- Dizaines (S1)
        S0_seg : out STD_LOGIC_VECTOR(6 downto 0)  -- Unités (S0)
    );
end Afficheur_Triple_Seg;

architecture Structurel of Afficheur_Triple_Seg is
    
    -- Signaux internes pour la séparation (BCD 4 bits)
    signal bcd_centaines : STD_LOGIC_VECTOR(3 downto 0);
    signal bcd_dizaines  : STD_LOGIC_VECTOR(3 downto 0);
    signal bcd_unites    : STD_LOGIC_VECTOR(3 downto 0);
    
    -- Signal entier pour les opérations (max 127)
    signal value_int : INTEGER range 0 to 127; 

begin

    -- 1. CONVERSION : Vecteur 7 bits -> Entier
    value_int <= to_integer(unsigned(data_in_7bit)); 
    
    -- 2. SÉPARATION : Entier -> Chiffres (arithmétique)
    
    -- Chiffre des UNITÉS : Reste de la division par 10
    bcd_unites <= std_logic_vector(to_unsigned(value_int mod 10, 4));

    -- Chiffre des DIZAINES : Reste de la division par 100, puis division par 10
    bcd_dizaines <= std_logic_vector(to_unsigned((value_int / 10) mod 10, 4));

    -- Chiffre des CENTAINES : Division par 100
    bcd_centaines <= std_logic_vector(to_unsigned(value_int / 100, 4));


    -- 3. DÉCODAGE : Instanciation du composant pour chaque chiffre
    
    -- S0 : Unités
    U0_Dec : component Decoder_7Segment_BCD
        Port map (
            bcd_in   => bcd_unites,
            segments => S0_seg 
        );
        
    -- S1 : Dizaines
    U1_Dec : component Decoder_7Segment_BCD
        Port map (
            bcd_in   => bcd_dizaines,
            segments => S1_seg 
        );

    -- S2 : Centaines
    U2_Dec : component Decoder_7Segment_BCD
        Port map (
            bcd_in   => bcd_centaines,
            segments => S2_seg 
        );
        
end Structurel;