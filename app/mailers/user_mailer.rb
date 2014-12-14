class UserMailer < ActionMailer::Base
  default from: "syllabestapp@gmail.com"

  def welcome_email(user)
    @user = user
    
    mail(to: @user.email, subject: "Welcome to Syllabest")
  end

end
