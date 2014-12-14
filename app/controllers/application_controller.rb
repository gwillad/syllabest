class ApplicationController < ActionController::Base
  before_action :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  


  private
  
  def require_login
    #p request.path
    unless request.path == "/signup"
      unless logged_in?
        #p "---------------------------------___________You are not logged in"
        redirect_to "/signin"
        #p request
      else
        #p "&&&&&&&&&&&&&&&&&&&&&&&&&&____________________&&&&&&&&&&&&&&&&&"
        #p current_user
      end
    end
  end

  def require_not_login
    unless !logged_in?
      redirect_to "/users/" + current_user.id.to_s
    end
  end

  def error(code)
    if code == 401
      #p current_user.id
      render status: 401, json: {message: "Unauthenticated, please log in", user: current_user.id}
    elsif code == 304
      render status: 304, json: {message: "Logout successful"}
    elsif code == 403
      render status: 403, json: {message: "Forbidden"}
    end
  end

end
