class SyllabusesController < ApplicationController

  respond_to :json, :pdf, :html
  before_action :find_user, only: [:create, :index, :update, :destroy]

  def index
    respond_with @user.syllabuses.all
  end

  def show
    @syllabus = Syllabus.find(params[:id])
    respond_to do |format|
      format.pdf do
        components = @syllabus.components.all
        pdf = SyllabusPdf.new(@syllabus, components)
        title = @syllabus.title + ".pdf"
        send_data pdf.render, filename: title, type: "application/pdf", disposition: "inline"
      end
      format.json do 
        respond_with @syllabus
      end
      format.html do
        resond_with @syllabus
      end
    end
  end
  
  def update
    respond_with Syllabus.update(params[:id], params[:syllabus])
  end
  
  def create
    params.permit!
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
