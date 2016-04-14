require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/content_for'
require 'pry'
require 'httparty'
require './console'
require './db_config'
require './models/movie'

get '/' do
  erb :index
end

get '/movie_list' do
  if params[:movie] != nil
    movie_name = params[:movie]
    @result = HTTParty.get("http://omdbapi.com/?s=#{movie_name}")
    if @result['Search'].length == 1
      redirect "/movie_info?imdbID=#{ @result['Search'][0]['imdbID'] }"
    end
  end
  erb :movie_list
end

get '/movie_info' do

  movie_id = params[:imdbID]

  if !Movie.exists?(imdbid: movie_id)
    @movie_info = HTTParty.get("http://omdbapi.com/?i=#{movie_id}")
    movie = Movie.new
    movie.title = @movie_info['Title']
    movie.poster = @movie_info['Poster']
    movie.imdbid = @movie_info['imdbID']
    movie.save
    puts "==================================================="
    puts "#{movie.title} saved and the id is #{movie.imdbid}"
    puts "==================================================="
  else
    @movie_info = Movie.find_by(imdbid: movie_id)
  end

  erb :movie_info
end

# binding.pry



# movie.Year = @movie_info['Year']
# movie.Rated = @movie_info['Rated']
# movie.Released = @movie_info['Released']
# movie.Runtime = @movie_info['Runtime']
# movie.Genre = @movie_info['Genre']
# movie.Director = @movie_info['Director']
# movie.Writer = @movie_info['Writer']
# movie.Actors = @movie_info['Actors']
# movie.Plot = @movie_info['Plot']
# movie.Language = @movie_info['Language']
# movie.Country = @movie_info['Country']
# movie.Awards = @movie_info['Awards']
# movie.Metascore = @movie_info['Metascore']
# movie.imdbRating = @movie_info['imdbRating']
# movie.imdbVotes = @movie_info['imdbVotes']
# movie.Type = @movie_info['Type']
# movie.Response = @movie_info['Response']



# get '/movie_info' do
#   if params[:movie] != nil
#     movie_name = params[:movie].to_s
#     @result = HTTParty.get("http://omdbapi.com/?s=#{movie_name}")
#
#     if @result['Search'].length == 1
#       url = 'http://omdbapi.com/?t='+movie_name
#       @movie_info = HTTParty.get(url)
#
#     elsif @result['Search'].length > 1
#       redirect "/movie_list"
#     end
#
#   end
#   erb :movie_info
# end
