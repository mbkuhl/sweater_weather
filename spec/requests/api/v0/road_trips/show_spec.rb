require 'rails_helper'

RSpec.describe "Forecast Show" do
  
  before :each do
    new_user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post "/api/v0/users", params: new_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    @user = User.all.last
  end

  it "Post request for road_trip show", :vcr do
    new_road_trip = {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": @user.api_key
    }

    post "/api/v0/road_trip", params: new_road_trip.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to be_successful
    
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(json_response).to be_a Hash
    expect(json_response[:data]).to be_a Hash
    expect(json_response[:data][:id]).to be nil
    expect(json_response[:data][:type]).to eq("road_trip")

    data = json_response[:data][:attributes]
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

  it "Post request for road_trip show w/bad API key", :vcr do
    new_road_trip = {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": "bad_keyadfkjgn;dfvn"
    }

    post "/api/v0/road_trip", params: new_road_trip.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(json_response).to be_a Hash
    expect(json_response[:errors]).to be_a Array
    expect(json_response[:errors].first[:detail]).to eq("Invalid API key")
  end

  it "Post request for multi day road_trip show", :vcr do
    new_road_trip = {
      "origin": "Anchorage,AK",
      "destination": "Panama City,Panama",
      "api_key": @user.api_key
    }

    post "/api/v0/road_trip", params: new_road_trip.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to be_successful
    
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(json_response).to be_a Hash
    expect(json_response[:data]).to be_a Hash
    expect(json_response[:data][:id]).to be nil
    expect(json_response[:data][:type]).to eq("road_trip")

    data = json_response[:data][:attributes]
    expect(data).to be_a Hash
    expect(data.keys.count).to eq(4)

    expect(data[:start_city]).to eq("Anchorage, AK")
    expect(data[:end_city]).to eq("Panama City, Panama")
    expect(data[:travel_time]).to be_a String
    expect(data[:weather_at_eta]).to be_a Hash
    expect(data[:weather_at_eta].keys.count).to eq(3)
    expect(data[:weather_at_eta][:datetime]).to be_a String
    expect(data[:weather_at_eta][:temperature]).to be_a Float
    expect(data[:weather_at_eta][:condition]).to be_a String
  end

  it "Post request for sad path road_trip show", :vcr do
    new_road_trip = {
      "origin": "Cincinatti,OH",
      "destination": "London,England",
      "api_key": @user.api_key
    }

    post "/api/v0/road_trip", params: new_road_trip.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to be_successful
    
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(json_response).to be_a Hash
    expect(json_response[:data]).to be_a Hash
    expect(json_response[:data][:id]).to be nil
    expect(json_response[:data][:type]).to eq("road_trip")

    data = json_response[:data][:attributes]
    expect(data).to be_a Hash
    expect(data.keys.count).to eq(4)

    expect(data[:start_city]).to eq("Cincinatti, OH")
    expect(data[:end_city]).to eq("London, England")
    expect(data[:travel_time]).to eq("impossible")
    expect(data[:weather_at_eta]).to be_a Hash
    expect(data[:weather_at_eta].keys.count).to eq(0)
    expect(data[:weather_at_eta]).to eq({})
  end
end
