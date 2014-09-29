class SyllabusesController < ApplicationController

  def new
    @syllabus = Syllabus.new
  end

  def create
    @syllabus = Syllabus.new(syllabus_params)

    if @syllabus.save
      redirect_to @syllabus
    else
      render 'new'
    end
  end

  def show
    @syllabus = Syllabus.find(params[:id])
  end

  def index
    @syllabuses = Syllabus.all
  end

  def edit
  end
  
  def update
  end

  def destroy
  end

  private
  def syllabus_params
    params.require(:syllabus).permit(:title, :location, 
                                     :course_num, :section_num, :course_type, :department, :term, :order)
  end
    



end
