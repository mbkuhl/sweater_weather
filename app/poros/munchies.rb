class Munchies
  attr_reader :restaurant,
              :forecast,
              :location
  def initialize(restaurant_data, forecast_data, location_string)
    @restaurant = restaurant_data
    @forecast = forecast_data
    @location = location_formatter(location_string)
  end

  def location_formatter(location_string)
    city_state = location_string.split(",")
    "#{city_state[0].capitalize}, #{city_state[1].upcase}"
  end
end