# Get num rows from user
num_rows = 0
until ((1 <= num_rows) && (num_rows <= 9))
	Kernel.print("How many rows do you want (1-9)? ")
	num_rows = Kernel.gets().chomp().to_i()
end
# Put rows into an array (to reference by position later)
rows_array = []
for i in (0..num_rows)
	rows_array << i
end

# Get num columns from user
num_cols = 0
until ((1 <= num_cols) && (num_cols <= 9))
	Kernel.print("How many columns do you want (1-9)? ")
	num_cols = Kernel.gets().chomp().to_i()
end
# Put columns into an array (to reference by position later)
cols_array = []
for i in (0..num_cols)
	cols_array << i
end

# Print table title
Kernel.puts("A #{num_rows.to_s()} x #{num_cols.to_s()} multiplication table:")

# Set space between headers
space_default = 5
header_space = " " * space_default

# Create header
header = "     "
for i in (1..num_cols)
	header += i.to_s() + header_space
end

# Print header and barrier
Kernel.puts(header)
header_barrier = "-" * (header.length - 3)
Kernel.puts(header_barrier)

# Stack rows
for r in (1..num_rows)

	#Set row ID and barrier
	across = "#{r}|   "

	# Build rows
	for c in (1..num_cols)
		product_num = c * r 

		# Reduce space between product if greater than 1 digit
		if (product_num >= 10)
			table_space = " " * (space_default - 1)
		else
			table_space = " " * (space_default)
		end

		product_str = product_num.to_s()
		across += product_str + table_space
	end
	Kernel.puts(across)

end
