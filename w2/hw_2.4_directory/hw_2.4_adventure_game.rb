require_relative "room"
require_relative "key"
require_relative "monster"
require_relative "player"

NUM_ROOMS = 9

# Instantiate new rooms ---------------------------------------------------
foyer = Room.new("foyer")
bath_room = Room.new("bathroom")
living_room = Room.new("living room")
master_bed = Room.new("master bedroom")
small_bed = Room.new("small bedroom")
kitchen = Room.new("kitchen")
game_room = Room.new("game room")
office = Room.new("office")
closet = Room.new("closet")

# Assign rooms to game board -----------------------------------------------------------
rooms_array = Room.get_rooms_array()
board = rooms_array.shuffle()
exit = Room.new("outside")
board << exit

# Connect rooms one another -------------

# Bottom Left --
board[0].set_up(board[1])
board[0].set_right(board[3])
#board[0].set_down()
#board[0].set_left()

# Middle Left --
board[1].set_up(board[2])
board[1].set_right(board[4])
board[1].set_down(board[0])
# board[1].set_left()

# Top Left --
# board[2].set_up()
board[2].set_right(board[5])
board[2].set_down(board[1])
# board[2].set_left()

# Bottom Middle --
board[3].set_up(board[4])
board[3].set_right(board[6])
#board[3].set_down()
board[3].set_left(board[0])

# Middle Middle --
board[4].set_up(board[5])
board[4].set_right(board[7])
board[4].set_down(board[3])
board[4].set_left(board[1])

# Top Middle --
# board[5].set_up()
board[5].set_right(board[8])
board[5].set_down(board[4])
board[5].set_left(board[2])

# Bottom Right --
board[6].set_up(board[7])
# board[6].set_right()
# board[6].set_down()
board[6].set_left(board[3])

# Middle Right --
board[7].set_up(board[8])
# board[7].set_right()
board[7].set_down(board[6])
board[7].set_left(board[4])

# Top Right --
board[8].set_up(board[9])
board[8].set_right(board[7])
board[8].set_down(board[3])
board[8].set_left(board[1])



# Assign key to room ---------------------------------
key_position = rand(0...NUM_ROOMS)
board[key_position].set_key()

# Initialize Player instance -------------------------
Kernel.puts("What is your name, hero?")
user_name = Kernel.gets().chomp().to_s()
hero = Player.new(user_name)

# Win condition --------------------------------------
hero_name = hero.get_name()
current_room = board[0]
name_of_current_room = current_room.get_name()

win = false
while !win

	Kernel.puts("You are in the #{name_of_current_room}.  What direction do you want to move? (up, down, left, right)")
	user_move = Kernel.gets.chomp()

	if current_room == board[8] && user_move == 'up'
		has_key = hero.get_key_status()
		current_room = current_room.move_room(user_move.downcase())
		name_of_current_room = current_room.get_name()
		if has_key
			Kernel.puts("Congratulations, #{hero_name}. You have unlocked the door and escaped to the #{name_of_current_room}. You win!")
			win = true
		else
			Kernel.puts("This door is locked.")
		end
	else
		current_room = current_room.move_room(user_move.downcase())
		name_of_current_room = current_room.get_name()
		key_status = current_room.get_key_status()
		if key_status
			hero.find_key()
			Kernel.puts("You've discovered a key in the #{name_of_current_room}.")
		end
	end
	
end

