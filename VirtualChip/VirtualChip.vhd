library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity VirtualChip is
  port (PCLK : in std_logic;
        ain, bin, cin: in std_logic_vector(7 downto 0);
        aout, bout, cout: inout std_logic_vector(7 downto 0));
end VirtualChip;

architecture Behavioral of VirtualChip is
  
  
  component Inverter
    port( A0  :     in  std_logic;
          Q0  :     out std_logic);
  end component;
  
  component RingOscillator
    port( rst, Enable, clkin :     in  std_logic;
          Output      :     inout std_logic);
  end component;
  
  component FullAdder4
    port( A, B               :  in  std_logic_vector(3 downto 0);
          CarryIn            :  in  std_logic;
          AB                 :  out std_logic_vector(3 downto 0);
          CarryOut           :  out std_logic);
  end component;
  
  component BitRecogn8
    port( clk, rst, DataIn    :   in  std_logic;
          MatchBit, MatchAll  :   out std_logic);
  end component;

begin
  
Inver_1: Inverter         port map(A0 =>  bin(0), Q0 => aout(0));
Oscil_1: RingOscillator   port map(rst => ain(1), Enable => bin(1), clkin => PCLK, Output => aout(1));
Adder_1: FullAdder4       port map(A(3 downto 0)  => bin(5 downto 2), CarryIn  => bin(6), 
                                   B(0)  => bin(7), B(3 downto 1)  => cin(2 downto 0),
                                   AB(3 downto 0) => aout(5 downto 2),Carryout => aout(6));
Match_1: BitRecogn8       port map(clk => ain(0), rst => ain(3), DataIn => cin(3), MatchBit => aout(7), MatchAll => bout(0));
end Behavioral;