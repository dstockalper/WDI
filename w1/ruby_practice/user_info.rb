def check_for_middle_name(hash_arg)
	has_middle_name = false
	if (!hash_arg["middle name"].empty?)
		has_middle_name = true
	end
	return has_middle_name
end

def get_full_name(hash_arg)
	first = hash_arg["first name"]
	last = hash_arg["last name"]

	middle_name_status = check_for_middle_name(hash_arg)

	if (middle_name_status == true)
		middle = hash_arg["middle name"]
		initial = middle[0]
		full_name = first + ' ' + initial + ' ' + last
	else
		full_name = first + ' ' + last
	end

	return full_name
end

def find_by_email(hashes_to_search, email_arg)
	for hash in hashes_to_search
		if (hash["email"] == email_arg.to_s)
			return hash
		end
	end
end

def error_msg_if_key_missing(hash_arg, hash_key)
	error_message = []
	if (!hash_arg.has_key?(hash_key))
		error_message << "Error> #{hash_key} is missing."
	end
	return error_message
end

#HELP:  I eventually worked around this problem but I don't undertstand why
# the below method, when called from lines 80-82 throws an error message:
#  user_info.rb:70:in `+': no implicit conversion of nil into Array (TypeError)

# def char_to_eval(hash_arg, char)
# 	error_message = []
# 	if ((hash_arg["email"]) && (!hash_arg["email"].include?(char)))
# 		error_message << "Email is missing #{char} character"
# 		return error_message
# 	end
# end

def error_msg_if_num_in_value(hash_arg, hash_key)
	error_message = []

	for n in (0..9)
		i = n.to_s
		if ((hash_arg[hash_key] != nil) && (hash_arg[hash_key].include?(i)))
			error_message << "Error> #{hash_key} has a number: #{i}"
		end
	end 

	return error_message
end

def validate_info(hash_arg)
	error_array = []
	error_array += error_msg_if_key_missing(hash_arg, "first name")
	error_array += error_msg_if_key_missing(hash_arg, "last name")
	error_array += error_msg_if_key_missing(hash_arg, "email")
	
	if (!hash_arg["email"].include?("@"))
		error_array << "@ char is missing from email"
	end
	if (!hash_arg["email"].include?("."))
		error_array << "Period (.) char is missing from email"
	end

	#HELP: the following two lines throw an error message (see method commented out on line 42)
	#error_array += char_to_eval(hash_arg, "@")
	#error_array += char_to_eval(hash_arg, ".")

	error_array += error_msg_if_num_in_value(hash_arg, "first name")
	error_array += error_msg_if_num_in_value(hash_arg, "last name")
	error_array += error_msg_if_num_in_value(hash_arg, "email name")

	return error_array
end

personal_info = Hash.new()
personal_info["first name"] = "Doug5"
personal_info["middle name"] = "Russell"
personal_info["last name"] = "St9ockalper"
personal_info["email"] = "dstockalper@gmail.com"
personal_info["favorite food"] = "carne asada"


# Output tests below
# ----------------------------------------------------------
# Kernel.puts(personal_info)
# test = get_full_name(personal_info)
# Kernel.puts(test)
# hashArray=[personal_info]
# test2 = find_by_email(hashArray, "dstockalper@gmail.com")
# Kernel.puts(test2)
test3 = validate_info(personal_info)
Kernel.puts(test3)
