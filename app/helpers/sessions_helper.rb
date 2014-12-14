module SessionsHelper

  #Helps with signing in
  def sign_in(user)
    #Rails function that creates a cookie (auto-encypted)
    session[:user_id] = user.id
  end

  #Returns the user who is currently logged in
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) #It is either user_id or its nil
  end

  #If user is not logged in -> return false, else return true
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
