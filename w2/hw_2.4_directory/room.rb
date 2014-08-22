class Room
		@@num_rooms = 0
		@@rooms_array = []
		@@no_room = "There is no door here."
		@@locked = "This door is locked."

	def self.get_num_rooms()
		return @@num_rooms
	end

	def self.get_rooms_array()
		return @@rooms_array
	end


	def initialize(name)
		@@num_rooms += 1
		@@rooms_array << self

		@name = name
		@has_key = false

		@right_room = self
		@up_room = self
		@down_room = self
		@left_room = self
	end

	def get_name()
		return @name
	end

	def get_key_status()
		return @has_key
	end

	def set_key()
		@has_key = true
	end

	def set_right(right)
		@right_room = right
	end

	def set_up(upper)
		@up_room = upper
	end

	def set_down(down)
		@down_room = down
	end

	def set_left(left)
		@left_room = left
	end

	def move_room(user_move)
		if (user_move == 'up') && (@up_room != self)
			return @up_room
		elsif (user_move == 'right') && (@right_room != self)
			return @right_room
		elsif (user_move == 'left') && (@left_room != self)
			return @left_room
		elsif (user_move == 'down') && (@down_room != self)
			return @down_room
		else
			Kernel.puts("There is no door there.")
			return self
		end
	end

end