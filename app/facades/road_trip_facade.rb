class RoadTripFacade

  def self.get_road_trip(origin, destination)
    coordinates_hash = MapquestService.get_lat_lon(destination)
    travel_time = MapquestService.get_travel_time(origin, destination)
    weather_data = WeatherService.get_weather_at_eta(coordinates_hash[:lat], coordinates_hash[:lng], DateTime.now + travel_time[:time_in_sec].seconds)
    road_trip_data = aggregate_data(weather_data, origin, destination, travel_time)
    RoadTrip.new(road_trip_data)
  end

  def self.aggregate_data(weather_data, origin, destination, travel_time)
    {
      start_city: origin.gsub(",", ", "),
      end_city: destination.gsub(",", ", "),
      travel_time: travel_time[:formatted_time],
      weather_at_eta: weather_data
    }
  end

end