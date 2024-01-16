require 'rails_helper'

RSpec.describe RoadTripSerializer do
  it 'can make a json style hash given a forecast object', :vcr do
    road_trip = RoadTripFacade.get_road_trip("Cincinatti, OH", "Chicago, IL")
    json_hash = RoadTripSerializer.new(road_trip).to_hash

    expect(json_hash).to be_a Hash
    expect(json_hash[:data]).to be_a Hash
    expect(json_hash[:data][:id]).to be nil
    expect(json_hash[:data][:type].to_s).to eq("road_trip")

    data = json_hash[:data][:attributes]
    expect(data).to be_a Hash
    expect(data.keys.count).to eq(4)

    expect(data[:start_city]).to eq("Cincinatti, OH")
    expect(data[:end_city]).to eq("Chicago, IL")
    expect(data[:travel_time]).to be_a String
    expect(data[:weather_at_eta]).to be_a Hash
    expect(data[:weather_at_eta].keys.count).to eq(3)
    expect(data[:weather_at_eta][:datetime]).to be_a String
    expect(data[:weather_at_eta][:temperature]).to be_a Float
    expect(data[:weather_at_eta][:condition]).to be_a String
  end
end