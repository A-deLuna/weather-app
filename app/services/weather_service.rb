module WeatherService
  def self.from_position(lat:, lng:)
    data = client.one_call(lat:lat, lon: lng, exclude: ['minutely', 'hourly', 'alerts'])
    Forecast.new(temp_c: data.current.temp_c, temp_f: data.current.temp_f, icon: data.current.weather[0].icon_uri.to_s )
  end

  def self.client
    OpenWeather::Client.new(
      api_key: Rails.configuration.weather[:api_key]
    )
  end
end
