require 'pry'
require 'ap'
require 'sqlite3'
require 'rack'
require 'erubis'
require 'geocoder'
require 'Typhoeus'
require 'models/user'
require 'models/post'
require 'models/orm'	

API_KEY = "AIzaSyDCfAMEsaM4jLhjpgFLXb0eTF4dhcgdNy4"

# Q's for Colt


# res.write only appends to the body
# res.redirect affects the headers

# 2 ways

# 2nd
# rubygeocoder.com 
# gem install geocoder
# binding.pry --> request.location

# 1st
# google maps api
# requires api key 
# require 'typhoeus'
# data = Typhoeus.get("url with string interpolation")
# res = JSON.parse(data.body)    <--- returns geolocation





# App ************************************************************
class App


	def initialize()
		@orm = ORM.new()
		# @users and @posts are arrays of objects
		@users = @orm.all(:users)
		@posts = @orm.all(:posts)
		@error_message = []
		@id_of_current_user = nil
		@posts_of_current_user = nil
		@friends_of_current_user = nil
	end
	

	def call(env)
		request = Rack::Request.new(env)
		response = handle_request(request)
		return response.finish()
	end


	def handle_request(request)
		Rack::Response.new do |res|
			case request.path_info

			when '/login', '/'
				# Check to see if there is a cookie with user_id
				if request.session['user_id']
					# If cookie is present, redirect to /profile
					@id_of_current_user = request.session['user_id']
					res.redirect('/profile')
				else
					# If no cookie is present, render login
					res.write render('login', {:errors => @error_message})
				end

			when '/register'

				# If user is trying to register as a new user
				if request.POST['new_username']
					attempted_new_username = request.POST['new_username']
					username_exists = check_if_username_exists(attempted_new_username)

					# Check if the username being entered already exists
					if username_exists 
						@error_message = ["Sorry, ***#{attempted_new_username}*** already exists. Please choose another."]
						res.redirect('/login')
					# Check if the password entered matches confirmed password entered
					elsif request.POST['new_password'] != request.POST['confirm_password'] # if passwords do NOT match
						@error_message = ["You did not enter the same password.  Please try again."]
						res.redirect('login')
					else
						# Use geocoding to get two element array with lattituted and longitude: [lat, lng]
						geo_arr_lat_lng = get_geo_location(
							request.POST['address'],
							request.POST['city'],
							request.POST['state'],
							request.POST['country']
						)

						# Create data structure of new user
						new_user_hash = {
							'username' => request.POST['new_username'],
							'password' => request.POST['new_password'],
							'address' => request.POST['address'],
							'city' => request.POST['city'],
							'state' => request.POST['state'],
							'country' => request.POST['country'],
							'lat' => geo_arr_lat_lng[0],
							'lng' => geo_arr_lat_lng[1]
						}

						# Create new user object with newly created data structure
						new_user_obj = User.new(new_user_hash)
						# Add newly created user ojbect to list of user objects
						@users.push(new_user_obj)
						# Save new user to databases
						@orm.save_user(new_user_obj)

						@id_of_current_user = @orm.get_user_id_from_username(request.POST['new_username'])
						# Set cookie of user_id
						request.session['user_id'] = @id_of_current_user

						res.redirect('/profile')
					end
				end

			when '/check_login'	# no cookie, but trying to login as EXISTING user
				if request.POST['return_username']
					attempted_return_username = request.POST['return_username']
					username_exists = check_if_username_exists(attempted_return_username)

					# If user tries to login as existing user, but username doesn't exist
					if !username_exists
						@error_message = ["***#{attempted_return_username}*** does not exist. Please re-enter the spelling or register as a new user."]
						res.redirect('/login')
					# If user uses an existing username
					elsif username_exists
						attempted_return_password = request.POST['return_password']
						password_valid = @orm.check_if_password_is_valid(attempted_return_username, attempted_return_password)
						# Check if password matches stored password
						if !password_valid
							@error_message = ["The password you entered does not match the password on file.  Please try again."]
							res.redirect('/login')
						# If password is valid, set cookie and redirect to '/profile'
						else
							@id_of_current_user = @orm.get_user_id_from_username(request.POST['return_username'])
							request.session['user_id'] = @id_of_current_user
							res.redirect('/profile')
						end
					end
				end

			when '/profile'
				# Load current user's posts form the database
				@posts_of_current_user = @orm.get_all_posts_of_current_user(@id_of_current_user) # returns array of objects (post id, content, timestamp
				

				locals = {
					:own_posts => @posts_of_current_user
				}

				res.write render('profile', locals)	
			when '/post'

				# Create data structure of new post
				new_post_hash = {
					'content' => request.POST['content'],
					'timestamp' => request.POST['timestamp'],
				}

				# Create new post object with newly created data structure
				new_post_obj = Post.new(new_post_hash)
				# Add newly created post ojbect to list of post objects
				@posts.push(new_post_obj)
				# Save new post to databases
				@orm.save_post(new_post_obj, @id_of_current_user)

				res.redirect('/profile')

			when '/semantic'
				res.write render('semantic_ex')

			end
		end
	end


	def render(file_name, locals = {})  
		path = "views/" + file_name + ".erb"
		file = File.read(path)
		Erubis::Eruby.new(file).result(locals)
	end

	def check_if_username_exists(attempted_username)
		username_exists = false
		@users.each do |user|
			if user.username == attempted_username
				username_exists = true
			end
		end
		return username_exists
	end


	# https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=API_KEY
	def get_geo_location(add, cit, sta, cou)
		address = add.gsub(" ", "+")
		city = cit.gsub(" ", "+")
		state = sta.gsub(" ", "+")
		country = cou.gsub(" ", "+")
		pre = "https://maps.googleapis.com/maps/api/geocode/json?address="
		url = pre + address + "," + city + "," + state + "&key=" + API_KEY
		data = Typhoeus.get(url)
		geo_data = JSON.parse(data.body)
		lat = geo_data['results'][0]['geometry']['location']['lat']
		lng = geo_data['results'][0]['geometry']['location']['lng']
		return [lat, lng]
	end


end

# This file runs from config.ru via the 'rackup' command in terminal
# Rack::Handler::WEBrick.run App.new
