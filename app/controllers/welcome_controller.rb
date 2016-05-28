class WelcomeController < ApplicationController

  def index
    render 'index'
  end

  def search
    if request.xhr?
      render 'index'
    else
      artist = params[:query]
      uri = URI("https://api.spotify.com/v1/search?q=#{artist}&type=album,artist")
      json = Net::HTTP.get(uri)
      parsed_json = JSON.parse(json)
      @artist_bio = erb :'_artist_bio', layout: false, locals: {artist: parsed_json["artists"]["items"][0]}
      @artist_results = erb :'_results', layout: false, locals: {albums: parsed_json["albums"]["items"]}
      erb :show, locals: { artist_bio: @artist_bio, artist_results: @artist_results }
    end
  end

  # get '/search_again' do
  #   redirect '/'
  # end

  # get '/play' do
  #   p params
  #   # uri = URI("https://api.spotify.com/v1/albums/#{album_id}")
  #   # json = Net::HTTP.get(uri)
  #   # parsed_json = JSON.parse(json)

  # end

end