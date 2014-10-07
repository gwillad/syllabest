class SyllabusesController < ApplicationController

  before_action :find_user, only: [:new, :create, :show, :index, :edit, :update, :destroy]
  before_action :find_syllabus, only: [:show, :edit, :update, :destroy]

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
  end

  def index
    @syllabuses = @user.syllabuses.all
  end

  def edit
    # necessary? 
    # @syllabus.components.build
  end
  
  def update
    #not working, probably has to do with params
    if @syllabus.update(params[:id]) 
      render 'show'
    else
      render 'edit'
    end
  end

  def destroy
    @syllabus.destroy
    redirect_to user_syllabuses_path
  end

  private
  def syllabus_params
    params.require(:syllabus).permit(:title, :location, 
                                     :course_num, :section_num, :course_type, :department, :term, :order, :user_id, 
                                     component_attributes: [:name, :component_type, :child_id, :syllabus_id])
  end
  
  def find_syllabus
    @syllabus = @user.syllabuses.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end


end
