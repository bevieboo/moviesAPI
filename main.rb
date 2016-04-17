require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/content_for'
require 'pry'
require 'httparty'
require './console'
require './db_config'
require './models/movie'

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  erb :index
end

get '/movie_list' do

  if params[:movie] != nil
    movie_name = params[:movie]

    @result = HTTParty.get("http://omdbapi.com/?s=#{movie_name}")

    if @result['Response'] == 'False'
      redirect "/page_not_found"
    end

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
    @movie_info = @movie_info.map { |k, v| [k.downcase, v] }.to_h
    movie = Movie.new
    movie.title = @movie_info['title']
    movie.year = @movie_info['year']
    movie.rated = @movie_info['rated']
    movie.released = @movie_info['released']
    movie.runtime = @movie_info['runtime']
    movie.genre = @movie_info['genre']
    movie.director = @movie_info['director']
    movie.writer = @movie_info['writer']
    movie.actors = @movie_info['actors']
    movie.plot = @movie_info['plot']
    movie.language = @movie_info['language']
    movie.country = @movie_info['country']
    movie.awards = @movie_info['awards']
    movie.poster = @movie_info['poster']
    movie.metascore = @movie_info['metascore']
    movie.imdbrating = @movie_info['imdbrating']
    movie.imdbvotes = @movie_info['imdbvotes']
    movie.imdbid = @movie_info['imdbid']
    movie.response = @movie_info['response']
    movie.save
    puts "==================================================="
    puts "#{movie.title} saved and the id is #{movie.imdbid}"
    puts "==================================================="
  else
    @movie_info = Movie.find_by(imdbid: movie_id)
    puts "==================================================="
    puts "#{@movie_info.title} has been retrieved from local database"
    puts "==================================================="
  end

  erb :movie_info
end

get '/page_not_found' do
  erb :error
end

# binding.pry
