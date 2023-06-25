module AddressesHelper
  def google_places_url
    api_key = Rails.configuration.maps[:api_key]
    "https://maps.googleapis.com/maps/api/js?key=#{api_key}&libraries=places&callback=initMap"
  end
end
