# get '/login' do
#   erb :login
# end

# post '/login' do
#   @user = User.find_by(username: params[:username])

#   if @user && @user.authenticate(params[:password])
#     session[:user_id] = @user.id
#     redirect '/'
#   else
#     @error = true
#     erb :login
#   end
# end

# get '/register' do
#   erb :register
# end

# post '/register' do
#   @user = User.new(params[:user])
#   if @user.save
#     session[:user_id] = @user.id
#     redirect '/'
#   else
#     @errors = @user.errors.full_messages
#     erb :register
#   end
# end

# get '/logout' do
#   session.clear
#   redirect 'login'
# end