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
        'filename' => 'Barbershop.mp3'
    }
]

add_song = Proc.new() do |title|
    if title.is_a?(String)
        Kernel.puts('Now playing ' + title)
    else
        Kernel.puts('FREAKIN OUT!')
    end
end

show_song = Proc.new() do |song|
    Kernel.puts(
        song['title'] +
        ' by ' +
        song['artist']
    )
end

def get_title_for_song(song)
    if song.has_key?('title')
        song['title']
    elsif song.has_key?('filename')
        song['filename'].split('.').first()
    else
        Kernel.puts('FREAKIN OUT!')
    end
end

fix_song_data = Proc.new() do |song|
    song['title'] = get_title_for_song(song)
end

def each(list_of_items, thing_to_do)
    for item in list_of_items
        thing_to_do.call(item)
    end
end

commands_to_procs = {
    'play' => add_song,
    'show' => show_song
}

user_subcommand = ARGV[0]

thing_to_do = commands_to_procs[user_subcommand]

each(SONGS, fix_song_data)
each(SONGS, thing_to_do)
