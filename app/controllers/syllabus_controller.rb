class SyllabusController < ApplicationController

  def new
  end

  def create
    @syllabus = Syllabus.new(params[:syllabus])

    @syllabus.save
    redirect_to @syllabus
  end

  def show
    @syllabus = Syllabus.find(params[:id])
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
                                     :course_num, :department, :term)
  end
    



end
