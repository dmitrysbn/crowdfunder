class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by(id: session[:user_id])
  end

  def require_login
    unless current_user
<<<<<<< HEAD
      flash[:alert] = "Please log in"
      redirect_to new_sessions_path
=======
      not_authenticated
>>>>>>> 0892e0bf8470da053bef23e919e7b0a6ff53b1f9
    end
  end

  helper_method :current_user

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
