require_relative "room"
require_relative "game"
require 'yaml'
require'ap'

LEVEL_MAX = 3

current_level = 1

while current_level <= LEVEL_MAX
	game = Game.new(current_level)
	game.read_instructions()
	while !game.win
		game.play()
	end
	game.win_level()
	current_level += 1
end