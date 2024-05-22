class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_place, only: [:new, :create]

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

  private

  def booking_params
    params.require(:booking).permit(:first_day, :last_day)
  end

  def set_place
    @place = Place.find(params[:place_id])
  end

end
