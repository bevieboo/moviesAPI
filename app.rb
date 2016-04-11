require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'httparty'

get '/' do
  erb :index
end

get '/movie_list' do
  if params[:movie] != nil
    movie_name = params[:movie].to_s
    @result = HTTParty.get("http://omdbapi.com/?s=#{movie_name}")
      # @result.inspect
      if @result['Search'].length == 1
        redirect "/movie_info?imdbID=#{ @result['Search'][0]['imdbID'] }"
      end

  end
  erb :movie_list
end

get '/movie_info' do

    movie_id = params[:imdbID]
    @movie_info = HTTParty.get("http://omdbapi.com/?i=#{movie_id}")

  erb :movie_info
end

# binding.pry
