class WeatherService::Response
  include ActiveModel::API
  attr_accessor :today, :daily
end
