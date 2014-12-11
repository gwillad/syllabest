class ApplicationController < ActionController::Base
  before_action :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  


  private
  
  def require_login
    unless logged_in?
      p "---------------------------------___________You are not logged in"
      redirect_to "/signin"
    else
      p "&&&&&&&&&&&&&&&&&&&&&&&&&&____________________&&&&&&&&&&&&&&&&&"
      p current_user
    end
  end

  def error(code)
    if code == 401
      p current_user.id
      render status: 401, json: {message: "Unauthenticated, please log in", user: current_user.id}
    end

  end

end
