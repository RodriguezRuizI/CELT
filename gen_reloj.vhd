----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    19:30:24 11/23/2017 
-- Design Name: 
-- Module Name:    gen_reloj - Behavioral 
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

entity gen_reloj is
    Port ( CLK : in  STD_LOGIC; -- Reloj de la FPGA
           CLK_M : out  STD_LOGIC); -- Reloj de muestreo
end gen_reloj;

architecture a_gen_reloj of gen_reloj is

signal cont_M : STD_LOGIC_VECTOR (31 downto 0):= (others=>'0'); -- contador 1
signal S_M : STD_LOGIC :='0';

begin

	PROC_CONT : process (CLK)
		begin
			if CLK'event and CLK='1' then
				cont_M <= cont_M + 1;
				if cont_M >= 625000 then -- división de frecuencia a 40 Hz el número de ciclos es 625000
					S_M <=not S_M;
					cont_M <=(others=>'0');
				end if;
			end if;
		end process;
		
CLK_M<=S_M;

end a_gen_reloj;