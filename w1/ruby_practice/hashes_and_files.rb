# 4.1
def write_to_file(filename, message)
	new_file = File.new(filename, "w")
	new_file.puts(message)
	new_file.close
end

write_to_file('exer4.txt', 'Some rando text')

# 4.2
def combine_pair(key, value)
	combined = key + ': ' + value
	return combined
end

combined = combine_pair("first name", "Doug")

# 4.3
def merge_info(hash, combined_string)
	combined_array = combined_string.split(":")
	key = combined_array[0]
	value = combined_array[1]
	hash[key] = value

	return hash
end

myHash = {"last name" => "Stockalper"}

test_4dot3 = merge_info(myHash, combined)
Kernel.puts(test_4dot3)

# 4.4
def stringify(hash)
	arr = []
	hash.each do |key, value|
		pair = key + ': ' + value
		arr << pair
	end

	return arr
end

abe_info = {
    'first name' => 'Abraham',
    'last name' => 'Lincoln',
    'email' => 'abe.killa@white-house.gov',
    'favorite food' => 'Monster Energy Drink'
}

test_4point4 = stringify(abe_info)
Kernel.puts(test_4point4.inspect)

# 4.5
def hash_to_file(hash)
	arr = stringify(hash)
	write_to_file('hash_write.txt', arr)
end

hash_to_file(abe_info)



