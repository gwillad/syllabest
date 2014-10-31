class ComponentsController < ApplicationController
  
  respond_to :json
  before_action :find_syllabus, only: [:index, :show, :update, :create, :destroy]

  def index
    respond_with @syllabus.components.all
  end

  def show
    respond_with @syllabus.components.find(params[:id])
  end
  
  def update
    respond_with @syllabus.components.update(params[:id], params[:component])
  end
  
  def create
    params.permit!
    @record = @syllabus.components.create(params[:component])
    @record.child_id = @record.plaintext.id
    @record.save
    @plain = @record.plaintext
    respond_with @user, @syllabus, @record, @plain
  end
  
  def destroy
    respond_with @syllabus.components.destroy(params[:id])
  end
  
  private
  def component_params
    params.require(:component).permit(:component_type, :child_id, :syllabus_id, plaintext_attributes: [:title, :contents, :component_id])
  end

  def find_syllabus
    @syllabus = Syllabus.find(params[:syllabus_id])
    @user = User.find(@syllabus[:user_id])
  end
end
