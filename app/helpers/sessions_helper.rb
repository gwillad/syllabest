module SessionsHelper

  #Helps with signing in
  def sign_in(user)
    #Rails function that creates a cookie (auto-encypted)
    session[:user_id] = user.id
  end

end
