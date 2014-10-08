class ComponentsController < ApplicationController
  
  respond_to :json
  before_action :find_syllabus, only: [:new, :create, :index, :show]

  def index
    respond_with @syllabus.components.all
  end

  def show
    respond_with Component.find(params[:id])
  end
  
  def update
    respond_with Component.update(params[:id], params[:component])
  end
  
  def create
    respond_with Component.create(params[:component])
  end
  
  def destroy
    respond_with Component.destroy(params[:id])
  end
  
  private
  def component_params
    params.require(:component).permit(:component_type, :child_id, :syllabus_id, plaintext_attributes: [:title, :contents, :component_id])
  end

  def find_syllabus
    @syllabus = Syllabus.find(params[:syllabus_id])
  end
end
