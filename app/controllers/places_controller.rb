class PlacesController < ApplicationController
  def index
    @places = Place.all

    if params[:query].present?
      @places = @places.where('address_city ILIKE ? OR address_country ILIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
    end

    if params[:address_country].present?
      @places = @places.where('address_country ILIKE ?', "%#{params[:address_country]}%")
    end

    if params[:address_city].present?
      @places = @places.where('address_city ILIKE ?', "%#{params[:address_city]}%")
    end

    if params[:internet_speed].present?
      @places = @places.where('internet_speed >= ?', params[:internet_speed].to_f)
    end

    if params[:price_per_day].present?
      @places = @places.where('price_per_day <= ?', params[:price_per_day].to_f)
    end

    if params[:screen_number].present?
      @places = @places.where('screen_number >= ?', params[:screen_number].to_i)
    end

    if params[:desk_number].present?
      @places = @places.where('desk_number >= ?', params[:desk_number].to_i)
    end

    if params[:bed_number].present?
      @places = @places.where('bed_number >= ?', params[:bed_number].to_i)
    end

    if params[:outdoor].present?
      @places = @places.where(outdoor: true)
    end

    if params[:air_conditionning].present?
      @places = @places.where(air_conditionning: true)
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
    @place = Place.new(place_params)
    @place.user = current_user
    if @place.save
      redirect_to place_path(@place)
      flash[:success] = "You successfully created a new place!"
    else
      render partial: "shared/addplacemodal", status: :unprocessable_entity
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      redirect_to place_path(@place)
      flash[:success] = "You successfully updated your place!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    if @place.bookings.any?
      redirect_to trip_path
      flash[:danger] = "You can't delete a place with bookings!"
    else
      @place.destroy
      redirect_to trip_path
      flash[:success] = "You successfully deleted your place!"
    end
  end

  private

  def place_params
    params.require(:place).permit(:address_country, :address_city, :address_street_name, :address_zip_code, :screen_number,
    :desk_number, :bed_number, :internet_speed, :outdoor, :air_conditionning, :price_per_day)
  end
end
