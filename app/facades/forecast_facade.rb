class ForecastFacade

  def self.get_forecast(location)
    coordinates_hash = MapquestService.get_lat_lon(location)
    forecast_data = WeatherService.get_forecast(coordinates_hash[:lat], coordinates_hash[:lng])
    Forecast.new(forecast_data)
  end

end