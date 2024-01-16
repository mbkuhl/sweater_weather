class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta,
              :id
  def initialize(road_trip_data)
    @id = nil
    @start_city = road_trip_data[:start_city]
    @end_city = road_trip_data[:end_city]
    @travel_time = road_trip_data[:travel_time]
    @weather_at_eta = road_trip_data[:weather_at_eta]
  end
end