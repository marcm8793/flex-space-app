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

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(list_params)
      redirect_to place_path(@place)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to places_path
  end

  private

  def list_params
    params.require(:place).permit!
  end
end
