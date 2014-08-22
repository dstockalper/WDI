Kernel.puts("What character do you want to make the pyramid out of?")
char = Kernel.gets()[0].chomp()

Kernel.puts("How many rows of #{char}'s do you want?")
total_rows = Kernel.gets().chomp().to_i()

base_row_size = (total_rows * 2) - 1
current_row = 0


while (current_row < total_rows)
	current_row += 1
	num_chars = (current_row * 2) - 1
	num_spaces = total_rows - current_row

	space_string =  " " * num_spaces
	char_string = char * num_chars
	entire_row = space_string + char_string + space_string
	Kernel.puts(entire_row)
end



