class ComponentsController < ApplicationController

  before_action :find_syllabus, only: [:new, :create, :index, :show]

  def new
    @component = Component.new
    @component.plaintexts.build
  end
  
  def create
    @component = @syllabus.components.create(component_params)
    
    if @component.save
      redirect_to @component
    else
      render 'new'
    end
  end
  
  def index
    @components = @syllabus.components.all
  end
  
  def show
    @component = @syllabus.components.find(params[:id])
  end
  
  private
  def component_params
    params.require(:component).permit(:component_type, :child_id, :syllabus_id, plaintext_attributes: [:title, :contents, :component_id])
  end

  def find_syllabus
    @syllabus = Syllabus.find(params[:syllabus_id])
  end
end
