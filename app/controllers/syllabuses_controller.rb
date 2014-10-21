class SyllabusesController < ApplicationController

  respond_to :json
  before_action :find_user, only: [:create, :show, :index, :update, :destroy]

  def index
    respond_with @user.syllabuses.all
  end

  def show
    respond_with Syllabus.find(params[:id])
  end
  
  def update
    respond_with Syllabus.update(params[:id], params[:syllabus])
  end
  
  def create
    params.permit!
    respond_with Syllabus.create(params[:syllabus])
  end
  
  def destroy
    respond_with Syllabus.destroy(params[:id])
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end
end
