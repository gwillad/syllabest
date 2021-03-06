class SyllabusesController < ApplicationController
  
  respond_to :json, :pdf, :html
  before_action :find_user, only: [:create, :index, :update, :destroy, :show]
  
  def index
    if(current_user == @user)
      p @user.syllabuses.all
      respond_with @user.syllabuses.all
    else
      error(401)
    end
  end
  
  def show
    if(current_user!= @user)
      error(401)
    end
    @syllabus = Syllabus.find(params[:id])
    respond_to do |format|
      format.pdf do
        components = @syllabus.components.all
        pdf = SyllabusPdf.new(@syllabus, components, @user)
        title = @syllabus.title + ".pdf"
        send_data pdf.render, filename: title, type: "application/pdf", disposition: "inline"
      end
      format.json do 
        respond_with @syllabus
      end
      format.html do
        respond_with @syllabus
      end
    end
  end
  
  def update
    p 
    '000000000000000000000000000000000000000000000000000000'
    syllabus = Syllabus.update(params[:id], params[:syllabus])
    
    #if syllabus.save
    syllabus.students.all.each do |student|
      StudentMailer.updated_syllabus(student, syllabus).deliver
    end

    respond_with syllabus #Syllabus.update(params[:id], params[:syllabus])
  end
  
  def create
    params.permit!
    p "----------------------------------------"
    p params
    p "----------------------------------------"
    
    @record = @user.syllabuses.create(params[:syllabus])
    respond_with @user, @record
  end
  
  def destroy
    respond_with Syllabus.destroy(params[:id])
  end
  
  private
  def find_user
    @user = User.find(params[:user_id])
  end
end
