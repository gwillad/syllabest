class ComponentsController < ApplicationController
  
  respond_to :json
  before_action :find_syllabus, only: [:index, :show, :update, :create, :destroy]

  def index
    @response = @syllabus.components.all
    @jsonResponse = []
    @response.each do |h|
      @plaintext = h.plaintext.as_json
      record = h.as_json
      record[:plaintext] = @plaintext
      @jsonResponse.push(record)
    end
    respond_with @jsonResponse
  end

  def show
    @response = @syllabus.components.find(params[:id])
    @plaintext = @response.plaintext
    @response = @response.as_json
    @response[:plaintext] = @plaintext.as_json
    respond_with @response
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
