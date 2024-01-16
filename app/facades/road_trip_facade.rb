class RoadTripFacade

  def self.get_road_trip(origin, destination)
    coordinates_hash = MapquestService.get_lat_lon(destination)
    travel_data = MapquestService.get_travel_data(origin, destination)
    weather_data = WeatherService.get_weather_at_eta(coordinates_hash[:lat], coordinates_hash[:lng], travel_data[:eta])
    road_trip_data = aggregate_data(weather_data)
    RoadTrip.new(road_trip_data)
  end

  def self.aggregate_data(weather_data)
    {
      start_city: nil,
      end_city: nil,
      travel_time: nil,
      weather_at_eta: nil
    }
  end

end