class ComponentsController < ApplicationController
	def new
		@component = Component.new
	end

	def create
		@component = Component.new(component_params)

		if @component.save
			redirect_to @component
		else
			render 'new'
		end
	end

	def index
		@components = Component.all
	end

	def show
		@component = Component.find(params[:id])
	end

	private
		def component_params
			params.require(:component).permit(:name, :type, :order, plaintext_attributes: [:title, :contents, :component_id])
		end
ends
