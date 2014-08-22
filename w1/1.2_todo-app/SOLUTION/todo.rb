require('colorize')

TODOS_DIRECTORY = 'todos'
TODO_EXTENSION = '.txt'


# Finds the file for an item by its ID.
def find_filename_for_todo(id)
    for filename in Dir.entries(TODOS_DIRECTORY)
        if filename.start_with?(id)
            return filename
        end
    end
end

# Shows an item by its ID.
def show_todo(id)
    filename = find_filename_for_todo(id)
    todo = create_todo_hash_from_file(filename)
    pretty_print_todo(todo)
end

# Opens a file and returns a hash representing that item.
def create_todo_hash_from_file(filename)
    todo = Hash.new()

    todo['filename'] = filename

    file_path = TODOS_DIRECTORY + '/' + filename
    lines = File.read(file_path).split("\n")

    read_mode = 'not_body'
    todo['body'] = ''

    for line in lines
        if line.empty?
            next
        elsif line.include?(': ')
            key_and_value = line.split(': ')
            key = key_and_value[0]
            value = key_and_value[1]

            if key == 'title'
                todo['title'] = value
            elsif key == 'status'
                todo['status'] = value
            end

        elsif line == '---'
            # Once we hit the triple-dashes, that means the rest of the file
            # is the body of the item.
            read_mode = 'body'

        elsif read_mode == 'body'
            todo['body'] += line + "\n"
        end
    end

    if !todo.has_key?('status')
        # The default status is 'pending'.
        todo['status'] = 'pending'
    end

    return todo
end

def pretty_print_todo(todo)
    Kernel.print(
        todo['filename'].colorize(:red).bold(),
        ': ',
        todo['title'],
        "\n"
    )
end


def list_todos()
    for filename in Dir.entries(TODOS_DIRECTORY)
        if filename.end_with?(TODO_EXTENSION)
            todo = create_todo_hash_from_file(filename)
            pretty_print_todo(todo)
        end
    end
end

if ARGV[0] == 'list'
    list_todos()
elsif ARGV[0] == 'show'
    show_todo(ARGV[1])
else
    puts "Usage:"
    puts "todo.rb list"
    puts "todo.rb show"
end
