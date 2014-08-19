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


def map(list_of_items, thing_to_do)
	map_array = []

	for item in list_of_items 
		map_array << thing_to_do.call(item) #get_title_for_song
	end

	Kernel.puts(map_array)
	return map_array
end

titles = map(SONGS, get_title_for_song)

Kernel.puts(titles)
