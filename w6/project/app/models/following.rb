# Following class is same as User class, but with distance from a particular OTHER user added

class Following
	attr_reader :id
	attr_accessor :username, :password, :address, :city, :state, :country, :lat, :lng, :hub_lat, :hub_lng, :distance

	def initialize(user_obj, own_obj)
		@id = user_obj.id
		@username = user_obj.username
		@password = user_obj.password
		@address = user_obj.address
		@city = user_obj.city
		@state = user_obj.state
		@country = user_obj.country
		@lat = user_obj.lat
		@lng = user_obj.lng
		@hub_lat = own_obj.lat
		@hub_lng = own_obj.lng
		@distance = ((((@hub_lat - @lat)**2 + (@hub_lng - @lng)**2)**(0.5)) * 100).round(2)
	end
end