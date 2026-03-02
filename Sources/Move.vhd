library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Move is
Port ( clk25, reset: in std_logic;
       QA, QB : in std_logic;
       Rot_left, Rot_right : out std_logic
);
end Move;

architecture Behavioral of Move is
type state is (S0,S2,S1,S3,S1r, S3r);
signal EP, EF : state:= S0;
begin

process(clk25, reset)
begin
    if reset = '0' then EP <= S0;
    elsif rising_edge(clk25) then EP <= EF; 
    end if;
end process;

process(EP, QA,QB)
begin
case EP is 
    when S0 => EF <= S0;
        if(QA = '1' and QB = '0') then EF <= S1 ;
        elsif(QA = '1' and QB = '1') then EF <= S1r ; end if;
    when S1 => EF <= S2;
    when S1r => EF <= S2;
    when S2 => EF <= S2;
        if(QA = '0' and QB = '1') then EF <= S3 ;
        elsif(QA = '0' and QB = '0') then EF <= S3r ; end if;
    when S3 => EF <= S0;
    when S3r => EF <= S0;
    end case;
end process;

process(EP)
begin
case EP is 
    when S0=> Rot_left <= '0';Rot_right <= '0';
    when S2=> Rot_left <= '0';Rot_right <= '0';
    
    when S1=> Rot_left <= '1';Rot_right <= '0';
    when S3=> Rot_left <= '1';Rot_right <= '0';
    
    when S1r=> Rot_left <= '0';Rot_right <= '1';
    when S3r=> Rot_left <= '0';Rot_right <= '1';
end case;
end process;
end Behavioral;
