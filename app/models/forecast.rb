class Forecast
  include ActiveModel::API
  attr_accessor :now, :icon, :high, :low, :date
end
