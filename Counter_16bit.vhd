----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/12/02 20:59:47
-- Design Name: 
-- Module Name: Counter_16bit - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter_16bit is
Port (
    m_clk       : in std_logic;
    m_cnt_en    : in std_logic;     -- Active H
    m_reset_b   : in std_logic;     -- Active L
    m_load_b    : in std_logic;     -- Active L
    m_din       : in std_logic_vector(15 downto 0);
    m_tc        : out std_logic;
    m_dout      : out std_logic_vector(15 downto 0)
 );
end Counter_16bit;

architecture Behavioral of Counter_16bit is
    signal s_cnt_val        : std_logic_vector (15 downto 0);
    signal s_tc             : std_logic;

begin
    
    process(m_clk)
    begin
        if rising_edge (m_clk) then
            if m_reset_b = '0' then
                s_cnt_val <= (others => '0');
            elsif m_load_b = '0' then 
                s_cnt_val<= m_din;
            elsif m_cnt_en = '1' then
                s_cnt_val <= s_cnt_val + '1';
            else
                s_cnt_val <= s_cnt_val;
            end if;
        end if;
     end process;
     
     m_tc <= '1' when s_cnt_val = x"ffff" else '0';
     
     --OUTPUT
     m_dout <= s_cnt_val;
     m_tc   <= s_tc; 
              
end Behavioral;
