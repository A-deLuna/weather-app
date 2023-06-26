class ForecastsController < ApplicationController
  # Handles requests that don't relate to a single zip code like a city or a landmark.
  def index
    @forecast = WeatherService.from_position(lat: lat, lng: lng)
    @address = address
    @cached = false
    render :show
  end

  # Handles requests of street addresses that can be associated with a zip code.
  def show
    @address = address
    @cached = true
    @forecast = Rails.cache.fetch("weather/zip/#{zip}", expires_in: 30.minutes) do
      @cached = false
      WeatherService.from_position(lat: lat, lng: lng)
    end
  end

  private
  def lat
    params[:lat]
  end

  def lng
    params[:lng]
  end

  def address
    params[:address]
  end

  def zip
    params[:id]
  end
end
