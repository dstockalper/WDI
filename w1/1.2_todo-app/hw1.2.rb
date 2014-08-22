# "magic constant"
TODO_DIRECTORY = 'todos'
 
# Get an array of filenames in the current directory
# ASSIGNING
# Iterate over each item in the my_todos
# array. (iterate == loop)
# ITERATING / LOOPING / ENUMERATING


 
def find_filename_for_todo(search)
	for filename in Dir.entries(TODO_DIRECTORY)
		if filename.include?(search)
			return filename
		end
 
	end
end
 
def show_todo(search)
	file = find_filename_for_todo(search)
	todo = Hash.new
	todo['filename'] = file
	file_path = TODO_DIRECTORY + '/' + file
	lines =File.read(file_path).split("\n")
 	
	green = "\e[32m "
	red = "\e[31m "
	white = "\e[0m"

 	bodyText = ""
	for line in lines
		if line.start_with?("title")
			todo["title"] = line.split(':')[1]
		elsif line.start_with?("status")
			temp = line.split(':')[1]
			if temp == "done"
				puts(green)
				status = temp
			else
				puts(red)
				status = temp
			end
			todo["status"] = status
		else
			bodyText = bodyText +"\n"+ line
		end
		

	end
	
	bodyText = bodyText[7, bodyText.length-1]
	todo["body"] = bodyText


	Kernel.puts(todo)

	#Kernel.puts(lines.inspect)

end

 # lines = 
 # [
 # 	"title:grocery",
 # 	"status:done",
 # 	"",
 # 	"---",
 # 	"",
 # 	"text",
 # 	"",
 # 	"text",
 # 	"",
 # 	"text"
 # ]

# todo = 
# { "filename" => "1_go_to_grocery_store.txt",
# 	"title" => "grocery",
# 	"status" => "done",
# 	"body" => "...a bunch of text..."
# }

 
def list_todos()
	my_todos = Dir.entries(TODO_DIRECTORY)
	for todo in my_todos
	    # Only print the item if it ends with ".txt"
	    # CONDITIONAL
	    if todo.end_with?('.txt')
 
	        file_contents = File.read(TODO_DIRECTORY + '/' + todo)
	        Kernel.puts(todo)
	        Kernel.puts(file_contents)
 
 
	    end
	end
end
 
def create_todo(task)
	filename = task.downcase
	filename = filename.gsub(' ', '_') 
	filename += '.txt'
	file_path = TODO_DIRECTORY + '/' + filename
	file = File.new(file_path, 'w')
	file.puts(task)
	file.close()
end	
 
 
 
if ARGV[0] == "list"
	list_todos()
elsif ARGV[0] == "new"
	create_todo(ARGV[1])
elsif ARGV[0] == "show"
	show_todo(ARGV[1])
else
	Kernel.puts("Type list to list todos, type new to create one")
end	