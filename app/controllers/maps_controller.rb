# app/controllers/maps_controller.rb
class MapsController < ApplicationController
  def show
    @places = Place.all
    puts @places
    @markers = @places.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window_html: render_to_string(partial: "shared/info_window_worldmap", locals: { place: place }),
        marker_html: render_to_string(partial: "shared/marker", locals: { place: place })
      }
    end
  end

end
