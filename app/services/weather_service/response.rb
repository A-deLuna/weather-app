# WeatherService Contract
# today: an instance of the Forecast model
# daily: an array of instances of the Forecast model
class WeatherService::Response
  include ActiveModel::API
  attr_accessor :today, :daily
end
