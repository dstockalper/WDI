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
		@db.execute <<-SQL, [id_of_user, post_object.content]
			INSERT INTO posts
				(user_id, content)
			VALUES
				(?, ?)
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



	def get_user_object_from_id(user_id)
		results = @db.execute("SELECT * FROM users WHERE id = #{user_id};")[0]
		obj = User.new(results)
	end



	def get_all_posts_of_user(obj)
		results = @db.execute(SQL_GET_ALL_USER_POSTS, obj.id)
		results.map do |row|
			temp_post = Post.new(row)
			temp_post.id = obj.id
			temp_post
		end
	end



	def get_all_following_of_user(own_obj)
		results = @db.execute(SQL_GET_ALL_USER_FOLLOWING, own_obj.id) # SQL is returning high id's

		arr_of_obj = results.map do |row|
			temp_user = User.new(row)
			temp_user.id = row['following_id']
			follower_obj = Following.new(temp_user, own_obj)
		end
		return arr_of_obj
	end



	def get_most_recent_post_of_each_following(arr_following)
		most_recent_posts = arr_following.map do |following|
			get_all_posts_of_user(following).last()
		end
		return most_recent_posts # array of Post objects
	end



	def add_to_following(id_of_user, id_of_following)
		@db.execute <<-SQL, [id_of_user, id_of_following]
			INSERT INTO following
				(user_id, following_id)
			VALUES
				(?, ?)
			;
		SQL
	end


	def change_location(address, city, state, country)
		
	end


end