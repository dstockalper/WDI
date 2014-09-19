require 'pry'
require 'ap'
require 'sqlite3'
require 'rack'
require 'erubis'
require 'geocoder'
require 'Typhoeus'
require 'models/user'
require 'models/post'
require 'models/following'
require 'models/orm'	

API_KEY = "AIzaSyDCfAMEsaM4jLhjpgFLXb0eTF4dhcgdNy4"

# Self notes;

# .write vs. .redirect:
# res.write affets the body
# res.redirect affects the headers

# 2 ways go get coordinates:

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
	end
	

	def call(env)
		request = Rack::Request.new(env)
		response = handle_request(request)
		return response.finish()
	end


	def handle_request(request)
		Rack::Response.new do |res|
			case request.path_info

			# LOGIN ===================================================================================================
			when '/login', '/'
				# Check to see if there is a cookie with user_id
				if request.session['user_id']
					# If cookie is present, redirect to /profile
					res.redirect('/profile')
				else
					# If no cookie is present, render login
					res.write render('login', {:errors => @error_message})
				end

			# REGISTER ===================================================================================================
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

						# Get SQL-created id of new user
						id_of_current_user = @orm.get_user_id_from_username(request.POST['new_username'])
						# Set cookie of user_id
						request.session['user_id'] = id_of_current_user

						res.redirect('/profile')
					end
				end

			# CHECK LOGIN ===================================================================================================
			when '/check_login'	# no cookie, but trying to login as EXISTING user
				if request.POST['return_username']
					attempted_return_username = request.POST['return_username']
					username_exists = check_if_username_exists(attempted_return_username)

					# If user tries to login as existing user, but username doesn't exist
					if !username_exists
						@error_message = ["***#{attempted_return_username}*** is not a valid username. Please check the spelling or register as a new user."]
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
							id_of_current_user = @orm.get_user_id_from_username(request.POST['return_username'])
							request.session['user_id'] = id_of_current_user
							res.redirect('/profile')
						end
					end
				end

			# PROFILE ===================================================================================================
			when '/profile'
				# If no cookie, send to index/login page
				if !request.session['user_id']
					res.redirect('/')
				end
				# Load current user's posts from the database
				id_of_current_user = request.session['user_id']
				current_user_obj = @orm.get_user_object_from_id(id_of_current_user)
				posts_of_current_user = @orm.get_all_posts_of_user(current_user_obj) # returns array of objects (post id, content, timestamp)

				# Load current user's following (as array of Following objects) from the database
				following_of_current_user = @orm.get_all_following_of_user(current_user_obj)

				# Get most recent post of each Following: top_post_arr is an array of Post objects...the element is 'nil' where the user has no Posts
				top_post_arr = @orm.get_most_recent_post_of_each_following(following_of_current_user)

				# Note on the two lines above: id of each top post should match id of following

				map_url = get_map_url(current_user_obj, following_of_current_user)


				locals = {
					:current_user => current_user_obj,
					:own_posts => posts_of_current_user,
					:following => following_of_current_user,
					:top_posts => top_post_arr,
					:map_url => map_url
				}

				res.write render('profile', locals)	

			# POST ===================================================================================================
			when '/post'
				# If no cookie, send to index/login page
				if !request.session['user_id']
					res.redirect('/')
				end

				# Get user id from cookie
				id_of_current_user = request.session['user_id']

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
				@orm.save_post(new_post_obj, id_of_current_user)

				res.redirect('/profile')

			# SEARCH ===================================================================================================
			when '/search'

				locals = {
					:all_users => @users
				}
				res.write render('search', locals)

			# LOGOUT ===================================================================================================
			when '/logout'
				request.session['user_id'] = nil
				@error_message = []
				res.redirect('/')

			# FOLLOW ===================================================================================================
			when '/follow'
				# If no cookie, send to index/login page

				if !request.session['user_id']
					res.redirect('/')
				end

				# Get user id from cookie
				id_of_current_user = request.session['user_id']


				# Get id of user to follow (from form submitted)
				id_to_follow = request.POST['follow'].to_i

				# Add this 'follow' to database
				@orm.add_to_following(id_of_current_user, id_to_follow)
				res.redirect('/search')

			when '/change_location'
				# If no cookie, send to index/login page
				if !request.session['user_id']
					res.redirect('/')
				end
				# Load current user's posts from the database
				id_of_current_user = request.session['user_id']
				
				address = request.POST['address']
				city = request.POST['city']
				state = request.POST['state']
				country = request.POST['country']

				# Use geocoding to get two element array with lattituted and longitude: [lat, lng]
				geo_arr_lat_lng = get_geo_location(
					address,
					city,
					state,
					country
				)
				new_lat = geo_arr_lat_lng[0]
				new_lng = geo_arr_lat_lng[1]

				# Update the database with user's new address and geo coordinates
				@orm.change_location(id_of_current_user, address, city, state, country, new_lat, new_lng)

				
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

	def get_max_distance(following_of_current_user)
		max = 0
		following_of_current_user.each do |obj|
			if obj.distance > max
				max = obj.distance
			end
		end
		return max
	end


	def get_map_url(current_user_obj, following_of_current_user)

				http = "http://maps.googleapis.com/maps/api/staticmap?"

				my_address = current_user_obj.address.gsub(" ", "+").gsub("'", "%27")
				my_city = current_user_obj.city.gsub(" ", "+")
				my_state = current_user_obj.state.gsub(" ", "+")
				my_country = current_user_obj.country.gsub(" ", "+")
				my_lat = current_user_obj.lat
				my_lng = current_user_obj.lng

				center = "center=#{my_address},#{my_city},#{my_state}"

				max_dist = get_max_distance(following_of_current_user)

				if max_dist < 5
					zfactor = 15
				elsif max_dist < 10
					zfactor = 12
				elsif max_dist < 20
					zfactor = 11
				elsif max_dist < 30
					zfactor = 10
				elsif max_dist < 50
					zfactor = 9
				elsif max_dist < 75
					zfactor = 8
				elsif max_dist < 100
					zfactor = 7
				elsif max_dist < 400
					zfactor = 6
				elsif max_dist < 1000
					zfactor = 5
				elsif max_dist < 1500
					zfactor = 4
				elsif max_dist < 5000
					zfactor = 3
				elsif max_dist < 10000
					zfactor = 2
				else
					zfactor = 1
				end

				zoom = "&zoom=#{zfactor}&size=700x400"
				map = "&maptype=terrain"
				self_color = "&markers=color:red"
				self_label = "%7Clabel:U%7C"
				self_coord = "#{my_lat},#{my_lng}"
				fol_text = ""

				following_of_current_user.each do |obj|
					fol_color = "&markers=color:green"
					fol_label = "%7Clabel:F%7C"
					fol_coord = "#{obj.lat},#{obj.lng}" 

					fol_text += fol_color + fol_label + fol_coord
				end
			
				url = http + center + zoom + map + self_color + self_label + self_coord + fol_text
	end


				# Map url template ************************
				# http://maps.googleapis.com/maps/api/staticmap?
				# center=Brooklyn+Bridge,New+York,NY
				# &zoom=13&size=600x300
				# &maptype=roadmap
				# &markers=color:blue
				# %7Clabel:S%7C
				# 40.702147,-74.015794

				# &markers=color:green
				# %7Clabel:G%7C
				# 40.711614,-74.012318
				# &markers=color:red
				# %7Clabel:C%7C
				# 40.718217,-73.998284
				# Map url template ************************


end

# This file runs from config.ru via the 'rackup' command in terminal
# Rack::Handler::WEBrick.run App.new
