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

class UsersController < ApplicationController
  before_filter :skip_password_attribute, only: :update

  def index
    @user = User.find(session[:user_id])
    @user.albums.find_or_create_by(spotify_id: params[:id], name: params[:name])
    if request.xhr?
      status 200
    else
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render "new"
    end
  end
  
  def update
   @user = User.find(params[:id])
    if @user.update(edit_user_params)
      redirect_to @user
    else
      render "edit"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :phone_number)
    end

    def edit_user_params
      params.require(:user).permit(:name, :password, :phone_number, :description, :current_phase)
    end

  def skip_password_attribute
    if params[:password].blank?
      params.except!(:password)
    end
  end

end