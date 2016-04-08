require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'httparty'

get '/' do
  erb :index
end

get '/movie_info' do
  if params[:movie] != nil
    movie_name = params[:movie].to_s
    url = 'http://omdbapi.com/?t='+movie_name
    @movie_info = HTTParty.get(url)
  end
  erb :movie_info
end
