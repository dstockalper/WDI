require_relative 'sql_statements'

# ORM Class ************************************************************
class ORM

	TABLE_CLASS_MAP = {
		:users => User,
		:posts => Post
	}


	def initialize()
		@db = SQLite3::Database.new('social_network.db')
		@db.results_as_hash = true
	end


	def all(table_symbol) # returns all rows from db into an array of objects
		# get array of hashes
		results = @db.execute("select * from #{table_symbol};")

		results.map do |row|
			model = TABLE_CLASS_MAP[table_symbol]
			model.new(row)
		end
	end


	def save_user(user_object)
		@db.execute <<-SQL, [user_object.username, user_object.password, user_object.address, user_object.city, user_object.state, user_object.country, user_object.lat, user_object.lng]
			INSERT INTO users 
				(username, password, address, city, state, country, lat, lng)
			VALUES
				(?, ?, ?, ?, ?, ?, ?, ?)
	
		SQL
	end

	def get_user_id_from_username(name)
		id_arr = @db.execute("SELECT id FROM users WHERE username = '#{name}';")
		id = id_arr[0]['id']
	end


end