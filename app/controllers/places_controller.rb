class PlacesController < ApplicationController
  def index
    @places = Place.all
    @applied_filters = {}

    if params[:places_searched].present?
      @places = @places.where('address_city ILIKE ? OR address_country ILIKE ?', "%#{params[:places_searched]}%", "%#{params[:places_searched]}%")
      @applied_filters[:places_searched] = params[:places_searched]
    end

    if params[:address_country].present?
      @places = @places.where('address_country ILIKE ?', "%#{params[:address_country]}%")
      @applied_filters[:address_country] = params[:address_country]
    end

    if params[:address_city].present?
      @places = @places.where('address_city ILIKE ?', "%#{params[:address_city]}%")
      @applied_filters[:address_city] = params[:address_city]
    end

    if params[:internet_speed].present?
      @places = @places.where('internet_speed >= ?', params[:internet_speed].to_f)
      @applied_filters[:internet_speed] = params[:internet_speed]
    end

    if params[:price_per_day].present?
      @places = @places.where('price_per_day <= ?', params[:price_per_day].to_f)
      @applied_filters[:price_per_day] = params[:price_per_day]
    end

    if params[:screen_number].present?
      @places = @places.where('screen_number >= ?', params[:screen_number].to_i)
      @applied_filters[:screen_number] = params[:screen_number]
    end

    if params[:desk_number].present?
      @places = @places.where('desk_number >= ?', params[:desk_number].to_i)
      @applied_filters[:desk_number] = params[:desk_number]
    end

    if params[:bed_number].present?
      @places = @places.where('bed_number >= ?', params[:bed_number].to_i)
      @applied_filters[:bed_number] = params[:bed_number]
    end

    if params[:outdoor].present?
      @places = @places.where(outdoor: true)
      @applied_filters[:outdoor] = true
    end

    if params[:air_conditionning].present?
      @places = @places.where(air_conditionning: true)
      @applied_filters[:air_conditionning] = true
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

  def list_params
    params.require(:place).permit!
  end
end
