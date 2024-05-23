class PlacesController < ApplicationController
  before_action :authenticate_user!
  def index
    @places = Place.all
  end

  def show
    @place = Place.find(params[:id])
    @booking = Booking.new
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(list_params)
    @place.user = current_user
    if @place.save
      redirect_to place_path(@place)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:place).permit!
  end
end
