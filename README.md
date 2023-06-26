# Weather Service

A simple weather service that caches responses.

## Flow overview

The user opens the weather service and is greeted with an address input box.

The input box uses google places API to give suggestions of addresses as the user types.

After the user selects an address the front-end submits a Get form that is handled by the
`ForecastController`.

The `ForecastController` makes use of the `WeatherService` to fetch weather data. The data
is provided by `OpenWeather` API. The WeatherService adapts the resesponse to a `WeatherService::Response` rails object. This mapping is performed to preserve API compatibility for callers
to the `WeatherService`. 

`WeatherService::Response` responds with instances of the `Forecast` model. Both  include `ActiveModel::API`. It facilitates serializability and
maintains interface compatibility with `ActiveRecord` objects. `ActiveModel` is used here 
because there's no need of preserving Weather API responses in a database. This avoids overhead
from database reads and writes.

`ForecastsController` can handle street addresses with zip codes and general addresses
like cities and other locations without a zip code. This works by passing latitude and longitude coordinates fetched from the google places API.

### Caching

When a street address is slected by the user the front-end sends a call that includes
the zip code in the URL. This is done so that we can respond with HTTP expiration headers
to cache the HTML response in shared and private caches.

The `ForecastsController` also maintains a redis-backed cache of `WeatherService::Response`
objects keyed by zip code. The entries are automatically exipired after 30 minutes.

## Testing
The project includes system tests that execute the flow from end to end.
Also each controller includes tests and validates that the caching behavior behaves as expected.
