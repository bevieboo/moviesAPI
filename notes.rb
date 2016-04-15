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

# <!-- Looping through object in Sinatra: -->
#
#   <!-- <div class="info">
#     <% @movie_info.each do |k, v| %>
#       <% if k != "Poster" && k != "Title" && k != "Plot" && k != "Year" && k != "imdbID" && k != "Type" && k != "Response" %>
#         <div class="info-text"> <%= k %>: </div> <%= v %> </br></br>
#       <% end %>
#     <% end %>
#   </div> -->
