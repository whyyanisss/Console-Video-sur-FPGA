library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity MAE_mode is
     Port ( clk25, reset : in std_logic;
            Fin_Tempo_Pause, Pause_Rqt ,Endframe ,Lost ,No_Brick : in std_logic;
            Timer_Lost : in std_logic_vector(5 downto 0);
            RAZ_Tempo_Pause : out std_logic;
            Update_Tempo_Pause : out std_logic;
            Load_Timer_Lost : out std_logic;
            Update_Timer_Lost : out std_logic;
            Pause : out std_logic;
            Brick_Win : out std_logic;
            pgl : in  std_logic
            );
end MAE_mode;

architecture Behavioral of MAE_mode is
type state is (S0, S1, S2, S3, S4, S5, S6,S7);
signal EP,EF : state := S0;
begin

process(clk25, reset)
begin
    if reset = '0' then EP <= S0; 
    elsif rising_edge(clk25) then EP<= EF;
    end if;
end process;

process(EP,  Fin_Tempo_Pause, Pause_Rqt ,Endframe ,Lost ,No_Brick, Timer_Lost )
begin
    case EP is 
    when S0 => EF <= S0;
        if Pause_Rqt = '1' then EF <= S1; end if;
    when S1 => EF <= S1;
        if Fin_Tempo_Pause = '1' and  Pause_Rqt = '0' then EF <= S2; end if;   -- and  Pause_Rqt = '0'
    when S2 => EF <= S2;
        if Pause_Rqt = '1' then EF <= S7;                       -- PAUSE sans rebond
        elsif Lost = '1' or pgl = '1'  then EF <= S4;
        elsif No_Brick = '1' then EF <= S3;
        end if;
        
    when S3 => EF <= S3;
    when S4 => EF <= S5;                                        
    when S5 => EF <= S6;
    when S6 => EF <= S6;
        if timer_lost = 0 then EF <= S0; 
        elsif Endframe = '1' and timer_lost > 0 then EF <= S5; end if;
                         
    when S7 => EF <= S7;                                    -- and  Pause_Rqt = '0'
        if Fin_Tempo_Pause = '1' and  Pause_Rqt = '0' then EF <= S0; end if;         --PAUSE sans rebond
    end case;
end process;

process(EP)
begin

    RAZ_Tempo_Pause    <= '0';
    Pause              <= '0';
    Update_Tempo_Pause <= '0';
    Brick_Win          <= '0';
    Load_Timer_Lost    <= '0';
    Update_Timer_Lost  <= '0';
    
    case EP is 
    when S0 => RAZ_Tempo_Pause      <= '1'; 
               Pause                <= '1';
    when S1 => Update_Tempo_Pause   <= '1';
    when S2 => RAZ_Tempo_Pause      <= '1';
    when S3 => Brick_Win            <= '1';
    when S4 => Load_Timer_Lost      <= '1';
    when S5 => Update_Timer_Lost    <= '1'; 
    when S6 => null;
    when S7 => Update_Tempo_Pause   <= '1';
    end case;
end process;
end Behavioral;
