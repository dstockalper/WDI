class Room

	def initialize(some_name, some_desc)
		@name = some_name
		@description = some_desc
		@ways = Hash.new
	end

	def add_way(direction, next_room)
		@ways[direction] = next_room
	end

	def navigate()
		input = Kernel.gets.chomp
		if @ways.has_key?(input)
			return @ways[input]
		else
			puts "Wrong way, play again!!"
			return self
		end
	end

	def discover_room()
		puts "=> You are in " + @description
		puts "You can go " + @ways.keys().join(" or ")
	end

end