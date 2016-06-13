module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    return true if session[:user_id] != nil
  end

  def authenticate!
    redirect_to login_path unless logged_in?
  end
end
