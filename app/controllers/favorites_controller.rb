class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    place = Place.find(params[:place_id])
    unless current_user.favorite_places.include?(place)
      current_user.favorite_places << place
      flash[:success] = 'You liked this place'
    end
    render_flash
  end

  def destroy
    place = Place.find(params[:place_id])
    if current_user.favorite_places.include?(place)
      current_user.favorite_places.delete(place)
      flash[:warning] = 'You unliked this place'
    end
    render_flash
  end

  private

  def render_flash
    render json: { flash: render_to_string(partial: 'shared/flash') }, status: :ok
  end
end
