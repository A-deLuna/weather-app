require "application_system_test_case"

class ForecastsTest < ApplicationSystemTestCase
  # Addresses that don't have a zip code like cities or states
  # get redirected to the index action of the forecasts controller.
  test "redirects to forecasts" do
    visit addresses_url
    fill_in "address", with: "Eugene, Oregon"
    click_first_suggestion
    assert_current_path /forecasts\?address/
  end

  # Addresses that have a zip code get redirected to the show
  # action of the forecasts controller. It implements caching by zip.
  test "redirects to forecasts with zip" do
    visit addresses_url
    fill_in "address", with: "1 Apple Park Way. Cupertino, CA"
    click_first_suggestion
    assert_current_path /forecasts\/95014/
  end

  private
  def click_first_suggestion
    all("div.pac-item").first.click
  end
end
