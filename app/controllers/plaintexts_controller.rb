class PlaintextsController < ApplicationController

  before_action :find_component, only: [:new, :create, :index, :show]

  def new
    @plaintext = Plaintext.new
  end
  
  def create
    @plaintext = @component.create(plaintext_params)
    
    if @plaintext.save
      render 'show'
    else
      render 'new'
  end
  
  def index
    @plaintexts = @component.plaintexts.all
  end
  
  def show
    @plaintext = @component.plaintexts.find(params[:id])
  end
  
  private
  def plaintext_params
    params.require(:plaintext).permit(:title, :contents, :component_id)
  end

  def find_component
    @component = Component.find(params[:component_id])
  end
  
end
