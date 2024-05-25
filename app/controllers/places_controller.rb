class PlacesController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:query].present?
      @places = Place.where('address_city ILIKE ? OR address_country ILIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @places = Place.all
    end
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
      flash[:success] = "You successfully created a new place!"
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
      flash[:success] = "You successfully updated your place!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to places_path
    flash[:success] = "You successfully deleted your place!"
  end

  private

  def list_params
    params.require(:place).permit!
  end
end
