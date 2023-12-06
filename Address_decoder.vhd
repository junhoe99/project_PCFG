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


    process(m_pc_address_valid, m_pc_address)
begin
    -- m_pc_addr_valid가 1일때만 address decoder를 실행
    if m_pc_address_valid = '1' then
        case m_pc_address is      
          when "1100000XX" => PCS_b <= '0'; -- address 180H-183H :   
          when "110000XXX" => db_en_b <= '0'; -- address 180H-187H
          when "110000100" => CW_addr <= '1'; -- address 184H
          when "110000101" => MEM_addr <= '1'; -- address 185H
          when "110000110" => XCLR_addr <= '1'; -- address 186H
          when "110001000" => DA_start_addr <= '1'; -- address 188H
          when "110001001" => DA_stop_addr <= '1'; --address 189H
          when others => 
            -- m_pc_address가 180H~189H가 아닌 경우에 원하는 동작을 정의합니다.
            PCS_b <= '1';
            db_en_b <= '1';
            CW_addr <= '0';
            MEM_addr <= '0';
            XCLR_addr <= '0';
            DA_start_addr <= '0';
            DA_stop_addr <= '0';
        end case;
    else
        -- m_pc_addr_valid가 0일때는 address decoder를 실행하지 않고, 모든 신호를 0으로 만듭니다.
        PCS_b <= '1';
        db_en_b <= '1';
        CW_addr <= '0';
        MEM_addr <= '0';
        XCLR_addr <= '0';
        DA_start_addr <= '0';
        DA_stop_addr <= '0';
    end if;

end process;
end Behavioral;
