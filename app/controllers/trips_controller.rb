class TripsController < ApplicationController
  before_action :authenticate_user!

  def index
    @places = current_user.places
    @bookings = current_user.bookings
    @place = Place.new
    @favorite_places = current_user.favorite_places
  end

  private

  def list_params
    params.require(:trip).permit!
  end

end
