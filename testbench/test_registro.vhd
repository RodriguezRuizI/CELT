--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:46:03 11/29/2017
-- Design Name:   
-- Module Name:   C:/Users/Isabel/Desktop/Isabel/uni/tercero/CELT/CELT_DIGITAL/test_registro.vhd
-- Project Name:  CELT_DIGITAL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registro
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY test_registro IS
END test_registro;
 
ARCHITECTURE behavior OF test_registro IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registro
    PORT(
         ENTRADA : IN  std_logic_vector(13 downto 0);
         SALIDA : OUT  std_logic_vector(13 downto 0);
			EN: in STD_LOGIC;
         CLK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ENTRADA : std_logic_vector(13 downto 0) := (others => '0');
	signal EN : std_logic := '0';
   signal RCLK : std_logic := '0';

 	--Outputs
   signal SALIDA : std_logic_vector(13 downto 0);

   -- Clock period definitions
   constant RCLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registro PORT MAP (
          ENTRADA => ENTRADA,
          SALIDA => SALIDA,
			 EN => EN,
          CLK => RCLK
        );

   -- Clock process definitions
   RCLK_process :process
   begin
		RCLK <= '0';
		wait for RCLK_period/2;
		RCLK <= '1';
		wait for RCLK_period/2;
   end process;
 

   -- El periodo de reloj es de 10 ns

   -- Stimulus process
   stim_proc: process
   begin		
      -- Probamos diferentes valores de las entradas.
		-- Dichos valores solamente deben ser capturados con el flanco positivo del reloj.
		-- En otro caso, la salida debe permanecer en el ultimo valor capturado
		
      wait for 10 ns;	
      ENTRADA<="01010101010101";
      wait for 2 ns;
		ENTRADA<="10101010101010";
      wait for 2 ns;
		ENTRADA<="01010101010101";
      wait for 2 ns;
		ENTRADA<="10101010101010";
      wait for 2 ns;
		ENTRADA<="01010101010101";
      wait for 2 ns;
		ENTRADA<="10101010101010";
      wait for 2 ns;
		ENTRADA<="01010101010101";
      wait for 2 ns;
		ENTRADA<="10101010101010";
      wait for 2 ns;
		ENTRADA<="01010101010101";
      wait for 2 ns;
		ENTRADA<="10101010101010";
      wait for 2 ns;
		EN<='1';
		wait for 2 ns;
		ENTRADA<="01010101010101";
      wait for 2 ns;
		ENTRADA<="10101010101010";
      wait for 2 ns;
		ENTRADA<="01010101010101";
      wait for 2 ns;
		ENTRADA<="10101010101010";
      wait for 2 ns;
		ENTRADA<="01010101010101";
      wait for 2 ns;
		ENTRADA<="10101010101010";
      wait for 2 ns;
		ENTRADA<="01010101010101";
      wait for 2 ns;
		ENTRADA<="10101010101010";
      wait for 2 ns;
		ENTRADA<="01010101010101";
      wait for 2 ns;
		ENTRADA<="10101010101010";
      wait for 2 ns;
		
      wait;
   end process;

END;
