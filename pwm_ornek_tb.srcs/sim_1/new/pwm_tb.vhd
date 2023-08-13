library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity pwm_tb is
  Generic(
	clk_freq : integer := 100_000_000;
	pwm_freq : integer := 1000			-- 100 000 000 / 1000 = 1ms
  );
end pwm_tb;


architecture Behavioral of pwm_tb is
component pwm is
  Generic(
	clk_freq : integer := 100_000_000;
	pwm_freq : integer := 1000			-- 100 000 000 / 1000 = 1ms
  );
  Port (
	clk : in std_logic;
	pwm_o : out std_logic;
	duty_cyc : in std_logic_vector(6 downto 0)
  );
end component;


signal	clk : std_logic := '0';
signal	pwm_o : std_logic;
signal	duty_cyc : std_logic_vector(6 downto 0) := "0000000";

constant clk_time : time := 10ns;


begin
DUT : pwm
  Generic map(
	clk_freq => clk_freq,
	pwm_freq => pwm_freq			-- 100 000 000 / 1000 = 1ms
  )
  Port map(
	clk => clk,
	pwm_o => pwm_o,
	duty_cyc => duty_cyc
  );

clock_time : process begin
	clk <= '0';
	wait for clk_time/2;
	clk <= '1';
	wait for clk_time/2;
end process;
	
sim_pwm : process begin
	duty_cyc <= conv_std_logic_vector(0,7);		-- %0 duty cycle  7 bit
	wait for 5ms;

	duty_cyc <= conv_std_logic_vector(10,7);		-- %10 duty cycle  7 bit
	wait for 5ms;

	duty_cyc <= conv_std_logic_vector(20,7);		-- %20 duty cycle  7 bit
	wait for 5ms;

	duty_cyc <= conv_std_logic_vector(40,7);		-- %40 duty cycle  7 bit
	wait for 5ms;
	
	duty_cyc <= conv_std_logic_vector(60,7);		-- %60 duty cycle  7 bit
	wait for 5ms;

	duty_cyc <= conv_std_logic_vector(70,7);		-- %70 duty cycle  7 bit
	wait for 5ms;

	duty_cyc <= conv_std_logic_vector(90,7);		-- %90 duty cycle  7 bit
	wait for 5ms;
	
	assert false
	report "SIMULATION DONE!"
	severity failure;
	
end process;
end Behavioral;
