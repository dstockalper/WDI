class Player

	def initialize(name)
		@name = name
		@has_key = false
	end

	def find_key()
		@has_key = true
	end

	def get_name()
		return @name
	end

	def get_key_status()
		return @has_key
	end

end