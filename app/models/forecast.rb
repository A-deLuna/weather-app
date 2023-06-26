# Represents the expected weather weather conditions at a particular point in time.
class Forecast
  include ActiveModel::API
  attr_accessor :now, :icon, :high, :low, :date
end
