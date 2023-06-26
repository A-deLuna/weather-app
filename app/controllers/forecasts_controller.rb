class ForecastsController < ApplicationController
  def index
    @forecast = WeatherService.from_position(lat: lat, lng: lng)   
    @name = name
    @cached = false
    render :show
  end

  def show
    @name = name
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

  def name
    params[:address]
  end

  def zip
    params[:id]
  end
end
