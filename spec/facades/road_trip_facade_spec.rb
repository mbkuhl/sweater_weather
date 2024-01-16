require 'rails_helper'

RSpec.describe 'Makes object from input location' do
  it 'gets a road_trip object with  all data for two endpoints given as city,st', :vcr do
    roadtrip = RoadTripFacade.get_road_trip("Cincinatti, OH", "Chicago, IL")

    expect(roadtrip).to be_a RoadTrip

    expect(roadtrip.start_city).to eq("Cincinatti, OH")
    expect(roadtrip.end_city).to eq("Chicago, IL")
    expect(roadtrip.travel_time).to be_a String
    expect(roadtrip.weather_at_eta).to be_a Hash
    expect(roadtrip.weather_at_eta.keys.count).to eq(3)
    expect(roadtrip.weather_at_eta[:datetime]).to be_a String
    expect(roadtrip.weather_at_eta[:temperature]).to be_a Float
    expect(roadtrip.weather_at_eta[:condition]).to be_a String

  end

  it 'sad path gets a road_trip object with  all data for two endpoints given as city,st', :vcr do
    roadtrip = RoadTripFacade.get_road_trip("Cincinatti, OH", "London, UK")

    expect(roadtrip).to be_a RoadTrip

    expect(roadtrip.start_city).to eq("Cincinatti, OH")
    expect(roadtrip.end_city).to eq("London, UK")
    expect(roadtrip.travel_time).to eq("impossible")
    expect(roadtrip.weather_at_eta).to be_a Hash
    expect(roadtrip.weather_at_eta.keys.count).to eq(0)

  end
end
