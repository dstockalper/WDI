SONGS = [
    {

        'artist' => 'Bastille',
        'title' => 'Pompeii'
    },
    {
        'artist' => 'Daft Punk',
        'title' => 'Get Lucky'
    },
    {
        'artist' => 'Murs',
        'album' => 'Murray\'s Revenge',
        'filename' => 'Barbershop.mp3'
    },
    {
        'artist' => 'Murs',
        'album' => 'Murray\'s Revenge',
        'filename' => 'Murs Day.mp3'
    },
    {
        'artist' => 'Bob Dylan',
        'title' => 'Like a Rolling Stone',
        'genre' => 'Classic Rock'
    }
]


# Reject all songs witout titles ------------------------------------------
songs_except_without_titles = SONGS.reject() do |song|
    !song.has_key?("title")
end

STDOUT.puts("Songs with a title:")
STDOUT.puts(songs_except_without_titles.inspect())
STDOUT.puts("")

# Select only songs with albums -------------------------------------------
songs_with_albums = SONGS.select() { |song| song.has_key?('album')}

STDOUT.puts("Songs with an album: ")
STDOUT.puts(songs_with_albums)
STDOUT.puts("")

# Find the first song by Boby Dylan ---------------------------------------
one_bob_dylan_song = SONGS.find() { |song| song["artist"] == "Bob Dylan" }

STDOUT.puts("Bob Dylan's song: ")
STDOUT.puts(one_bob_dylan_song)
STDOUT.puts("")

# Find out if ANY of the songs that have a genre ---------------------------
any_songs_have_genre = SONGS.any?() { |song| song.has_key?("genre") }
STDOUT.puts("Any of the songs have a genre: ")
STDOUT.puts(any_songs_have_genre)
STDOUT.puts("")

# List of 'Artist: Title' strings ------------------------------------------
title_and_song_list = SONGS.map do |song| 
    if (song.has_key?("title") && song.has_key?("artist"))
        song["artist"] + ": " + song["title"]
    end
end

STDOUT.puts("Artists and Title: ")
STDOUT.puts(title_and_song_list)
STDOUT.puts("")

# Every song with an odd-numbered index ------------------------------------
songs_with_odd_numbered_index = SONGS.each_with_index() do |song, index| 
    if ((index % 2) != 0 )
        puts(song)
    end
end

STDOUT.puts("Songs with odd-numbered index: ")
STDOUT.puts(songs_with_odd_numbered_index)





