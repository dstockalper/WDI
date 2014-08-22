
# magic constant:  the line position in each todo file where completion status is indicated
STATUS_POSITION = 1

#magic constant: todo directory
TODO_DIRECTORY = 'todo/'

# grab all files in directory that includes todos
allFiles = Dir.entries(TODO_DIRECTORY)

# self note:  how to grab only .txt files straight from Dir.entries ???

# create an empty array that will hold only .txt files
txtFiles = []

# filter out non-.txt files
for file in allFiles
	if file.include? '.txt'
		txtFiles << file
	end
end

# create an empty array that will hold only completed todo's 
# to be considered completed, the second line of the file must have the string 'complete' (vs. 'incomplete')
completedTodos = []

for filename in txtFiles
	# read the file into a variable containing string
	tempString = File.read(TODO_DIRECTORY + filename.to_s)
	# split the string by return line into an array
	tempArray = tempString.split("\n")
	# store the second line (array position [1]) in a variable called 'status'
	completionStatus = tempArray[STATUS_POSITION]
	# if status is 'complete', add the todo to the completedTodos array
	if completionStatus.downcase == "completed"
		completedTodos << filename
	end
end

Kernel.puts(completedTodos)

# to indicate completed files using only the command line: 
# grep 'completed' *
# searches for the word 'completed' in all files in the directory