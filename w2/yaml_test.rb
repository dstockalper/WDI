require 'yaml'


# Read/load a yaml file ---------------------------------
todo = File.new('test.yml', 'r')
hash_todo = YAML.load(todo.read)
todo.close

puts hash_todo



# Write a yaml file ------------------------------------

yaml_write = {"word-wrapping" => true, "font-size" => 20, "font" => "Arial"}
output = File.new('prefs.yml', 'w')
output.puts YAML.dump(yaml_write)
output.close