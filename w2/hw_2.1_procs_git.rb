SONGS = [
	{
		"artist" => "Batille",
		"title" => "Ponpeii"
	},
	{
		"artist" => "Daft Punk",
		"title" => "Get Lucky"
	},
	{
		"artist" => "Murs",
		"filename" => "Barbershop.mp3"
	}
]
	

get_title_for_song = Proc.new() do |song|
	if song.has_key?('title')
		song['title']
	elsif song.has_key?('filename')
		song['filename'].split('.').first()
	end
end

def each(list_of_items, thing_to_do)
	for item in list_of_items 
		thing_to_do.call(item)
	end
end

# Exercise 1: Map -----------------------------------------------
def map(list_of_items, thing_to_do)
	map_array = []

	for item in list_of_items 
		map_array << thing_to_do.call(item)
	end

	return map_array
end

titles = map(SONGS, get_title_for_song)

# Kernel.puts(titles)

# Exercise 2: Select --------------------------------------------

song_has_title = Proc.new() do |song|
    if song.has_key?('title')
        true
    else
        false
    end
end


def select(list_of_items, proc)
	select_array = Array.new()
	for item in list_of_items
		if proc.call(item)
			select_array.push(item)
		end
	end
	select_array
end

songs_with_titles = select(SONGS, song_has_title)

# Kernel.puts(songs_with_titles.inspect)

# Exercise 3: Each Pair ------------------------------------------

kids = [ 'Kate', 'Jem', 'Larry', 'Thor', 'Milosh', 'Aurora', 'Lester', 'Stella']

buddy_system = Proc.new() do |kid_a , kid_b|
	Kernel.puts(kid_a + ' and ' + kid_b + ' are buddies!')
end

def each_pair(list_of_items, proc)  #the code works but I also get an error ('wrong number of arguments')
	for i in (0...list_of_items.length())
		if (i%2 ==0)
			proc.call(list_of_items[i], list_of_items[i+1])
		end
	end
end

each_pair(kids, buddy_system)

Kernel.puts(each_pair)



