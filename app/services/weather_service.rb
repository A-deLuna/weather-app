module WeatherService
  def self.from_position(lat:, lng:)
    data = client.one_call(lat:lat, lon: lng, exclude: ['minutely', 'hourly', 'alerts'])
    WeatherService::Response.new(
      today: Forecast.new(
        now: data.current.temp_f,
        date: data.current.dt,
        icon: data.current.weather[0].icon_uri.to_s,
        high: data.daily[0].temp.max_f,
        low: data.daily[0].temp.min_f),
      daily: data.daily[1..7].map do |d|
        Forecast.new(
          date: d.dt,
          icon: d.weather[0].icon_uri.to_s,
          high: d.temp.max_f,
          low: d.temp.min_f)
      end
    )
  end

  def self.client
    OpenWeather::Client.new(
      api_key: Rails.configuration.weather[:api_key]
    )
  end
end
