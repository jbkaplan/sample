# get '/users' do
#     @user = User.find_by(id: current_user.id)
#     @user.albums.find_or_create_by(spotify_id: params[:id], name: params[:name])
#   if request.xhr?
#     status 200
#   else
#     redirect '/'
#   end
# end

# get '/users/:user_id' do
#   @user = User.find_by(id: current_user.id)

#   erb :"users/show"
# end