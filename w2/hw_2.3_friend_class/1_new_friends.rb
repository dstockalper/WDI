
class Person

	def initialize(name)
		@name = name
		@friend_names_list = []
		@pet_names_list = []
		@friend_objects_list = []
		@pet_objects_list = []
		@pets_of_friends = []
	end
	
	def get_name()
		@name
	end


	def meet_friend(some_object)
		friend_name = some_object.get_name()
		@friend_names_list << friend_name
		@friend_objects_list << some_object 
	end

	def get_friend_names_list()
		@friend_names_list
	end

	def get_friend_objects_list()
		@friend_objects_list
	end


	def meet_pet(some_object)
		pet_name = some_object.get_name()
		@pet_names_list << pet_name
		@pet_objects_list << some_object
	end

	def get_pet_names_list()
		@pet_names_list
	end

	def get_friend_objects_list()
		@friend_objects_list
	end

	def get_pets_of_friends()
		for friend in @friend_objects_list
			pets = friend.get_pet_names_list()
			@pets_of_friends << pets
		end

		@pets_of_friends
	end

end

class Pet
	def initialize(name)
		@name = name
	end

	def get_name()
		@name
	end
end

doug = Person.new("Doug")
colt = Person.new("Colt")
max = Person.new("Max")
charley = Pet.new("Charley")
killer = Pet.new("Killer")
rover = Pet.new("Rover")

doug.meet_friend(colt)
doug.meet_friend(max)
doug.meet_pet(charley)
colt.meet_pet(killer)
max.meet_pet(rover)

friends = doug.get_friend_names_list()
pets = doug.get_pet_names_list()
pets_of_friends = doug.get_pets_of_friends()

STDOUT.puts("\n" + "Friends: ")
STDOUT.puts(friends)

STDOUT.puts("\n" + "Pets: ")
STDOUT.puts(pets)

STDOUT.puts("\n" + "Pets of friends: ")
STDOUT.puts(pets_of_friends)

