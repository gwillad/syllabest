class UsersController < ApplicationController
  respond_to :json 

  def index
    respond_with User.all
  end
  
  def show
    respond_with User.find(params[:id])
  end

  def new 
    @user = User.new
  end
  
  def create
    params.permit!
 #require(:user).permit(:first_name,:last_name,:email,:school,:office,:password)
    respond_with User.create(params[:user])
  end

  def update
    respond_with User.update(params[:id], params[:user])
  end

  def destroy
    respond_with User.destroy(params[:id])
  end

  private
    def user_params
      params[:user].require(:first_name).permit(:school,:office)
    end
end
