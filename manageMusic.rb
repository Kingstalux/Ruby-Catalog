require_relative './musicAlbum'
require_relative './genre'
require 'json'

def add_music
    puts 'What genre of music do you want to add?'
    genre = gets.chomp
    puts ' '
    puts 'What is the publish date of your genre?'
    date = gets.chomp
    puts ' '
    puts 'Is your music album found on spotify? [Y/N]'
    ans = gets.chomp.capitalize
    case ans
    when 'Y'
      ans = true
    when 'N'
      ans = false
    end
    music = MusicAlbum.new(date, on_spotify: ans)
    @musics_arr.push(music)
    genre = Genre.new(genre)
    genre.add_item(music)
    @genre_arr.push(genre)
    puts ' '
    puts 'Music added successfully!'
    puts ' '
end

def list_musics
    puts ' '
    @musics_arr.each {|x| puts "Publish date: #{x.published_date}, On_Spotify: #{x.on_spotify}"}
    puts ' '
end



def save_albums
    albums_json = []
    @musics_arr.each do |music|
      m = {
        'date' => music.published_date,
        'spotify' => music.on_spotify
      }
      albums_json.push(m)
    end
    File.write('./albums.json', albums_json.to_json)
end



def initialize_musics
    music_file = './albums.json'
    f = File.read(music_file)
    if f.empty? == false
        json = JSON.parse(f)
        get_album(json)
    else
        @musics_arr = []
    end
end

def get_album(json)
    @musics_arr = []
    i = 0
    while i < json.length
        m = MusicAlbum.new(json[i]['date'], on_spotify: json[i]['spotify'])
        @musics_arr.push(m)
        i += 1
    end
end

