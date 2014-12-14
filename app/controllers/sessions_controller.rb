class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :show]
  before_action :require_not_login, only: [:new, :create, :show]
  respond_to :json
	def show
	end
	
	def new
	end

        def create
          user = User.find_by(email: params[:session][:email].downcase)
          if user && user.authenticate(params[:session][:email], params[:session][:password])
            # Log user in and
            sign_in user
            #....redirect where?
            redirect_to "/users/" + user.id.to_s
            p "-----------------------------------------Success"
          else
            #create an errors messages
            flash.now[:danger] = 'Invalid email/password combination'
            render 'new'
          end
        end

	def destroy
          log_out
          error(304)
	end
	
end
