require 'rails_helper'

RSpec.describe RoadTrip do
  it 'object has all attributes if given proper data', :vcr do
    origin = "Cincinatti, OH"
    destination = "Chicago, IL"
    coordinates_hash = MapquestService.get_lat_lon(destination.gsub(" ", ""))
    travel_time = MapquestService.get_travel_time(origin.gsub(" ", ""), destination.gsub(" ", ""))
    weather_data = WeatherService.get_weather_at_eta(coordinates_hash[:lat], coordinates_hash[:lng], DateTime.now + travel_time[:time_in_sec].seconds)
    road_trip_data = RoadTripFacade.aggregate_data(weather_data, origin, destination, travel_time)

    roadtrip = RoadTrip.new(road_trip_data)


    expect(roadtrip).to be_a RoadTrip

    expect(roadtrip.start_city).to eq("Cincinatti, OH")
    expect(roadtrip.end_city).to eq("Chicago, IL")
    expect(roadtrip.id).to be nil
    expect(roadtrip.travel_time).to be_a String
    expect(roadtrip.weather_at_eta).to be_a Hash
    expect(roadtrip.weather_at_eta.keys.count).to eq(3)
    expect(roadtrip.weather_at_eta[:datetime]).to be_a String
    expect(roadtrip.weather_at_eta[:temperature]).to be_a Float
    expect(roadtrip.weather_at_eta[:condition]).to be_a String
  end
end