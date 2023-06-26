require "test_helper"
require "minitest/mock"

class ForecastsControllerTest < ActionDispatch::IntegrationTest
  include ForecastsHelper

  teardown do
    Rails.cache.clear
  end

  test "should get today's" do
    params = {address: "Eugene, OR", lat: "44.05", lng: "-123.08" }
    get forecasts_url, params: params
    assert_response :success
    assert_select "#address", params[:address]
    assert_select "#date-now", weekday_month_and_day(Time.now)
  end

  test "should render dates returned by WeatherService" do
    params = {address: "Eugene, OR", lat: "44.05", lng: "-123.08" }
    WeatherService.stub :from_position, weather_service_result do
      get forecasts_url, params: params
      assert_select "#date-now", weekday_month_and_day(now)
      assert_select "#temp-now", "Now: #{temp}"
      assert_select "#temp-low", "Low: #{temp}"
      assert_select "#temp-high", "High: #{temp}"
      assert_select "#daily" do |elements|
        elements.each do |element|
          assert_select element, ".weekday", weekday(tomorrow)
          assert_select element, ".month-day", month_and_day(tomorrow)
          assert_select element, ".temp-low", "Low: #{temp}"
          assert_select element, ".temp-high", "High: #{temp}"
        end
      end
    end
  end

  test "show should store result in cache" do
    zip = 97402
    params = {address: "Eugene, OR", lat: "44.05", lng: "-123.08" }
    assert_not Rails.cache.exist?("weather/zip/#{zip}"), "Cache should not have key for zip code"
    # First request with a zip should fill the cache
    WeatherService.stub :from_position, weather_service_result do
      get "/forecasts/#{zip}", params: params
      assert_response :success
      assert Rails.cache.exist?("weather/zip/#{zip}"), "should have cached zip code"
    end

    # Second request should respond with cached response and avoid hitting
    # the WeatherService again.
    mock = Minitest::Mock.new
    WeatherService.stub :from_position, mock do
      params = {address: "Eugene, OR", lat: "44.05", lng: "-123.08" }
      get "/forecasts/#{zip}", params: params
      assert_response :success
      assert_select "#temp-now", "Now: #{temp}"
    end
    mock.verify
  end

  private
  def temp
    "99.9"
  end
  def now
    Time.new(2023, 06, 26)
  end
  def tomorrow
    now + 1.day
  end
  def weather_service_result
    img = "http://example.com/img.png"
    WeatherService::Response.new(
      today: Forecast.new(
        now: temp,
        date: now,
        high: temp,
        low: temp,
        icon: img,
      ),
      daily: [
        Forecast.new(
          date: tomorrow,
          high: temp,
          icon: img,
          low: temp)
      ])
  end
end
