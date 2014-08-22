TODO_DIRECTORY = 'yaml_files/'
require('yaml')
require('colorize')

# Create New File ---------------------------------------------------------------

def create_new_todo(title_arg)
	title = title_arg
	filename = convert_to_filename(title)
	priority = set_priority()
	status = set_status()
	body_array = set_body_array()
	body_string = set_body_string(body_array)
	yaml_file = File.new(TODO_DIRECTORY + filename, "w")

	write_todo_to_yaml_file(yaml_file, title, status, priority, body_string)

end

def convert_to_filename(title)
	no_spaces = title.gsub(/ /, "_")
	filename = (no_spaces + ".yaml")
	return filename
end

def write_todo_to_yaml_file(yaml_file, title, status, priority, body_string)
	yaml_file.puts("---" +"\n" + "title: " + title, "status: " + "(" + status + ")", "priority: " + priority, "body: |", body_string)
	#HELP: I'm not understanding YAML.dump in general
	#yaml_file.puts(YAML.dump("---" +"\n" + "title: " + title, "status: " + "(" + status + ")", "priority: " + priority, "body: |", body_string))
	yaml_file.close
end

def set_priority()
	priority = nil
	until (priority == "top"  || priority == "high" || priority == "low")
		Kernel.puts("Enter the priority for this todo:", "Top", "High", "Low")
		priority = STDIN.gets().chomp().downcase()
	end
	return priority
end

def set_status()
	status = nil
	until (status == "done" || status == "pending")
		Kernel.puts("Enter the status for this todo:", "Done", "Pending")
		status = STDIN.gets().chomp().downcase()
	end

	return status
end

def set_body_array()

	body_array = []

	until (body_array.last() == "quit")
		Kernel.print("Enter a note for this todo and hit 'Enter' - as many times as you'd like (type 'quit' to quit): ")
		user_note = STDIN.gets().chomp()
		body_array << user_note
	end

	quit_elem = body_array.pop()
	return body_array
end

def set_body_string(body_array)
	body_string = ""

	for i in body_array
		body_string += " " + i + "\n"
	end

	return body_string
end


# List Todo(s) -------------------------------------------------------------

def list_todos()
	yaml_file_array = get_yaml_file_array
	print_yamls(yaml_file_array)
end

def get_yaml_file_array
	all_files = Dir.entries(TODO_DIRECTORY)
	yaml_file_array = []

	for file in all_files
		if file.include?(".yaml")
			yaml_file_array << file
		end
	end

	return yaml_file_array
end

def print_yamls(yaml_file_array)

	for filename in yaml_file_array
		content = File.new(TODO_DIRECTORY + filename, 'r')
		todo = YAML.load(content.read)
	 	Kernel.puts(todo["status"] + " " + todo["title"] + ": " + todo["priority"] + " priority")
	end

end

# Show Todo ----------------------------------------------------------------

# def show_todo(title_arg)

# 	todo_exists = check_if_todo_exists(title_arg)



# 	if todo_exists
# 		file = File.new()
# 		Kernel.puts(title_arg["status"] + " " + title_arg["title"] + ": " + title_arg["priority"] + " priority", "\n" + todo_hash[title_arg]["body"])
# 	end
# end

# def check_if_todo_exists(title_arg)
# 	yaml_file_array = get_yaml_file_array()
# 	array_of_titles = []

# 	for file in yaml_file_array
# 		array_of_titles << file["title"]
# 	end

# 	if array_of_titles.include?(title_arg)
# 		todo_exists = true
# 	else
# 		Kernel.puts("That's not one of your todo's.", "See todo's below: (Status) 'Todo name': Priority level")
# 		list_todos()
# 	end

# 	return todo_exists
# end

# # Update Todo --------------------------------------------------------------

# def update_todo(title_arg)
# 	todo_hash = get_todo_hash()

# 	if todo_hash.include?(title_arg)
# 		title = title_arg
# 		body_string = todo_hash[title]["body"]
# 		filename = convert_to_filename(title)

# 		value_to_update = nil
# 		until (value_to_update == "quit")
# 			Kernel.puts("What part of the todo do you want to update? 'status', 'priority' ('quit' to quit)")
# 			value_to_update = STDIN.gets().chomp()
			
# 			if (value_to_update.downcase() == 'status')
# 				priority = todo_hash[title]["priority"]
# 				new_status = set_status()
# 				yaml_file = File.open(TODO_DIRECTORY + filename, "w")

# 				write_todo_to_yaml_file(yaml_file, title, new_status, priority, body_string)

# 				Kernel.puts("You updated the status to #{new_status}.")
# 			elsif (value_to_update.downcase() == 'priority')
# 				status = todo_hash[title]["status"]
# 				new_priority = set_priority()
# 				yaml_file = File.open(TODO_DIRECTORY + filename, "w")

# 				write_todo_to_yaml_file(yaml_file, title, status, new_priority, body_string)

# 				Kernel.puts("You updated the priority to #{new_priority}.")
# 			elsif (value_to_update.downcase() == 'quit')
# 				next
# 			else
# 				Kernel.puts("'#{value_to_update}' is not a valid selection.")
# 			end

# 		end

# 	else
# 		Kernel.puts("That's not one of your todo's.", "See todo's below: (Status) 'Todo name': Priority level")
# 		list_todos()
# 	end

# end

# # Delete Todo -----------------------------------------------------------

# def delete_todo(title_arg)
# 	todo_hash = get_todo_hash()
# 	todo_exists = check_if_todo_exists(title_arg, todo_hash)
# 	filename = convert_to_filename(title_arg)

# 	if todo_exists
# 		File.delete(TODO_DIRECTORY + filename)
# 	else
# 		Kernel.puts("That's not one of your todo's.", "See todo's below: (Status) 'Todo name': Priority level")
# 		list_todos()
# 	end

# end



# Interface ----------------------------------------------------------------
	

if (ARGV[0] == '-new')
	title_arg = ARGV[1]
	create_new_todo(title_arg)
elsif (ARGV[0] == '-list')
	list_todos()
elsif (ARGV[0] == '-show')
	title_arg = ARGV[1].capitalize()
	show_todo(title_arg)
elsif (ARGV[0] == '-update')
	title_arg = ARGV[1].capitalize()
	update_todo(title_arg)
elsif (ARGV[0] == '-delete')
	title_arg = ARGV[1].capitalize()
	delete_todo(title_arg)
else
	Kernel.puts("Please select action: ", "-new 'todo name'", "-list", "-show 'todo name'", "-update 'todo name'", "-delete 'todo name'", "Example: ruby todo.rb -new 'make a todo list'")
end


# Quesions --------------------------------------------------------------
# Where does the RETURN happen in if-statements and loops, where an explicit return is present but not at the end of the code block.
# STDIN.gets() vs. Kernel.gets()





