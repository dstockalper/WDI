
class Person

	def initialize(name)
		@name = name
		@friend_names_list = []
		@friend_objects_list = []
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

	def get_num_friends()
		@friend_names_list.length()
	end

end

def people_by_popularity(people_array)
	popularity_hash = {}
	for person in people_array
		num_friends = person.get_num_friends()
		popularity_hash[person] = num_friends
	end
	popularity_array = popularity_hash.sort_by {|key, value| value }

	popularity_array_clean = []
	for elem in popularity_array
		popularity_array_clean << elem[0]
	end

	popularity_array_clean
end


celes = Person.new("Celes")
michaelangelo = Person.new("Michaelangelo")
graves = Person.new("Graves")

celes.meet_friend(michaelangelo)
graves.meet_friend(michaelangelo)
celes.meet_friend(graves)

people = people_by_popularity([celes, michaelangelo, graves])

people.each() do |person|
	STDOUT.puts(person.get_name)
end



