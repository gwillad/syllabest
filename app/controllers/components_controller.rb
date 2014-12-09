class ComponentsController < ApplicationController
  
  respond_to :json
  before_action :find_syllabus, only: [:index, :show, :update, :create, :destroy]

  def index
    @response = @syllabus.components.all
    @jsonResponse = []
    @response.each do |h|
      if h.component_type == "plaintext"
        @plaintext = h.plaintext.as_json
        record = h.as_json
        record[:plaintext_attributes] = @plaintext
        @jsonResponse.push(record)
      elsif h.component_type == "table"
        @table = h.table.as_json
        p @table
        record = h.as_json
        record[:table_attributes] = @table
        @jsonResponse.push(record)
      end
    end
    respond_with @jsonResponse
  end

  def show
    @response = @syllabus.components.find(params[:id])
    @plaintext = @response.plaintext
    @response = @response.as_json
    @response[:plaintext_attributes] = @plaintext.as_json
    respond_with @response
  end
  
  def update
    params.permit!
    p params
    @record = @syllabus.components.update(params[:id].to_i, params[:component])
    respond_with @user, @syllabus, @record
  end
  
  def create
    params.permit!
    @record = @syllabus.components.create(params[:component])
    respond_with @user, @syllabus, @record
  end
  
  def destroy
    respond_with @syllabus.components.destroy(params[:id])
  end
  
  private
  def component_params
    params.require(:component).permit(:id, :order, :component_type, :order, :syllabus_id, plaintext_attributes: [:title, :contents, :component_id, :id], table_attributes: [:title, :rows, :columns, :border_class])
  end

  def find_syllabus
    @syllabus = Syllabus.find(params[:syllabus_id])
    @user = User.find(@syllabus[:user_id])
  end
end
