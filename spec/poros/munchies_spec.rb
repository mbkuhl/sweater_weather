require 'rails_helper'

RSpec.describe Munchies do
  it 'object has all attributes if given proper data', :vcr do
    coordinates_hash = MapquestService.get_lat_lon("houston,tx")
    restaurant_data = YelpService.get_restaurant("italian", coordinates_hash[:lat], coordinates_hash[:lng])
    forecast_data = WeatherService.get_forecast_for_munchies(coordinates_hash[:lat], coordinates_hash[:lng])
    munchies = Munchies.new(restaurant_data, forecast_data, "houston,tx")

    expect(munchies).to be_a Munchies

    expect(munchies.destination_city).to eq("Houston, TX")
    expect(munchies.id).to be nil
    expect(munchies.forecast).to be_a Hash
    expect(munchies.forecast.keys).to eq([:temperature, :condition])
    expect(munchies.forecast[:temperature]).to be_a Float
    expect(munchies.forecast[:condition]).to be_a String
    expect(munchies.restaurant).to be_a Hash
    expect(munchies.restaurant.keys).to eq([:name, :address, :rating, :reviews])
    expect(munchies.restaurant[:name]).to be_a String
    expect(munchies.restaurant[:address]).to be_a String
    expect(munchies.restaurant[:rating]).to be_a Float
    expect(munchies.restaurant[:reviews]).to be_a Integer

  end
end