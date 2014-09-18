require 'sql_statements'

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
			;
		SQL
	end

	def save_post(post_object, id_of_user)
		@db.execute <<-SQL, [post_object.content]
			INSERT INTO posts
				(content)
			VALUES
				(?)
			;
		SQL

		@db.execute <<-SQL, [id_of_user]
			INSERT INTO user_posts
				(user_id)
			VALUES
				(?)
			;
		SQL
	end


	def check_if_password_is_valid(name, attempted_password)
		temp = @db.execute("SELECT password FROM users WHERE username = '#{name}';")
		stored_password = temp[0]['password']
		if attempted_password == stored_password
			return true
		else
			return false
		end
	end

	def get_user_id_from_username(name)
		temp = @db.execute("SELECT id FROM users WHERE username = '#{name}';")
		id = temp[0]['id']
	end

	def get_all_posts_of_current_user(id)
		results = @db.execute(SQL_GET_ALL_CURRENT_USER_POSTS, id)
		results.map do |row|
			Post.new(row)
		end

	end


end