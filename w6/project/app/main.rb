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
# - How to do password matching and verification?  If-Then, followed by redirect?    --> Max to show tomorrow
# - The SQL database stores keys as strings (and not symbols).  Do I have to work with strings all the time instead of symbols?  --> Yes
# - Geomapping: either ruby geocoder or google maps api 

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

	attr_accessor :current_user

	def initialize()
		@orm = ORM.new()
		# @users and @posts are arrays of objects
		@users = @orm.all(:users)
		@posts = @orm.all(:posts)
		@id_of_current_user = nil
		@error_message = []
	end
	
	def call(env)
		ap env

		request = Rack::Request.new(env)
		response = handle_request(request)
		return response.finish()
	end


	def handle_request(request)
		Rack::Response.new do |res|
			case request.path_info
			when '/login', '/'
				res.write render('login', {:errors => @error_message})
			when '/register'

				if request.POST['new_username'] #trying to register NEW user
					attempted_new_username = request.POST['new_username']
					username_exists = check_if_username_exists(attempted_new_username)

					if username_exists # check if username already exists
						@error_message = ["Sorry, ***#{attempted_new_username}*** already exists. Please choose another."]
						res.write render('login', {:errors => @error_message})
					elsif request.POST['new_password'] != request.POST['confirm_password'] # if passwords do NOT match
						@error_message = ["You did not enter the same password.  Please try again."]
						res.write render('login', {:errors => @error_message})
					else
						# get two element array with lattituted and longitude
						geo_arr_lat_lng = get_geo_location(
							request.POST['address'],
							request.POST['city'],
							request.POST['state'],
							request.POST['country']
						)

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

						new_user_obj = User.new(new_user_hash)
						@users.push(new_user_obj)
						@orm.save_user(new_user_obj)

						@id_of_current_user = @orm.get_user_id_from_username(request.POST['new_username'])
						request.session['user_id'] = @id_of_current_user

						res.redirect('/profile')
					end

				end

			when '/check_login'	# trying to login as EXISTING user
				if request.POST['return_username']
					attempted_return_username = request.POST['return_username']
					username_exists = check_if_username_exists(attempted_return_username)
					if !username_exists
						@error_message = ["***#{attempted_return_username}*** does not exist. Please re-enter the spelling or register as a new user."]
						binding.pry
						res.write render('login', {:errors => @error_message})
					end

				end
			when '/profile'
				# @current_user is the username
				# current_user_all_posts_arr = get_all_current_user_posts(@current_user)
				# current_user_friends_arr = get_all_current_user_friends(@current_user)
				# current_user_friends_posts_arr = get_all_current_user_friends_posts(@current_user)

				locals = {
					:users => @users,
				}
				res.write render('profile', locals)	
			when '/profile'
				res.redirect('/provile')
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

	def get_all_current_user_posts(current_user)
	end

end

# This file runs from config.ru via the 'rackup' command in terminal
# Rack::Handler::WEBrick.run App.new
