----------------------------------------------------------------------------------

-- Module Name: address_decoder - Behavioral

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity address_decoder is
  Port ( 
  m_pc_address	: in std_logic_vector(8 downto 0); -- 9bit address bus
  m_pc_address_valid :in std_logic;
  
  CW_addr :out std_logic;
  MEM_addr :out std_logic;
  XCLR_addr :out std_logic;
  DA_start_addr :out std_logic;
  DA_stop_addr	:out std_logic;
  
  db_en_b :out std_logic; -- pc mode (Directional Buffer enable control)
  PCS_b	:out std_logic
  );
end address_decoder;

architecture Behavioral of address_decoder is
begin


    process(m_pc_address_valid)
begin
    case m_pc_address is      
      when "1100000XX" => PCS_b <= '0'; -- address 180H-183H :
      when "110000XXX" => db_en_b <= '0'; -- address 180H-187H
      when "110000100" => CW_addr <= '1'; -- address 184H
      when "110000101" => MEM_addr <= '1'; -- address 185H
      when "110000110" => XCLR_addr <= '1'; -- address 186H
      when "110001000" => DA_start_addr <= '1'; -- address 188H
      when "110001001" => DA_stop_addr <= '1'; --address 189H
      when others  =>
      PCS_b <= '1';
      db_en_b <= '1';
      CW_addr <= '0';
      MEM_addr <= '0';
      XCLR_addr <= '0';
      DA_start_addr<= '0';
      DA_stop_addr<= '0';
    end case;

end process;
end Behavioral;
