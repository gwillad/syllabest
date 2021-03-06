class StudentsController < ApplicationController

  respond_to :json 
  before_action :find_syllabus, only: [:index, :show, :update, :create, :destroy]
  

  def index
    respond_with @syllabus.students.all
  end
  
  def show
    respond_with @syllabus.students.find(params[:id])
  end

  
  def create
    params.permit!
    @record = @syllabus.students.create(params[:student])
    # @record.save
    
    ## NOTE: I have commented this mailer out temporarily due to 500 internal
    ##       service errors. To go back uncomment bellow (including respond with
    ##       record) and comment above '@record.save' -Paul

    if @record.save
      #StudentMailer.new_student(@record, @syllabus).deliver
    end

    respond_with @user, @syllabus, @record
  end

  def update
    params.premit!
    @record = @syllabus.students.update(params[:id].to_i, params[:student])
    respond_with @user, @syllabus, @record
  end

  def destroy
    respond_with @syllabus.students.destroy(params[:id])
  end

  private
    def user_params
      params[:user].require(:first_name).permit(:school,:office)
    end

    def find_syllabus
      @syllabus = Syllabus.find(params[:syllabus_id])
      @user = User.find(@syllabus[:user_id])
    end
end
