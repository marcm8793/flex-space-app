class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_place, only: [:edit, :update, :destroy]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.place = @place
    if @booking.save
      redirect_to root_path, notice: "Booking created successfully"
    else
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to places_path, notice: "Booking updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @place = current_user.places.find_by(id: params[:place_id])
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to places_path, notice: "Booking deleted successfully delete"
  end

  private

  def booking_params
    params.require(:booking).permit!
  end

  def set_place
    @place = Place.find(params[:place_id])
  end

end
