class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 

  def index
    spices = Spice.all
    render json: spices
  end

  # def show
  #   spices = find_spice
  #   render json: spices
  # end

  def create 
    spices = Spice.create(spice_params)
    render json: spices, status: :created
  end

  def update
    spices = find_spice
    spices.update(spice_params)
    render json: spices
  end

  def destroy
    spices = find_spice
    spices.destroy
    head :no_content
  end


  private 

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def render_not_found_response
    render json: {error: 'Spice not found'}, status: :not_found
  end

  def find_spice
    Spice.find_by(id: params[:id])
  end


end
