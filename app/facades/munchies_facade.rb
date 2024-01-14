class MunchiesFacade

  def self.get_munchies(location, type)
    coordinates_hash = MapquestService.get_lat_lon(location)
    restaurant_data = YelpService.get_restaurant(type, coordinates_hash[:lat], coordinates_hash[:lng])
    forecast_data = WeatherService.get_forecast_for_munchies(coordinates_hash[:lat], coordinates_hash[:lng])
    Munchies.new(restaurant_data, forecast_data, location)
  end
end