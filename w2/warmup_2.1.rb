arr_1 = [1, 1, 2, 3, 4, 4, 4, 5, 9, 10, 34, 34]
arr_2 = [15, 20, 15, 4, 89, 1, 4, 6, 100]

def remove_duplicates(array)
	no_dupe_array = Array.new()
	for num in array
		if !no_dupe_array.include?(num)
			no_dupe_array << num
		end
	end
	return no_dupe_array
end

part1 = remove_duplicates(arr_1)

Kernel.puts("Part 1: ", part1.inspect)

part2 = remove_duplicates(arr_2)

Kernel.puts("Part 2: ", part2.inspect)


# Implementing the same method for a hash ---------------------

# Trick question:  a hash cannot have duplicate keys, 
# and different keys with the same value should be kept