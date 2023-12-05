----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/12/04 21:31:34
-- Design Name: 
-- Module Name: Address_decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
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
  port (
    m_pc_address: in std_logic_vector(8 downto 0); -- input from PC
    A: out std_logic_vector(7 downto 0); -- output to A
    m_CW_addr: out std_logic; -- output to Control Word register
    m_DA_start_addr: out std_logic; -- output to DA start
    m_DA_stop_addr: out std_logic; -- output to DA stop
    m_MEM_addr: out std_logic; -- output to memory
    m_XCLR_addr: out std_logic; -- output to PC mode reset or DA mode reset
    m_db_en_b: out std_logic; -- output to data bus enable
    m_PCS_b: out std_logic -- output to peripheral chip select
  );
end address_decoder;

architecture behavioral of address_decoder is
begin
  process (m_pc_address)
  begin
    case m_pc_address is      
      when "10110000" => m_ <= '1'; -- address 180H :
      when "10110111" => m_ <= '1'; -- address 183H
      when "10111000" => m_CW_addr <= '1'; -- address 184H
      when "10111001" => m_MEM_addr <= '1'; -- address 185H
      when "10111010" => m_XCLR_addr <= '1'; -- address 186H
      when "10111000" => m_DA_start_addr <= '1'; -- address 188H
      when "10111001" => m_DA_stop_addr <= '1'; --address 189H
      when others => A <= "00000000"; -- invalid address
    end case;
    --db_en, PCS is not yet completed
    m_db_en_b <= '0' when m_pc_address >= "10110000" and m_pc_address <= "10111011" else '1'; -- data bus enable for addresses 180H to 18BH
    m_PCS_b <= '0' when m_pc_address >= "10110000" and m_pc_address <= "10111011" else '1'; -- peripheral chip select for addresses 180H to 18BH
  end process;
end behavioral;
