array_1 = [5,8,9,11]
array_2 = [4,6,7,10]

def merge(arr1, arr2)
	arr_combined = []

	for elem in arr1
		arr_combined << elem
	end

	for elem in arr2
		arr_combined << elem
	end

	final = arr_combined.length()

	arr_sorted = []
	for i in (0..final)
		last = arr_combined.length()
		if last > 0
			smallest_remaining = arr_combined[0, last].min()
			arr_sorted << smallest_remaining
			position_of_smallest = arr_combined.index(smallest_remaining)
			arr_combined.delete_at(position_of_smallest.to_i())   # Don't know why need .to_i(), but without it there is an error
			i += 1
		end
	end

	return arr_sorted
	
end

test = merge(array_1, array_2)

STDOUT.puts(test.inspect)