class Game

	def initialize(level)
		@win = false

		#Load the data of the game from the file
		file = File.new('games_data/level' + level.to_s + '.yml', 'r')
		contents = file.read.split('---')
		file.close

		#Get the general info of the game
		infos = YAML.load(contents.shift)
		@name = infos['game_name']
		@instructions = infos['instructions']

		#Build the hash 'all_rooms' and 'all_ways'
		#    key=name
		all_rooms = Hash.new
		all_ways = Hash.new
		contents.each do |room_yml|
			room_hash = YAML.load(room_yml)
			name = room_hash['name']
			all_rooms[name] = Room.new(name, room_hash['description']) 
			all_ways[name] = room_hash['ways'] 
		end

		#Build the ways for all hash
		all_rooms.each do |name, room|
			all_ways[name].each do |direction, next_room_name|
				room.add_way(direction, all_rooms[next_room_name])
			end
		end

		#Complete the general infos
		@current_room = all_rooms[infos['first_room']]
		@final_room = all_rooms[infos['final_room']]

	end

	def read_instructions()
		puts "Hello! Welcome to the " + @name
		puts @instructions
		puts ""
	end

	def play()
		@current_room.discover_room()
		@current_room = @current_room.navigate()
		if @current_room == @final_room
			@win = true
		end
	end

	def win_level()
		puts " ===================================================="
		puts " CONGRATULATIONS!!! YOU REACH THE NEXT LEVEL !!!"
		puts " ===================================================="
		
	end

	attr_reader :win
end