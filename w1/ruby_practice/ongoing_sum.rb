total = 0
user_input = nil
total_array = []

until (user_input == "q")
	if (user_input == "save")
		total_array << total
	end
	Kernel.print("Please enter a number ('save' to save, q' to quit): ")
	user_input = Kernel.gets().chomp()
	number_input = user_input.to_i()
	total += number_input
	Kernel.puts("Sum: " + total.to_s())
end

Kernel.puts("You just quit, quitter.", "Your saved numbers are: ")
for saved_total in total_array
	Kernel.puts(saved_total)
end