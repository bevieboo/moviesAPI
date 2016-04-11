require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'httparty'

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
    @movie_info = HTTParty.get("http://omdbapi.com/?i=#{movie_id}")
  erb :movie_info
end

# binding.pry

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
