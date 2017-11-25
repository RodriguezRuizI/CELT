----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    20:25:04 11/23/2017 
-- Design Name: 
-- Module Name:    reg_desp - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_desp is
	Port ( SIN : in STD_LOGIC; -- Datos de entrada serie
			 CLK : in STD_LOGIC; -- Reloj
			 EN : in STD_LOGIC; -- Enable
			 Q : out STD_LOGIC_VECTOR (13 downto 0)); -- Salida paralelo
end reg_desp;

architecture a_reg_desp of reg_desp is

signal QSAL : STD_LOGIC_VECTOR(13 downto 0):= (others=>'0');

begin

  process (CLK)
    begin
      if (CLK'event and CLK='1') then
			if(EN = '1') then
				QSAL(13 downto 1) <= QSAL(12 downto 0);
				QSAL(0)<=SIN;
			end if;
		end if;
  end process;
			Q <= QSAL;

end a_reg_desp;

