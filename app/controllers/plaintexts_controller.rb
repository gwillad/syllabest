class PlaintextsController < ApplicationController
  respond_to :json
  before_action :find_component, only: [:new, :create, :index, :show]

  def index
    respond_with @component.plaintext
  end

  def show
    respond_with Plaintext.find(params[:id])
  end
  
  def update
    respond_with Plaintext.update(params[:id], params[:plaintext])
  end
  
  def create
    @record = @component.plaintexts.create(params[:component])
    respond_with @record, @component
  end
  
  def destroy
    respond_with Plaintext.destroy(params[:id])
  end
  
  private
  def plaintext_params
    params.require(:plaintext).permit(:title, :contents, :component_id)
  end

  def find_component
    @component = Component.find(params[:component_id])
  end
  
end
