class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_place, only: [:edit, :update, :destroy, :create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.place = @place
    if @booking.save
      redirect_to trip_path
      flash[:success] = "You successfully booked your trip!"
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
      redirect_to trip_path
      flash[:success] = "You successfully updated your booking!"
    else
      render :edit
    end
  end

  def destroy
    @place = current_user.places.find_by(id: params[:place_id])
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to trip_path
    flash[:success] = "You successfully deleted your booking!"
  end

  private

  def booking_params
    params.require(:booking).permit!
  end

  def set_place
    @place = Place.find(params[:place_id])
  end

end
