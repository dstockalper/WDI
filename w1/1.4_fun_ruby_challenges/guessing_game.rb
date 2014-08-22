low_num = 1
high_num = 100
correct_num = Random.rand(low_num..high_num)
guess = nil
passes = 0

Kernel.print("Guess an integer between #{low_num} and #{high_num}: ")

until (guess == correct_num)
	passes += 1
	guess = Kernel.gets().chomp().to_i()

	if (guess != 0)
		if (guess == correct_num)
			Kernel.puts("Congratulations, you guessed the correct number (#{correct_num.to_s()}) in #{passes.to_s()} guesses.")
		elsif (guess > correct_num)
			Kernel.print("Your guess was too high. Guess again: ")
		elsif (guess < correct_num)
			Kernel.print("Your guess was too low. Guess again: ")
		else
			Kernel.puts("Error: The code is broken.")
		end
	else
		Kernel.puts("Your guess is either out of range or not in the correct format, and this still counts as a guess!  Guess again: ")
	end
end