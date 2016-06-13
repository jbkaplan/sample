class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:danger] = 'Invalid Login'
      # @error = true
      render 'new'
    end
  end

  def destroy
    session.clear
    current_user = nil
    flash[:success] = 'Logout Successful!'
    redirect_to login_path
  end

end

# get '/login' do
#   erb :login
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