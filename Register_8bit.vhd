----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/11/29 03:08:20
-- Design Name: 
-- Module Name: Register_8bit - Behavioral
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

entity Register_8bit is
 Port ( 
        m_reset_b           : in    std_logic;
        m_reg_data_in       : in    std_logic_vector(7 downto 0);
        m_reg_data_out      : out   std_logic_vector(7 downto 0);
        m_reg_clk           : in    std_logic
);
end Register_8bit;

architecture Behavioral of Register_8bit is

begin

process(m_reg_clk, m_reset_b)
begin
    if m_reset_b = '0' then
        m_reg_data_out  <= (others=>'0');
    elsif rising_edge(m_reg_clk) then
        m_reg_data_out  <= m_reg_data_in;
    end if;
end process; 

end Behavioral; 
 
    
