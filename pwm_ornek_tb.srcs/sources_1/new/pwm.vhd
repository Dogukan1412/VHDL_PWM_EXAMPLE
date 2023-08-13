library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity pwm is
  Generic(
	clk_freq : integer := 100_000_000;
	pwm_freq : integer := 1000			-- 100 000 000 / 1000 = 1ms
  );
  Port (
	clk : in std_logic;
	pwm_o : out std_logic;
	duty_cyc : in std_logic_vector(6 downto 0)
  );
end pwm;

architecture Behavioral of pwm is
constant timer_lim : integer := clk_freq/pwm_freq;

signal timer : integer range 0 to timer_lim := 0;
signal high_time : integer range 0 to timer_lim/2;

begin
	high_time <= (timer_lim/100)*conv_integer(duty_cyc);
	
	process(clk) begin
		if(rising_edge(clk)) then
			if(timer = timer_lim - 1) then
				timer <= 0;
			elsif(timer < high_time) then
				timer <= timer + 1;
				pwm_o <= '1';
			else
				pwm_o <= '0';
				timer <= timer + 1;
			end if;
		end if;
	end process;

end Behavioral;
