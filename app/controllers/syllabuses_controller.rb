class SyllabusesController < ApplicationController

  before_action :find_user, only: [:new, :create, :show, :index. :edit]

  def new
    @syllabus = Syllabus.new
    @syllabus.components.build
  end

  def create
    @syllabus = @user.syllabuses.create(syllabus_params)    

    if @syllabus.save
      render 'show'
    else
      render 'new'
    end
  end

  def show
    @syllabus = @user.syllabuses.find(params[:id])
  end

  def index
    @syllabuses = @user.syllabuses.all

  end

  def edit
    @syllabus = @user.syllabuses.find(params[:id])
    # necessary? 
    # @syllabus.components.build
  end
  
  def update
  end

  def destroy
  end

  private
  def syllabus_params
    params.require(:syllabus).permit(:title, :location, 
                                     :course_num, :section_num, :course_type, :department, :term, :order, :user_id, 
                                     component_attributes: [:name, :component_type, :child_id, :syllabus_id])
  end
    
  def find_user
    @user = User.find(params[:user_id])
  end


end
