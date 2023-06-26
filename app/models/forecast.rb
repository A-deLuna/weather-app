class Forecast
  include ActiveModel::API
  attr_accessor :temp_c, :temp_f, :icon
end
